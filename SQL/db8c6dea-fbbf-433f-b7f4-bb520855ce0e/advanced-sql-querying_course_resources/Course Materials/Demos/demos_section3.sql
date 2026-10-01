-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. Subqueries in the SELECT clause
SELECT * FROM happiness_scores;

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Happiness score deviation from the average
SELECT	year, country, happiness_score,
		(SELECT AVG(happiness_score) FROM happiness_scores) AS avg_hs,
        happiness_score - (SELECT AVG(happiness_score) FROM happiness_scores) AS diff_from_avg
FROM	happiness_scores;

-- 2. Subqueries in the FROM clause
SELECT * FROM happiness_scores;

-- Average happiness score for each country
SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
FROM	 happiness_scores
GROUP BY country;

/* Return a country's happiness score for the year as well as
the average happiness score for the country across years */
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;
            
-- View one country
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country
WHERE	hs.country = 'United States';
            
-- 3. Multiple subqueries

-- Return happiness scores for 2015 - 2024
SELECT DISTINCT year FROM happiness_scores;
SELECT * FROM happiness_scores_current;

SELECT year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score FROM happiness_scores_current;
            
/* Return a country's happiness score for the year as well as
the average happiness score for the country across years */
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	(SELECT year, country, happiness_score FROM happiness_scores
		 UNION ALL
		 SELECT 2024, country, ladder_score FROM happiness_scores_current) AS hs
         LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;
       
/* Return years where the happiness score is a whole point
greater than the country's average happiness score */
SELECT * FROM

(SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	(SELECT year, country, happiness_score FROM happiness_scores
		 UNION ALL
		 SELECT 2024, country, ladder_score FROM happiness_scores_current) AS hs
         LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country) AS hs_country_hs
        
WHERE happiness_score > avg_hs_by_country + 1;

-- 4. Subqueries in the WHERE and HAVING clauses

-- Average happiness score
SELECT AVG(happiness_score) FROM happiness_scores;

-- Above average happiness scores (WHERE)
SELECT	*
FROM	happiness_scores
WHERE	happiness_score > (SELECT AVG(happiness_score) FROM happiness_scores);

-- Above average happiness scores for each region (HAVING)
SELECT	 region, AVG(happiness_score) AS avg_hs
FROM	 happiness_scores
GROUP BY region
HAVING	 avg_hs > (SELECT AVG(happiness_score) FROM happiness_scores);

-- 5. ANY vs ALL
SELECT * FROM happiness_scores; -- 2015-2023
SELECT * FROM happiness_scores_current; -- 2024

-- Scores that are greater than ANY 2024 scores
SELECT 	COUNT(*)
FROM 	happiness_scores
WHERE	happiness_score > 
		ANY(SELECT  ladder_score
			FROM	happiness_scores_current);
            
SELECT 	COUNT(*)
FROM 	happiness_scores;

-- Scores that are greater than ALL 2024 scores
SELECT 	*
FROM 	happiness_scores
WHERE	happiness_score > 
		ALL(SELECT  ladder_score
			FROM	happiness_scores_current);

-- 6. EXISTS
SELECT * FROM happiness_scores;
SELECT * FROM inflation_rates;

/* Return happiness scores of countries
that exist in the inflation rates table */
SELECT	*
FROM 	happiness_scores h
WHERE	EXISTS (
		SELECT	i.country_name
        FROM	inflation_rates i
        WHERE	i.country_name = h.country);

-- Alternative to EXISTS: INNER JOIN
SELECT	*
FROM 	happiness_scores h
		INNER JOIN inflation_rates i
        ON h.country = i.country_name AND h.year = i.year;
     
-- 7. CTEs: Readability

/* SUBQUERY: Return the happiness scores along with
   the average happiness score for each country */
SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN
		(SELECT	 country, AVG(happiness_score) AS avg_hs_by_country
		 FROM	 happiness_scores
		 GROUP BY country) AS country_hs
		ON hs.country = country_hs.country;

/* CTE: Return the happiness scores along with
   the average happiness score for each country */
WITH country_hs AS (SELECT	 country,
							 AVG(happiness_score) AS avg_hs_by_country
				    FROM	 happiness_scores
				    GROUP BY country)

SELECT	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs_by_country
FROM	happiness_scores hs LEFT JOIN country_hs
		ON hs.country = country_hs.country;
   
-- 8. CTEs: Reusability
        
-- SUBQUERY: Compare the happiness scores within each region in 2023
SELECT * FROM happiness_scores WHERE year = 2023;

SELECT	hs1.region, hs1.country, hs1.happiness_score,
		hs2.country, hs2.happiness_score
FROM	happiness_scores hs1 INNER JOIN happiness_scores hs2
		ON hs1.region = hs2.region;
        
SELECT	hs1.region, hs1.country, hs1.happiness_score,
		hs2.country, hs2.happiness_score
