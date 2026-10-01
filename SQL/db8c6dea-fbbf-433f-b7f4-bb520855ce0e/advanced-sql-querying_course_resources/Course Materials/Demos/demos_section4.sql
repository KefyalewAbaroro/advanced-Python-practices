-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. Window function basics

-- Return all row numbers
SELECT	 country, year, happiness_score,
		 ROW_NUMBER() OVER() AS row_num
FROM	 happiness_scores
ORDER BY country, year;

-- Return all row numbers within each window
SELECT	 country, year, happiness_score,
		 ROW_NUMBER() OVER(PARTITION BY country) AS row_num
FROM	 happiness_scores
ORDER BY country, year;

-- Return all row numbers within each window
-- where the rows are ordered by happiness score
SELECT	 country, year, happiness_score,
		 ROW_NUMBER() OVER(PARTITION BY country ORDER BY happiness_score) AS row_num
FROM	 happiness_scores
ORDER BY country, row_num;

-- Return all row numbers within each window
-- where the rows are ordered by happiness score descending
SELECT	 country, year, happiness_score,
		 ROW_NUMBER() OVER(PARTITION BY country ORDER BY happiness_score DESC) AS row_num
FROM	 happiness_scores
ORDER BY country, row_num;

-- 2. ROW_NUMBER vs RANK vs DENSE_RANK
CREATE TABLE baby_girl_names (
    name VARCHAR(50),
    babies INT);

INSERT INTO baby_girl_names (name, babies) VALUES
	('Olivia', 99),
	('Emma', 80),
	('Charlotte', 80),
	('Amelia', 75),
	('Sophia', 72),
	('Isabella', 70),
	('Ava', 70),
	('Mia', 64);
    
-- View the table
SELECT * FROM baby_girl_names;

-- Compare ROW_NUMBER vs RANK vs DENSE_RANK
SELECT	name, babies,
		ROW_NUMBER() OVER(ORDER BY babies DESC) AS babies_rn,
        RANK() OVER(ORDER BY babies DESC) AS babies_rank,
        DENSE_RANK() OVER(ORDER BY babies DESC) AS babies_drank
FROM	baby_girl_names;

-- 3. FIRST_VALUE, LAST VALUE & NTH_VALUE
CREATE TABLE baby_names (
    gender VARCHAR(10),
    name VARCHAR(50),
    babies INT);

INSERT INTO baby_names (gender, name, babies) VALUES
	('Female', 'Charlotte', 80),
	('Female', 'Emma', 82),
	('Female', 'Olivia', 99),
	('Male', 'James', 85),
	('Male', 'Liam', 110),
	('Male', 'Noah', 95);
    
-- View the table
SELECT * FROM baby_names;
    
-- Return the first name in each window
SELECT	gender, name, babies,
		FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM	baby_names;
    
-- Return the top name for each gender
SELECT * FROM

(SELECT	gender, name, babies,
		FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM	baby_names) AS top_name

WHERE name = top_name;

-- CTE alternative
WITH top_name AS
(SELECT	gender, name, babies,
		FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM	baby_names) 

SELECT * 
FROM top_name
WHERE name = top_name;

-- Return the second name in each window
SELECT	gender, name, babies,
		NTH_VALUE(name, 2) OVER(PARTITION BY gender ORDER BY babies DESC) AS second_name
FROM	baby_names;

-- Return the 2nd most popular name for each gender
SELECT * FROM

(SELECT	gender, name, babies,
		NTH_VALUE(name, 2) OVER(PARTITION BY gender ORDER BY babies DESC) AS second_name
FROM	baby_names) AS second_name

WHERE name = second_name;

-- Alternative using ROW_NUMBER

-- Number all the rows within each window
SELECT	gender, name, babies,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY babies DESC) AS popularity
FROM	baby_names;

-- Return the top 2 most popular names for each gender
SELECT * FROM

(SELECT	gender, name, babies,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY babies DESC) AS popularity
FROM	baby_names) AS pop

WHERE popularity <= 2;

-- 4. LEAD & LAG

-- Return the prior year's happiness score
SELECT	country, year, happiness_score,
		LAG(happiness_score) OVER(PARTITION BY country ORDER BY year) AS prior_happiness_score
FROM	happiness_scores;

-- Return the difference between yearly scores
WITH hs_prior AS (SELECT	country, year, happiness_score,
							LAG(happiness_score) OVER(PARTITION BY country ORDER BY year)
                            AS prior_happiness_score
				  FROM		happiness_scores)
                  
SELECT  country, year, happiness_score, prior_happiness_score,
		happiness_score - prior_happiness_score AS hs_change
FROM	hs_prior;

-- 5. NTILE

-- Add a percentile to each row of data
SELECT	region, country, happiness_score,
		NTILE(4) OVER(PARTITION BY region ORDER BY happiness_score DESC) AS hs_percentile
FROM	happiness_scores
WHERE	year = 2023
ORDER BY region, happiness_score DESC;

-- For each region, return the top 25% of countries, in terms of happiness score
WITH hs_pct AS (SELECT	region, country, happiness_score,
						NTILE(4) OVER(PARTITION BY region ORDER BY happiness_score DESC)
                        AS hs_percentile
				FROM	happiness_scores
				WHERE	year = 2023
				ORDER BY region, happiness_score DESC)

			/* This ORDER BY clause in the CTE doesn't affect the final order of
			the query and can be removed to make the code run more efficiently */
                
SELECT	*
FROM	hs_pct
WHERE	hs_percentile = 1;