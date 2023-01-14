---------------------------
## DA102.2 SQL Data Cleaning ##
---------------------------

## LEFT/RIGHT ##
/* Extracts a number of characters from a string starting from the left/right */
LEFT(string, number_of_chars) AS column_name
/* "Extract the student ID and salary information from the column" */
LEFT(student_information, 8) AS student_id
RIGHT(student_information, 6) AS salary
/* "Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number)." */
SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;


## SUBSTRING ##
/* Extracts a substring from a string (starting at any position) */
SUBSTR(string, start, length) AS column_name
/* "Extract the student gender from the columm" */
SUBSTR(student_information, 11, 1) AS gender


## CONCAT ##
/* Adds two or more expressions together */
CONCAT(string1, string2, string3) AS column_name
/* "Create a date field that combines the day, month, and year columns" */
CONCAT(month, '-', day, '-', year) AS date
/* "From the accounts table, display the name of the client, the coordinate as concatenated (latitude, longitude), email id of the primary point of contact as <first letter of the primary_poc><last letter of the primary_poc>@<extracted name and domain from the website>." */
SELECT NAME, CONCAT(LAT, ', ', LONG) COORDINATE, CONCAT(LEFT(PRIMARY_POC, 1), RIGHT(PRIMARY_POC, 1), '@', SUBSTR(WEBSITE, 5)) EMAIL
FROM ACCOUNTS;


## CAST ##
/* Convert a value of any type into a specific, different data type */
CAST(column_name AS datatype)
/* "Cast the salary column into a numeric to run computation across the student database" */
CAST(salary AS int)
/* "Write a query to change the date into the correct SQL date format." */
SELECT date orig_date, (SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2)) new_date
FROM sf_crime_data;


---------------------------------
## ADVANCED cleaning functions ##
---------------------------------

## Position ##
/* Returns the position of the first occurrence of a substring in a string */
/** When there's a single column that holds too much information, and the user is required to identify where the information is. This location is typically then used to consistenly extract this information across all records **/
POSITION(substring IN string)
/* "Determine what position the student's salary information is in" */
/** Naming the position then allows for ease of use within other functions, i.e; could use the salary_starting_position within substring to get the salary information across all records. **/
POSITION("$" IN student_information) as
salary_starting_position


## STRPOS ##
/* Similar to position, returns the position of a substring within a string */
STRPOS(string, substring)
/* "Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc." */
SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name, 
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name
FROM accounts;
/* "Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com." */
WITH t1 AS (
 SELECT LEFT(primary_poc,     STRPOS(primary_poc, ' ') -1 ) first_name,  RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, name
 FROM accounts)
SELECT first_name, last_name, CONCAT(first_name, '.', last_name, '@', REPLACE(name, ' ', ''), '.com')
FROM  t1;


## COALESCE ##
/* Returns the first non-null value in a list */
/** If there are multiple columns that have a combination of null and non-null values, user can use coalesce to extract the first non-null value **/
COALESCE(val1, val2, val3)
/* "Calculate a total compensation field off the 3 types of income" */
COALESCE(hourly_wage * 40 * 52, salary, commission * sales) AS annual_income
/* */
SELECT COALESCE(a.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;