/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAMILIAR WITH THE DATABASE AND TABLES HERE


.tables


--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/

SELECT movie_id FROM movie_distributors
WHERE distributor_id = 10;

/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/

SELECT distributors.name FROM distributors
JOIN movie_distributors ON distributors.distributor_id = movie_distributors.distributor_id 
JOIN movies ON movie_distributors.movie_id = movies.movie_id
WHERE movies.year = 2006;


/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/

SELECT m1.title, m2.title, m1.year 
FROM movies as m1
LEFT JOIN movies as m2
ON m1.year = m2.year
WHERE m1.movie_id < m2.movie_id AND m1.year > 2010;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/

select people.name, movies.title from movies
join directors on movies.movie_id=directors.movie_id
join roles on directors.person_id=roles.person_id
join people on directors.person_id=people.person_id
group by movies.movie_id;


/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/

select movies.*, aka_titles.title as aka_movie_title, aka_titles.note  from movies
left join aka_titles on movies.movie_id=aka_titles.movie_id
where movies.year=2011;


/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/

SELECT movies.*, people.name from movies
join composers on movies.movie_id=composers.movie_id
join people on people.person_id=composers.person_id
where movies.year= 1976 or movies.year=1977;

/* TASK VII
Find the most popular movie genres.
*/

SELECT genres.label from movie_genres
join genres on genres.genre_id=movie_genres.genre_id
GROUP BY movie_genres.genre_id
order by count(movie_genres.genre_id) DESC
LIMIT 1;

/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/

select people.name from cinematographers
JOIN movies on movies.movie_id=cinematographers.movie_id
JOIN people ON cinematographers.person_id=people.person_id
GROUP BY cinematographers.person_id
order by avg(movies.rating) DESC
limit 10;

/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

select countries.name from movie_countries
JOIN countries on countries.country_id=movie_countries.country_id
JOIN movies on movies.movie_id=movie_countries.movie_id
GROUP BY countries.country_id
HAVING max(movies.rating)>8.5;

/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/

select movies.title,movies.year,movies.rating,countries.name from movie_countries
JOIN countries on countries.country_id=movie_countries.country_id
JOIN movies on movies.movie_id=movie_countries.movie_id
order by movies.rating DESC
limit 1;

/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
