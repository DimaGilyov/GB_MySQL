DROP DATABASE topic_5;

/*
    Подсчитайте произведение чисел в столбце таблицы.
*/

-- Создадим тестовую базу
CREATE DATABASE topic_5;
USE topic_5;

CREATE TABLE `number`
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `value` INT NOT NULL
);

-- Заполним таблицу данными
DELIMITER $$ 
CREATE PROCEDURE prepare_data() 
BEGIN
    DECLARE i INT DEFAULT 1; 
    DECLARE random_number INT DEFAULT 1; 
    WHILE i <= 5 DO 
        SET random_number = (RAND() * (5 - 1)) + 1;
       INSERT INTO `number` (`value`) 
       VALUES (random_number); 
	SET i = i + 1; 
    END WHILE;
END$$ 
DELIMITER ; 

CALL prepare_data;

SELECT * FROM `number`;

-- Запрос по задаче
SELECT ROUND(EXP(SUM(LOG(`value`))), 0) FROM `number`;