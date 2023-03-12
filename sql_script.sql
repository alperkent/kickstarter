-- create a new table that containts all the information
CREATE TABLE all_data 
SELECT cam.id AS ID, cam.name AS project_name, sub.name AS subcategory_name, cat.name AS category_name, cou.name AS country, cur.name AS currency, cam.launched AS launch_date, cam.deadline AS deadline_date, DATEDIFF(cam.deadline, cam.launched) AS duration_days, cam.goal AS goal, cam.pledged AS money_raised, cam.backers AS no_of_backers, cam.outcome AS outcome
FROM campaign AS cam
JOIN sub_category AS sub ON cam.sub_category_id = sub.id
JOIN category AS cat ON cat.id = sub.category_id
JOIN country AS cou ON cou.id = cam.country_id
JOIN currency AS cur ON cur.id = cam.currency_id
ORDER BY ID;

-- preview all the data
SELECT *
FROM all_data;

-- number of USD campaigns
SELECT COUNT(*)
FROM all_data
WHERE currency = 'USD';

-- list of outcomes and count
SELECT outcome, COUNT(*)
FROM all_data
WHERE currency = 'USD'
GROUP BY outcome;

-- pledged and outcome statistics
SELECT  COUNT(*), AVG(money_raised), STDDEV(money_raised), VARIANCE(money_raised), outcome
FROM all_data
WHERE currency = 'USD' AND outcome = 'successful' OR outcome = 'failed'
GROUP BY outcome;

-- pledged and outcome table
SELECT  id, money_raised, outcome
FROM all_data
WHERE currency = 'USD' AND outcome = 'successful' OR outcome = 'failed';

-- goal and outcome statistics
SELECT  COUNT(*), AVG(goal), STDDEV(goal), VARIANCE(goal), outcome
FROM all_data
WHERE currency = 'USD' AND outcome = 'successful' OR outcome = 'failed'
GROUP BY outcome;

-- goal and outcome table
SELECT  id, goal, outcome
FROM all_data
WHERE currency = 'USD' AND outcome = 'successful' OR outcome = 'failed';

-- backers and outcome statistics
SELECT  COUNT(*), AVG(no_of_backers), STDDEV(no_of_backers), VARIANCE(no_of_backers), outcome
FROM all_data
WHERE currency = 'USD' AND outcome = 'successful' OR outcome = 'failed'
GROUP BY outcome;

-- backers and outcome table
SELECT  id, no_of_backers, outcome
FROM all_data
WHERE currency = 'USD' AND outcome = 'successful' OR outcome = 'failed';

-- list of categories and count
SELECT category_name, COUNT(category_name) AS number_of_campaigns
FROM all_data
GROUP BY category_name
ORDER BY number_of_campaigns DESC;

-- list of subcategories and count
SELECT subcategory_name, COUNT(subcategory_name) AS number_of_campaigns
FROM all_data
GROUP BY subcategory_name
ORDER BY number_of_campaigns DESC;

-- top 3 subcategories by backers
SELECT subcategory_name, COUNT(no_of_backers)
FROM all_data 
GROUP BY subcategory_name
ORDER BY COUNT(no_of_backers) DESC
LIMIT 3;

-- bottom 3 subcategories by backers
SELECT subcategory_name, COUNT(no_of_backers)
FROM all_data 
GROUP BY subcategory_name
ORDER BY COUNT(no_of_backers) ASC
LIMIT 3;

-- top 3 categories by backers
SELECT category_name, COUNT(no_of_backers)
FROM all_data 
GROUP BY category_name
ORDER BY COUNT(no_of_backers) DESC
LIMIT 3;

-- bottom 3 categories by backers
SELECT category_name, COUNT(no_of_backers)
FROM all_data 
GROUP BY category_name
ORDER BY COUNT(no_of_backers) ASC
LIMIT 3;

-- top 3 subcategories by money raised
SELECT subcategory_name, SUM(money_raised)
FROM all_data 
WHERE currency = 'USD'
GROUP BY subcategory_name
ORDER BY SUM(money_raised) DESC
LIMIT 3;

-- bottom 3 subcategories by money raised
SELECT subcategory_name, SUM(money_raised)
FROM all_data
WHERE currency = 'USD' 
GROUP BY subcategory_name
ORDER BY SUM(money_raised) ASC
LIMIT 3;

-- top 3 categories by money raised
SELECT category_name, SUM(money_raised)
FROM all_data 
WHERE currency = 'USD'
GROUP BY category_name
ORDER BY SUM(money_raised) DESC
LIMIT 3;

-- bottom 3 categories by money raised
SELECT category_name, SUM(money_raised)
FROM all_data 
WHERE currency = 'USD'
GROUP BY category_name
ORDER BY SUM(money_raised) ASC
LIMIT 3;

-- most successful board game company
SELECT project_name, money_raised, no_of_backers
FROM all_data
WHERE subcategory_name = 'Tabletop Games'
ORDER BY money_raised DESC
LIMIT 1;

-- top 3 countries by money raised
SELECT country, SUM(money_raised)
FROM all_data
WHERE outcome = 'successful'
GROUP BY country
ORDER BY SUM(money_raised) DESC
LIMIT 3;

-- top 3 countries by number of campaigns backed
SELECT country, COUNT(outcome) AS backed_campaigns
FROM all_data
WHERE outcome = 'successful'
GROUP BY country
ORDER BY backed_campaigns DESC
LIMIT 3;

-- campaign duration statistics
SELECT AVG(duration_days) AS mean_duration, MAX(duration_days) AS max_duration, MIN(duration_days) AS min_duration, STD(duration_days) AS std_duration
FROM all_data;

-- list containing money raised by campaign duration
SELECT money_raised, duration_days, outcome
FROM all_data
WHERE currency = 'USD'
ORDER BY duration_days DESC
