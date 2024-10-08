
![logo_ironhack_blue 7](https://github.com/ciberzerone/ironSocial/blob/main/public_html/static/img/banner.PNG)


- [script.sql](./sql/script.sql): Sql de la base de datos `ironSocial`.
- [ironsocial.pdf](./presenta/ironsocial.pdf): Presentacion del proyecto `ironSocial`.


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

## Estructura del Proyecto

![estructura](https://github.com/ciberzerone/ironSocial/blob/main/imagen/estructura.JPG)


## Script Sql aplicados en el proyecto

### 1. Crear la base de datos:
```sql
CREATE DATABASE IronSocial;
```
![crear base datos](https://github.com/ciberzerone/ironSocial/blob/main/imagen/1crearBdIronSocial.PNG)

### Explicación del Comando SQL `CREATE DATABASE IronSocial`
- El comando `CREATE DATABASE IronSocial;` se utiliza para crear una nueva base de datos en un servidor de bases de datos MySQL o MariaDB. A continuación se detalla su funcionalidad y propósito:

### 2. Usar la base de datos:
```sql

USE IronSocial;

```

#### Explicación del Comando SQL `USE IronSocial`

- El comando `USE IronSocial` se utiliza para seleccionar la base de datos `IronSocial` en un entorno de MySQL o MariaDB. Este comando le indica al servidor de base de datos que todas las consultas SQL posteriores se ejecutarán en el contexto de la base de datos `IronSocial`.

### 3. Crear tablas:

#### Tabla de Users
```sql
-- Tabla de Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    github VARCHAR(100),
    portfolio VARCHAR(100)
);
```
![crear tabla Users ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/1creartabla01.PNG)

#### Explicación del Comando SQL `CREATE TABLE Users ...`
  - Este bloque de código crea una tabla llamada `Users` en la base de datos. La tabla está diseñada para almacenar la información básica de los usuarios, como el nombre de usuario, contraseña, correo electrónico, y enlaces a sus perfiles en GitHub y portafolio. A continuación se detallan los campos de la tabla:

  - **`user_id INT PRIMARY KEY AUTO_INCREMENT`:**
    - **Tipo**: `INT`
    - **Propiedades**: Clave primaria (`PRIMARY KEY`), Auto-incremental (`AUTO_INCREMENT`).
    - **Descripción**: `user_id` es el identificador único para cada usuario en la tabla. Se genera automáticamente de manera incremental para cada nuevo registro.

  - **`username VARCHAR(50) NOT NULL UNIQUE`:**
    - **Tipo**: `VARCHAR(50)`
    - **Propiedades**: No nulo (`NOT NULL`), Único (`UNIQUE`).
    - **Descripción**: `username` almacena el nombre de usuario elegido por el usuario. Debe ser único en la base de datos, lo que asegura que no haya dos usuarios con el mismo nombre.

  - **`password VARCHAR(255) NOT NULL`:**
    - **Tipo**: `VARCHAR(255)`
    - **Propiedades**: No nulo (`NOT NULL`).
    - **Descripción**: `password` almacena la contraseña del usuario. La longitud de 255 caracteres permite almacenar contraseñas hasheadas.

  - **`email VARCHAR(100) NOT NULL UNIQUE`:**
    - **Tipo**: `VARCHAR(100)`
    - **Propiedades**: No nulo (`NOT NULL`), Único (`UNIQUE`).
    - **Descripción**: `email` almacena la dirección de correo electrónico del usuario. Debe ser único para garantizar que cada correo electrónico esté asociado a un solo usuario.

  - **`github VARCHAR(100)`:**
    - **Tipo**: `VARCHAR(100)`
    - **Descripción**: `github` almacena la URL del perfil de GitHub del usuario. Este campo es opcional, por lo que puede quedar vacío.

  - **`portfolio VARCHAR(100)`:**
    - **Tipo**: `VARCHAR(100)`
    - **Descripción**: `portfolio` almacena la URL del portafolio personal del usuario. Este campo también es opcional.


<hr>

#### Tabla de Perfiles
```sql
-- Tabla de Perfiles (One-to-One con Users)
CREATE TABLE Profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
```



![crear tabla Perfiles ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/1creartabla02.PNG)


#### Explicación del Comando SQL `CREATE TABLE Profiles (...`
  - Crea una tabla llamada `Profiles` diseñada para almacenar información adicional sobre los usuarios.

- **`profile_id INT PRIMARY KEY AUTO_INCREMENT`:**
  - **Tipo**: `INT`
  - **Propiedades**: Clave primaria (`PRIMARY KEY`), Auto-incremental (`AUTO_INCREMENT`).
  - **Descripción**: `profile_id` es el identificador único para cada perfil en la tabla `Profiles`. Se genera automáticamente de manera incremental con cada nuevo registro.

- **`user_id INT NOT NULL`:**
  - **Tipo**: `INT`
  - **Propiedades**: No nulo (`NOT NULL`), Clave foránea.
  - **Descripción**: `user_id` es un campo que almacena el identificador del usuario al que pertenece el perfil. Está relacionado con la columna `user_id` de la tabla `Users`, creando una relación uno a uno entre `Users` y `Profiles`.

- **`bio TEXT`:**
  - **Tipo**: `TEXT`
  - **Descripción**: `bio` almacena la biografía del usuario. Este campo es opcional y permite almacenar texto de longitud variable.

- **`FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE`:**
  - **Propósito**: Define una clave foránea que conecta `user_id` en la tabla `Profiles` con `user_id` en la tabla `Users`.
  - **`ON DELETE CASCADE`**: Esta opción asegura que si un registro en la tabla `Users` es eliminado, el perfil asociado en la tabla `Profiles` también será eliminado automáticamente. Esto mantiene la integridad referencial entre las dos tablas.


<hr>

#### Tabla de Photos

```sql
-- Tabla de Photos (One-to-Many con Users)
CREATE TABLE Photos (
    photo_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    photo_url VARCHAR(255) NOT NULL,
    caption TEXT,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
```

![crear tabla Photos ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/1creartabla03.PNG)


#### Explicación del Comando SQL `CREATE TABLE Photos (...`
Esta tabla está diseñada para almacenar información sobre las fotos subidas por los usuarios.

- **`photo_id INT PRIMARY KEY AUTO_INCREMENT`:**
  - **Tipo**: `INT`
  - **Propiedades**: Clave primaria (`PRIMARY KEY`), Auto-incremental (`AUTO_INCREMENT`).
  - **Descripción**: `photo_id` es el identificador único para cada foto en la tabla `Photos`. Se genera automáticamente de manera incremental con cada nuevo registro.

- **`user_id INT NOT NULL`:**
  - **Tipo**: `INT`
  - **Propiedades**: No nulo (`NOT NULL`), Clave foránea.
  - **Descripción**: `user_id` es un campo que almacena el identificador del usuario que subió la foto. Está relacionado con la columna `user_id` de la tabla `Users`, creando una relación uno a muchos entre `Users` y `Photos`.

- **`photo_url VARCHAR(255) NOT NULL`:**
  - **Tipo**: `VARCHAR(255)`
  - **Propiedades**: No nulo (`NOT NULL`).
  - **Descripción**: `photo_url` almacena la URL de la foto. Este campo es obligatorio.

- **`caption TEXT`:**
  - **Tipo**: `TEXT`
  - **Descripción**: `caption` almacena una descripción o subtítulo para la foto. Este campo es opcional y permite almacenar texto de longitud variable.

- **`upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP`:**
  - **Tipo**: `TIMESTAMP`
  - **Propiedades**: Valor por defecto (`DEFAULT CURRENT_TIMESTAMP`).
  - **Descripción**: `upload_date` almacena la fecha y hora en que la foto fue subida. Se establece automáticamente en la fecha y hora actuales al momento de la inserción del registro.

- **`FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE`:**
  - **Propósito**: Define una clave foránea que conecta `user_id` en la tabla `Photos` con `user_id` en la tabla `Users`.
  - **`ON DELETE CASCADE`**: Esta opción asegura que si un registro en la tabla `Users` es eliminado, todas las fotos asociadas en la tabla `Photos` también serán eliminadas automáticamente. Esto mantiene la integridad referencial entre las dos tablas.


<hr>

#### Tabla Friends
```sql
-- Tabla de Friends (Many-to-Many entre Usuarios)
CREATE TABLE Friends (
    user_id INT,
    friend_id INT,
    PRIMARY KEY (user_id, friend_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
```

![crear tabla Comments ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/1creartabla04.PNG)


#### Explicación del Comando SQL `CREATE TABLE Friends (...`
Se utiliza para gestionar las relaciones de amistad entre usuarios en la base de datos.

- **`user_id INT`:**
  - **Tipo**: `INT`
  - **Descripción**: `user_id` representa el identificador del usuario que tiene una relación de amistad con otro usuario. Este campo actúa como parte de la clave primaria y como clave foránea que referencia el campo `user_id` de la tabla `Users`.

- **`friend_id INT`:**
  - **Tipo**: `INT`
  - **Descripción**: `friend_id` representa el identificador del amigo del usuario. Al igual que `user_id`, este campo es parte de la clave primaria y también es una clave foránea que referencia el campo `user_id` de la tabla `Users`.

- **`PRIMARY KEY (user_id, friend_id)`:**
  - **Descripción**: Define una clave primaria compuesta por los campos `user_id` y `friend_id`. Esto asegura que cada par de relaciones de amistad sea único, impidiendo que se duplique una relación entre dos usuarios.

- **`FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE`:**
  - **Descripción**: Establece una clave foránea que conecta `user_id` en la tabla `Friends` con `user_id` en la tabla `Users`. La cláusula `ON DELETE CASCADE` asegura que si un usuario es eliminado de la tabla `Users`, todas las relaciones de amistad asociadas con ese usuario también serán eliminadas automáticamente.

- **`FOREIGN KEY (friend_id) REFERENCES Users(user_id) ON DELETE CASCADE`:**
  - **Descripción**: Establece una clave foránea que conecta `friend_id` en la tabla `Friends` con `user_id` en la tabla `Users`. Al igual que la clave foránea anterior, la cláusula `ON DELETE CASCADE` asegura que si un usuario es eliminado, todas las relaciones de amistad asociadas también se eliminen automáticamente.


<hr>

#### Tabla Comments

```sql
-- Tabla de Comentarios (One-to-Many con Photos)
CREATE TABLE Comments (
    comment_id INT PRIMARY KEY AUTO_INCREMENT,
    photo_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (photo_id) REFERENCES Photos(photo_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
```

![Relaciones entre tablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/1creartabla05.PNG)


#### Explicación del Comando SQL `CREATE TABLE Comments (...`
Esta tabla está diseñada para almacenar los comentarios que los usuarios hacen en las fotos.

- **`comment_id INT PRIMARY KEY AUTO_INCREMENT`:**
  - **Tipo**: `INT`
  - **Propiedades**: Clave primaria (`PRIMARY KEY`), Auto-incremental (`AUTO_INCREMENT`).
  - **Descripción**: `comment_id` es el identificador único para cada comentario en la tabla `Comments`. Se genera automáticamente de manera incremental con cada nuevo registro.

- **`photo_id INT NOT NULL`:**
  - **Tipo**: `INT`
  - **Propiedades**: No nulo (`NOT NULL`), Clave foránea.
  - **Descripción**: `photo_id` es un campo que almacena el identificador de la foto en la cual se ha hecho el comentario. Está relacionado con la columna `photo_id` de la tabla `Photos`, creando una relación uno a muchos entre `Photos` y `Comments`.

- **`user_id INT NOT NULL`:**
  - **Tipo**: `INT`
  - **Propiedades**: No nulo (`NOT NULL`), Clave foránea.
  - **Descripción**: `user_id` es un campo que almacena el identificador del usuario que hizo el comentario. Está relacionado con la columna `user_id` de la tabla `Users`, indicando quién realizó el comentario.

- **`comment_text TEXT NOT NULL`:**
  - **Tipo**: `TEXT`
  - **Propiedades**: No nulo (`NOT NULL`).
  - **Descripción**: `comment_text` almacena el contenido del comentario. Este campo es obligatorio y puede contener texto de longitud variable.

- **`comment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP`:**
  - **Tipo**: `TIMESTAMP`
  - **Propiedades**: Valor por defecto (`DEFAULT CURRENT_TIMESTAMP`).
  - **Descripción**: `comment_date` almacena la fecha y hora en que se realizó el comentario. Se establece automáticamente en la fecha y hora actuales al momento de la inserción del registro.

- **`FOREIGN KEY (photo_id) REFERENCES Photos(photo_id) ON DELETE CASCADE`:**
  - **Descripción**: Establece una clave foránea que conecta `photo_id` en la tabla `Comments` con `photo_id` en la tabla `Photos`. La cláusula `ON DELETE CASCADE` asegura que si una foto es eliminada, todos los comentarios asociados en la tabla `Comments` también serán eliminados automáticamente.

- **`FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE`:**
  - **Descripción**: Establece una clave foránea que conecta `user_id` en la tabla `Comments` con `user_id` en la tabla `Users`. La cláusula `ON DELETE CASCADE` asegura que si un usuario es eliminado, todos los comentarios asociados con ese usuario también serán eliminados automáticamente.


<hr>

### 4. Relaciones entre tablas:
```sql 

-- One-to-One Perfiles con Users
 FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE

-- One-to-Many Photos con Users
 FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE

-- Many-to-Many entre Usuario
FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
FOREIGN KEY (friend_id) REFERENCES Users(user_id) ON DELETE CASCADE

-- One-to-Many Comments con Photos
 FOREIGN KEY (photo_id) REFERENCES Photos(photo_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
```






![Relaciones entre tablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/erDiagrama.JPG)


### 5. Contenido de las tablas:

```sql 

-- Cada tabla debe contener al menos 10 elementos (filas o registros).
INSERT INTO Users (username, password, email, github, portfolio) VALUES
('michael_scott', 'password_hash1', 'michael@dundermifflin.com', 'https://github.com/michaelscott', 'https://michaelportfolio.com'),
('pam_beesly', 'password_hash2', 'pam@dundermifflin.com', 'https://github.com/pambeesly', 'https://pamart.com'),
('jim_halpert', 'password_hash3', 'jim@dundermifflin.com', 'https://github.com/jimhalpert', 'https://jimpranks.com'),
('dwight_schrute', 'password_hash4', 'dwight@dundermifflin.com', 'https://github.com/dwightschrute', 'https://schrutefarms.com'),
('angela_martin', 'password_hash5', 'angela@dundermifflin.com', 'https://github.com/angelamartin', 'https://angelacats.com'),
('kevin_malone', 'password_hash6', 'kevin@dundermifflin.com', 'https://github.com/kevinmalone', 'https://kevinchili.com'),
('oscar_martinez', 'password_hash7', 'oscar@dundermifflin.com', 'https://github.com/oscarmartinez', 'https://oscaraccounting.com'),
('ryan_howard', 'password_hash8', 'ryan@dundermifflin.com', 'https://github.com/ryanhoward', 'https://ryanwolf.com'),
('kelly_kapoor', 'password_hash9', 'kelly@dundermifflin.com', 'https://github.com/kellykapoor', 'https://kellyfashion.com'),
('creed_bratton', 'password_hash10', 'creed@dundermifflin.com', 'https://github.com/creedbratton', 'https://creedstrange.com');

UPDATE Users SET password = 'scrypt:32768:8:1$fNoMO2F0BDuSvK0D$d4499ccb6423b48efd1c0f227c269ddcfa6bb29a4e9e5e7d37c6f3b4808459c05d9a87c412a76ed7d42f9e784aa693c3c4f130f0a7bfc1a6c89f77e414f92cb9' WHERE username = 'michael_scott';

UPDATE Users SET password = 'scrypt:32768:8:1$nVqJwHZolL2kN2r9$8b07b15986c315ee1f55102a68965c1b0b84067e8fa12308f1f965904e091f25866f05a7e95fc33bd812746170fd8949e914e94850e722939e7180fb1927f5f3' WHERE username = 'pam_beesly';

UPDATE Users SET password = 'scrypt:32768:8:1$N6QFrPSLczbKn99V$5037951c6bd0a51145830e5c092906006407631db509af8014ad65dd3a9f1117dc21e4136b1042e8c8d1802f303f95455781aba052ab7573ec375b05d131dfc8' WHERE username = 'jim_halpert';

UPDATE Users SET password = 'scrypt:32768:8:1$DxfQPCXHM5npJqdV$b5fc5f61f2bcd3d6dd3506ba2e534e85d675db1f0c80a5ae085af50daaf71a89a1d97eb736ee1424617dd8807979bd8711d42f9fc8769d8b02935d150ff0e87f' WHERE username = 'dwight_schrute';

UPDATE Users SET password = 'scrypt:32768:8:1$YDBDDSiXjnUrHbcI$837ead8767c6cc6629643078533bf0f97ff045aa51d30ff4f918b7b88009b257a20a40555ba823b0ad2052056cf79cc68863f06ce1c674efc7a97cfe9908b894' WHERE username = 'angela_martin';

UPDATE Users SET password = 'scrypt:32768:8:1$mDq4CtpIAP6qtnM7$34bbc6980ad6cd14f484aecc3bef3fea72610eeebbaf2e27937c46d2efe2329a479d69383f761561bdc1fedfb82fed3104166c40c01d6a86e255e2496a167c07' WHERE username = 'kevin_malone';

UPDATE Users SET password = 'scrypt:32768:8:1$J58sklUtPbXKcLzI$a1bf6b67c5f53db0449e8033ab29095798938c254ac1af9d7603732e7da2e60830097876c5dfc8fc459f00603325f5c1ba90458fd8bd1f6a8d52b986936b086a' WHERE username = 'oscar_martinez';

UPDATE Users SET password = 'scrypt:32768:8:1$4EVPm347GmCZAN1o$f413f16acc3128b5ba87806473cb28770ac5009a1b3574dffbfc2f75097460731bccbc99f3807cbc4966c9d9faea3f0248dc28892d4d7dbbafe777ab5bf128be' WHERE username = 'ryan_howard';

UPDATE Users SET password = 'scrypt:32768:8:1$6bFDydD3mzZLh55A$530e843d04a9026748fd14a672e7f35669833d9cdea7de8d9b974eeda13e530cc91b4e4a4396f1201d096c58adc7a2bda85a070337a9fda5c1921f9815fb6ff4' WHERE username = 'kelly_kapoor';

UPDATE Users SET password = 'scrypt:32768:8:1$l2tOodTwF7RTsMSs$a4553749b499aa459903ef7abd6415e950df1f3163e61dd20add3dafbaa050a1dd9cd877c969ad2ee5adb43431cde8c3be655ff94aa0f50ad4a873d80113a83a' WHERE username = 'creed_bratton';


USE IronSocial;
UPDATE Users SET password = 'scrypt:32768:8:1$fNoMO2F0BDuSvK0D$d4499ccb6423b48efd1c0f227c269ddcfa6bb29a4e9e5e7d37c6f3b4808459c05d9a87c412a76ed7d42f9e784aa693c3c4f130f0a7bfc1a6c89f77e414f92cb9' WHERE username = 'michael_scott';

UPDATE Users SET password = 'scrypt:32768:8:1$nVqJwHZolL2kN2r9$8b07b15986c315ee1f55102a68965c1b0b84067e8fa12308f1f965904e091f25866f05a7e95fc33bd812746170fd8949e914e94850e722939e7180fb1927f5f3' WHERE username = 'pam_beesly';

UPDATE Users SET password = 'scrypt:32768:8:1$N6QFrPSLczbKn99V$5037951c6bd0a51145830e5c092906006407631db509af8014ad65dd3a9f1117dc21e4136b1042e8c8d1802f303f95455781aba052ab7573ec375b05d131dfc8' WHERE username = 'jim_halpert';

UPDATE Users SET password = 'scrypt:32768:8:1$DxfQPCXHM5npJqdV$b5fc5f61f2bcd3d6dd3506ba2e534e85d675db1f0c80a5ae085af50daaf71a89a1d97eb736ee1424617dd8807979bd8711d42f9fc8769d8b02935d150ff0e87f' WHERE username = 'dwight_schrute';

UPDATE Users SET password = 'scrypt:32768:8:1$YDBDDSiXjnUrHbcI$837ead8767c6cc6629643078533bf0f97ff045aa51d30ff4f918b7b88009b257a20a40555ba823b0ad2052056cf79cc68863f06ce1c674efc7a97cfe9908b894' WHERE username = 'angela_martin';

UPDATE Users SET password = 'scrypt:32768:8:1$mDq4CtpIAP6qtnM7$34bbc6980ad6cd14f484aecc3bef3fea72610eeebbaf2e27937c46d2efe2329a479d69383f761561bdc1fedfb82fed3104166c40c01d6a86e255e2496a167c07' WHERE username = 'kevin_malone';

UPDATE Users SET password = 'scrypt:32768:8:1$J58sklUtPbXKcLzI$a1bf6b67c5f53db0449e8033ab29095798938c254ac1af9d7603732e7da2e60830097876c5dfc8fc459f00603325f5c1ba90458fd8bd1f6a8d52b986936b086a' WHERE username = 'oscar_martinez';

UPDATE Users SET password = 'scrypt:32768:8:1$4EVPm347GmCZAN1o$f413f16acc3128b5ba87806473cb28770ac5009a1b3574dffbfc2f75097460731bccbc99f3807cbc4966c9d9faea3f0248dc28892d4d7dbbafe777ab5bf128be' WHERE username = 'ryan_howard';

UPDATE Users SET password = 'scrypt:32768:8:1$6bFDydD3mzZLh55A$530e843d04a9026748fd14a672e7f35669833d9cdea7de8d9b974eeda13e530cc91b4e4a4396f1201d096c58adc7a2bda85a070337a9fda5c1921f9815fb6ff4' WHERE username = 'kelly_kapoor';

UPDATE Users SET password = 'scrypt:32768:8:1$l2tOodTwF7RTsMSs$a4553749b499aa459903ef7abd6415e950df1f3163e61dd20add3dafbaa050a1dd9cd877c969ad2ee5adb43431cde8c3be655ff94aa0f50ad4a873d80113a83a' WHERE username = 'creed_bratton';


INSERT INTO Profiles (user_id, bio) VALUES
(1, 'Regional Manager at Dunder Mifflin Scranton. World’s best boss.'),
(2, 'Receptionist turned Office Administrator. Loves painting and design.'),
(3, 'Salesman at Dunder Mifflin. Expert in pranks and sports.'),
(4, 'Assistant to the Regional Manager. Beet farmer. Martial artist.'),
(5, 'Head of the Accounting Department. Cat lover.'),
(6, 'Accountant who loves food, especially chili.'),
(7, 'Accountant with a flair for numbers and a critical eye.'),
(8, 'Former temp at Dunder Mifflin, now a successful entrepreneur.'),
(9, 'Customer service representative. Loves pop culture and fashion.'),
(10, 'Quality Assurance Director. Known for his eccentric behavior.');



INSERT INTO Friends (user_id, friend_id) VALUES
(1, 2), (1, 3), (1, 4),
(2, 1), (2, 3),
(3, 1), (3, 2), (3, 4),
(4, 1), (4, 3),
(5, 6),
(6, 5), (6, 7),
(7, 6),
(8, 9),
(9, 8), (9, 10),
(10, 9);


INSERT INTO Comments (photo_id, user_id, comment_text) VALUES
(1, 2, '¡Me encanta tu taza, Michael!'),
(1, 3, 'Clásico Michael.'),
(2, 3, '¡Tu arte es increíble, Pam!'),
(3, 4, 'Buen tiro, Halpert.'),
(4, 1, 'Los mejores remolachas en Scranton.'),
(5, 6, '¡Tus gatos son adorables, Angela!'),
(6, 7, 'Kevin, deberías llevar esa receta a la oficina.'),
(7, 8, '¡Felicidades, Oscar!'),
(8, 9, '¡Mucha suerte con tu startup, Ryan!'),
(9, 10, 'Me encanta tu estilo, Kelly.');

``` 

![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/5ContenidoTabla.PNG)

### 6. Búsquedas:

#### Búsquedas simples:


#### Seleccionar todos los usuarios
```sql 

-- Seleccionar todos los usuarios
SELECT * FROM Users;
```

![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.1.1.PNG)
 #### Seleccionar usuarios con un ID par
```sql 
-- Seleccionar usuarios con un ID par
SELECT * FROM Users WHERE MOD(user_id, 2) = 0;
```
![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.1.2.PNG)

#### Ordenar usuarios por nombre de usuario
```sql 
-- Ordenar usuarios por nombre de usuario
SELECT * FROM Users ORDER BY username ASC;
```

![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.1.3.PNG)


#### Limitar resultados a 5 usuarios
```sql 
-- Limitar resultados a 5 usuarios
SELECT * FROM Users LIMIT 5;
```
![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.1.4.PNG)

#### Buscar usuarios con github definido
```sql 
-- Buscar usuarios con github definido
SELECT * FROM Users WHERE github IS NOT NULL;
```

![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.1.5.PNG)

#### Contar el número de usuarios con portafolio
```sql 
-- Contar el número de usuarios con portafolio
SELECT COUNT(*) FROM Users WHERE portfolio IS NOT NULL;

```
![contenido de lastablas ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.1.6.PNG)



#### Búsquedas complejas:

#### Subconsulta para encontrar usuarios
```sql 
-- Subconsulta para encontrar usuarios con más de 1 foto subida
SELECT username FROM Users WHERE user_id IN (
    SELECT user_id FROM Photos GROUP BY user_id HAVING COUNT(*) > 1
);
```
![Subconsulta para encontrar usuarios ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.2.1.PNG)

####  JOIN para obtener fotos y los comentarios asociados
```sql 
-- JOIN para obtener fotos y los comentarios asociados
SELECT Photos.photo_url, Comments.comment_text FROM Photos
JOIN Comments ON Photos.photo_id = Comments.photo_id;
```

![JOIN para obtener fotos y los comentarios ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.2.3.PNG)


#### Agregación para contar el número de fotos por usuario
```sql 
-- Agregación para contar el número de fotos por usuario
SELECT Users.username, COUNT(Photos.photo_id) as total_photos FROM Users
LEFT JOIN Photos ON Users.user_id = Photos.user_id
GROUP BY Users.username;
```
![Agregación para contar ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.2.3.PNG)


####  Subconsulta anidada para encontrar fotos con más de un comentario
```sql 
-- Subconsulta anidada para encontrar fotos con más de un comentario
SELECT photo_url FROM Photos WHERE photo_id IN (
    SELECT photo_id FROM Comments GROUP BY photo_id HAVING COUNT(comment_id) > 1
);
```

![Subconsulta anidada ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/6.2.4.PNG)

### 7. Triggers:

#### Trigger para mantener el recuento de fotos 

```sql 
-- Trigger para mantener el recuento de fotos de un usuario
DELIMITER //

CREATE TRIGGER after_photo_insert
AFTER INSERT ON Photos
FOR EACH ROW
BEGIN
    UPDATE Users
    SET photo_count = (SELECT COUNT(*) FROM Photos WHERE user_id = NEW.user_id)
    WHERE user_id = NEW.user_id;
END //

DELIMITER ;
```

![Trigger para mantener el recuento de fotos  ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/7.1.PNG)

#### Trigger para mantener el recuento de fotos 

```sql
-- Trigger para enviar un mensaje de bienvenida al crear un perfil

DELIMITER //
CREATE TRIGGER after_profile_insert
AFTER INSERT ON Profiles
FOR EACH ROW
BEGIN
    INSERT INTO Messages (user_id, message) VALUES (NEW.user_id, 'Bienvenido a IronSocial!');
END;
DELIMITER ;

``` 
![Trigger parapara enviar un mensaje de bienvenida al crear un perfil  ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/7.2.PNG)


### 8. Transacciones:

```sql

START TRANSACTION;

-- Inserta un nuevo usuario en la tabla Users
INSERT INTO users (username, password, email, github, portfolio) 
VALUES ('newuser', 'newpassword_hash', 'newuser@example.com', 'https://github.com/newuser', 'https://newuserportfolio.com');

-- Obtener el ID del usuario recién insertado
SET @new_user_id = LAST_INSERT_ID();

-- Inserta el perfil asociado al nuevo usuario en la tabla Profiles
INSERT INTO Profiles (user_id, bio) 
VALUES (@new_user_id, 'Esta es la biografía de New User');

COMMIT; // Confirma la transacción:

```  
![TRANSACTION ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/transaction01.PNG)

### Explicación TRANSACTION: 
La transacción realiza la inserción de un nuevo usuario y la creación de su perfil asociado. Se asegura de que ambas operaciones se completen con éxito.


### 9. Funciones:

```sql

-- Función para obtener el número de amigos de un usuario
CREATE FUNCTION GetFriendCount(user_id INT) RETURNS INT
BEGIN
    DECLARE friend_count INT;
    SELECT COUNT(*) INTO friend_count FROM Friends WHERE user_id = user_id;
    RETURN friend_count;
END;
```  

![Función para obtener el número de amigos de un usuario ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/funcion01.PNG)

```sql
-- Función para obtener el nombre de usuario por ID
CREATE FUNCTION GetUsername(user_id INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE username VARCHAR(50);
    SELECT username INTO username FROM Users WHERE user_id = user_id;
    RETURN username;
END;



```

![Función para obtener el nombre de usuario por ID ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/funcion02.PNG)

```sql
-- Función para obtener la URL de la foto más reciente de un usuario
CREATE FUNCTION GetLatestPhoto(user_id INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE photo_url VARCHAR(255);
    SELECT photo_url INTO photo_url FROM Photos WHERE user_id = user_id ORDER BY upload_date DESC LIMIT 1;
    RETURN photo_url;
END;

```  

![Función para obtener la URL de la foto ](https://github.com/ciberzerone/ironSocial/blob/main/imagen/funcion03.PNG)



## Instalación

### Prerrequisitos

- Python 3.2
- MySQL (o MariaDB)

### Instrucciones

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/ciberzerone/ironsocial.git
   cd ironsocial
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```
2. Crear un entorno virtual (opcional pero recomendado):
  ```bash
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```
3. Instalar las dependencias:
  ```bash
pip install -r requirements.txt
```

4. Configurar la base de datos:

- Crear una base de datos MySQL llamada ironsocial.
- Ejecutar el script SQL para crear las tablas necesarias.
- Configurar la conexión a la base de datos en app.py

5. Ejecutar la aplicación:

  ```bash
  python app.py
```
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

### Contacto
Para cualquier consulta o sugerencia, puedes contactarme a través de [gianmarcobeltran@gmail.com] o tu perfil de LinkedIn.

