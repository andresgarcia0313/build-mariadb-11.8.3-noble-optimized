-- 01-init.sql
-- Ejemplo: crea una base y un usuario de aplicación.
-- La base de datos se llama db y el usuario user y la contraseña user1234.
CREATE DATABASE IF NOT EXISTS db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON db.* TO 'user'@'%';
FLUSH PRIVILEGES;
