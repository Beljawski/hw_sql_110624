-- Создать таблицу комментариев (comments) с использованием механизма валидации данных в SQL

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    track_id INT NOT NULL,
    comment_text TEXT NOT NULL CHECK (length(comment_text) > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_track FOREIGN KEY (track_id) REFERENCES tracks(id)
    );


-- Добавить в таблицу комментариев несколько записей

INSERT INTO comments (user_id, track_id, comment_text) VALUES
(1, 3, "Supeer track"),
(3,3,"I like it"),
(2,3, "It is wonderfull!"),
(2,1, "This is my favorite!"),
(2,2, "AWESOME!");


-- Вывести ко-во комментариев на каждый трек (в упорядоченном виде)

SELECT 
    tracks.title,
    COUNT(comments.id) AS comment_count
FROM 
    tracks
LEFT JOIN 
    comments ON tracks.id = comments.track_id
GROUP BY 
    tracks.title
ORDER BY 
    comment_count DESC, tracks.title ASC;