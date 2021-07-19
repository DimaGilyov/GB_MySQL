/*
    3) (по желанию) Пусть имеется таблица с календарным полем created_at. 
    В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2018-08-04', '2018-08-16' и 2018-08-17. 
    Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

-- Для начала создадим DB и таблицу и наполним таблицу данными из условия
CREATE DATABASE topic_9;
USE topic_9;
CREATE TABLE dates
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    created_at DATE NOT NULL
);

INSERT INTO dates (created_at)
VALUES ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');

-- Выполняем запрос
SELECT *, IF((SELECT created_at FROM dates WHERE created_at = `date`) IS NULL, 0, 1) AS val FROM 
(SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) `date` FROM
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
(SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
WHERE `date` BETWEEN '2018-08-01' AND '2018-08-31'
ORDER BY `date`;
 
