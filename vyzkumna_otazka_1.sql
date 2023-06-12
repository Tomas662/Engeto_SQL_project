
SELECT 
	wage.avarage_wage,
	wage.industry_branch_code,
	wage.payroll_year,
	info.name,
	ROUND(((wage.avarage_wage - wage_percentage.avarage_wage) / wage_percentage.avarage_wage * 100), 2) AS yearly_growth
FROM
	(SELECT 
		ROUND(AVG(wages)) AS avarage_wage,
		industry_branch_code,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
		AND industry_branch_code IS NOT NULL
	GROUP BY industry_branch_code, payroll_year) wage
JOIN
	(SELECT code, name
	FROM czechia_payroll_industry_branch cpib) info 
ON info.code = wage.industry_branch_code
JOIN 
	(SELECT
		ROUND(AVG(wages)) AS avarage_wage,
		industry_branch_code,
		payroll_year
	FROM t_tomas_marek_project_sql_primary_final
	WHERE value_type_code = 5958
		AND calculation_code = 100
		AND unit_code = 200
		AND industry_branch_code IS NOT NULL
	GROUP BY industry_branch_code, payroll_year) wage_percentage
ON wage.industry_branch_code = wage_percentage.industry_branch_code
AND wage.payroll_year = wage_percentage.payroll_year + 1;
