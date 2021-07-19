/*
    3) (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
        в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

*/

DELIMITER $$
DROP FUNCTION IF EXISTS FIBONACCI $$
CREATE FUNCTION FIBONACCI (num INT)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE lastValue1, lastValue2 INT DEFAULT 1;
    DECLARE i, result INT DEFAULT 0;
	DECLARE isPositiveNumber BOOLEAN DEFAULT TRUE;
     IF (num < 0) THEN
         SET num = ABS(num);
         SET isPositiveNumber = FALSE;
     END IF;
        WHILE i < num DO
           IF i < 2 THEN
               SET result = i;
		   ELSE
                 SET result = lastValue1 + lastValue2;
                 SET lastValue1 = lastValue2;
                 SET lastValue2 = result;
		   END IF;
           SET i = i + 1;
        END WHILE;
	IF (isPositiveNumber IS FALSE) THEN
         SET result = -result;
	END IF;
     return result;
END $$
DELIMITER ;

SELECT FIBONACCI(10);

