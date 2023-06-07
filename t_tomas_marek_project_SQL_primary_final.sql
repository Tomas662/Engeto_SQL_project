-- Tomáš M.#0524

CREATE TABLE IF NOT EXISTS t_tomas_marek_project_sql_primary_final AS
SELECT
	cpay.value AS wages,
	cpay.value_type_code,
	cpay.unit_code,
	cpay.calculation_code,
	cpay.industry_branch_code,
	cpay.payroll_year,
	cpay.payroll_quarter,
	cp.value,
	cp.category_code,
	cp.date_from,
	cp.date_to
FROM czechia_payroll cpay
JOIN czechia_price cp 
ON cpay.payroll_year = YEAR(cp.date_from);
