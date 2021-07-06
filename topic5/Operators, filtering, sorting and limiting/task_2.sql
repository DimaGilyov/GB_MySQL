/*
    Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом 
	VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. 
    Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения 
*/

-- Создадим тестовую базу
CREATE DATABASE topic_5;
USE topic_5;

CREATE TABLE users 
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    created_at VARCHAR(50),
    updated_at VARCHAR(50)
);

INSERT INTO users (`name`, created_at, updated_at) VALUES
("Dima", "20.10.2017 8:10", "20.10.2017 8:10"),
("Roma", "20.10.2017 8:10", "20.10.2017 8:10"),
("Katya", "20.10.2017 8:10", "20.10.2017 20:10"),
("Nastya", "20.10.2017 8:10", "20.10.2017 8:10");

-- Для начала сменим формат даты
UPDATE users SET
created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i')
WHERE id > 0;

-- запрос по задаче
ALTER TABLE users
CHANGE COLUMN created_at created_at DATETIME,
CHANGE COLUMN updated_at updated_at DATETIME;

SELECT * FROM users;