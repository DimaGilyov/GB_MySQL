/*
   5) Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
*/


SELECT 
user_id,
(
IFNULL((SELECT COUNT(from_user_id) FROM `message` WHERE `message`.from_user_id = `profile`.user_id), 0)  + 
IFNULL((SELECT COUNT(user_id) FROM `like` WHERE `like`.user_id = `profile`.user_id), 0) + 
IFNULL((SELECT COUNT(user_id) FROM `post` WHERE `post`.user_id = `profile`.user_id), 0)
) AS cft
FROM `profile`
ORDER BY cft LIMIT 1;