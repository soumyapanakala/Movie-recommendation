--- create a database---
create database movies;

---use database--
use movies;

---import the datasets by using import flat file----
select * from tags; 
select * from links;
select * from movies;
select * from ratings;

---Check whether there are any null values in all the dataset---
select * from tags where movieId is null; 
select * from links where tmdbId is null;   ---links data consists of some nullvalues--
select * from movies where title is null;
select * from ratings where rating is null;

---Show top rated movies with movieid and movie name (number of rating for certain movie should be 
--                                                     greater than 200)

select  ratings.movieId ,title,count(rating) as num_of_ratings
from ratings
left join movies
on ratings.movieId = movies.movieId 
group by ratings.movieId,title
having COUNT(rating)>200
order by COUNT(rating) desc;

--- Show the top 10 movies only from above conditions...
select top 10  ratings.movieId ,title,count(rating) as num_of_ratings
from ratings
left join movies
on ratings.movieId = movies.movieId 
group by ratings.movieId,title
having COUNT(rating)>200
order by COUNT(rating) desc;

--- Show the top 10 users who have rated most number of movies (minimum number of
---                                  rating should be 1000,Show the top 10 data only in descending order)
select top 10 userId,COUNT(rating) as num_of_ratings from ratings
group by userId
having count(rating)>=1000
order by count(rating) desc;

---Create a Table Value Function in which if we pass the username it will return us a
---                                  table in which we can see rated movies by user with all details...
create function rated_movies()
returns table 
as
return
select ratings.userId as username,title as movie,rating
from ratings
left join movies
on ratings.movieId=movies.movieId;
--- execute table value function with the function name ---
select * from rated_movies();


-- Create a popularity based recommendation system which will recommend nearly 18 
--                                                  movies with following rules:---
--Most Rated movies their title name
-- There total average rating
-- Order them in descending order
-- Also add movieid column
-------         Create whole code of the above question in a procedure with any name:      ------

CREATE PROCEDURE top_recommended_movies
as
begin
select top 18 ratings.movieId,title,avg(rating) as avg_rating
from ratings
left join movies
on ratings.movieId=movies.movieId
group by ratings.movieId,title
order by avg(rating) desc;
end;
-- Now execute the created procedure--
execute top_recommended_movies;



                    ----- END of End_capstone_2 ------




