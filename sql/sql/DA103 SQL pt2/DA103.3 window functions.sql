------------------------------
## DA102.2 Window Functions ##
------------------------------

/* Calculation across a set of rows within a table that are somehow related to the current row. Similar to aggregate functions but window functions retain the total number of rows. */

## PARTITION BY & OVER ##
/* A subcaluse of the OVER clause. Similar to GROUP BY. */
/* OVER used immediately after the primary function, before the PARTITION BY */
AGGREGATE_FUNCTION (column_1) OVER
 (PARTITION BY column_2 ORDER BY column_3)
  AS column_name
/* "Create a running total of standard_amt_usd (in the orders table) over order time with no date truncation." */
SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders
/* "Now, modify your query from the previous quiz to include partitions." */
SELECT standard_amt_usd,
       DATE_TRUNC('year', occurred_at) as year,
       SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at) AS running_total
FROM orders


## ROW_NUMBER ##
/* Ranking is distinct amongst records even with ties in what the table is ranked against. */
SELECT ROW_NUMBER() OVER(ORDER BY date_time) AS rank, date_time
FROM   db


## RANK ##
/* Ranking is the same amongst tied values and ranks skip for subsequent values. */
SELECT RANK() OVER(ORDER BY date_time) AS rank, date_time
FROM   db
/* "Select the id, account_id, and total variable from the orders table, then create a column called total_rank that ranks this total amount of paper ordered (from highest to lowest) for each account using a partition." */
SELECT id,
       account_id,
       total,
       RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders


## DENSE_RANK ##
/* Ranking is the same amongst tied values and ranks do not skip for subsequent values. */
SELECT DENSE_RANK() OVER(ORDER BY date_time) AS rank, date_time
FROM   db


---------------------------------
## ADVANCED window functions ##
---------------------------------

## ALIASES ##
/* A monthly_window alias function is defined at the end of the query in the WINDOW caluse. It is then called on each time an aggregate function is used within the SELECT clause. */
/** If you are planning to write multiple window fucntions that leverage the same PARTITION BY, OVER, and ORDER BY in a single query, leveraging aliases will help tighten your syntax **/
SELECT order_id,
       order_total,
       order_price,
       SUM(order_total) OVER monthly_window AS running_monthly_sales,
       COUNT(order_id) OVER monthly_window AS running_monthly orders,
       AVG(order_price) OVER monthly_window AS average_monthly_price
FROM   amazon_sales_db
WHERE  order_date < '2017-01-01'
WINDOW monthly_window AS
       (PARTITION BY month(order_date) ORDER BY order_date);
/* "Now, create and use an alias to shorten the following query that has multiple window functions. Name the alias account_year_window." */
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
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))


## LAG ##
/* Returns the value from a previous row to the current row in the table */
SELECT account_id,
       standard_sum,
       LAG(standard_sum) OVER (ORDER BY standard_sum) AS lag
FROM   (
        SELECT   account_id,
                 SUM(standard_qty) AS standard_sum
        FROM     orders
        GROUP BY 1
       ) sub       


## LEAD ##
/* Returns the value from the row following the current row in the table */
SELECT account_id,
       standard_sum,
       LEAD(standard_sum) OVER (ORDER BY standard_sum) AS lead
FROM   (
        SELECT   account_id,
                 SUM(standard_qty) AS standard_sum
        FROM     orders
        GROUP BY 1
       ) sub
/* "Determine how the current order's total revenue compares to the next order's total revenue" */
SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt_usd
  FROM orders 
 GROUP BY 1
) sub


## PERCENTILES ##
/* When there are a large number of records that need to be ranked, percentiles help better describe large datasets. */
NTILE(number_of_buckets) OVER

 (ORDER BY ranking_column)

  AS column_name
/* "Use the NTILE functionality to divide the orders for each account into 100 levels in terms of the amount of total_amt_usd for their orders. Your resulting table should have the account_id, the occurred_at time for each order, the total amount of total_amt_usd paper purchased, and one of 100 levels in a total_percentile column." */
SELECT
       account_id,
       occurred_at,
       total_amt_usd,
       NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
  FROM orders 
 ORDER BY account_id DESC