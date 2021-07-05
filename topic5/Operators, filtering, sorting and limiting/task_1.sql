/*Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
  Заполните их текущими датой и временем. */

-- Создадим тестовую базу
CREATE DATABASE topic_5;
USE topic_5;

CREATE TABLE users 
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    created_at DATETIME,
    updated_at DATETIME
);

INSERT INTO users (`name`) VALUES
("Dima"),
("Roma"),
("Katya"),
("Nastya");

SELECT * FROM users;

-- запрос по задаче
UPDATE users SET
created_at = NOW(),
updated_at = NOW()
WHERE id > 0;

-- проверяем
SELECT * FROM users;


