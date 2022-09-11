SELECT Articles.id AS article_id, 
	Users.id AS user_id, 
	Users.email, 
	Tags.name, 
	Articles.status, 
	Articles.language, 
	COUNT(ck_editor_images.file ) 
FROM Articles
INNER JOIN article_tags ON Articles.id = article_tags.id
INNER JOIN Users ON Articles.user_id = Users.id
INNER JOIN tags ON article_tags.tag_id = tags.id 
INNER JOIN ck_editor_images ON Articles.id = ck_editor_images.id 
GROUP BY Articles.id, Users.id, Tags.name
