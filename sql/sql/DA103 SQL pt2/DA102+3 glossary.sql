--------------------------------
## DA102&3 SQL Terms Glossary ##
--------------------------------
/*

Aggregates	
Aggregate functions that are used in window functions, too (e.g., sum, count, avg).

Aliases	
Shorthand that can be used if there are several window functions in one query.

Cast	
Converts a value of any type into a specific, different data type.

Coalesce	
Returns the first non-null value in a list.

Concat	
Adds two or more expressions together.

Correlated Subquery	
The inner subquery is dependent on the larger query.

CREATE TABLE	
is a statement that creates a new table in a database.

CTE	
Common Table Expression in SQL allows you to define a temporary result, such as a table, to then be referenced in a later part of the query.

Dense_rank()	
Ranking function similar to rank() but ranks are not skipped with ties.

Dense_rank()	
Ranking is the same amongst tied values and ranks do not skip for subsequent values.

DISTINCT	
Always used in SELECT statements, and it provides the unique rows for all columns written in the SELECT statement.

DROP TABLE	
is a statement that removes a table in a database.

Entity-relationship diagram (ERD)	
A common way to view data in a database.

Foreign Key (FK)	
is a column in one table that is a primary key in a different table.

FROM	
specifies from which table(s) you want to select the columns. Notice the columns need to exist in this table.

Full Outer Join	
Include unmatched rows from all tables being joined.

GROUP BY	
Used to aggregate data within subsets of the data. For example, grouping for different accounts, different regions, or different sales representatives.

HAVING	
is the “clean” way to filter a query that has been aggregated.

Inline	
This subquery is used in the same fashion as the WITH use case above. However, instead of the temporary table sitting on top of the larger query, it’s embedded within the from clause.

JOIN	
is an INNER JOIN that only pulls data that exists in both tables.

Joins Dependencies	
Cannot stand independently.

Joins Output	
A joint view of multiple tables stitched together using a common “key”.

Joins Use Case	
Fully stitch tables together and have full flexibility on what to “select” and “filter from”.

Lag/Lead	
Calculating differences between rows’ values.

Left	
Extracts a number of characters from a string starting from the left.

LEFT JOIN	
is a JOIN that pulls all the data that exists in both tables, as well as all of the rows from the table in the FROM even if they do not exist in the JOIN statement.

Nested	
This subquery is used when you’d like the temporary table to act as a filter within the larger query, which implies that it often sits within the where clause.

NULLs	
A datatype that specifies where no data exists in SQL.

Over	
Typically precedes the partition by that signals what to “GROUP BY”.

Partition by	
A subclause of the OVER clause. Similar to GROUP BY.

Percentiles	
Defines what percentile a value falls into over the entire table.

Performance Tuning	
Improving queries to perform better and faster.

Position	
Returns the position of the first occurrence of a substring in a string.

Primary Key (PK)	
is a unique column in a particular table.

Rank()	
Ranking function where a row could get the same rank if they have the same value.

Rank()	
Ranking is the same amongst tied values and ranks skip for subsequent values.

Right	
Extracts a number of characters from a string starting from the right.

RIGHT JOIN	
is a JOIN pulls all the data that exists in both tables, as well as all of the rows from the table in the JOIN even if they do not exist in the FROM statement.

Row_number()	
Ranking function where each row gets a different number.

Row_number()	
Ranking is distinct amongst records even with ties in what the table is ranked against.

Scalar	
This subquery is used when you’d like to generate a scalar value to be used as a benchmark of some sort.

SELECT	
allows you to read data and display it. This is called a query and it specifies from which table(s) you want to select the columns.

Self Join	
Joining a table with itself.

Simple Subquery	
The inner subquery is completely independent of the larger query.

SQL Views	
Virtual tables that are derived from one or more base tables. The term virtual means that the views do not exist physically in a database, instead, they reside in the memory (not database), just like the result of any query is stored in the memory.

Strpos	
Returns the position of a substring within a string.

Subquery	
A SQL query where one SQL query is nested within another query.

Subquery Dependencies	
Stand independently and be run as complete queries themselves.

Subquery Output	
Either a scalar (a single value) or rows that have met a condition.

Subquery Use Case	
Calculate a scalar value to use in a later part of the query (e.g., average price as a filter).

Substr	
Extracts a substring from a string (starting at any position).

Union	
Combine the result sets of 2 or more SELECT statements. It removes duplicate rows between the various SELECT statements.

With	
This subquery is used when you’d like to “pseudo-create” a table from an existing table and visually scope the temporary table at the top of the larger query.

*/
