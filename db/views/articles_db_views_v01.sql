SELECT Article_tags.article_id,	Articles.title,
		Articles.created_at, Tags.name AS Tag_name, Articles.text
FROM Article_tags
RIGHT JOIN Articles
	ON Articles.id = Article_tags.article_id
LEFT JOIN Tags
	ON Article_tags.tag_id = Tags.id
WHERE user_id =
	(SELECT id FROM Users WHERE email = 'admin@example.com')
	AND	(SELECT DATE_PART('day', CURRENT_DATE - Articles.updated_at) < 14)
	AND (SELECT name IN('work', 'Work', 'робота', 'Робота'))
ORDER BY created_at DESC
	