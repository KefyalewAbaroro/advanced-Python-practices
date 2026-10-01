SELECT * FROM film

SELECT * FROM film
WHERE title LIKE 'G%';

SELECT * FROM film
ORDER BY rental_rate DESC LIMIT 150;

SELECT * FROM city
ORDER BY city DESC LIMIT 150;

SELECT * FROM customer
WHERE first_name like 'J%' AND (last_name like 'B%');


SELECT * FROM customer
WHERE first_name like 'J%' OR (last_name like 'B%');

SELECT * FROM Customer
WHERE NOT last_name like '%B%';

SELECT * FROM Customer
ORDER BY customer_id ASC last_name like '%B%';

UPDATE Customer
SET first_name = 'Hulgize', last_name = 'kefyalew',
email= 'kefyalew@gamil.com'
WHERE Customer_id = 1;

SELECT COUNT(DISTINCT length)
FROM film
WHERE length >= 90;

CREATE TABLE student (first_name VARCHAR(20), last_name VARCHAR(20),
dob DATE, city VARCHAR(20), country VARCHAR(15));
INSERT INTO student (first_name, last_name, dob, city, country)
VALUES ('william', 'james', '1975-08-21', 'new york', 'USA'),
('scott', 'helder', '1981-10-04', 'north carolina', 'USA'),
('samuel', 'bruce', '1983-06-12', 'washington', 'USA'),
('jefferson', 'plummer', '1980-02-21', 'london', 'britain'),
('jankien', 'thomas', '1978-05-27', 'paris', 'france'),
('zowi', 'leo', '1980-07-11', 'new york', 'USA');


SELECT * FROM student
ORDER BY last_name;

SELECT * FROM student
ORDER BY last_name DESC;

SELECT * FROM student
WHERE last_name like 'a%'

SELECT DISTINCT country  FROM student
ORDER BY country ASC;

UPDATE student
SET first_name ='Bethel', last_name ='Kefyalew'
WHERE dob='1977-08-21';

SELECT * FROM student
WHERE first_name LIKE 'Be%';

SELECT * FROM student
WHERE Country IN ('ethiopia', 'France');

SELECT first_name
FROM stud
WHERE condition
LIMIT number;

SELECT *, 'shortest film'  AS filmlength FROM film
ORDER BY length DESC
UNION 
SELECT *, 'lo film'  AS filmlength FROM film
ORDER BY length DESC

SELECT (last_name, first_name)  FROM student
ORDER BY last_name, first_name ASC;
select * from spl
INSERT INTO SPL (GaN_thickness, GaN_Uniformyty, GaN_STD, 
SiN_Thickness, SiN_Uniformity, SiN_STD, meas DATE;
VALUES (1425.21, 4800021, 25.112, 
28.21, 115242, 17.214, GET CURRENT TIMESTAMP

