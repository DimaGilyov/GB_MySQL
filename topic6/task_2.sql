/* 
    2) Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
*/

-- Для начала добавим немного записей, иначе там очень мало сообщений для этого задания.
INSERT INTO message (from_user_id, to_user_id, `text`, created_at, read_at)
VALUES 
(17, 13, "Hello", NOW(), NOW()), 
(17, 13, "Hello", NOW(), NOW()),
(21, 13, "Hello", NOW(), NOW()),
(21, 13, "Hello", NOW(), NOW()),
(17, 13, "Hello", NOW(), NOW()),
(17, 13, "Hello", NOW(), NOW()),
(17, 13, "Hello", NOW(), NOW()),
(13, 21, "Hello", NOW(), NOW()), 
(13, 21, "Hello", NOW(), NOW()),
(13, 21, "Hello", NOW(), NOW()),
(13, 21, "Hello", NOW(), NOW()),
(13, 21, "Hello", NOW(), NOW()),
(13, 21, "Hello", NOW(), NOW());


-- Находим пользователя который больше всех отправил сообщений нашему пользователю c id=13.
SELECT from_user_id, COUNT(from_user_id) AS message_count 
FROM message 
WHERE to_user_id = 13 
GROUP BY from_user_id 
ORDER BY message_count DESC
LIMIT 1;



-- Находим пользователя c которым велась самая активная переписка.
SELECT from_user_id as user_id, COUNT(from_user_id) as message_count 
FROM (SELECT from_user_id
      FROM message 
      WHERE from_user_id = 13 OR to_user_id = 13
      UNION ALL
      SELECT to_user_id
      FROM message 
      WHERE from_user_id = 13 OR to_user_id = 13) AS t
WHERE from_user_id != 13
GROUP BY from_user_id
ORDER BY message_count DESC
LIMIT 1;