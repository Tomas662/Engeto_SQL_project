
CREATE VIEW v_wage_quarter_2006_1 AS
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		payroll_year,
		payroll_quarter 
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
		AND payroll_year = 2006
		AND payroll_quarter = 1
	GROUP BY payroll_year, payroll_quarter);

CREATE VIEW v_wage_quarter_2018_4 AS
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		payroll_year,
		payroll_quarter 
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
		AND payroll_year = 2018
		AND payroll_quarter = 4
	GROUP BY payroll_year, payroll_quarter);

CREATE VIEW v_price_food_2006_1 AS 
	(SELECT 
		ROUND(AVG(value), 2) AS avarage_price,
		category_code
	FROM czechia_price
	WHERE date_from >= '2006-01-01' 
	AND date_to <= '2006-03-31'
	AND category_code IN('114201', '111301')
	GROUP BY category_code);

CREATE VIEW v_price_food_2018_4 AS 
	(SELECT 
		ROUND(AVG(value), 2) AS avarage_price,
		category_code
	FROM czechia_price cp
	WHERE date_from >= '2018-10-01' 
	AND date_to <= '2018-12-31'
	AND category_code IN('114201', '111301')
	GROUP BY category_code);

SELECT 
	wage.*,
	price.avarage_price,
	FLOOR((wage.avarage_wage / price.avarage_price)) AS possibility_purchase,
	info.*
FROM
	(SELECT 
		avarage_wage,
		payroll_year,
		payroll_quarter
	FROM v_wage_quarter_2018_4) wage
JOIN
	(SELECT
		avarage_price,
		category_code
	FROM v_price_food_2018_4) price
JOIN 
	(SELECT
		*
	FROM czechia_price_category cpc) info 
ON info.code = price.category_code;

SELECT 
	wage.*,
	price.avarage_price,
	FLOOR((wage.avarage_wage / price.avarage_price)) AS possibility_purchase,
	info.*
FROM
	(SELECT 
		avarage_wage,
		payroll_year,
		payroll_quarter
	FROM v_wage_quarter_2006_1) wage
JOIN
	(SELECT
		avarage_price,
		category_code
	FROM v_price_food_2006_1) price
JOIN 
	(SELECT
		*
	FROM czechia_price_category cpc) info 
ON info.code = price.category_code;
