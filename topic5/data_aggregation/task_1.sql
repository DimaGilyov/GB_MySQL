/*
    Подсчитайте средний возраст пользователей в таблице users.
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
    DECLARE random_year INT DEFAULT 1968; 
	DECLARE random_month INT DEFAULT 1; 
    WHILE i <= 5 DO 
        SET random_year = (RAND() * (2000 - 1968)) + 1968;
	    SET random_month = (RAND() * (12 - 1)) + 1;
        SET `date` = CONCAT(random_year,'-', random_month, '-01 00:00:00');
       INSERT INTO users (`name`, birthday) 
       VALUES (CONCAT("user_", i), `date`); 
	SET i = i + 1; 
    END WHILE;
END$$ 
DELIMITER ; 

CALL prepare_data;

-- Запрос по задаче
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) AS  average_age
FROM users;
    
