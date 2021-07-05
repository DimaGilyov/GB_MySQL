/*
    В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
	если товар закончился и выше нуля, если на складе имеются запасы. 
    Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
	Однако нулевые запасы должны выводиться в конце, после всех записей.
*/

-- Создадим тестовую базу
CREATE DATABASE topic_5;
USE topic_5;

CREATE TABLE storehouses_products 
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `value` INT NOT NULL
);

-- Заполним таблицу данными
DELIMITER $$ 
CREATE PROCEDURE prepare_data() 
BEGIN
    DECLARE i INT DEFAULT 1; 
    DECLARE j INT DEFAULT 1; 
    WHILE i <= 15 DO 
       INSERT INTO storehouses_products (`value`) 
       VALUES (RAND()*100); 
	SET i = i + 1; 
    END WHILE;
    WHILE j <= 5 DO 
	    INSERT INTO storehouses_products (`value`) 
        VALUES (0); 
   SET j = j + 1; 
  END WHILE;
END$$ 
DELIMITER ; 

CALL prepare_data;

-- Запрос по задаче
SELECT `value`
FROM storehouses_products
ORDER BY IF( `value` = 0, 1, 0 ) , `value`;