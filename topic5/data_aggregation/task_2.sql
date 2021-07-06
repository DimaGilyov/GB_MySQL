/*
    Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
	Следует учесть, что необходимы дни недели текущего года, а не года рождения.
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
    DECLARE random_day INT DEFAULT 1; 
    WHILE i <= 10 DO 
        SET random_year = (RAND() * (2000 - 1968)) + 1968;
	    SET random_month = (RAND() * (12 - 1)) + 1;
        SET random_day = (RAND() * (28 - 1)) + 1;
        SET `date` = CONCAT(random_year,'-', random_month, '-', random_day, ' 00:00:00');
       INSERT INTO users (`name`, birthday) 
       VALUES (CONCAT("user_", i), `date`); 
	SET i = i + 1; 
    END WHILE;
END$$ 
DELIMITER ; 

CALL prepare_data;

-- Запрос по задаче
SELECT COUNT(DAYOFWEEK(CONCAT(YEAR(NOW()), SUBSTRING(birthday, 5)))) as days_count, 
       DAYNAME(CONCAT(YEAR(NOW()), SUBSTRING(birthday, 5))) as day_name
FROM users GROUP BY day_name;