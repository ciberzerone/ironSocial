from flask import Flask, render_template, request, redirect, url_for, session
import mysql.connector
from werkzeug.security import check_password_hash
import random
app = Flask(__name__)
app.secret_key = 'supersecretkey'  # Cambiar por una clave secreta segura

# Configuración de la conexión a la base de datos
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="ironsocial"
)

@app.route('/')
def home():
    if 'user_id' in session:
        return redirect(url_for('posts'))
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    email = request.form.get('email')
    password = request.form.get('password')

    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Users WHERE email = %s", (email,))
    user = cursor.fetchone()

    if user and check_password_hash(user['password'], password):
        session['user_id'] = user['user_id']
        session['username'] = user['username']
        return redirect(url_for('posts'))
    else:
        return "Correo o contraseña incorrectos. Inténtalo de nuevo.", 400

@app.route('/posts')
def posts():
    if 'user_id' not in session:
        return redirect(url_for('home'))

    cursor = db.cursor(dictionary=True)

    # Obtener las publicaciones del usuario
    cursor.execute("SELECT * FROM Photos WHERE user_id = %s", (session['user_id'],))
    photos = cursor.fetchall()

    # Obtener la lista de amigos con su user_id, username y foto de perfil
    cursor.execute("""
        SELECT Users.user_id, Users.username, Users.profile_picture 
        FROM Friends 
        JOIN Users ON Friends.friend_id = Users.user_id 
        WHERE Friends.user_id = %s
    """, (session['user_id'],))
    friends = cursor.fetchall()

    # Obtener 5 publicaciones aleatorias de otros usuarios
    cursor.execute("""
        SELECT Photos.photo_url, Photos.caption, Users.username, Users.user_id
        FROM Photos
        JOIN Users ON Photos.user_id = Users.user_id
        WHERE Photos.user_id != %s
        ORDER BY RAND()
        LIMIT 5
    """, (session['user_id'],))
    random_posts = cursor.fetchall()

    # Renderizar la plantilla con los datos obtenidos
    return render_template('posts.html', photos=photos, friends=friends, random_posts=random_posts)













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


# para eliminar post
@app.route('/delete_post/<int:photo_id>', methods=['POST'])
def delete_post(photo_id):
    if 'user_id' not in session:
        return redirect(url_for('home'))

    cursor = db.cursor()
    cursor.execute("DELETE FROM Photos WHERE photo_id = %s AND user_id = %s", (photo_id, session['user_id']))
    db.commit()

    return redirect(url_for('posts'))

# para editar post
@app.route('/edit_post/<int:photo_id>', methods=['GET', 'POST'])
def edit_post(photo_id):
    if 'user_id' not in session:
        return redirect(url_for('home'))

    cursor = db.cursor(dictionary=True)
    
    if request.method == 'POST':
        new_caption = request.form.get('caption')
        cursor.execute("UPDATE Photos SET caption = %s WHERE photo_id = %s AND user_id = %s", 
                       (new_caption, photo_id, session['user_id']))
        db.commit()
        return redirect(url_for('posts'))

    cursor.execute("SELECT * FROM Photos WHERE photo_id = %s AND user_id = %s", (photo_id, session['user_id']))
    photo = cursor.fetchone()
    
    return render_template('edit_post.html', photo=photo)




@app.route('/logout')
def logout():
    session.clear()  # Limpia la sesión para desconectar al usuario
    return redirect(url_for('home'))  # Redirige a la página principal



if __name__ == '__main__':
    app.run(debug=True)
