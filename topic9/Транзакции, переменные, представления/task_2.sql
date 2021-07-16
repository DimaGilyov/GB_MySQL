/*
    2) Создайте представление, которое выводит название name товарной позиции из таблицы products
       и соответствующее название каталога name из таблицы catalogs.
*/

CREATE VIEW prod AS 
SELECT p.name AS product_name, c.name AS catalog_name
FROM shop.products AS p
LEFT JOIN shop.catalogs AS c
ON c.id = p.catalog_id;

SELECT * FROM prod;