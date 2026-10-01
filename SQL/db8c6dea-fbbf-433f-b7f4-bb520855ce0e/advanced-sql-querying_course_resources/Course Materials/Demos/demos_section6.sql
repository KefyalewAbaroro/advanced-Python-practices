-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. DUPLICATE VALUES

CREATE TABLE employee_details (
    region VARCHAR(50),
    employee_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employee_details (region, employee_name, salary) VALUES
	('East', 'Ava', 85000),
	('East', 'Ava', 85000),
	('East', 'Bob', 72000),
	('East', 'Cat', 59000),
	('West', 'Cat', 63000),
	('West', 'Dan', 85000),
	('West', 'Eve', 72000),
	('West', 'Eve', 75000);

-- View the employee details table
SELECT * FROM employee_details;

-- View duplicate rows

-- 1. View duplicate employees
SELECT	 employee_name, COUNT(*) AS dup_count
FROM	 employee_details
GROUP BY employee_name
HAVING	 COUNT(*) > 1;

-- 2. View duplicate region + employee combos
SELECT	 region, employee_name, COUNT(*) AS dup_count
FROM	 employee_details
GROUP BY region, employee_name
HAVING	 COUNT(*) > 1;

-- 3. View fully duplicate rows
SELECT	 region, employee_name, salary, COUNT(*) AS dup_count
FROM	 employee_details
GROUP BY region, employee_name, salary
HAVING	 COUNT(*) > 1;

-- Exclude duplicate rows

-- 1. Exclude fully duplicate rows
SELECT	DISTINCT region, employee_name, salary
FROM	employee_details;

-- 2. Exclude partially duplicate rows (unique employee name for each row)
SELECT * FROM

(SELECT	region, employee_name, salary,
		ROW_NUMBER() OVER(PARTITION BY employee_name ORDER BY salary DESC) AS top_sal
FROM	employee_details) AS ts

WHERE top_sal = 1;

-- 3. Exclude partially duplicate rows (unique region + employee name for each row)
SELECT * FROM

(SELECT	region, employee_name, salary,
		ROW_NUMBER() OVER(PARTITION BY region, employee_name ORDER BY salary DESC) AS top_sal
FROM	employee_details) AS ts

WHERE top_sal = 1;

-- 2. MIN / MAX VALUE FILTERING

CREATE TABLE sales (
    id INT PRIMARY KEY,
    sales_rep VARCHAR(50),
    date DATE,
    sales INT
);

INSERT INTO sales (id, sales_rep, date, sales) VALUES 
    (1, 'Emma', '2024-08-01', 6),
    (2, 'Emma', '2024-08-02', 17),
    (3, 'Jack', '2024-08-02', 14),
    (4, 'Emma', '2024-08-04', 20),
    (5, 'Jack', '2024-08-05', 5),
    (6, 'Emma', '2024-08-07', 1);

-- View the sales table
SELECT * FROM sales;

-- Goal: Return the most recent sales amount for each sales rep

-- Return the most recent sales date for each sales rep
SELECT	 sales_rep, MAX(date) AS most_recent_date
FROM	 sales
GROUP BY sales_rep;

-- Return the most recent sales date for each sales rep + attempt to add on the sales
SELECT	 sales_rep, MAX(date) AS most_recent_date, MAX(sales)
FROM	 sales
GROUP BY sales_rep;

-- Number of sales on most recent date: Group by + join approach
WITH rd AS (SELECT	 sales_rep, MAX(date) AS most_recent_date
			FROM	 sales
			GROUP BY sales_rep)
            
SELECT	rd.sales_rep, rd.most_recent_date, s.sales
FROM	rd LEFT JOIN sales s
		ON rd.sales_rep = s.sales_rep
        AND rd.most_recent_date = s.date;
                
-- Number of sales on most recent date: Window function approach
SELECT * FROM

(SELECT	sales_rep, date, sales,
		ROW_NUMBER() OVER (PARTITION BY sales_rep ORDER BY date DESC) AS row_num
FROM	sales) AS rn

WHERE row_num = 1;

-- 3. PIVOTING

CREATE TABLE pizza_table (
    category VARCHAR(50),
    crust_type VARCHAR(50),
    pizza_name VARCHAR(100),
    price DECIMAL(5, 2)
);

INSERT INTO pizza_table (category, crust_type, pizza_name, price) VALUES
    ('Chicken', 'Gluten-Free Crust', 'California Chicken', 21.75),
    ('Chicken', 'Thin Crust', 'Chicken Pesto', 20.75),
    ('Classic', 'Standard Crust', 'Greek', 21.50),
    ('Classic', 'Standard Crust', 'Hawaiian', 19.50),
    ('Classic', 'Standard Crust', 'Pepperoni', 18.75),
    ('Supreme', 'Standard Crust', 'Spicy Italian', 22.75),
    ('Veggie', 'Thin Crust', 'Five Cheese', 18.50),
    ('Veggie', 'Thin Crust', 'Margherita', 19.50),
    ('Veggie', 'Gluten-Free Crust', 'Garden Delight', 21.50);

-- View the pizza table
SELECT * FROM pizza_table;

-- Create 1/0 columns
SELECT 	*,
		CASE WHEN crust_type = 'Standard Crust' THEN 1 ELSE 0 END AS standard_crust,
        CASE WHEN crust_type = 'Thin Crust' THEN 1 ELSE 0 END AS thin_crust,
        CASE WHEN crust_type = 'Gluten-Free Crust' THEN 1 ELSE 0 END AS gluten_free_crust
FROM 	pizza_table;

-- Create a summary table of categories & pizza types
SELECT 	 category,
		 SUM(CASE WHEN crust_type = 'Standard Crust' THEN 1 ELSE 0 END) AS standard_crust,
         SUM(CASE WHEN crust_type = 'Thin Crust' THEN 1 ELSE 0 END) AS thin_crust,
         SUM(CASE WHEN crust_type = 'Gluten-Free Crust' THEN 1 ELSE 0 END) AS gluten_free_crust
FROM 	 pizza_table
GROUP BY category;

-- 4. ROLLING CALCULATIONS

-- Create a pizza orders table
CREATE TABLE pizza_orders (
    order_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    order_date DATE,
    pizza_name VARCHAR(100),
    price DECIMAL(5, 2)
);

INSERT INTO pizza_orders (order_id, customer_name, order_date, pizza_name, price) VALUES
    (1, 'Jack', '2024-12-01', 'Pepperoni', 18.75),
    (2, 'Jack', '2024-12-02', 'Pepperoni', 18.75),
    (3, 'Jack', '2024-12-03', 'Pepperoni', 18.75),
    (4, 'Jack', '2024-12-04', 'Pepperoni', 18.75),
    (5, 'Jack', '2024-12-05', 'Spicy Italian', 22.75),
    (6, 'Jill', '2024-12-01', 'Five Cheese', 18.50),
    (7, 'Jill', '2024-12-03', 'Margherita', 19.50),
    (8, 'Jill', '2024-12-05', 'Garden Delight', 21.50),
    (9, 'Jill', '2024-12-05', 'Greek', 21.50),
    (10, 'Tom', '2024-12-02', 'Hawaiian', 19.50),
    (11, 'Tom', '2024-12-04', 'Chicken Pesto', 20.75),
    (12, 'Tom', '2024-12-05', 'Spicy Italian', 22.75),
    (13, 'Jerry', '2024-12-01', 'California Chicken', 21.75),
    (14, 'Jerry', '2024-12-02', 'Margherita', 19.50),
    (15, 'Jerry', '2024-12-04', 'Greek', 21.50);
    
-- View the table
SELECT * FROM pizza_orders;

-- 1. Calculate the sales subtotals for each customer

-- View the total sales for each customer on each date
SELECT	 customer_name, order_date, SUM(price) AS total_sales
FROM	 pizza_orders
GROUP BY customer_name, order_date;

-- Include the subtotals
SELECT	 customer_name, order_date, COUNT(price) AS total_sales
FROM	 pizza_orders
GROUP BY customer_name, order_date WITH ROLLUP;

-- 2. Calculate the cumulative sum of sales over time

-- View the columns of interest
SELECT	order_date, price
FROM	pizza_orders
ORDER BY order_date;

-- Calculate the total sales for each day
SELECT	 order_date, SUM(price) AS total_sales
FROM	 pizza_orders
GROUP BY order_date
ORDER BY order_date;

-- Calculate the cumulative sales over time
WITH ts AS (SELECT	 order_date, SUM(price) AS total_sales
			FROM	 pizza_orders
			GROUP BY order_date
			ORDER BY order_date)
            
SELECT	order_date,
		SUM(total_sales) OVER(ORDER BY order_date) AS cumulative_sum
FROM 	ts;

-- 3. Calculate the 3 year moving average of happiness scores for each country

-- View the happiness score table
SELECT * FROM happiness_scores;

-- View the happiness scores for each country, sorted by year
SELECT	 country, year, happiness_score 
FROM 	 happiness_scores
ORDER BY country, year;

-- Create a basic row number window function
SELECT	 country, year, happiness_score,
		 ROW_NUMBER() OVER (PARTITION BY country ORDER BY year) AS row_num
FROM 	 happiness_scores
ORDER BY country, year;

-- Update the function to a moving average calculation
SELECT	 country, year, happiness_score,
		 ROUND(AVG(happiness_score)
         OVER (PARTITION BY country ORDER BY year
			   ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 3) AS row_num
FROM 	 happiness_scores
ORDER BY country, year;

-- 5. FINAL DEMO: Imputing NULL Values

/* Stock prices table was created in prior section:
   This is the code if you need to create it again */

/* -- Create a stock prices table
CREATE TABLE IF NOT EXISTS stock_prices (
    date DATE PRIMARY KEY,
    price DECIMAL(10, 2)
);

INSERT INTO stock_prices (date, price) VALUES
	('2024-11-01', 678.27),
	('2024-11-03', 688.83),
	('2024-11-04', 645.40),
	('2024-11-06', 591.01); */
    
-- Recursive CTE from earlier
WITH RECURSIVE my_dates(dt) AS (SELECT '2024-11-01'
								UNION ALL
								SELECT dt + INTERVAL 1 DAY
								FROM my_dates
								WHERE dt < '2024-11-06')
     
SELECT	md.dt, sp.price
FROM	my_dates md
		LEFT JOIN stock_prices sp
        ON md.dt = sp.date;
        
-- Let's replace the NULL values in the price column 4 different ways (aka imputation)
-- 1. With a hard coded value
-- 2. With a subquery
-- 3. With one window function
-- 4. With two window functions

WITH RECURSIVE my_dates(dt) AS (SELECT '2024-11-01'
								UNION ALL
								SELECT dt + INTERVAL 1 DAY
								FROM my_dates
								WHERE dt < '2024-11-06'),
                                
	 sp AS (SELECT	md.dt, sp.price
			FROM	my_dates md
					LEFT JOIN stock_prices sp
					ON md.dt = sp.date)
                    
SELECT	dt, price,
		COALESCE(price, 600) AS updated_price_600,
        COALESCE(price, ROUND((SELECT AVG(price) FROM sp), 2)) AS updated_price_avg,
        COALESCE(price, LAG(price) OVER()) AS updated_price_prior,
        COALESCE(price, ROUND((LAG(price) OVER() + LEAD(price) OVER())/2, 2)) AS updated_price_smooth
FROM	sp;
