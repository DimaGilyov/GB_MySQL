-- View, Информация по группам
CREATE VIEW groups_info AS 
SELECT g.title, u.first_name, gm.administrator, gm.ban  FROM `group_member` AS gm
JOIN `group` AS g
ON g.id = gm.group_id
JOIN `user` AS u
ON gm.user_id = u.id;

SELECT * FROM groups_info;


-- TRIGGER, Проверка на то что бы сообщение содержало только 1 контект. Либо это текст, либо медиа файлы. Медиа может влючать в себя описание "caption". caption не может быть без медиа. 
DELIMITER $$ 
CREATE TRIGGER message_insert BEFORE INSERT ON message
FOR EACH ROW
    BEGIN
    IF NEW.text IS NOT NULL AND (NEW.photo_id IS NOT NULL OR NEW.document_id IS NOT NULL OR NEW.audio_id IS NOT NULL
                                 OR NEW.audio_id IS NOT NULL OR NEW.animation_id IS NOT NULL OR NEW.caption IS NOT NULL) 
	OR NEW.photo_id IS NOT NULL AND (NEW.text IS NOT NULL OR NEW.document_id IS NOT NULL OR NEW.audio_id IS NOT NULL
                                 OR NEW.audio_id IS NOT NULL OR NEW.animation_id IS NOT NULL) 
    OR NEW.document_id IS NOT NULL AND (NEW.photo_id IS NOT NULL OR NEW.text IS NOT NULL OR NEW.audio_id IS NOT NULL
                                 OR NEW.audio_id IS NOT NULL OR NEW.animation_id IS NOT NULL) 
	OR NEW.audio_id IS NOT NULL AND (NEW.photo_id IS NOT NULL OR NEW.document_id IS NOT NULL OR NEW.text IS NOT NULL
                                 OR NEW.audio_id IS NOT NULL OR NEW.animation_id IS NOT NULL) 
	OR NEW.animation_id IS NOT NULL AND (NEW.photo_id IS NOT NULL OR NEW.document_id IS NOT NULL OR NEW.audio_id IS NOT NULL
                                 OR NEW.audio_id IS NOT NULL OR NEW.text IS NOT NULL)
    THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = "Can't fill multiple fields at the same time (text, photo_id, document_id, audio_id, animation_id, caption)";
	END IF;
    IF  NEW.caption IS NOT NULL AND (NEW.photo_id IS NULL AND NEW.document_id IS NULL AND NEW.audio_id IS NULL
                                     AND NEW.audio_id IS NULL AND NEW.animation_id IS NULL) 
	THEN
         SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "caption cannot be without media (text, photo_id, document_id, audio_id, animation_id, caption)";
    END IF;
END $$
DELIMITER ;

-- Проверка тригера
SELECT * FROM message;
INSERT INTO message (chat_id, from_user_id, to_user_id, `text`, photo_id, document_id, audio_id, animation_id, caption, created_at, readed_at)
VALUES (35, 17, 22, "Hello", 3, 5, 14, 58, "Hello", NOW(), NOW());