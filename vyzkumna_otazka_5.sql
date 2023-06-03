
CREATE VIEW v_yearly_percentage_HDP AS
	(SELECT 
		a.YEAR,
		ROUND(((a.HDP - b.HDP) / b.HDP * 100), 2) AS yearly_percentage_HDP
	FROM
		(SELECT 
			country,
			YEAR,
			ROUND((GDP), 0) AS HDP
		FROM economies e
		WHERE country = 'Czech Republic'
		AND GDP IS NOT NULL
		GROUP BY year DESC) a
	JOIN 
		(SELECT 
			country,
			year,
			ROUND((GDP), 0) AS HDP
		FROM economies e
		WHERE country = 'Czech Republic'
		AND GDP IS NOT NULL
		GROUP BY year  DESC) b
	ON a.YEAR = b.YEAR + 1);

/*
SELECT 
	*
FROM v_yearly_percentage_HDP;

DROP TABLE v_yearly_percentage_HDP;
*/

CREATE VIEW v_yearly_percentage_wage AS
	(SELECT 
		a.payroll_year,
		ROUND(((a.avarage_wage - b.avarage_wage) / b.avarage_wage * 100), 2) AS yearly_percentage_wage
	FROM	
		(SELECT 
			ROUND(avg(wages)) AS avarage_wage,
			payroll_year
		FROM t_tomas_marek_project_sql_primary_final
		WHERE value_type_code = 5958
			AND calculation_code = 100
			AND unit_code = 200
		GROUP BY payroll_year) a
	JOIN
	(SELECT 
			ROUND(avg(wages)) AS avarage_wage,
			payroll_year
		FROM t_tomas_marek_project_sql_primary_final
		WHERE value_type_code = 5958
			AND calculation_code = 100
			AND unit_code = 200
		GROUP BY payroll_year) b
	ON a.payroll_year = b.payroll_year + 1);

/*
SELECT 
	*
FROM v_yearly_percentage_wage;

DROP TABLE v_yearly_percentage_wage;
*/

CREATE VIEW v_yearly_percentage_food AS
	(SELECT
		b.year_food,
		ROUND(((a.avarage_price_of_food - b.avarage_price_of_food) / b.avarage_price_of_food * 100), 2) AS yearly_percentage_food
	FROM
		(SELECT
			ROUND(avg(value), 2) AS avarage_price_of_food,
			CASE 
				WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
			END AS year_food		
		FROM t_tomas_marek_project_sql_primary_final
		GROUP BY year_food) a
	JOIN
		(SELECT
			ROUND(avg(value), 2) AS avarage_price_of_food,
			CASE 
				WHEN YEAR(date_from) = YEAR(date_to) THEN YEAR(date_from)
			END AS year_food		
		FROM t_tomas_marek_project_sql_primary_final
		GROUP BY year_food) b
	ON a.year_food = b.year_food + 1);

/*
SELECT 
	*
FROM v_yearly_percentage_food;

DROP TABLE v_yearly_percentage_food;
*/

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
