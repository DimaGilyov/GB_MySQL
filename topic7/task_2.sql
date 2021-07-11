/*
    2)Выведите список товаров products и разделов catalogs, который соответствует товару.
*/


SELECT p.id, p.name, p.description, p.price, c.name AS catalog_name, p.created_at, p.updated_at 
FROM products AS p
LEFT JOIN catalogs AS c
ON p.catalog_id = c.id;