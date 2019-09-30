-- You're wandering through the wilderness of someone else's code, and you stumble across
-- the following queries that use subqueries. You think they'd be better as CTE's
-- Go ahead and re-write the queries to use CTE's

-- -- EXAMPLE CTE:
--Returns the customer ID’s of ALL customers who have spent more money than $100 in their life.

WITH customer_totals AS (
  SELECT customer_id, 
         SUM(amount) as total
  FROM payment
  GROUP BY customer_id
)

SELECT customer_id, total 
FROM customer_totals 
WHERE total > 100;


--YOUR TURN:
-- Returns the average of the amount of stock each store has in their inventory. 
SELECT AVG(stock)
FROM (SELECT COUNT(inventory_id) as stock
	  FROM inventory
	  GROUP BY store_id) as store_stock;

WITH store_stock AS (
    SELECT COUNT(inventory_id) as stock
    from inventory
    GROUP BY store_id
) 
SELECT AVG(stock)
FROM store_stock;
	  
-- Returns the average customer lifetime spending, for each staff member.
-- HINT: you can work off the example
SELECT staff_id, AVG(total)
FROM (SELECT staff_id, SUM(amount) as total
	  FROM payment 
	  GROUP BY customer_id, staff_id) as customer_totals
GROUP BY staff_id;

WITH customer_total AS (
    SELECT staff_id, SUM(amount) as total
    FROM payment
    GROUP BY customer_id, staff_id
)

SELECT staff_id, AVG(total)
FROM customer_total
GROUP BY staff_id;

-- Returns the average rental rate for each genre of film.
SELECT AVG(rental_rate)
FROM film JOIN film_category ON film.film_id=film_category.film_id
GROUP BY category_id;

WITH film_and_category AS(
    SELECT *
    FROM film 
    JOIN film_category USING(film_id)
)

SELECT category_id, AVG(rental_rate)
FROM film_and_category
GROUP BY category_id;

-- Return all films that have the rating that is biggest category 
-- (ie. rating with the highest count of films)
SELECT title, rating
FROM film
WHERE rating = (SELECT rating 
				FROM film
			   GROUP BY rating
			   ORDER BY COUNT(*)
			   LIMIT 1);

WITH rating_count AS(
    SELECT rating AS rating_count
    FROM film 
    GROUP BY rating
    ORDER BY COUNT(*)
) 

SELECT 
    title, 
    MAX(rating_count) as rating
FROM film 
JOIN rating_count 
ON film.rating = rating_count.rating_count
GROUP BY title
ORDER BY rating, title;

SELECT title 
-- Return all purchases from the longest standing customer
-- (ie customer who has the earliest payment_date)
SELECT * 
FROM payment
WHERE customer_id = (SELECT customer_id
					  FROM payment
					  ORDER BY payment_date
					 LIMIT 1);

WITH oldest_customer AS(
    SELECT 
        customer_id,
        MIN(payment_date) AS first_payment
        FROM payment
        GROUP BY customer_id
        ORDER BY first_payment
        LIMIT 1
)

SELECT 
    *
FROM oldest_customer
JOIN payment USING(customer_id);

-- You're wandering through the wilderness of someone else's code, and you stumble across
-- the following queries that use subqueries. You think they'd be better as CTE's
-- Go ahead and re-write the queries to use CTE's

-- -- EXAMPLE CTE:
--Returns the customer ID’s of ALL customers who have spent more money than $100 in their life.

WITH customer_totals AS (
  SELECT customer_id, 
         SUM(amount) as total
  FROM payment
  GROUP BY customer_id
)

SELECT customer_id, total 
FROM customer_totals 
WHERE total > 100;


--YOUR TURN:
-- Returns the average of the amount of stock each store has in their inventory. 
SELECT AVG(stock)
FROM (SELECT COUNT(inventory_id) as stock
	  FROM inventory
	  GROUP BY store_id) as store_stock;

WITH store_stock AS (
    SELECT COUNT(inventory_id) as stock
    from inventory
    GROUP BY store_id
) 
SELECT AVG(stock)
FROM store_stock;
	  
-- Returns the average customer lifetime spending, for each staff member.
-- HINT: you can work off the example
SELECT staff_id, AVG(total)
FROM (SELECT staff_id, SUM(amount) as total
	  FROM payment 
	  GROUP BY customer_id, staff_id) as customer_totals
GROUP BY staff_id;

WITH customer_total AS (
    SELECT staff_id, SUM(amount) as total
    FROM payment
    GROUP BY customer_id, staff_id
)

SELECT staff_id, AVG(total)
FROM customer_total
GROUP BY staff_id;

-- Returns the average rental rate for each genre of film.
SELECT AVG(rental_rate)
FROM film JOIN film_category ON film.film_id=film_category.film_id
GROUP BY category_id;

WITH film_and_category AS(
    SELECT *
    FROM film 
    JOIN film_category USING(film_id)
)

SELECT category_id, AVG(rental_rate)
FROM film_and_category
GROUP BY category_id;

-- Return all films that have the rating that is biggest category 
-- (ie. rating with the highest count of films)
SELECT title, rating
FROM film
WHERE rating = (SELECT rating 
				FROM film
			   GROUP BY rating
			   ORDER BY COUNT(*)
			   LIMIT 1);

WITH rating_count AS(
    SELECT rating AS rating_count
    FROM film 
    GROUP BY rating
    ORDER BY COUNT(*)
) 

SELECT 
    title, 
    MAX(rating_count) as rating
FROM film 
JOIN rating_count 
ON film.rating = rating_count.rating_count
GROUP BY title
ORDER BY rating, title;

SELECT title 
-- Return all purchases from the longest standing customer
-- (ie customer who has the earliest payment_date)
SELECT * 
FROM payment
WHERE customer_id = (SELECT customer_id
					  FROM payment
					  ORDER BY payment_date
					 LIMIT 1);

WITH oldest_customer AS(
    SELECT 
        customer_id,
        MIN(payment_date) AS first_payment
        FROM payment
        GROUP BY customer_id
        ORDER BY first_payment
        LIMIT 1
)

SELECT 
    *
FROM oldest_customer
JOIN payment USING(customer_id);