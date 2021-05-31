/*This file lists query solutions for all the quiz questions in the udacity course: SQL for Data Analysis, lessons 6 & 7*/

SELECT standard_amt_usd, SUM(standard_amt_usd) OVER (ORDER BY occurred_at) FROM orders;

SELECT standard_amt_usd,
DATE_TRUNC('year', occurred_at),
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total FROM orders;

SELECT id, account_id, total,
RANK() OVER(PARTITION BY account_id ORDER BY total DESC) AS rank_new FROM orders;

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at));

/*Window function to find difference between rows*/
SELECT occurred_at, total_amt_usd, 
LEAD(total_amt_usd) OVER(ORDER BY occurred_at) AS lead,
LEAD(total_amt_usd) OVER(ORDER BY occurred_at) - total_amt_usd AS lead_diff
FROM (
  SELECT occurred_at, SUM(total_amt_usd) AS total_amt_usd FROM orders GROUP BY 1
) sub;

SELECT account_id, occurred_at, standard_qty,
NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS quartile
FROM orders
ORDER BY account_id DESC;

SELECT account_id, occurred_at, gloss_qty,
NTILE(2) OVER (ORDER BY gloss_qty) AS gloss_half
FROM orders;

SELECT account_id, occurred_at, total_amt_usd,
NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
FROM orders;

SELECT accounts.id, accounts.name, sales_reps.id as sales_rep_id, sales_reps.name as sales_rep 
FROM accounts 
FULL OUTER JOIN sales_reps ON sales_reps.id = accounts.sales_rep_id;

/*If unmatched rows existed (they don't for this query), you could isolate them by adding the following line to the end of the query:
WHERE accounts.sales_rep_id IS NULL OR sales_reps.id IS NULL*/

SELECT accounts.*, sales_reps.name AS sales_rep FROM accounts LEFT JOIN sales_reps ON 
accounts.sales_rep_id = sales_reps.id AND 
accounts.primary_poc < sales_reps.name;

/*Self joins used when to find events that occur one after another*/
SELECT o1.id AS id,
o1.channel AS channel,
o1.account_id AS account_id,
o1.occurred_at AS occurred_at,
o2.id AS o2_id,
o2.account_id AS o2_account_id,
o2.occurred_at AS o2_occurred_at,
o2.channel AS o2_channel
FROM web_events o1 LEFT JOIN web_events o2 ON
o1.account_id = o2.account_id
AND o2.occurred_at > o1.occurred_at
AND o2.occurred_at <= o1.occurred_at + INTERVAL '1 day'
ORDER BY o1.account_id, o1.occurred_at;

/*The use case for leveraging the UNION command in SQL is when a user wants to pull together distinct values of specified columns that are
spread across multiple tables. For example, a chef wants to pull together the ingredients and respective aisle across three separate meals
that are maintained in different tables. 
Joins stack side by side, UNION stack one on top of another
UNION appends only distinct rows, UNION ALL appends all rows*/

WITH accounts AS (
SELECT a1.* FROM accounts a1
UNION ALL
SELECT a2.* FROM accounts a2
)
SELECT * FROM accounts;


WITH accounts AS (
SELECT a1.* FROM accounts a1 
WHERE a1.name = 'Walmart'
UNION ALL
SELECT a2.* FROM accounts a2
WHERE a2.name = 'Disney'
)
SELECT * FROM accounts;

WITH double_accounts AS (
SELECT a1.name AS a1_name FROM accounts a1
UNION ALL
SELECT a2.name AS a2_name FROM accounts a2
)
SELECT a1_name, COUNT(*) FROM double_accounts GROUP BY a1_name;

SELECT account_id, SUM(poster_qty) FROM (select * from orders LIMIT 100) sub 
WHERE occurred_at >= '2016-01-01'
AND occurred_at < '2016-07-01'
GROUP BY 1;

