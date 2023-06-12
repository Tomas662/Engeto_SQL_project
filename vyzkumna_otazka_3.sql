
CREATE VIEW v_yearly_growth_of_food AS
	SELECT 
		price.avarage_price_yearly,
		price.category_code,
		price.year,
		info.name,
		info.price_value,
		info.price_unit,
		ROUND(((price.avarage_price_yearly - price_percentage.avarage_price_yearly) / price_percentage.avarage_price_yearly * 100), 2) AS yearly_growth
	FROM 
		(SELECT
			ROUND(AVG(value), 2) AS avarage_price_yearly,
			category_code,
			date_from,
			date_to,
			CASE 
				WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
			END AS year
		FROM t_tomas_marek_project_sql_primary_final 
		WHERE YEAR(date_from) = YEAR(date_to) 
		GROUP BY category_code, year) price
	JOIN 
		(SELECT
			code,
			name,
			price_value,
			price_unit
		FROM czechia_price_category cpc) info
	ON price.category_code = info.code
	JOIN
		(SELECT 
			ROUND(AVG(value), 2) AS avarage_price_yearly,
			YEAR(date_from) AS year,
			category_code
		FROM t_tomas_marek_project_sql_primary_final
		GROUP BY category_code, year) price_percentage
	ON price.category_code = price_percentage.category_code
	AND price.year = price_percentage.year + 1
	ORDER BY yearly_growth DESC

SELECT 
	name,
	category_code,
	price_value,
	price_unit,
	ROUND(AVG(yearly_growth), 2) AS yearly_avarage_change_of_price
FROM v_yearly_growth_of_food
GROUP BY category_code
ORDER BY AVG(yearly_growth)
LIMIT 1;
