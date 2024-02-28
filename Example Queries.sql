-- 1. Select all information for the top ten best-selling games
-- Order the results from best-selling game down to tenth best-selling

SELECT 
	game_name, 
    platform, 
	publisher, 
    developer, 
    games_sold, 
    years
FROM videogame_data.sales s
JOIN videogame_data.game_names gn
ON gn.game_id = s.game_id
ORDER BY games_sold DESC
LIMIT 10
;




-- 2. Join games_sales and reviews
-- Select a count of the number of games where both critic_score and user_score are null

SELECT COUNT(*)
FROM videogame_data.sales s
RIGHT JOIN videogame_data.reviews r
ON s.game_id = r.game_id
WHERE critic_score IS NULL and user_score IS NULL
;


-- 3. Try and measure which years were the best for video games. 
-- 	  Find the avg critic score by year and sort highest to lowest limiting the data to only the 10 highest.

SELECT 
	s.years, 
	ROUND(AVG(r.critic_score),2) AS 'Avg Critic Score'
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
ORDER BY AVG(r.critic_score) DESC
LIMIT 10
;



-- 4. Investigate this further. Do all these years have enough data to say they were in the golden age of video games?
--    Update the above query so that we can see the count of games released each year and only show years that had more than 20 reviewed games.

SELECT 
	s.years, 
    ROUND(AVG(r.critic_score),2) AS 'Avg Critic Score', 
    COUNT(s.game_id) AS num_games
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
HAVING COUNT(s.game_id) > 20
ORDER BY AVG(r.critic_score) DESC
LIMIT 10
;


-- 5: Compare the previous to data pulls to see which years fell off.
--    Based on this we can identify what really was the golden age of video games.

CREATE TEMPORARY TABLE temp_inclusive_games
SELECT 
	s.years, 
	ROUND(AVG(r.critic_score),2) AS avg_critic_score, 
    COUNT(s.game_id) AS num_games
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
ORDER BY AVG(r.critic_score) DESC
LIMIT 10
;

CREATE TEMPORARY TABLE temp_top_games
SELECT 
	s.years, 
	ROUND(AVG(r.critic_score),2) AS avg_critic_score, 
    COUNT(s.game_id) AS num_games
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
HAVING COUNT(s.game_id) > 20
ORDER BY AVG(r.critic_score) DESC
LIMIT 10
;


SELECT *
FROM temp_inclusive_games tig
EXCEPT
SELECT *
FROM temp_top_games ttg
;




-- 6: 1984, 1985, and 2020 fell off. It looks like the golden age was the early 1990's
--    Lets now look at how users reviewed video games. Do the same thing in question 4 but for user_score.

SELECT 
	s.years, 
	ROUND(AVG(r.user_score),2) AS 'Avg User Score', 
    COUNT(s.game_id) AS num_games
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
HAVING COUNT(s.game_id) > 20
ORDER BY AVG(r.user_score) DESC
LIMIT 10
;



-- 7: Now compare the top critic years to the top user years. What Years overlap?

CREATE TEMPORARY TABLE temp_top_critic_games
SELECT 
	s.years, 
    ROUND(AVG(r.critic_score),2) AS avg_critic_score, 
    COUNT(s.game_id) AS num_games
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
HAVING COUNT(s.game_id) > 20
ORDER BY AVG(r.critic_score) DESC
LIMIT 10
;


CREATE TEMPORARY TABLE temp_top_user_games
SELECT 
	s.years, 
    ROUND(AVG(r.user_score),2) AS avg_user_score, 
    COUNT(s.game_id) AS num_games
FROM videogame_data.sales s
JOIN videogame_data.reviews r
ON s.game_id = r.game_id
GROUP BY s.years
HAVING COUNT(s.game_id) > 20
ORDER BY AVG(r.user_score) DESC
LIMIT 10
;


SELECT years FROM temp_top_user_games
INTERSECT
SELECT years FROM temp_top_critic_games;


-- 8: 1990 and 1994 were the only years that overlapped in the top 10.
--    Lets see how the games sold those years. select year and sum of games sold ordered by 
--    games sold. Filter to only the two relevant years.

CREATE TEMPORARY TABLE years_top_games

SELECT years FROM temp_top_user_games
INTERSECT
SELECT years FROM temp_top_critic_games;


SELECT 
	s.years, 
    SUM(s.games_sold) AS sum_games_sold
FROM sales s
WHERE s.years IN (SELECT years FROM years_top_games)
GROUP BY s.years
ORDER BY SUM(s.games_sold) DESC
;