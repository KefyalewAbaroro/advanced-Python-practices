--Practice Questions: SQL Filtering Operations

---Write a query to find all films with a rental rate greater than $4.00 and a replacement cost less than $20.00.

SELECT * FROM film
WHERE rental_rate > 4 and replacement_cost <20;

--Find all customers whose last name starts with 'A' and email contains 'gmail'.
SELECT * FROM customer
WHERE last_name LIKE 'A%';

--Retrieve all rentals that occurred between June 1, 2005 and June 15, 2005 and that weren't returned
SELECT * FROM film
WHERE last_update BETWEEN June 1, 2005 AND Jun

Find all films in the categories 'Action', 'Comedy', or 'Family'.

NULL Handling

List all staff members who don't have a recorded return date, then use COALESCE to display 'Pending' instead of NULL.

Film Length Analysis

Find all films that are between 60 and 90 minutes long AND have a rental rate less than $3.00 OR a replacement cost greater than $20.00.

Special Offers

Find all films where replacement cost is more than twice the rental rate OR the rental duration is exactly 7 days.

Special Inventory

Find all films where the title contains the word 'LOVE' or 'HOPE' and length is between 90 and 120 minutes.

Challenge question: Write a query that finds films that are either longer than 180 minutes OR have a 'PG' rating AND were released after 2005.