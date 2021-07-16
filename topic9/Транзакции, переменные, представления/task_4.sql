/*
    4)(по желанию) Пусть имеется любая таблица с календарным полем created_at. 
       Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
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
VALUES ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17'), ('2018-08-18'), ('2018-08-19'), ('2018-08-20');

-- Выполняем запрос
DELETE FROM dates
WHERE id NOT IN (SELECT d.id 
				 FROM (SELECT id 
					   FROM dates ORDER BY created_at  DESC LIMIT 5) as d);

SELECT * FROM dates 