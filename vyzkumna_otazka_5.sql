
CREATE VIEW v_yearly_percentage_HDP AS
	(SELECT 
		HDP.YEAR,
		ROUND(((HDP.HDP - HDP_percentage.HDP) / HDP_percentage.HDP * 100), 2) AS yearly_percentage_HDP
	FROM
		(SELECT 
			country,
			YEAR,
			ROUND((GDP), 0) AS HDP
		FROM economies e
		WHERE country = 'Czech Republic'
		AND GDP IS NOT NULL
		GROUP BY year DESC) HDP
	JOIN 
		(SELECT 
			country,
			year,
			ROUND((GDP), 0) AS HDP
		FROM economies e
		WHERE country = 'Czech Republic'
		AND GDP IS NOT NULL
		GROUP BY year DESC) HDP_percentage
	ON HDP.YEAR = HDP_percentage.YEAR + 1);

CREATE VIEW v_yearly_percentage_wage AS
	(SELECT 
		wage.payroll_year,
		ROUND(((wage.avarage_wage - wage_percentage.avarage_wage) / wage_percentage.avarage_wage * 100), 2) AS yearly_percentage_wage
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
			ROUND(AVG(wages)) AS avarage_wage,
			payroll_year
		FROM t_tomas_marek_project_sql_primary_final
		WHERE value_type_code = 5958
			AND calculation_code = 100
			AND unit_code = 200
		GROUP BY payroll_year) wage_percentage
	ON wage.payroll_year = wage_percentage.payroll_year + 1);

CREATE VIEW v_yearly_percentage_food AS
	(SELECT
		food_percentage.year_food,
		ROUND(((food.avarage_price_of_food - food_percentage.avarage_price_of_food) / food_percentage.avarage_price_of_food * 100), 2) AS yearly_percentage_food
	FROM
		(SELECT
			ROUND(AVG(value), 2) AS avarage_price_of_food,
			CASE 
				WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
			END AS year_food		
		FROM t_tomas_marek_project_sql_primary_final
		GROUP BY year_food) food
	JOIN
		(SELECT
			ROUND(AVG(value), 2) AS avarage_price_of_food,
			CASE 
				WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
			END AS year_food		
		FROM t_tomas_marek_project_sql_primary_final
		GROUP BY year_food) food_percentage
	ON food.year_food = food_percentage.year_food + 1);

SELECT 
	a.*,
	b.yearly_percentage_wage,
	c.yearly_percentage_food
FROM
	(SELECT 
		YEAR,
		yearly_percentage_HDP
	FROM v_yearly_percentage_HDP) a 
JOIN
	(SELECT 
		payroll_year,
		yearly_percentage_wage
	FROM v_yearly_percentage_wage) b
ON a.YEAR = b.payroll_year
JOIN 
	(SELECT 
		yearly_percentage_food,
		year_food
	FROM v_yearly_percentage_food) c
ON a.YEAR = c.year_food	
GROUP BY a.year;
