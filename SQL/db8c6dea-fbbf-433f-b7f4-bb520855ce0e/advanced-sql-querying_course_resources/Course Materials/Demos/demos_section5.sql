-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. NUMERIC FUNCTIONS

-- Math and rounding functions
SELECT	country, population,
		LOG(population) AS log_pop,
        ROUND(LOG(population), 2) AS log_pop_2
FROM	country_stats;

-- Pro tip: FLOOR function for binning
WITH pm AS (SELECT	country, population,
					FLOOR(population / 1000000) AS pop_m
			FROM	country_stats)
            
SELECT	pop_m, COUNT(country) AS num_countries
FROM	pm
GROUP BY pop_m
ORDER BY pop_m;

-- Max of a column vs max of a row: Least & greatest

-- Create a miles run table
CREATE TABLE miles_run (
    name VARCHAR(50),
    q1 INT,
    q2 INT,
    q3 INT,
    q4 INT
);

INSERT INTO miles_run (name, q1, q2, q3, q4) VALUES
	('Ali', 100, 200, 150, NULL),
	('Bolt', 350, 400, 380, 300),
	('Jordan', 200, 250, 300, 320);

SELECT * FROM miles_run;

-- Return the greatest value of each column
SELECT	MAX(q1), MAX(q2), MAX(q3), MAX(q4)
FROM	miles_run;

-- Return the greatest value of each row
SELECT	GREATEST(q1, q2, q3, q4) AS most_miles
FROM	miles_run;

-- Lookahead: Deal with the NULL values
SELECT	GREATEST(q1, q2, q3, COALESCE(q4, 0)) AS most_miles
FROM	miles_run;

-- 2. CAST & CONVERT FUNCTIONS

-- Create a sample table
CREATE TABLE sample_table (
    id INT,
    str_value CHAR(50)
);

INSERT INTO sample_table (id, str_value) VALUES
	(1, '100.2'),
	(2, '200.4'),
	(3, '300.6');

SELECT * FROM sample_table;

-- Try to do a math calculation on the string column
SELECT	id, str_value*2
FROM	sample_table;

-- Turn the string to a decimal
SELECT	id, CAST(str_value AS DECIMAL(5, 2))*2
FROM	sample_table;

-- Turn an integer into a float
SELECT	country, population / 5.0
FROM	country_stats;

-- 3. DATETIME FUNCTIONS

-- Get the current date and time
SELECT	CURRENT_DATE(), CURRENT_TIMESTAMP();

-- Create a my events table
CREATE TABLE my_events (
    event_name VARCHAR(50),
    event_date DATE,
    event_datetime DATETIME,
    event_type VARCHAR(20),
    event_desc TEXT);

INSERT INTO my_events (event_name, event_date, event_datetime, event_type, event_desc) VALUES
('New Year\'s Day', '2025-01-01', '2025-01-01 00:00:00', 'Holiday', 'A global celebration to mark the beginning of the New Year. Festivities often include fireworks, parties, and various cultural traditions as people reflect on the past year and set resolutions for the upcoming one.'),
('Lunar New Year', '2025-01-29', '2025-01-29 10:00:00', 'Holiday', 'A significant cultural event in many Asian countries, the Lunar New Year, also known as the Spring Festival, involves family reunions, feasts, and various rituals to welcome good fortune and happiness for the year ahead.'),
('Persian New Year', '2025-03-20', '2025-03-20 12:00:00', 'Holiday', 'Known as Nowruz, this celebration marks the first day of spring and the beginning of the year in the Persian calendar. It is a time for family gatherings, traditional foods, and cultural rituals to symbolize renewal and rebirth.'),
('Birthday', '2025-05-13', '2025-05-13 18:00:00', ' Personal!', 'A personal celebration marking the anniversary of one\'s birth. This special day often involves gatherings with family and friends, cake, gifts, and reflecting on personal growth and achievements over the past year.'),
('Last Day of School', '2025-06-12', '2025-06-12 15:30:00', ' Personal!', 'The final day of the academic year, celebrated by students and teachers alike. It often includes parties, awards, and a sense of excitement for the upcoming summer break, marking the end of a year of hard work and learning.'),
('Vacation', '2025-08-01', '2025-08-01 08:00:00', ' Personal!', 'A much-anticipated break from daily routines, this vacation period allows individuals and families to relax, travel, and create memories. It is a time for adventure and exploration, often enjoyed with loved ones.'),
('First Day of School', '2025-08-18', '2025-08-18 08:30:00', ' Personal!', 'An exciting and sometimes nerve-wracking day for students, marking the beginning of a new academic year. This day typically involves meeting new teachers, reconnecting with friends, and setting goals for the year ahead.'),
('Halloween', '2025-10-31', '2025-10-31 18:00:00', 'Holiday', 'A festive occasion celebrated with costumes, trick-or-treating, and various spooky activities. Halloween is a time for fun and creativity, where people of all ages dress up and participate in themed events, parties, and community gatherings.'),
('Thanksgiving', '2025-11-27', '2025-11-27 12:00:00', 'Holiday', 'A holiday rooted in gratitude and family, Thanksgiving is celebrated with a large feast that typically includes turkey, stuffing, and various side dishes. It is a time to reflect on the blessings of the year and spend quality time with loved ones.'),
('Christmas', '2025-12-25', '2025-12-25 09:00:00', 'Holiday', 'A major holiday celebrated around the world, Christmas commemorates the birth of Jesus Christ. It is marked by traditions such as gift-giving, festive decorations, and family gatherings, creating a warm and joyous atmosphere during the holiday season.');

