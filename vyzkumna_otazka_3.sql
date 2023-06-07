
SELECT 
	a.avarage_price,
	a.category_code,
	a.year,
	b.name,
	b.price_value,
	b.price_unit,
	ROUND(((a.avarage_price - c.avarage_price) / c.avarage_price * 100), 2) AS yearly_growth
FROM 
	(SELECT
		ROUND(AVG(value), 2) AS avarage_price,
		category_code,
		date_from,
		date_to,
		CASE 
			WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
		END AS year
	FROM t_tomas_marek_project_sql_primary_final 
	WHERE YEAR(date_from) = YEAR(date_to) 
	GROUP BY category_code, year) a
JOIN 
	(SELECT
		code,
		name,
		price_value,
		price_unit
	FROM czechia_price_category cpc) b
ON a.category_code = b.code
JOIN
	(SELECT 
		ROUND(AVG(value), 2) AS avarage_price,
		YEAR(date_from) AS year,
		category_code
	FROM t_tomas_marek_project_sql_primary_final
	GROUP BY category_code, year) c
ON a.category_code = c.category_code
AND a.year = c.year + 1
ORDER BY yearly_growth DESC;
