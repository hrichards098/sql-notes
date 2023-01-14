------------------------
## DA102.2 Basic SQL ##
------------------------

## LIMIT ##
/* Limit the number of returned queried with LIMIT */
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;


## ORDER BY ##
/* Sort the data temporarily with the ORDER BY statement. Can use DESC also to sort in descending order, which will show the most recent results for dates for example. */
SELECT *
FROM orders
ORDER BY occurred_at
LIMIT 1000;
/* "Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd" */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC 
LIMIT 5;
/* "Now write a query that again displays order ID, account ID, and total dollar amount for each order, but this time sorted first by total dollar amount (in descending order), and then by account ID (in ascending order)." */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;


## WHERE clause ##
/* Display subsets of tables based upon conditions that must be met using WHERE. Filters the data. Can use symbols for example > greater than, and <= less than or equal to */
SELECT *
FROM orders
WHERE account_id = 4251
ORDER BY occurred_at
LIMIT 1000;
/* "Create a query that pulls the first 5 rows and all columns from the orders table that have a dollar amount of gloss_amt_usd greater than or equal to 1000." */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;
/* "Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc) just for the Exxon Mobil company in the accounts table." */
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


## AS & Derived Columns ##
/* Creating a new column that is a combination of existing columns is known as a derived column. Can give it an alias using AS. Derived columns are generally only temporary. */
SELECT id, (standard_amt_usd/total_amt_usd)*100 AS std_percent, total_amt_usd
FROM orders
LIMIT 10;
/* "Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order. Limit the results to the first 10 orders, and include the id and account_id fields." */
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;


## LIKE operator ##
/* LIKE is used within a WHERE clause, and is frequently used with % (wildcard). The purpose of the % is to tell the query to allow for any number of characters leading to or following from a particular set of characters. */
SELECT *
FROM accounts
WHERE website LIKE '%google%';
/* "Use the accounts table to find all companies whose names contain the string 'one' somewhere in the name." */
SELECT name
FROM accounts
WHERE name LIKE '%one%';


## IN operator ##
/* The IN operator can be used in both numerical and text columns. Can be used to check one, two or many column values for which we want to pull data, but within the same query. */
SELECT *
FROM orders
WHERE account_id IN (1001,1021);
/* "Use the web_events table to find all information regarding individuals who were contacted via the channel of organic or adwords." */
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');


## NOT operator ##
/* By specifying NOT LIKE or NOT IN, we can grab all of the rows that do not meet particular criteria. */
SELECT sales_rep_id, 
       name
FROM accounts
WHERE sales_rep_id NOT IN (321500,321570)
ORDER BY sales_rep_id
/* "Use the accounts table to find all companies whose names do not end with 's'". */
SELECT name
FROM accounts
WHERE name NOT LIKE '%s';


## AND & BETWEEN operators ##
/* The AND operator is used within a WHERE clause to consider more than one logical statement at a time. You may link as many statements as you like to consider at a time. */
/* The BETWEEN operator is best used instead of AND when we are using the same column for different parts of our AND statement. */
SELECT *
FROM orders
WHERE occurred_at BETWEEN '2016-04-01' AND '2016-10-01'
ORDER BY occurred_at
/* "Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'." */
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';


## OR operator ##
/* Similar to the AND operator, the OR operator can combine multiple statements. Each time you link a new statement with an OR, you will need to specify the column you are interested in looking at. You may link as many statements as you would like to consider at the same time. */
SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty
FROM orders
WHERE standard_qty = 0 OR gloss_qty = 0 OR poster_qty = 0
/* "Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'." */
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') 
           AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') 
           AND primary_poc NOT LIKE '%eana%');