/*
1) Написать 3-4 запроса:
    SELECT, GROUP BY + FN, JOIN, HAVING
*/

/*
    1) Количество групп которые администрирует пользователь
*/

SELECT u.first_name, u.username, COUNT(*) AS administration_group_count FROM `group_member` AS gm
JOIN `group` AS g
ON g.id = gm.group_id
JOIN `user` AS u
ON u.id = gm.user_id
WHERE gm.administrator = 1
GROUP By u.first_name
ORDER BY administration_group_count DESC;


/*
    2) Запрос в исследовательских целях. В сообщениях есть поля из какого чата, кем и кому было отправлено сообщение. 
	   По логике будет ошибка если участинк пишет сообщение в группу в которой не состоит, или пишет участнику группы который не состоит в группе. 
	   Проверим насколько корректно вставил данные сервис FillDB.
*/

-- Узнаем id группы
SELECT * FROM `chat`
WHERE id = 31; 

-- Узнаем участников группы
SELECT * FROM `group_member`
WHERE group_id  = 1; 

-- Смотрим кто и кому отправлял сообщения от имени этой группы
SELECT id, chat_id, from_user_id, to_user_id FROM message
WHERE  chat_id = 31;

 /*
 Корректные данные которые реально могли отправится, не считаяя что в группе пользователь отправил данные сам себе =)) 
105	31	14	16
320	31	14	14
444	31	24	28
 */
 
 -- Запрос на вывод корректных данных в таблице message, которые мы проанализировали по отдельности.
SELECT correct_user_to.* FROM (SELECT group_member.id,group_member.user_id AS gr_user, m.id as msg_id, m.chat_id, m.from_user_id, m.to_user_id FROM message AS m
                               LEFT JOIN (SELECT c.id, gm.group_id, gm.user_id FROM `group_member` AS gm
                                          JOIN `chat` AS c
                                          ON c.group_id = gm.group_id 
                                          WHERE gm.group_id  = (SELECT group_id FROM `chat` WHERE id = 31)) as group_member
                               ON group_member.user_id = from_user_id
                               WHERE group_member.id IS NOT NULL AND m.chat_id = group_member.id) AS correct_user_from
JOIN (SELECT group_member.id,group_member.user_id AS gr_user, m.id as msg_id, m.chat_id, m.from_user_id, m.to_user_id FROM message AS m
      LEFT JOIN (SELECT c.id, gm.group_id, gm.user_id FROM `group_member` AS gm
                 JOIN `chat` AS c
                 ON c.group_id = gm.group_id 
                 WHERE gm.group_id  = (SELECT group_id FROM `chat` WHERE id = 31)) as group_member
      ON group_member.user_id = to_user_id
      WHERE group_member.id IS NOT NULL AND m.chat_id = group_member.id) AS correct_user_to
ON correct_user_from.msg_id = correct_user_to.msg_id;

-- Честно говоря. какой то извращенский запрос, но вроде работает.

/*
    3) Посчитаем 5 самых активных иточников трафика. Вытащим имена чатов, тип чата (лс, чат, канал) и посчитаем количество сообщений.
*/

SELECT statistic.id, 
(case when user_id IS NOT NULL then "private messages"
	  when group_id IS NOT NULL then "group"
	  when channel_id IS NOT NULL then "channel"
end) as chat_type, 
(case when user_id IS NOT NULL then (SELECT username FROM `user` WHERE user_id = `user`.id)
	  when group_id IS NOT NULL then (SELECT title FROM `group` WHERE group_id = `group`.id)
	  when channel_id IS NOT NULL then (SELECT title FROM `channel` WHERE channel_id = `channel`.id)
end) as chat_name, 
statistic.message_count 
FROM (SELECT c.id, c.user_id, c.group_id, c.channel_id, COUNT(*) as message_count
                              FROM message as m
                              JOIN chat AS c
                              ON c.id = m.chat_id
                              GROUP BY chat_id
                              ORDER BY message_count DESC
                              LIMIT 5) AS statistic;