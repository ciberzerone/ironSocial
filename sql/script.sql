CREATE DATABASE IronSocial;
USE IronSocial;

-- Tabla de Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    github VARCHAR(100),
    portfolio VARCHAR(100)
);

-- Tabla de Perfiles (One-to-One con Users)
CREATE TABLE Profiles (
    profile_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);


-- Tabla de Photos (One-to-Many con Users)
CREATE TABLE Photos (
    photo_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    photo_url VARCHAR(255) NOT NULL,
    caption TEXT,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Tabla de Friends (Many-to-Many entre Usuarios)
CREATE TABLE Friends (
    user_id INT,
    friend_id INT,
    PRIMARY KEY (user_id, friend_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

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

-- ALTER TABLE para añadir un nuevo campo en Users
ALTER TABLE Users ADD COLUMN profile_picture VARCHAR(255);
-- Modificar la tabla de usuarios si es necesario para incluir campos adicionales
ALTER TABLE Users ADD COLUMN session_token VARCHAR(255);


-- 5. Contenido de las tablas:
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


-- Búsquedas: Realiza al menos 10 tipos de búsquedas simples.
-- Seleccionar todos los usuarios
SELECT * FROM Users;

-- Seleccionar usuarios con un ID par
SELECT * FROM Users WHERE MOD(user_id, 2) = 0;

-- Ordenar usuarios por nombre de usuario
SELECT * FROM Users ORDER BY username ASC;

-- Limitar resultados a 5 usuarios
SELECT * FROM Users LIMIT 5;

-- Buscar usuarios con github definido
SELECT * FROM Users WHERE github IS NOT NULL;


-- Contar el número de usuarios con portafolio
SELECT COUNT(*) FROM Users WHERE portfolio IS NOT NULL;


-- 6.2 Búsquedas Complejas

-- Subconsulta para encontrar usuarios con más de 1 foto subida
SELECT username FROM Users WHERE user_id IN (
    SELECT user_id FROM Photos GROUP BY user_id HAVING COUNT(*) > 1
);

-- JOIN para obtener fotos y los comentarios asociados
SELECT Photos.photo_url, Comments.comment_text FROM Photos
JOIN Comments ON Photos.photo_id = Comments.photo_id;

-- Agregación para contar el número de fotos por usuario
SELECT Users.username, COUNT(Photos.photo_id) as total_photos FROM Users
LEFT JOIN Photos ON Users.user_id = Photos.user_id
GROUP BY Users.username;

-- Subconsulta anidada para encontrar fotos con más de un comentario
SELECT photo_url FROM Photos WHERE photo_id IN (
    SELECT photo_id FROM Comments GROUP BY photo_id HAVING COUNT(comment_id) > 1
);

-- 7. Triggers: Crea al menos dos triggers dentro de la base de datos.
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


-- Trigger para enviar un mensaje de bienvenida al crear un perfil

DELIMITER //
CREATE TRIGGER after_profile_insert
AFTER INSERT ON Profiles
FOR EACH ROW
BEGIN
    INSERT INTO Messages (user_id, message) VALUES (NEW.user_id, 'Bienvenido a IronSocial!');
END;
DELIMITER ;

-- 8. TRANSACTION;: ## Implementación de una Transacción con Operaciones de Manipulación de Datos


START TRANSACTION;

-- Inserta un nuevo usuario en la tabla Users
INSERT INTO users (username, password, email, github, portfolio) 
VALUES ('newuser', 'newpassword_hash', 'newuser@example.com', 'https://github.com/newuser', 'https://newuserportfolio.com');

-- Obtener el ID del usuario recién insertado
SET @new_user_id = LAST_INSERT_ID();

-- Inserta el perfil asociado al nuevo usuario en la tabla Profiles
INSERT INTO Profiles (user_id, bio) 
VALUES (@new_user_id, 'Esta es la biografía de New User');

COMMIT;


-- 9. Funciones:  Definidas por el Usuario

-- Función para obtener el número de amigos de un usuario
CREATE FUNCTION GetFriendCount(user_id INT) RETURNS INT
BEGIN
    DECLARE friend_count INT;
    SELECT COUNT(*) INTO friend_count FROM Friends WHERE user_id = user_id;
    RETURN friend_count;
END;

-- Función para obtener el nombre de usuario por ID
CREATE FUNCTION GetUsername(user_id INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE username VARCHAR(50);
    SELECT username INTO username FROM Users WHERE user_id = user_id;
    RETURN username;
END;

-- Función para obtener la URL de la foto más reciente de un usuario
CREATE FUNCTION GetLatestPhoto(user_id INT) RETURNS VARCHAR(255)
BEGIN
    DECLARE photo_url VARCHAR(255);
    SELECT photo_url INTO photo_url FROM Photos WHERE user_id = user_id ORDER BY upload_date DESC LIMIT 1;
    RETURN photo_url;
END;

