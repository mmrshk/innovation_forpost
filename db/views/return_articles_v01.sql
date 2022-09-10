Select Articles.id AS article_id, Users.id AS user_id, Users.email, Tags.name, Articles.status, Articles.language, ck_editor_images.file 
From Articles
INNER Join article_tags ON Articles.id = article_tags.id
INNER Join Users ON Articles.user_id = Users.id
INNER JOIN tags ON article_tags.tag_id = tags.id 
INNER JOIN ck_editor_images ON Articles.id = ck_editor_images.id 
