/*
    Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august).
*/

-- Создадим тестовую базу
CREATE DATABASE topic_5;
USE topic_5;

CREATE TABLE users 
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    birthday DATETIME NOT NULL
);

-- Заполним таблицу данными
DELIMITER $$ 
CREATE PROCEDURE prepare_data() 
BEGIN
    DECLARE i INT DEFAULT 1; 
	DECLARE `date` DATETIME; 
	DECLARE random_month INT DEFAULT 1; 
    WHILE i <= 100 DO 
	    SET random_month = (RAND() * (12 - 1)) + 1;
        SET `date` = CONCAT('2021-', random_month, '-06 03:21:52');
       INSERT INTO users (`name`, birthday) 
       VALUES (CONCAT("user_", i), `date`); 
	SET i = i + 1; 
    END WHILE;
END$$ 
DELIMITER ; 

CALL prepare_data;

-- Запрос по задаче
SELECT `name`,
   MONTHNAME(birthday) AS `month`
FROM users
WHERE DATE_FORMAT(birthday, '%m') = 08 OR DATE_FORMAT(birthday, '%m') = 05;