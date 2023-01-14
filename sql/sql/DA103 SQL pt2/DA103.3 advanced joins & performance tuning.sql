-----------------------------------------------------
## DA102.2 SQL Advanced JOINS & Performance Tuning ##
-----------------------------------------------------

## FULL OUTER JOIN ##
/* In some join cases, you might want to include unmatched rows from both tables being joined. This can be achieved with a full outer join. */
SELECT *
  FROM accounts
 FULL JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id


## UNION ##
/* The UNION operator is used to combine the results sets of 2 or more SELECT statements. It removes duplicate rows between the various SELECT statements. */
SELECT *
FROM web_events
UNION
SELECT *
FROM web_events_2
/* "Write a query that uses UNION ALL on two instances of the accounts table." */
SELECT *
    FROM accounts

UNION ALL

SELECT *
  FROM accounts


------------------------
## PERFORMANCE TUNING ##
------------------------

## LIMIT ##
/* If you have time series data, limiting to a small time window can make your queries run more quickly. */
/* Testing your queries on a subset of data, finalizing your query, then removing the subset limitation is a good strategy */
/* When working with subqueries, limiting the amount of the data that you're working with in the place where it will be executed first will have the maximum impact on query run time. */
SELECT account_id,
       SUM(poster_qty) AS sum_poster_qty
FROM   (SELECT * FROM orders LIMIT 100) sub
WHERE  occurred_at >= '2016-01-01'
AND    occurred_at < '2016-07-01'
GROUP BY 1


## EXPLAIN ##
/* Adding the command EXPLAIN at the beginning of any query allows you to get a sense of how long it will take your query to run. This will output a query plan which outlines the execution order of the query. The higher the cost in the plan, the higher the runtime. */
/* Most useful to use EXPLAIN to identify and modify the steps that are expensive. */
EXPLAIN
SELECT *
FROM   web_events
WHERE  occurred_at >='2016-01-01'
AND    occurred_at < '2016-02-01'
LIMIT 100