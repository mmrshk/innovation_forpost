-- SELECT * FROM articles WHERE status = 1;

SELECT Articles.id, Users.id, tags.name
FROM Articles 
INNER JOIN Users ON Articles.user_id = Users.id
INNER Join article_tags ON Articles.id = article_tags.id
INNER JOIN tags ON article_tags.tag_id = tags.id AND tags.name IN ('Work', 'Робота')
WHERE Users.email = 'admin@example.com' 
  AND Articles.created_at > now()::date - 14;
