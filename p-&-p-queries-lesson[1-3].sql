/*This file lists query solutions for all the quiz questions in the udacity course: SQL for Data Analysis, lessons 1, 2 & 3*/

select occurred_at, account_id, channel from web_events limit 15;
SELECT id, occurred_at, total_amt_usd FROM orders ORDER BY occurred_at LIMIT 10;
SELECT id, occurred_at, total_amt_usd FROM orders ORDER BY total_amt_usd DESC LIMIT 5;
SELECT id, occurred_at, total_amt_usd FROM orders ORDER BY total_amt_usd LIMIT 20;
SELECT id, account_id, total_amt_usd FROM orders ORDER BY account_id, total_amt_usd DESC;
SELECT id, account_id, total_amt_usd FROM orders ORDER BY total_amt_usd DESC, account_id;
SELECT * FROM orders WHERE gloss_amt_usd >= 1000 ORDER BY gloss_amt_usd LIMIT 5;
SELECT * FROM orders WHERE total_amt_usd < 500 ORDER BY total_amt_usd LIMIT 10;
SELECT name, website, primary_poc FROM accounts WHERE website = 'www.exxonmobil.com';
SELECT id, account_id, (standard_amt_usd / standard_qty) AS unit_price FROM orders LIMIT 10;
SELECT id, account_id, (poster_amt_usd / total_amt_usd)*100 AS revenue FROM orders LIMIT 10;

