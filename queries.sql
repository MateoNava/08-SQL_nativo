CREATE TABLE movies (
  id TEXT PRIMARY KEY
  name TEXT DEFAULT NULL
  year INTEGER DEFAULT NULL
  rank REAL DEFAULT NULL
)

CREATE TABLE actors(
  id INTEGER PRIMARY KEY
  first_name TEXT DEFAULT NULL
  last_name TEXT DEFAULT NULL
  gender TEXT DEFAULT NULL
)

CREATE TABLE roles (
  actor_id INTEGER
  movie_id INTEGER
  role_name TEXT DEFAULT NULL
)

SELECT name, year FROM movies WHERE year=1902 AND rank>5

-- Año de nacimiento

SELECT * FROM movies WHERE year = 1998;

SELECT * FROM movies WHERE year = 1998;

--1982

SELECT COUNT(*) FROM movies WHERE year = 1982;

--Stacktors

SELECT * FROM actors WHERE actors.last_name LIKE '%stack%';

--Nombre de la fama

SELECT first_name fn, COUNT(*) FROM actors
GROUP BY fn
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT last_name ln, COUNT(*) FROM actors
GROUP BY ln
ORDER BY COUNT(*) DESC
LIMIT 10;

SELECT first_name fn, last_name ln, COUNT(*) FROM actors
GROUP BY fn||ln
ORDER BY COUNT(*) DESC
LIMIT 10;

--Prolífico


SELECT first_name, last_name, COUNT(*) as contador FROM actors
JOIN roles
ON id=actor_id
GROUP BY id
ORDER BY contador DESC
LIMIT 100;

--Fondo del Barril

SELECT genre, COUNT (*) FROM  movies_genres
JOIN movies
ON movies.id = movies_genres.movie_id
GROUP BY genre
ORDER BY COUNT () ASC;


--Braveheart

SELECT first_name,last_name FROM actors
JOIN roles
ON actors.id = roles.actor_id
JOIN movies
ON roles.movie_id = movies.id
WHERE movies.name LIKE '%Braveheart%' AND movies.year = 1995
ORDER BY last_name ASC;


--Noir


SELECT directors.first_name, directors.last_name, movies.name, movies.year
FROM movies_directors
JOIN directors
ON movies_directors.director_id = directors.id
JOIN directors_genres
ON movies_directors.director_id = directors_genres.director_id
JOIN movies
ON movies_directors.movie_id = movies.id
JOIN movies_genres
ON movies_directors.movie_id = movies_genres.movie_id
WHERE movies_genres.genre = 'Film-Noir' AND movies.year%4=0
GROUP BY movies.name
ORDER BY movies.name ASC;



-- Kevin Bacon



SELECT movies.name, actors.first_name, actors.last_name
  FROM actors
  INNER JOIN roles
    ON roles.actor_id = actors.id
  INNER JOIN movies
    ON roles.movie_id = movies.id
  INNER JOIN movies_genres
    ON movies_genres.movie_id = movies.id
    AND movies_genres.genre = 'Drama'
  WHERE movies.id IN (
    SELECT bacon_movies.id
    FROM movies AS bacon_movies
    INNER JOIN roles AS bacon_roles 
      ON bacon_roles.movie_id = bacon_movies.id
    INNER JOIN actors AS bacon_actors 
      ON bacon_roles.actor_id = bacon_actors.id
    WHERE bacon_actors.first_name = 'Kevin'
      AND bacon_actors.last_name = 'Bacon'
    )
    AND first_name != 'Kevin' AND last_name != 'Bacon'
  ORDER BY movies.name ASC
  LIMIT 30;



-- Actores inmortales

SELECT actors.first_name, actors.last_name, actors.id 
FROM roles
JOIN actors ON roles.actor_id = actors.id

WHERE actor_id IN (
SELECT actor_id 
FROM roles
WHERE movie_id IN (
SELECT id
FROM movies
WHERE year < 1900
))

AND actor_id IN (
SELECT actor_id 
FROM roles
WHERE movie_id IN (
SELECT id
FROM movies
WHERE year > 2000
))

GROUP BY first_name, last_name, id;





--PRUEBAS Actores inmortales


SELECT * FROM roles
JOIN actors
ON roles.actor_id = actors.id
JOIN movies
ON roles.movie_id = movies.id
WHERE actors.first_name AND actors.last_name IN(
  SELECT actors_1900.first_name, actors_1900.last_name
  FROM actors AS actors_1900
  JOIN roles AS roles_1900
  ON actors_1900.id = roles_1900.actor_id
  JOIN movies AS movies_1900
  on roles_1900.movie_id = movies_1900.movie_id
  WHERE movies_1900.year <1900

  INTERSECT

  SELECT actors_2000.first_name, actors_1900.last_name
  FROM actors AS actors_2000
  JOIN roles AS roles_2000
  ON actors_2000.id = roles_2000.actor_id
  JOIN movies AS movies_2000
  on roles_2000.movie_id = movies_2000.movie_id
  WHERE movies_2000.year > 2000

)
LIMIT 20;



-- Ocupados en filmacion

SELECT actors.first_name, actors.last_name, movies.name, movies.year, COUNT()

SELECT *
FROM roles
JOIN actors
ON roles.actor_id = actors.id
JOIN movies
ON roles.movie_id = movies.id
ORDER BY movies.id
LIMIT 50;


SELECT *
FROM roles
WHERE COUNT()


--Female

SELECT * 
FROM roles
JOIN actors
ON roles.actor_id = actors.id
JOIN movies
ON roles.movie_id = movies.id
WHERE actors.gender != 'M'
LIMIT 50;


SELECT * FROM roles
LIMIT 10;