SELECT * FROM my_events;

-- Extract info about datetime values
SELECT	event_name, event_date, event_datetime,
		YEAR(event_date) AS event_year,
        MONTH(event_date) AS event_month,
        DAYOFWEEK(event_date) AS event_dow
FROM	my_events;

-- Spell out the full days of the week using CASE statements
WITH dow AS (SELECT	event_name, event_date, event_datetime,
					YEAR(event_date) AS event_year,
					MONTH(event_date) AS event_month,
					DAYOFWEEK(event_date) AS event_dow
			 FROM	my_events)
             
SELECT	*, CASE WHEN event_dow = 1 THEN 'Sunday'
				WHEN event_dow = 2 THEN 'Monday'
				WHEN event_dow = 3 THEN 'Tuesday'
				WHEN event_dow = 4 THEN 'Wednesday'
				WHEN event_dow = 5 THEN 'Thursday'
				WHEN event_dow = 6 THEN 'Friday'
				WHEN event_dow = 7 THEN 'Saturday'
				ELSE 'Unknown' END AS event_dow_name
FROM	dow;

-- Calculate an interval between datetime values
SELECT	event_name, event_date, event_datetime, CURRENT_DATE(),
		DATEDIFF(event_date, CURRENT_DATE()) AS days_until
FROM	my_events;

-- Add / subtract an interval from a datetime value
SELECT	event_name, event_date, event_datetime,
		DATE_ADD(event_datetime, INTERVAL 1 MINUTE) AS plus_one_hour
FROM	my_events;

-- 4. STRING FUNCTIONS

-- Change the case
SELECT	event_name, UPPER(event_name), LOWER(event_name)
FROM	my_events;

-- Clean up event type and find the length of the description
SELECT	event_name, event_type,
        TRIM(REPLACE(event_type, '!', '')) AS event_type_clean,
		event_desc,
        LENGTH(event_desc) AS desc_len
FROM	my_events;

-- Combine the type and description columns
WITH my_events_clean AS (SELECT	event_name, event_type,
								TRIM(REPLACE(event_type, '!', '')) AS event_type_clean,
								event_desc,
								LENGTH(event_desc) AS desc_len
						 FROM	my_events)
                         
SELECT	event_name, event_type_clean, event_desc,
		CONCAT(event_type_clean, ' | ', event_desc) AS full_desc
FROM	my_events_clean;

-- Return the first word of each event
SELECT	event_name,
		SUBSTR(event_name, 1, 3)
FROM	my_events;

SELECT	event_name,
		INSTR(event_name, ' ')
FROM	my_events;

SELECT	event_name,
		SUBSTR(event_name, 1, INSTR(event_name, ' ') - 1) AS first_word
FROM	my_events;

-- Update to handle single word events
SELECT	event_name,
		CASE WHEN INSTR(event_name, ' ') = 0 THEN event_name
			 ELSE SUBSTR(event_name, 1, INSTR(event_name, ' ') - 1) END AS first_word
FROM	my_events;

-- Return descriptions that contain 'family'
SELECT	*
FROM	my_events
WHERE	event_desc LIKE '%family%';

-- Return descriptions that start with 'A'
SELECT	*
FROM	my_events
WHERE	event_desc LIKE 'A %';

-- Return students with three letter first names
SELECT	*
FROM	students
WHERE	student_name LIKE '___ %';

-- Note any celebration word in the sentence
SELECT	event_desc,
		REGEXP_SUBSTR(event_desc, 'celebration|festival|holiday') AS celebration_word
FROM	my_events
WHERE	event_desc LIKE '%celebration%'
		OR event_desc LIKE '%festival%'
        OR event_desc LIKE '%holiday%';

-- Return words with hyphens in them
SELECT	event_desc,
		REGEXP_SUBSTR(event_desc, '[A-Z][a-z]+(-[A-Za-z]+)+') AS hyphen_phrase
FROM	my_events;

-- 5. NULL FUNCTIONS

-- Create a contacts table
CREATE TABLE contacts (
    name VARCHAR(50),
    email VARCHAR(100),
    alt_email VARCHAR(100));

INSERT INTO contacts (name, email, alt_email) VALUES
	('Anna', 'anna@example.com', NULL),
	('Bob', NULL, 'bob.alt@example.com'),
	('Charlie', NULL, NULL),
	('David', 'david@example.com', 'david.alt@example.com');

SELECT * FROM contacts;

-- Return null values
SELECT 	*
FROM 	contacts
WHERE	email IS NULL;

-- Return non-null values
SELECT 	*
FROM 	contacts
WHERE	email IS NOT NULL;

-- Return non-NULL values using a CASE statement
SELECT 	name, email,
		CASE WHEN email IS NOT NULL THEN email
			 ELSE 'no email' END AS contact_email
FROM 	contacts;

-- Return non-NULL values using IF NULL
SELECT 	name, email,
		IFNULL(email, 'no email') AS contact_email
FROM 	contacts;

-- Return an alternative field using IF NULL
SELECT 	name, email, alt_email,
		IFNULL(email, alt_email) AS contact_email
FROM 	contacts;

-- Return an alternative field after multiple checks
SELECT 	name, email, alt_email,
		IFNULL(email, 'no email') AS contact_email_value,
        IFNULL(email, alt_email) AS contact_email_column,
        COALESCE(email, alt_email, 'no email') AS contact_email_coalesce
FROM 	contacts;