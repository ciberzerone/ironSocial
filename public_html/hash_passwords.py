from werkzeug.security import generate_password_hash

# Diccionario de usuarios y contraseñas en texto plano
users_passwords = {
    'michael_scott': 'password123',
    'pam_beesly': 'password123',
    'jim_halpert': 'password123',
    'dwight_schrute': 'password123',
    'angela_martin': 'password123',
    'kevin_malone': 'password123',
    'oscar_martinez': 'password123',
    'ryan_howard': 'password123',
    'kelly_kapoor': 'password123',
    'creed_bratton': 'password123'
}

# Generar hashes de las contraseñas
hashed_passwords = {user: generate_password_hash(password) for user, password in users_passwords.items()}

# Imprimir los resultados para copiar en la base de datos
for user, hashed in hashed_passwords.items():
    print(f"Usuario: {user}, Hash de la contraseña: {hashed}")
