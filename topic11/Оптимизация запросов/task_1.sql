/*
    1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
	   catalogs и products в таблицу logs помещается время и дата создания записи, 
       название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(100) NOT NULL,
	pk_id INT NOT NULL,
	`name` VARCHAR(100) NOT NULL
) ENGINE = ARCHIVE;


DROP TRIGGER IF EXISTS users_log;
DELIMITER $$
CREATE TRIGGER users_log AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, pk_id, `name`)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS catalogs_log;
DELIMITER $$
CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, pk_id, `name`)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS products_log;
DELIMITER $$
CREATE TRIGGER products_log AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, pk_id, `name`)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END $$
DELIMITER ;

