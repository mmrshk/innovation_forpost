SELECT articles.id AS article_id, 
	articles.status, 
	articles.language, 
	users.id AS user_id, 
	users.email, 
	string_agg(Tags.name, ',') AS tag_names,
	COUNT(ck_editor_images.file ) AS images_count
FROM articles
LEFT JOIN article_tags ON articles.id = article_tags.article_id
INNER JOIN users ON articles.user_id = users.id
LEFT JOIN tags ON article_tags.tag_id = tags.id 
LEFT JOIN ck_editor_images ON Articles.id = ck_editor_images.id 
GROUP BY articles.id,users.id;
