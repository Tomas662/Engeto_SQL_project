
CREATE TABLE t_tomas_marek_project_sql_secondary_final AS
	SELECT
		a.country,
		a.continent,
		a.population,
		b.YEAR,
		b.GDP,
		b.gini
	FROM
		(SELECT
			*
		FROM countries c) a 
	JOIN 
		(SELECT 
			*
		FROM economies e
		WHERE YEAR BETWEEN 2006 AND 2018) b  
	ON a.country = b.country
	WHERE continent = 'Europe'	
GROUP BY a.country, b.YEAR DESC;

/*
SELECT 
	*
FROM t_tomas_marek_project_sql_secondary_final;

DROP TABLE t_tomas_marek_project_sql_secondary_final;
*/
