
![logo_ironhack_blue 7](https://github.com/ciberzerone/ironSocial/blob/main/public_html/static/img/banner.PNG)

red social Iron : manejo de base de datos, pytnon, javascript, css


IronSocial es una red social diseñada para alumnos y exalumnos de Ironhack. Los usuarios pueden registrarse, iniciar sesión, publicar fotos, ver perfiles y gestionar amistades. Este proyecto implementa un sistema básico de CRUD (Crear, Leer, Actualizar, Eliminar) en Flask con un frontend en HTML/CSS y una base de datos MySQL.

## Características


- **Inicio de Sesión**: Autenticación segura de usuarios mediante contraseñas hasheadas.
- **Gestión de Fotos**: Los usuarios pueden subir, ver y eliminar fotos.
- **Perfiles de Usuario**: Los perfiles incluyen información básica, como nombre de usuario, correo electrónico, GitHub y portafolio.
- **Sistema de Amigos**: Los usuarios pueden enviar y aceptar solicitudes de amistad.

## Tecnologías Utilizadas

- **Backend**: Python con Flask
- **Base de Datos**: MySQL (MariaDB)
- **Frontend**: HTML, CSS, JavaScript
- **Autenticación**: Werkzeug para hashear y verificar contraseñas
- **Gestión de Sesión**: Flask Sessions

## Estructura del Proyecto

IronSocial/
│
├── app.py # Archivo principal de la aplicación Flask
├── hash_passwords.py # Script para hashear contraseñas (para desarrollo)
├── README.md # Este archivo
├── requirements.txt # Dependencias del proyecto
├── templates/ # Plantillas HTML
│ ├── index.html
│ ├── profile.html
│ ├── posts.html
│ └── upload.html
├── static/ # Archivos estáticos
│ ├── css/ # Archivos CSS
│ │ └── styles.css
│ ├── js/ # Archivos JavaScript
│ │ └── script.js
│ └── img/ # Imágenes
│ └── uploaded_photos/ # Fotos subidas por usuarios
└── ...



IronSocial/
├── app.py                   # Archivo principal de la aplicación Flask
├── hash_passwords.py        # Script para hashear contraseñas (para desarrollo)
├── README.md                # Este archivo
├── requirements.txt         # Dependencias del proyecto
├── templates/               # Plantillas HTML
│   ├── index.html
│   ├── profile.html
│   ├── posts.html
│   └── upload.html
├── static/                  # Archivos estáticos
│   ├── css/                 # Archivos CSS
│   │   └── styles.css
│   ├── js/                  # Archivos JavaScript
│   │   └── script.js
│   └── img/                 # Imágenes
│       └── uploaded_photos/ # Fotos subidas por usuarios



## Instalación

### Prerrequisitos

- Python 3.x
- MySQL (o MariaDB)

### Instrucciones

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/tu_usuario/ironsocial.git
   cd ironsocial
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate

2. Crear un entorno virtual (opcional pero recomendado):
  ```bash
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate

3. Instalar las dependencias:
  ```bash
pip install -r requirements.txt


4. Configurar la base de datos:

- Crear una base de datos MySQL llamada ironsocial.
- Ejecutar el script SQL para crear las tablas necesarias.
- Configurar la conexión a la base de datos en app.py

5. Ejecutar la aplicación:

  ```bash
  python app.py

### Uso
Registro: Dirígete a la página principal y regístrate como nuevo usuario.
Inicio de Sesión: Usa tu correo y contraseña para iniciar sesión.
Subir Fotos: Una vez que hayas iniciado sesión, puedes subir fotos desde la página de publicaciones.
Gestionar Amigos: Busca otros usuarios y envía solicitudes de amistad.
Contribuciones
Las contribuciones son bienvenidas. Por favor, sigue los pasos a continuación para contribuir al proyecto:

### Haz un fork del repositorio.
Crea una nueva rama (git checkout -b feature/nueva-funcionalidad).
Realiza los cambios necesarios y haz commit (git commit -am 'Añadida nueva funcionalidad').
Haz push a la rama (git push origin feature/nueva-funcionalidad).
Crea un nuevo Pull Request.
Licencia
Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para más detalles.

Contacto
Para cualquier consulta o sugerencia, puedes contactarme a través de [gianmarcobeltran@gmail.com] o tu perfil de LinkedIn.

