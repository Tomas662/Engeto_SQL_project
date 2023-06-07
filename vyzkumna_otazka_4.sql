
SELECT 
	a.payroll_year,
	ROUND(((a.avarage_wage - c.avarage_wage) / c.avarage_wage * 100), 2) AS yearly_growth_wage,
	ROUND(((b.avarage_price_of_food - d.avarage_price_of_food) / d.avarage_price_of_food * 100), 2) AS yearly_growth_food
FROM
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
	GROUP BY payroll_year) a
JOIN
	(SELECT
		ROUND(AVG(value), 2) AS avarage_price_of_food,
		CASE 
			WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
		END AS year_food		
	FROM t_tomas_marek_project_sql_primary_final
	GROUP BY year_food) b
ON a.payroll_year = b.year_food
JOIN
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
	GROUP BY payroll_year) c
ON a.payroll_year = c.payroll_year + 1
JOIN
	(SELECT
		ROUND(AVG(value), 2) AS avarage_price_of_food,
		CASE 
			WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
		END AS year_food		
	FROM t_tomas_marek_project_sql_primary_final
	GROUP BY year_food) d
ON a.payroll_year = d.year_food + 1;
