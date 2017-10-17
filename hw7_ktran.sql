-- Kevin Tran 
-- CPSC 321 - 02
-- Homework 7
-- Description: Outer queries and normalization 


-- Query 1 all of the ids and titles of films that are not in any store’s inventory.
SELECT f.film_id,f .title
FROM film f
LEFT JOIN inventory i USING(film_id)
WHERE i.film_id IS null
GROUP BY f.title, f.film_id;

-- Query 2 all of the ids and titles of films that are not in any store’s inventory.

SELECT f.title, f.film_id
FROM film f
JOIN inventory i USING (film_id)
WHERE f.film_id IS null
UNION
SELECT f.title, f.film_id 
FROM film f
WHERE f.film_id NOT IN (
    SELECT i.film_id 
    FROM inventory i
    );

-- Query 3 the number of actors that acted in each film
SELECT f.film_id, f.title, COUNT(DISTINCT fa.actor_id) as total_actors
FROM film f
LEFT JOIN film_actor fa USING(film_id)
GROUP BY film_id
ORDER BY total_actors ASC;


