from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector
from werkzeug.security import check_password_hash

app = Flask(__name__)
app.secret_key = 'supersecretkey'  # Cambiar por una clave secreta segura

# Configuración de la conexión a la base de datos
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="root",
    database="ironsocial"
)

# Ruta para la portada con registro e inicio de sesión
@app.route('/')
def home():
    if 'user_id' in session:
        return redirect(url_for('posts'))
    return render_template('index.html')

# Paso 1 del inicio de sesión: verificar que el correo existe
@app.route('/login-step-1', methods=['POST'])
def login_step_1():
    email = request.form.get('email')
    
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Users WHERE email = %s", (email,))
    user = cursor.fetchone()

    if user:
        session['pending_email'] = email  # Almacenar el correo en sesión temporalmente
        return redirect(url_for('home'))  # Esto hará que el formulario de contraseña se muestre
    else:
        return "Correo no registrado. Por favor, regístrate.", 400

# Paso 2 del inicio de sesión: verificar la contraseña
@app.route('/login-step-2', methods=['POST'])
def login_step_2():
    email = session.get('pending_email')
    password = request.form.get('password')

    if not email:
        return redirect(url_for('home'))  # Si no hay correo en sesión, redirigir al inicio

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Users WHERE email = %s", (email,))
    user = cursor.fetchone()

    if user and check_password_hash(user['password'], password):
        session['user_id'] = user['user_id']
        session['username'] = user['username']
        session.pop('pending_email', None)  # Eliminar el correo temporal de la sesión
        return redirect(url_for('posts'))
    else:
        return "Contraseña incorrecta. Inténtalo de nuevo.", 400

# Ruta para mostrar las publicaciones del usuario
@app.route('/posts')
def posts():
    if 'user_id' not in session:
        return redirect(url_for('home'))

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Photos WHERE user_id = %s", (session['user_id'],))
    photos = cursor.fetchall()

    return render_template('posts.html', photos=photos)

# Ruta para mostrar el perfil del usuario
@app.route('/profile/<int:user_id>')
def profile(user_id):
    if 'user_id' not in session:
        return redirect(url_for('home'))

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Users WHERE user_id = %s", (user_id,))
    user = cursor.fetchone()

    cursor.execute("SELECT * FROM Photos WHERE user_id = %s", (user_id,))
    photos = cursor.fetchall()

    return render_template('profile.html', user=user, photos=photos)

# Ruta para agregar una nueva foto (simulación, agregar funcionalidad completa si es necesario)
@app.route('/add_photo', methods=['POST'])
def add_photo():
    if 'user_id' not in session:
        return redirect(url_for('home'))

    user_id = session['user_id']
    photo_url = request.form['photo_url']
    caption = request.form['caption']

    cursor = db.cursor()
    cursor.execute("INSERT INTO Photos (user_id, photo_url, caption) VALUES (%s, %s, %s)",
                   (user_id, photo_url, caption))
    db.commit()

    return redirect(url_for('posts'))

if __name__ == '__main__':
    app.run(debug=True)

