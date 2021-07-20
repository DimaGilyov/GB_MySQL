/*
    1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу 
       "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

DELIMITER $$
DROP FUNCTION IF EXISTS hello$$
CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC NO SQL 
BEGIN
   DECLARE currentTime TIME;
   SET currentTime = CURRENT_TIME();
   CASE
       WHEN currentTime BETWEEN "00:00" AND "05:00" THEN 
          RETURN 'Доброй ночи';
	   WHEN currentTime BETWEEN "06:00" AND "11:00" THEN 
          RETURN 'Доброе утро';
       WHEN currentTime BETWEEN "12:00" AND "17:00" THEN 
          RETURN 'Добрый день';
       WHEN currentTime BETWEEN "18:00" AND "23:00" THEN 
          RETURN 'Добрый вечер';
    END CASE;
END$$
DELIMITER ;

SELECT hello();