FROM	(SELECT * FROM happiness_scores WHERE year = 2023) hs1
		INNER JOIN
        (SELECT * FROM happiness_scores WHERE year = 2023) hs2
		ON hs1.region = hs2.region;

-- CTE: Compare the happiness scores within each region in 2023
WITH hs AS (SELECT * FROM happiness_scores WHERE year = 2023)

SELECT	hs1.region, hs1.country, hs1.happiness_score,
		hs2.country, hs2.happiness_score
FROM	hs hs1 INNER JOIN hs hs2
		ON hs1.region = hs2.region
WHERE	hs1.country < hs2.country;

-- 9. Multiple CTEs

-- Step 1: Compare 2023 vs 2024 happiness scores side by side
WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
	 hs24 AS (SELECT * FROM happiness_scores_current)
     
SELECT	hs23.country,
		hs23.happiness_score AS hs_2023,
        hs24.ladder_score AS hs_2024
FROM	hs23 LEFT JOIN hs24
		ON hs23.country = hs24.country;

-- Step 2: Return the countries where the score increased
SELECT * FROM

(WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
	 hs24 AS (SELECT * FROM happiness_scores_current)
     
SELECT	hs23.country,
		hs23.happiness_score AS hs_2023,
        hs24.ladder_score AS hs_2024
FROM	hs23 LEFT JOIN hs24
		ON hs23.country = hs24.country) AS hs_23_24
        
WHERE hs_2024 > hs_2023;

-- Alternative: CTEs only
WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
	 hs24 AS (SELECT * FROM happiness_scores_current),
     hs_23_24 AS (SELECT	hs23.country,
							hs23.happiness_score AS hs_2023,
							hs24.ladder_score AS hs_2024
					FROM	hs23 LEFT JOIN hs24
							ON hs23.country = hs24.country)
SELECT *
FROM hs_23_24
WHERE hs_2024 > hs_2023;

-- 10. Recursive CTEs

-- Create a stock prices table
CREATE TABLE IF NOT EXISTS stock_prices (
    date DATE PRIMARY KEY,
    price DECIMAL(10, 2)
);

INSERT INTO stock_prices (date, price) VALUES
	('2024-11-01', 678.27),
	('2024-11-03', 688.83),
	('2024-11-04', 645.40),
	('2024-11-06', 591.01);
    
/* Employee table was created in prior section:
   This is the code if you need to create it again */
    
/*
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary INT,
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, salary, manager_id) VALUES
	(1, 'Ava', 85000, NULL),
	(2, 'Bob', 72000, 1),
	(3, 'Cat', 59000, 1),
	(4, 'Dan', 85000, 2);
*/

-- Example 1: Generating sequences
SELECT * FROM stock_prices;

-- Generate a column of dates
WITH RECURSIVE my_dates(dt) AS
	(SELECT '2024-11-01'
     UNION ALL
     SELECT dt + INTERVAL 1 DAY
     FROM my_dates
     WHERE dt < '2024-11-06')
     
SELECT * FROM my_dates;

-- Include the original prices
WITH RECURSIVE my_dates(dt) AS
	(SELECT '2024-11-01'
     UNION ALL
     SELECT dt + INTERVAL 1 DAY
     FROM my_dates
     WHERE dt < '2024-11-06')
     
SELECT	md.dt, sp.price
FROM	my_dates md
		LEFT JOIN stock_prices sp
        ON md.dt = sp.date;

-- Example 2: Working with hierachical data
SELECT * FROM employees;

-- Return the reporting chain for each employee
WITH RECURSIVE employee_hierarchy AS (
    SELECT	employee_id, employee_name, manager_id,
			employee_name AS hierarchy
    FROM	employees
    WHERE	manager_id IS NULL
    
    UNION ALL
    
    SELECT	e.employee_id, e.employee_name, e.manager_id,
			CONCAT(eh.hierarchy, ' > ', e.employee_name) AS hierarchy
    FROM	employees e INNER JOIN employee_hierarchy eh
			ON e.manager_id = eh.employee_id
)

SELECT	employee_id, employee_name,
		manager_id, hierarchy
FROM	employee_hierarchy
ORDER BY employee_id;

-- 11. Subquery vs CTE vs Temp Table vs View

-- Subquery
SELECT * FROM

(SELECT	year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT	2024, country, ladder_score FROM happiness_scores_current) AS my_subquery;

-- CTE
WITH my_cte AS (SELECT	year, country, happiness_score FROM happiness_scores
				UNION ALL
				SELECT	2024, country, ladder_score FROM happiness_scores_current)
                
SELECT * FROM my_cte;

-- Temporary table
CREATE TEMPORARY TABLE my_temp_table AS
SELECT	year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT	2024, country, ladder_score FROM happiness_scores_current;

SELECT * FROM my_temp_table;

-- View
CREATE VIEW my_view AS
SELECT	year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT	2024, country, ladder_score FROM happiness_scores_current;

SELECT * FROM my_view;