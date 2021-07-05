/*
    Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
    Отсортируйте записи в порядке, заданном в списке IN
*/

-- Создадим тестовую базу
CREATE DATABASE topic_5;
USE topic_5;

CREATE TABLE catalogs 
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

-- Заполним таблицу данными
DELIMITER $$ 
CREATE PROCEDURE prepare_data() 
BEGIN
    DECLARE i INT DEFAULT 1; 
    WHILE i <= 10 DO 
       INSERT INTO catalogs (`name`) 
       VALUES (CONCAT("product_", i)); 
	SET i = i + 1; 
    END WHILE;
END$$ 
DELIMITER ; 

CALL prepare_data;

-- Запрос по задаче
SELECT * FROM catalogs WHERE id IN (5, 1, 2)
ORDER BY CASE
    WHEN id = 5 THEN 0
	WHEN id = 1 THEN 1
    WHEN id = 2 THEN 3
END;
    
