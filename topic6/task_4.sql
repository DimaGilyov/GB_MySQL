/*
   4) Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/


SELECT (SELECT gender 
        FROM `profile` 
        WHERE `profile`.user_id = `like`.user_id) AS gender, COUNT(*)
FROM `like`
GROUP BY gender
ORDER BY gender DESC
LIMIT 1;