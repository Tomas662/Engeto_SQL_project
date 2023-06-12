
CREATE TABLE t_tomas_marek_project_sql_secondary_final AS
	SELECT
		countries.country,
		countries.continent,
		countries.population,
		economy.YEAR,
		economy.GDP,
		economy.gini
	FROM countries
	JOIN 
		(SELECT 
			YEAR,
		 	GDP,
		 	gini,
		 	country
		FROM economies
		WHERE YEAR BETWEEN 2006 AND 2018) economy  
	ON countries.country = economy.country
	WHERE continent = 'Europe'	
GROUP BY countries.country, economy.YEAR DESC;
