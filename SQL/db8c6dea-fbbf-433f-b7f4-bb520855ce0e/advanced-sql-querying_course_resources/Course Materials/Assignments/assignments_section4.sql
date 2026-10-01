-- Connect to database


-- ASSIGNMENT 1: Window function basics

-- View the orders table


-- View the columns of interest


-- For each customer, add a column for transaction number


-- ASSIGNMENT 2: Row Number vs Rank vs Dense Rank

-- View the columns of interest


-- Try ROW_NUMBER to rank the units


-- For each order, rank the products from most units to fewest units
-- If there's a tie, keep the tie and don't skip to the next number after


-- Check the order id that ends with 44262 from the results preview


-- ASSIGNMENT 3: First Value vs Last Value vs Nth Value

-- View the rankings from the last assignment


-- Add a column that contains the 2nd most popular product


-- Return the 2nd most popular product for each order


-- Alternative using DENSE RANK

-- Add a column that contains the rankings


-- Return the 2nd most popular product for each order


-- ASSIGNMENT 4: Lead & Lag

-- View the columns of interest


-- For each customer, return the total units within each order


-- Add on the transaction id to keep track of the order of the orders


-- Turn the query into a CTE and view the columns of interest


-- Create a prior units column


-- For each customer, find the change in units per order over time


-- ASSIGNMENT 5: NTILE

-- Calculate the total amount spent by each customer


-- View the data needed from the orders table


-- View the data needed from the products table


-- Combine the two tables and view the columns of interest

        
-- Calculate the total spending by each customer and sort the results from highest to lowest


-- Turn the query into a CTE and apply the percentile calculation


-- Return the top 1% of customers in terms of spending


