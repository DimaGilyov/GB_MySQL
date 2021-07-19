/*
    2) В таблице products есть два текстовых поля: name с названием товара и description с его
       описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля
       принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь
       того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям
       NULL-значение необходимо отменить операцию.
*/


USE shop;

SELECT * FROM products;
DELIMITER $$ 
CREATE TRIGGER products_insert BEFORE INSERT ON products
FOR EACH ROW
    BEGIN
    IF NEW.name IS NULL AND NEW.description IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'products.name and products.description is null';
	END IF;
END $$
DELIMITER ;

INSERT INTO products (name, description, price, catalog_id, created_at, updated_at)
VALUES (NULL, NULL, 234.0, 1, NOW(), NOW());