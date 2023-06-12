
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
			country,
		 	continent,
		 	population
		FROM countries) country 
	JOIN 
		(SELECT 
			YEAR,
		 	GDP,
		 	gini,
		 	country
		FROM economies
		WHERE YEAR BETWEEN 2006 AND 2018) economy  
	ON country.country = economy.country
	WHERE continent = 'Europe'	
GROUP BY country.country, economy.YEAR DESC;
