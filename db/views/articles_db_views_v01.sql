SELECT article_tags.article_id,	articles.title,
		articles.created_at, tags.name AS tag_name, articles.text
	FROM articles
LEFT JOIN article_tags
	ON article_tags.article_id = articles.id
LEFT JOIN tags
	ON article_tags.tag_id = tags.id
WHERE user_id =
	(SELECT id FROM users WHERE email = 'admin@example.com')
	AND	(SELECT DATE_PART('day', CURRENT_DATE - articles.updated_at) < 14)
	AND (SELECT name IN('work', 'Work', 'робота', 'Робота'))
ORDER BY created_at DESC
