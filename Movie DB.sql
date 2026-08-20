# create database
CREATE DATABASE MovieDB;

# use database
USE MovieDB;

# create table of directors
CREATE TABLE directors(
	director_id INT PRIMARY KEY,
    director_name VARCHAR(50) NOT NULL,
    country	VARCHAR(50) DEFAULT "Pakistan"
);

# create table of movies
CREATE TABLE movies(
	movie_id INT PRIMARY KEY,
    title VARCHAR(50) NOT NULL UNIQUE,
    rating FLOAT,
    budget INT,
    director_id INT,
    FOREIGN KEY (director_id) REFERENCES directors(director_id)
    ON DELETE CASCADE
);

# create table of actors
CREATE TABLE actors(
	actor_id INT Primary Key,
    actor_name	VARCHAR(50) NOT NULL,
	age INT, CHECK (age >= 18),
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

# Inset data in directors table
INSERT INTO directors
(director_id, director_name, country)
VALUES
(101, "Bob", "England"),
(102, "Jhon", "Iceland"),
(103, "Casey", "Canada"),
(104, "Donald", "England");
# Insert data in movies table
INSERT INTO movies
(movie_id, title, rating, budget, director_id)
VALUES
(201, "Movie1", 2.0, 50000, 102),
(202, "Movie2", 4.6, 50000, 104),
(203, "Movie3", 4.0, 2100000, 101),
(204, "Movie4", 4.9, 70000, 103),
(205, "Movie5", 3.5, 60000, 101),
(206, "Movie6", 4.1, 200000, 103);

# Insert data in actors table
INSERT INTO actors
(actor_id, actor_name, age, movie_id)
VALUES
(301, "actor1", 48, 201),
(302, "actor2", 23, 202),
(303, "actor3", 21, 203),
(304, "actor4", 30, 204),
(305, "actor5", 36, 205),
(306, "actor6", 25, 206),
(307, "actor7", 26, 202),
(308, "actor8", 28, 204);

# Display all movies
SELECT * FROM movies;

# Display movies with a rating greater than 4.0
SELECT * FROM movies WHERE rating>4.0;

# Display movies with budget between 50000 and 150000.
SELECT * FROM movies WHERE budget BETWEEN 50000 AND 150000;

# Display the top 3 highest-rated movies.
SELECT * FROM movies ORDER BY rating DESC LIMIT 3;

# Find the highest movie budget.
SELECT MAX(budget) FROM movies;

# Find the average movie rating.
SELECT AVG(rating) FROM movies;

# Count the total number of movies.
SELECT COUNT(*) FROM movies;

# Display: Movie title + Director name
SELECT title, director_name
FROM directors
INNER JOIN movies
ON directors.director_id = movies.director_id;

# Display: Movie title + Actor name
SELECT title, actor_name
FROM movies
INNER JOIN actors
ON movies.movie_id = actors.movie_id;

# Display all movies directed by a particular director(Bob) using the director's name, not ID.
SELECT *
FROM movies
INNER JOIN directors
ON movies.director_id = directors.director_id
WHERE director_name = "Bob";

# Find movies whose rating is greater than the average rating.
SELECT *
FROM movies 
WHERE rating>(SELECT AVG(rating) FROM movies);

# Find the movie with the highest budget.
SELECT *
FROM movies
WHERE budget = (SELECT MAX(budget) FROM movies);

# Find actors who are acting in the same movie as a particular actor.
SELECT *
FROM actors
WHERE movie_id = (
    SELECT movie_id
    FROM actors
    WHERE actor_name = "actor2"
);

# Find the number of movies made by each director.
SELECT director_name, COUNT(movie_id)
FROM movies
INNER JOIN directors
ON movies.director_id = directors.director_id
GROUP BY director_name;


# Find directors who have made more than 1 movie.
SELECT director_name, COUNT(movie_id)
FROM movies
INNER JOIN directors
ON movies.director_id = directors.director_id
GROUP BY director_name
HAVING COUNT(movie_id)>1;


# Create a view called: movie_details
# It should show: Movie title | Rating | Budget | Director name
# Then display the view.
CREATE VIEW movie_details AS
SELECT title, rating, budget, director_name
FROM movies
INNER JOIN directors
ON movies.director_id = directors.director_id;

SELECT * FROM movie_details;

# Create one query showing: Movie title | Rating | Director name
# But only show movies whose rating is higher than the average rating of all movies.
SELECT title, rating, director_name
FROM movies
INNER JOIN directors
ON movies.director_id = directors.director_id
WHERE rating> (SELECT AVG(rating) FROM movies);

