-- Kevin Tran 
-- CPSC 321 - 02
-- Homework 7
-- Description: Outer queries and normalization 


-- Query 1 all of the ids and titles of films that are not in any store’s inventory.
SELECT f.film_id,f .title
FROM film f
LEFT JOIN inventory i USING(film_id)
GROUP BY f.title, f.film_id;

-- Query 2 all of the ids and titles of films that are not in any store’s inventory.

SELECT f.title, i.film_id
FROM film f
JOIN inventory i USING (film_id)
UNION
SELECT f.title, NULL 
FROM film f
WHERE f.film_id NOT IN (
    SELECT i.film_id 
    FROM inventory i
    );

-- Query 3 the number of actors that acted in each film
SELECT f.film_id, f.title, total_actors
FROM film f
LEFT JOIN (
    SELECT fa.film_id, COUNT(*) as total_actors
    FROM film_actor fa 
    RIGHT JOIN actor a ON fa.actor_id = a.actor_id
    GROUP BY fa.film_id
) as t USING(film_id)
GROUP BY f.film_id, f.title;