SELECT * FROM accounts WHERE name LIKE 'C%';
SELECT * FROM accounts WHERE name LIKE '%one%';
SELECT * FROM accounts WHERE name LIKE '%s';
SELECT name, primary_poc, sales_rep_id FROM accounts WHERE name IN ('Walmart', 'Target', 'Nordstrom');
SELECT * FROM web_events WHERE channel IN ('organic', 'adwords');
SELECT name, primary_poc, sales_rep_id FROM accounts WHERE name NOT IN ('Walmart','Target','Nordstrom');
SELECT * FROM web_events WHERE channel NOT IN ('organic', 'adwords');
SELECT * FROM accounts WHERE name NOT LIKE 'C%';
SELECT * FROM accounts WHERE name NOT LIKE '%one%';
SELECT * FROM accounts WHERE name NOT LIKE '%s';
SELECT * FROM orders WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;
SELECT * FROM accounts WHERE name NOT LIKE 'C%' AND name LIKE '%s';
SELECT occurred_at, gloss_qty FROM orders WHERE gloss_qty BETWEEN 24 AND 29; /*includes the values*/
SELECT * FROM web_events WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01' ORDER BY occurred_at DESC;
SELECT id FROM orders WHERE (gloss_qty > 4000 OR poster_qty > 4000);
SELECT * FROM orders WHERE standard_qty = 0 AND (poster_qty > 1000 OR gloss_qty > 1000);
SELECT name FROM accounts WHERE (primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND (name LIKE 'C%' OR name LIKE 'W%') AND (primary_poc NOT LIKE '%eana%');


SELECT * FROM orders JOIN accounts ON orders.account_id = accounts.id;
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc FROM orders JOIN accounts on orders.account_id = accounts.id;
select accounts.primary_poc, web_events.occurred_at, web_events.channel, accounts.name
from accounts 
JOIN web_events
ON web_events.account_id = accounts.id WHERE accounts.name = 'Walmart';
SELECT region.name AS region, 
sales_reps.name AS sales_rep, 
accounts.name AS account
FROM accounts
JOIN sales_reps 
ON sales_reps.id = accounts.sales_rep_id
JOIN region
ON region.id = sales_reps.region_id ORDER BY accounts.name;


SELECT orders.total_amt_usd/(orders.total+0.01) AS unit_price, region.name AS region, accounts.name 
FROM accounts
JOIN orders ON orders.account_id = accounts.id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON region.id = sales_reps.region_id;

SELECT region.name AS region, sales_reps.name AS sales_rep, accounts.name 
FROM region
JOIN sales_reps 
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest';

SELECT region.name AS region, sales_reps.name AS sales_rep, accounts.name 
FROM region
JOIN sales_reps 
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest' AND sales_reps.name LIKE 'S%' ORDER BY accounts.name;

SELECT region.name AS region, sales_reps.name AS sales_rep, accounts.name 
FROM region
JOIN sales_reps 
ON sales_reps.region_id = region.id
JOIN accounts
ON accounts.sales_rep_id = sales_reps.id
WHERE region.name = 'Midwest' AND sales_reps.name LIKE '% K%' ORDER BY accounts.name;

SELECT orders.occurred_at, accounts.name, orders.total, orders.total_amt_usd FROM orders 
JOIN accounts 
ON accounts.id = orders.account_id
WHERE '2015-01-01' <= orders.occurred_at AND orders.occurred_at < '2016-01-01';

SELECT DISTINCT accounts.name, web_events.channel
FROM accounts 
JOIN web_events
ON web_events.account_id = accounts.id
WHERE accounts.id = '1001';

SELECT region.name AS region, accounts.name AS account, (orders.total_amt_usd / orders.total + 0.01) AS unit_price FROM region JOIN sales_reps ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id 
JOIN orders 
ON orders.account_id = accounts.id WHERE orders.standard_qty > 100;


SELECT region.name AS region, accounts.name AS account, (orders.total_amt_usd / orders.total + 0.01) AS unit_price FROM region JOIN sales_reps ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id 
JOIN orders 
ON orders.account_id = accounts.id WHERE orders.standard_qty > 100 AND poster_qty > 50 ORDER BY unit_price;

SELECT region.name AS region, accounts.name AS account, (orders.total_amt_usd / orders.total + 0.01) AS unit_price FROM region JOIN sales_reps ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id 
JOIN orders 
ON orders.account_id = accounts.id WHERE orders.standard_qty > 100 AND poster_qty > 50 ORDER BY unit_price DESC;

SELECT SUM(poster_qty) FROM orders; /*723646*/
SELECT SUM(standard_qty) FROM orders; /*193846*/
SELECT SUM(total_amt_usd) FROM orders; /*231411511*/
SELECT (standard_amt_usd + gloss_amt_usd) AS total_amt FROM orders;
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS total_amt FROM orders; /*4.9*/
SELECT MIN(occurred_at) FROM orders; /*2013-12-04*/
SELECT occurred_at FROM orders ORDER BY occurred_at LIMIT 1; 
SELECT MAX(occurred_at) FROM web_events;
SELECT occurred_at FROM web_events ORDER BY occurred_at DESC LIMIT 1; /*2017-01-01*/
SELECT AVG(standard_qty)AS standard_sales_avg, AVG(gloss_qty) AS gloss_sales_avg, AVG(poster_qty) poster_sales_avg, AVG(standard_amt_usd) standard_amt_avg, AVG(gloss_amt_usd) gloss_amt_avg, AVG(poster_amt_usd) poster_amt_avg FROM orders;

SELECT accounts.name, orders.occurred_at FROM accounts JOIN orders
ON accounts.id = orders.account_id ORDER BY orders.occurred_at LIMIT 1;

SELECT accounts.name, SUM(orders.total_amt_usd) FROM accounts JOIN orders
ON accounts.id = orders.account_id GROUP BY accounts.name;


SELECT accounts.name,  web_events.channel, web_events.occurred_at FROM accounts JOIN web_events
ON accounts.id = web_events.account_id ORDER BY web_events.occurred_at DESC LIMIT 1;

SELECT COUNT(channel), channel FROM web_events GROUP BY channel;

SELECT accounts.primary_poc FROM accounts JOIN web_events
ON accounts.id = web_events.account_id ORDER BY web_events.occurred_at LIMIT 1;

SELECT MIN(orders.total_amt_usd) AS min_order, accounts.name FROM accounts JOIN orders ON orders.account_id = accounts.id GROUP BY accounts.name ORDER BY min_order;

SELECT region.name, COUNT(sales_reps.id) FROM region JOIN sales_reps ON sales_reps.region_id = region.id GROUP BY region.name;

SELECT accounts.name, AVG(orders.standard_qty) standard_avg_qty, AVG(orders.gloss_qty) gloss_avg_qty, AVG(orders.poster_qty) poster_avg_qty FROM orders JOIN accounts ON accounts.id = orders.account_id GROUP BY accounts.name;

SELECT accounts.name, AVG(orders.standard_amt_usd) standard_amt_usd, AVG(orders.gloss_amt_usd) gloss_amt_usd, AVG(orders.poster_amt_usd) poster_amt_usd FROM orders JOIN accounts ON accounts.id = orders.account_id GROUP BY accounts.name;

SELECT sales_reps.name, web_events.channel, COUNT(web_events.channel) FROM sales_reps JOIN accounts ON accounts.sales_rep_id = sales_reps.id JOIN web_events ON web_events.account_id = accounts.id GROUP BY sales_reps.name, web_events.channel;

SELECT region.name, web_events.channel, COUNT(web_events.channel) 
FROM sales_reps JOIN accounts 
ON accounts.sales_rep_id = sales_reps.id 
JOIN web_events ON web_events.account_id=accounts.id 
JOIN region ON region.id = sales_reps.region_id GROUP BY region.name, web_events.channel ORDER BY web_events.channel;

SELECT DISTINCT accounts.name AS account, region.name AS region FROM accounts 
JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id 
JOIN region ON sales_reps.region_id = region.id ORDER BY account;

SELECT DISTINCT sales_reps.name, accounts.name AS account FROM sales_reps JOIN accounts ON sales_reps.id = accounts.sales_rep_id ORDER BY name;


/*Essentially, any time you want to perform a WHERE on an element of your query that was created by an aggregate, you need to use HAVING instead.*/
SELECT sales_reps.name, COUNT(accounts.id) FROM sales_reps JOIN accounts ON accounts.sales_rep_id = sales_reps.id GROUP BY sales_reps.name HAVING COUNT(accounts.id) > 5;

SELECT COUNT(*) FROM accounts JOIN orders ON accounts.id = orders.account_id HAVING COUNT(orders.total) > 5;

SELECT accounts.name, COUNT(orders.*) AS count_test FROM accounts JOIN orders on orders.account_id = accounts.id GROUP BY accounts.name ORDER BY count_test DESC LIMIT 1;

SELECT accounts.name, SUM(orders.total_amt_usd) FROM accounts JOIN orders on orders.account_id = accounts.id GROUP BY accounts.name, orders.account_id HAVING SUM(orders.total_amt_usd) > 30000;

SELECT accounts.name, SUM(orders.total_amt_usd) FROM accounts JOIN orders on orders.account_id = accounts.id GROUP BY accounts.name, orders.account_id HAVING SUM(orders.total_amt_usd) < 1000;

select accounts.name, accounts.id, SUM(orders.total_amt_usd) AS total_spent FROM accounts JOIN orders ON accounts.id = orders.account_id GROUP BY accounts.id, accounts.name ORDER BY total_spent DESC LIMIT 1;

select accounts.name, accounts.id, SUM(orders.total_amt_usd) AS total_spent FROM accounts JOIN orders ON accounts.id = orders.account_id GROUP BY accounts.id, accounts.name ORDER BY total_spent LIMIT 1;

select accounts.name, accounts.id, COUNT(web_events.*) AS total_events FROM accounts JOIN web_events ON web_events.account_id = accounts.id GROUP BY accounts.name, accounts.id, web_events.channel HAVING web_events.channel = 'facebook' AND COUNT(web_events.*) > 6  ORDER BY total_events DESC; 

select accounts.name, accounts.id, COUNT(web_events.*) AS total_events FROM accounts JOIN web_events ON web_events.account_id = accounts.id GROUP BY accounts.name, accounts.id, web_events.channel HAVING web_events.channel = 'facebook' AND COUNT(web_events.*) > 6  ORDER BY total_events DESC LIMIT 1;

select accounts.name, accounts.id, web_events.channel, COUNT(web_events.*) AS total_events FROM accounts JOIN web_events ON web_events.account_id = accounts.id GROUP BY accounts.name, accounts.id, web_events.channel ORDER BY total_events DESC;

SELECT SUM(total_amt_usd) AS total, DATE_PART('year', occurred_at) AS year_occurrence FROM orders GROUP BY year_occurrence ORDER BY total DESC;

SELECT DATE_PART('year', occurred_at) ord_year, DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
 FROM orders
 GROUP BY 1, 2
 ORDER BY 3 DESC;


SELECT SUM(total_amt_usd) AS total, DATE_PART('month', occurred_at) AS month_occurrence FROM orders WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01' GROUP BY month_occurrence ORDER BY total DESC;

SELECT COUNT(total) AS total, DATE_PART('year', occurred_at) AS year_occurrence FROM orders GROUP BY year_occurrence ORDER BY total DESC LIMIT 1;

SELECT COUNT(total) AS total, DATE_PART('month', occurred_at) AS month_occurrence FROM orders GROUP BY month_occurrence ORDER BY total DESC LIMIT 1;

SELECT DATE_PART('month', orders.occurred_at) AS month_occurrence, DATE_PART('year', orders.occurred_at) AS year_occurrence, SUM(orders.gloss_amt_usd) AS total, accounts.name FROM orders JOIN accounts ON accounts.id = orders.account_id WHERE accounts.name = 'Walmart' GROUP BY month_occurrence, year_occurrence, accounts.name ORDER BY total DESC LIMIT 1;

SELECT CASE WHEN orders.total_amt_usd > 3000 THEN 'Large' ELSE 'Small' END AS type, accounts.id, orders.total_amt_usd FROM orders JOIN accounts ON accounts.id = orders.account_id;

SELECT CASE 
WHEN orders.total >= 2000 THEN 'Atleast 2000' 
WHEN  orders.total >=1000 AND orders.total < 2000 THEN 'Between 1000 and 2000' 
ELSE 'Less than 1000'
END AS type, COUNT(*) FROM orders GROUP BY type;

SELECT accounts.name, SUM(orders.total_amt_usd), 
CASE 
WHEN SUM(orders.total_amt_usd) > 200000 THEN 'greater than 200,000'
WHEN SUM(orders.total_amt_usd) BETWEEN 100000 AND 200000 THEN '200,000 and 100,000'
ELSE 'under 100,000' END AS type FROM orders JOIN accounts ON accounts.id = orders.account_id GROUP BY accounts.name ORDER BY sum DESC;

SELECT accounts.name, SUM(orders.total_amt_usd), 
CASE 
WHEN SUM(orders.total_amt_usd) > 200000 THEN 'greater than 200,000'
WHEN SUM(orders.total_amt_usd) BETWEEN 100000 AND 200000 THEN '200,000 and 100,000'
ELSE 'under 100,000' END AS type FROM orders JOIN accounts ON accounts.id = orders.account_id WHERE orders.occurred_at BETWEEN '2016-01-01' AND '2017-01-01' GROUP BY accounts.name ORDER BY sum DESC;

SELECT sales_reps.name, COUNT(orders.*) AS total, CASE WHEN COUNT(orders.*) > 200 THEN 'top' ELSE 'not' END AS type FROM sales_reps JOIN accounts ON accounts.sales_rep_id = sales_reps.id
JOIN orders on accounts.id = orders.account_id  GROUP BY sales_reps.name ORDER BY total DESC;


SELECT sales_reps.name, COUNT(orders.*) AS total,SUM(orders.total_amt_usd),
CASE WHEN COUNT(orders.*) > 200 OR SUM(orders.total_amt_usd) > 750000 THEN 'top' 
WHEN COUNT(orders.*) > 150 OR SUM(orders.total_amt_usd) > 500000 THEN 'middle'
ELSE 'low' END AS type FROM sales_reps JOIN accounts ON accounts.sales_rep_id = sales_reps.id
JOIN orders on accounts.id = orders.account_id  GROUP BY sales_reps.name ORDER BY sum DESC;

select day, channel FROM (
select DATE_TRUNC('day', occurred_at) AS day, channel, COUNT(*) AS total_events FROM web_events GROUP BY 1,2 ORDER BY 3 DESC ) sub LIMIT 2;

select channel, AVG(total_events) FROM (
select DATE_TRUNC('day', occurred_at) AS day, channel, COUNT(*) AS total_events FROM web_events GROUP BY 1,2 ORDER BY 3 DESC ) sub GROUP BY 1;

SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders;

SELECT SUM(total_amt_usd) as total, AVG(standard_qty) AS standard_avg, AVG(gloss_qty) AS gloss_avg, AVG(poster_qty) AS poster_avg FROM orders WHERE DATE_TRUNC('month', occurred_at) = (SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders);

SELECT t3.sales_rep, t2.region, t2.max 
FROM
    (SELECT MAX(total_spent), t1.region 
     FROM
    (SELECT sales_reps.name AS sales_rep,  region.name AS region , SUM(orders.total_amt_usd) AS total_spent FROM accounts 
    JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
    JOIN orders ON orders.account_id = accounts.id
    JOIN region ON sales_reps.region_id = region.id GROUP BY sales_rep, region order by 2)t1 GROUP BY t1.region) t2
JOIN 
    (SELECT sales_reps.name AS sales_rep,  region.name AS region , SUM(orders.total_amt_usd) AS total_spent FROM accounts 
    JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
    JOIN orders ON orders.account_id = accounts.id
    JOIN region ON sales_reps.region_id = region.id GROUP BY sales_rep, region order by 2)t3 ON
t2.region = t3.region AND t3.total_spent = t2.max;

SELECT region.name, COUNT(orders.total) FROM
orders JOIN accounts
ON accounts.id = orders.account_id
JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
JOIN region ON sales_reps.region_id = region.id
GROUP BY region.name
HAVING SUM(orders.total_amt_usd) = 
(SELECT MAX(total_spent)
     FROM
    (SELECT region.name AS region,SUM(orders.total_amt_usd) AS total_spent FROM accounts 
    JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id
    JOIN orders ON orders.account_id = accounts.id
    JOIN region ON sales_reps.region_id = region.id GROUP BY region order by 2)t1);

SELECT COUNT(*) FROM (SELECT accounts.name, accounts.id FROM accounts JOIN orders ON orders.account_id=accounts.id
GROUP BY 1,2
HAVING SUM(orders.total) > (SELECT total FROM (SELECT accounts.name, SUM(orders.standard_qty) AS total_orders, SUM(orders.total) AS total FROM accounts
JOIN orders ON accounts.id = orders.account_id
GROUP BY 1 ORDER BY 2 DESC LIMIT 1)t1))t2;

SELECT COUNT(*) AS total, channel, accounts.name 
FROM web_events 
JOIN accounts ON web_events.account_id = accounts.id 
WHERE web_events.account_id = ( 
SELECT id 
FROM 
(SELECT accounts.name, accounts.id, SUM(total_amt_usd) FROM accounts 
JOIN orders ON accounts.id=orders.account_id GROUP BY 1,2 ORDER BY 3 DESC LIMIT 1)
t1) 
GROUP BY channel, name ORDER BY total DESC;

SELECT AVG(total_amt_usd) FROM (
SELECT accounts.name, accounts.id, SUM(orders.total_amt_usd) AS total_amt_usd FROM accounts JOIN orders ON orders.account_id = accounts.id GROUP BY 1,2 ORDER BY 3 DESC LIMIT 10)t1;

SELECT AVG(avg_order) FROM (
SELECT accounts.name, AVG(orders.total_amt_usd) AS avg_order FROM accounts JOIN orders ON accounts.id=orders.account_id  GROUP BY accounts.name HAVING AVG(orders.total_amt_usd) > (SELECT AVG(orders.total_amt_usd) AS total_amt_usd FROM orders))t1;

