/*
    1)Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

SELECT u.name 
FROM orders AS o
JOIN users AS u
ON u.id = o.user_id
GROUP BY u.name;