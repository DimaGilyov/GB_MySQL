/*
    3)Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
      Поля from, to и label содержат английские названия городов, поле name — русское. 
      Выведите список рейсов flights с русскими названиями городов.
*/


CREATE DATABASE topic_7;
USE topic_7;

CREATE TABLE flights
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `from` VARCHAR(50) NOT NULL,
	`to` VARCHAR(50) NOT NULL
);

CREATE TABLE cities
(
    `label` VARCHAR(50) NOT NULL,
	`name` VARCHAR(50) NOT NULL
);

INSERT INTO flights (`from`, `to`)
VALUES 
('moscow', 'omsk'),
('novgorod', 'kazan'),
('irkutsk', 'moscow'),
('omsk', 'irkutsk'),
('moscow', 'kazan');

INSERT INTO cities (`label`, `name`)
VALUES 
('moscow', 'Москва'),
('novgorod', 'Новгород'),
('irkutsk', 'Иркутск'),
('omsk', 'Омск'),
('kazan', 'Казань');

-- Запрос по задаче
SELECT f.id, f.from, c.name AS `to`
FROM (SELECT f.id, c.name AS `from`, f.to 
	  FROM flights AS f
	  LEFT JOIN cities AS c
      ON c.label = f.from) AS f
LEFT JOIN cities AS c
ON c.label = f.to;


