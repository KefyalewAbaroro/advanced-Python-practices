--1) Display the minimum and maximum film length in the database.*/
SELECT  MIN(LENGTH), MAX(LENGTH)
       FROM film
	  
--2) Return the minimum and maximum film length for each rental duration.*/
SELECT rental_duration, MIN(LENGTH),  MAX(LENGTH) as Longestmovies
from film
group by rental_duration
--3)  Show the average length for each rating, only including ratings where the average length is
between 90 and 120 minutes.*/
SELECT rating, round(AVG(LENGTH), 0)
from film
GROUP by rating
having AVG(LENGTH) BETWEEN 90 AND 120
/*Show the average length for each rating, only including ratings where the average length
is between 90 and 120 minutes and excluding a rating R*/
SELECT rating, round(AVG(LENGTH), 0)
from film
where rating <> 'R'
GROUP by rating
having AVG(LENGTH) BETWEEN 90 AND 120
/*Find the maximum rental duration among films that are longer than 120 minutes.*/
SELECT film_id, MAX(rental_duration) AS max_rental_duration
 FROM film
 WHERE length > 120
 group by film_id
/*Display the minimum and maximum film length for each rental duration  among films that are longer than 120 minutes.*/
SELECT rental_duration, MAX(length), MIN(length)
 FROM film
 WHERE length > 120
 group by rental_duration
/*Show the total number of films for each duration among films that are longer
than 120 minutes, only including durations with at least 50 films.*/
SELECT film_id, COUNT(rental_duration)
           FROM film
		   where length > 120
		   group by film_id
		   limit 50
/*(hard) Display the total payment amount for each month, only including  months the total exceeds $500.*/
SELECT EXTRACT(month from payment_date) as payment_month, SUM(amount) as total_payment
	  from payment
	  group by EXTRACT(month from payment_date)
	  having SUM(amount) > 500

	  SELECT EXTRACT(month from payment_date), SUM(amount) as to
	  from payment
	  group by EXTRACT(month from payment_date)
	  having SUM(amount) > 500