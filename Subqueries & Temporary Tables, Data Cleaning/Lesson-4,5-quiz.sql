/*This file lists query solutions for all the quiz questions in the udacity course: SQL for Data Analysis, lessons 4 & 5*/

SELECT RIGHT(website, 3) as extension, COUNT(*) FROM accounts GROUP BY RIGHT(website, 3);

SELECT LEFT(UPPER(name), 1) as name, COUNT(*) FROM accounts GROUP BY LEFT(UPPER(name), 1) ORDER BY 2 DESC; 

SELECT 
SUM(CASE WHEN LEFT(name, 1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END) AS name, 
SUM(CASE WHEN LEFT(name, 1) NOT IN ('0','1','2','3','4','5','6','7','8','9') THEN 1 ELSE 0 END) AS alphabet FROM accounts;

SELECT 
SUM(CASE WHEN UPPER(LEFT(name, 1)) IN ('A','E','I','O', 'U') THEN 1 ELSE 0 END) AS name, 
SUM(CASE WHEN LEFT(name, 1) NOT IN ('A','E','I','O', 'U') THEN 1 ELSE 0 END) AS alphabet FROM accounts;

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS name, RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)) AS surname FROM accounts;

SELECT LEFT(name, STRPOS(name, ' ')-1) AS firstname, RIGHT(name, LENGTH(name) - POSITION(' ' IN name)) AS surname, name FROM sales_reps;

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) as first_name, RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) AS last_name, REPLACE(LOWER(LEFT(primary_poc, STRPOS(primary_poc, ' ')-1)  || '.' || RIGHT(primary_poc, LENGTH(primary_poc)-POSITION(' ' IN primary_poc)) || '@' || name || '.com'), ' ', '') AS email FROM accounts;

SELECT primary_poc, 
LOWER(LEFT(primary_poc,1)) as firstname_first, 
RIGHT(LOWER(LEFT(primary_poc, STRPOS(primary_poc, ' ')-1)),1) as firstname_last,
LEFT(LOWER(RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' '))), 1) as lastname_first, 
RIGHT(primary_poc, 1) AS lastname_last, LENGTH(LEFT(primary_poc,STRPOS(primary_poc,' ')-1)) as left_length, 
LENGTH(RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' '))) as right_length,
UPPER(REPLACE(name, ' ', '')) as company
FROM accounts;

WITH t1 AS (
  SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) first_name, RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' ')) last_name, name FROM ACCOUNTS
)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ',''),'.com') AS email,
LEFT(LOWER(first_name),1) || RIGHT(LOWER(first_name),1) || 
LEFT(LOWER(last_name),1) ||
RIGHT(LOWER(last_name),1) ||
LENGTH(first_name) ||
LENGTH(last_name) ||
UPPER(REPLACE(name, ' ','')) AS password
FROM t1;

/*dates format in sql: yyyy-mm-dd*/
WITH t1 AS (
  SELECT date, LEFT(date, 2) AS month, SUBSTR(date, 4, 2) AS date_new, RIGHT(LEFT(date, STRPOS(date, ' ')-1), 4) as year_new
FROM sf_crime_data
)
SELECT CONCAT(year_new, '-', month,'-', date_new)::date FROM t1;

SELECT COALESCE(o.id, a.id) filled_id, a.*, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COALESCE(o.id, a.id) filled_id, a.*, o.*,
COALESCE(o.account_id, a.id) filled_accountid
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

SELECT COALESCE(o.id, a.id) filled_id, a.name,a.website,a.lat,a.long,a.primary_poc,a.sales_rep_id, COALESCE(o.account_id, a.id) filled_order_id , o.account_id,o.occurred_at, COALESCE(o.standard_qty,0) filled_std_qty, COALESCE(o.gloss_qty,0) filled_gloss_qty, COALESCE(o.poster_qty,0) filled_poster_qty, COALESCE(o.total,0) filled_total, COALESCE(o.standard_amt_usd,0) filled_std_amt, COALESCE(o.gloss_amt_usd,0) filled_gloss_amt, COALESCE(o.poster_amt_usd,0) filled_poster_amt,COALESCE(o.total_amt_usd,0) filled_total_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

