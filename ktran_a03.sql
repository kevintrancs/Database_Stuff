-- Kevin Tran
-- CPSC 321-02
-- Assignment 3
-- 9/17/17

-- Query 1
SELECT a.title
FROM album a, band b
WHERE b.name = 'Winners' AND b.group_id = a.group_id;

-- Query 2
SELECT b.name
FROM band b, genre g, genre_album ga
WHERE g.name = 'rap' AND ga.group_id = b.group_id AND ga.genre_id = g.genre_id;

SELECT b.name
FROM band b, genre g, genre_album ga
WHERE g.name = 'rock' AND ga.group_id = b.group_id AND ga.genre_id = g.genre_id;

-- Query 3
SELECT m.name
FROM member m, band b
WHERE b.name = 'Winners' AND m.end_year - 2000 > 0 AND m.own_group = b.group_id;

-- Query 4
SELECT m.name
FROM member m, band b
WHERE b.name = 'Loser' AND m.start_year >= 2000 AND m.end_year <= 2005 AND m.own_group = b.group_id;

-- Query 5
SELECT s.name
FROM song s, album a
WHERE a.title = 'Good Album'AND a.album_id = s.album_id;


-- Query 6
SELECT DISTINCT s.name
FROM song s, album a, member m, band b
WHERE m.start_year >= a.year AND m.name = 'John Smith' AND m.own_group = a.group_id AND s.album_id = a.album_id ;

-- Query 7
SELECT a.title
FROM album a, band b
WHERE b.label = 'RCA' AND a.year IN (2000, 2001, 2002, 2003, 2004, 2005) AND a.group_id = b.group_id;


