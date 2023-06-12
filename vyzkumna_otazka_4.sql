
SELECT 
	wage.payroll_year,
	ROUND(((wage.avarage_wage - wage_percentage.avarage_wage) / wage_percentage.avarage_wage * 100), 2) AS yearly_growth_wage,
	ROUND(((food.avarage_price_of_food - food_percentage.avarage_price_of_food) / food_percentage.avarage_price_of_food * 100), 2) AS yearly_growth_food
FROM
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
	GROUP BY payroll_year) wage
JOIN
	(SELECT
		ROUND(AVG(value), 2) AS avarage_price_of_food,
		CASE 
			WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
		END AS year_food		
	FROM t_tomas_marek_project_sql_primary_final
	GROUP BY year_food) food
ON wage.payroll_year = food.year_food
JOIN
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
	GROUP BY payroll_year) wage_percentage
ON wage.payroll_year = wage_percentage.payroll_year + 1
JOIN
	(SELECT
		ROUND(AVG(value), 2) AS avarage_price_of_food,
		CASE 
			WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
		END AS year_food		
	FROM t_tomas_marek_project_sql_primary_final
	GROUP BY year_food) food_percentage
ON wage.payroll_year = food_percentage.year_food + 1;
