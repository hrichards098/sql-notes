------------------------
## DA102.2 SQL Joins ##
------------------------

## JOIN ##
/* The purpose of a join statement is to allow us to pull data from more than one table at a time. We can use an ON clause to specify a JOIN condition which is a logical statement to combine the table in FROM and JOIN statements. */
SELECT orders.*,
       accounts.*
FROM orders 
JOIN accounts
ON orders.account_id = accounts.id;
/* "Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table." */
SELECT orders.standard_qty, orders.gloss_qty, 
 orders.poster_qty,  accounts.website, 
 accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
/* "Provide a table that provides the region for each sales_rep along with their associated accounts. Your final table should include three columns: the region name, the sales rep name, and the account name. Sort the accounts alphabetically (A-Z) according to the account name." */
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;
/* "Provide the name for each region for every order, as well as the account name and the unit price they paid (total_amt_usd/total) for the order. However, you should only provide the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50. Your final table should have 3 columns: region name, account name, and unit price. Sort for the largest unit price first. In order to avoid a division by zero error, adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01)." */
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;
