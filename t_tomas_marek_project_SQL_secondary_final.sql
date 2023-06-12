
CREATE TABLE t_tomas_marek_project_sql_secondary_final AS
	SELECT
		country.country,
		country.continent,
		country.population,
		economy.YEAR,
		economy.GDP,
		economy.gini
	FROM
		(SELECT
			*
		FROM countries c) country 
	JOIN 
		(SELECT 
			*
		FROM economies e
		WHERE YEAR BETWEEN 2006 AND 2018) economy  
	ON country.country = economy.country
	WHERE continent = 'Europe'	
GROUP BY country.country, economy.YEAR DESC;
