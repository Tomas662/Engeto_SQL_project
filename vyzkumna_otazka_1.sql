
SELECT 
	a.avarage_wage,
	a.industry_branch_code,
	a.payroll_year,
	b.name,
	ROUND(((a.avarage_wage - c.avarage_wage) / c.avarage_wage * 100), 2) AS yearly_growth
FROM
	(SELECT 
		ROUND(avg(wages)) AS avarage_wage,
		industry_branch_code,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
		AND industry_branch_code IS NOT NULL
	GROUP BY industry_branch_code, payroll_year) a
JOIN
	(SELECT code, name
	FROM czechia_payroll_industry_branch cpib) b 
ON b.code = a.industry_branch_code
JOIN 
	(SELECT
		ROUND(avg(wages)) AS avarage_wage,
		industry_branch_code,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
		AND industry_branch_code IS NOT NULL
	GROUP BY industry_branch_code, payroll_year) c
ON a.industry_branch_code = c.industry_branch_code
AND a.payroll_year = c.payroll_year + 1;
