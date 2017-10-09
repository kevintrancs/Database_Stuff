-- Kevin Tran 
-- CPSC 321 - 02
-- Homework 6
-- Description: Inner queries and joins


-- total number of films by category ordered from most to least
SELECT c.name, COUNT(*)
FROM film f, inventory i, film_category fc, category c
WHERE f.film_id = fc.film_id AND fc.category_id = c.category_id AND i.film_id = fc.film_id
GROUP BY c.category_id
ORDER BY COUNT(fc.category_id) desc;

-- Number of films acted in by each actor ordered from highest number of films to lowest.

SELECT DISTINCT a.first_name, a.last_name, COUNT(*)
FROM actor a, film_actor fa, film f, inventory i
WHERE a.actor_id = fa.actor_id AND
fa.film_id = f.film_id AND
i.film_id = fa.film_id
GROUP BY a.actor_id
ORDER BY COUNT(*) desc;

--  Each ‘G’ rated film find the number of times it has been rented
SELECT f.title, COUNT(*)
FROM film f, rental r, inventory i
WHERE r.inventory_id = i.inventory_id AND
i.film_id = f.film_id AND
f.rating = 'G'
GROUP BY f.title
ORDER BY COUNT(*) desc;

--all first and last names of customers that have rented at least ten ‘G’ rated films.
SELECT c.first_name, c.last_name, COUNT(*)
FROM customer c, rental r, film f, inventory i
WHERE f.rating = 'G' AND
c.customer_id = r.customer_id AND
i.inventory_id = r.inventory_id AND
i.film_id = f.film_id
GROUP BY c.customer_id
HAVING COUNT(*) >= 10;

-- total sales (of payments) for each film category.

SELECT c.name, SUM(p.amount)
FROM payment p 
JOIN rental r ON r.rental_id = p.rental_id
JOIN inventory i ON i.inventory_id = r.inventory_id
JOIN film_category fc ON fc.film_id = i.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.category_id;

-- the film (or films if there is a tie) that have been rented the most number of times.

SELECT t.title, MAX(most)
FROM (
	SELECT f.title, COUNT(*) as most
	FROM rental r
	JOIN inventory i USING (inventory_id)
	JOIN film f ON i.film_id = f.film_id
	GROUP BY f.title
	ORDER BY most desc
) as t;

--  Find the store (or stores) that have the most rentals.

SELECT i.store_id
FROM inventory i, (
	SELECT COUNT(*) as most
	FROM rental r 
	JOIN payment p ON r.rental_id = p.rental_id
) as s_id
GROUP BY most
ORDER BY most desc;

--  title of the most rented ‘G rated film(s).

SELECT t2.title
FROM(
	SELECT MAX(most), t1.title
		FROM(
		SELECT f.title, COUNT(*) as most
		FROM rental r
		JOIN inventory i ON r.inventory_id = i.inventory_id
		JOIN film f ON f.film_id = i.film_id
		WHERE f.rating = 'G'
		GROUP BY f.title
		ORDER BY most desc
		) as t1
) as t2;

--  Find the total sales (of payments) for each store ordered from highest to lowest total sales.
SELECT
  i.store_id , SUM(p.amount)
FROM inventory i, payment p , rental r 
WHERE p.rental_id = r.rental_id 
AND i.inventory_id = r.inventory_id
GROUP BY i.store_id
ORDER BY SUM(p.amount) desc;

--  find the movies and the total number of times that they were rented to customers by the staff member.
SELECT f.title, t.last_name, t.first_name, COUNT(f.title)
FROM film f 
	JOIN(
		SELECT rs.first_name, rs.last_name, i.film_id
		FROM inventory i
		JOIN(
			SELECT s.last_name, s.first_name, r.inventory_id
			FROM staff s
			JOIN rental r ON s.staff_id = r.staff_id
			) as rs ON i.inventory_id = rs.inventory_id
		) as t ON f.film_id = t.film_id
GROUP BY f.title, t.last_name
ORDER BY COUNT(f.title) desc;