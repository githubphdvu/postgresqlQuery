--$ psql -U username -d dbname -f filename.sql

-- SELECT * FROM analytics;--verify table analytics,columns:id,app_name,category,rating,reviews,...
--...size,min_installs,price,content_rating,genres,last_updated,current_version,android_version

-- 1.Find app with ID 1880
SELECT * FROM analytics WHERE id = 1880;--Web Browser for Android ...

-- 2. Find ID,app name of apps that were last_updated 2018-08-01
SELECT id, app_name FROM analytics WHERE last_updated = '2018-08-01';

-- 3. Count apps in each category, e.g. "Family | 1972"
SELECT category, COUNT(*) FROM analytics GROUP BY category;

-- 4. Find top 5 most-reviewed apps and number of reviews for each
SELECT * FROM analytics ORDER BY reviews DESC LIMIT 5;

-- 5. Find full record of app that has the most reviews with rating >= 4.8
SELECT * FROM analytics WHERE rating >= 4.8 ORDER BY reviews DESC LIMIT 1;

-- 6. Find average rating for each category ordered by highest rated to lowest rated
SELECT category, AVG(rating) FROM analytics GROUP BY category ORDER BY avg DESC;

-- 7. Find name,price,rating of most expensive app with rating < 3
SELECT app_name, price, rating FROM analytics WHERE rating < 3 ORDER BY price DESC LIMIT 1;

-- 8. Find all records with a min install not exceeding 50, that have rating.Order results by highest rated first
SELECT * FROM analytics WHERE min_installs <= 50 AND rating IS NOT NULL ORDER BY rating DESC;

-- 9. Find app_name with rating<3 and reviews>=10000
SELECT app_name FROM analytics WHERE rating < 3 AND reviews >= 10000;

-- 10. Find top 10 most-reviewed apps with price BETWEEN 0.1 and $1
SELECT * FROM analytics WHERE price BETWEEN 0.1 and 1 ORDER BY reviews DESC LIMIT 10;

-- 11. Find most out of date app(http://www.postgresqltutorial.com/postgresql-max-function)
SELECT * FROM analytics WHERE last_updated = (SELECT MIN(last_updated) FROM analytics);--with subquery
SELECT * FROM analytics ORDER BY last_updated LIMIT 1;--without subquery

-- 12. Find most expensive app (very similar to #11)
SELECT * FROM analytics WHERE price = (SELECT MAX(price) FROM analytics);--with subquery
SELECT * FROM analytics ORDER BY price DESC LIMIT 1;--without subquery

-- 13. Count all reviews in Google Play Store
SELECT SUM(reviews) AS "All the Reviews" FROM analytics;

-- 14. Find all categories that have more than 300 apps in them
SELECT category FROM analytics GROUP BY category HAVING COUNT(*) > 300;

-- 15. Find app that has highest proportion of reviews to min_installs,among apps that have been installed at least 100,000 times. 
--Display app_name,reviews, the min_installs,proportion.
SELECT app_name, reviews, min_installs,  min_installs / reviews AS proportion
FROM analytics 
WHERE min_installs >= 100000 
ORDER BY proportion DESC LIMIT 1;

-- FURTHER STUDY1. Find app_name,rating in each category,among apps that have been installed at least 50,000 times
SELECT app_name, rating, category FROM analytics
  WHERE (rating, category) IN (SELECT MAX(rating), category FROM analytics WHERE min_installs >= 50000 GROUP BY category)
  ORDER BY category;

-- FS2. Find all the apps with name similar to "facebook"
SELECT * FROM analytics WHERE app_name ILIKE '%facebook%';

-- FS3. Find all the apps that have more than 1 genre.
SELECT * FROM analytics WHERE  array_length(genres, 1) = 2;

-- FS4. Find all the apps that have education as one of their genres.
SELECT * FROM analytics WHERE genres @> '{"Education"}';