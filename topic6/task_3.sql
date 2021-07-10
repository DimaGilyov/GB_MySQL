/*
    3) Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
*/


SELECT COUNT(*) AS likes_count FROM `like`
WHERE user_id IN (SELECT user_id FROM (
				       SELECT user_id FROM `profile` ORDER BY birhday DESC LIMIT 10) AS t);
					 
					 
					 
					 