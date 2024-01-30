-- Comparison Operators
--   <  Less than
--   >  Greater than
--   <= Less than or equal to
--   >= Greater than or equal to
--   =  Equal
--   <> Not Equal
--   != Not Equal
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'COOKIE';


-- AND operator
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'COOKIE'
  AND bs.sale_date = '2021-02-14';


-- OR operator
-- Find all records for the DEMI and CEREAL BAGUETTES
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'DEMI BAGUETTE'
   OR bs.article = 'CEREAL BAGUETTE';


-- IN operator to match against a list of values
-- You can use the IN operator in a WHERE clause to check if a value
-- matches any value in a list of values
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.article IN ('DEMI BAGUETTE', 'CEREAL BAGUETTE');


-- NOT IN
-- You can combine NOT and IN to select rows whose value does not
-- match the values in the list
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.ticket_number NOT IN (159219, 161853, 164878, 170079, 186662)


-- BETWEEN operator
-- The following two queries are equivalent
SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.unit_price >= 1
  AND bs.unit_price <= 2;

SELECT *
FROM assignment01.bakery_sales AS bs
WHERE bs.unit_price BETWEEN 1 AND 2;


-- LIKE OPERATOR (Pattern matching)
SELECT DISTINCT bs.article
FROM assignment01.bakery_sales AS bs
WHERE UPPER(bs.article) like '%BAGUETTE%';

SELECT COUNT(DISTINCT bs.article)
FROM assignment01.bakery_sales AS bs
WHERE UPPER(bs.article) like '%BAGUETTE%';

SELECT *
FROM assignment01.bakery_sales AS bs
WHERE CAST(bs.ticket_number AS text) LIKE '15004_'
ORDER BY ticket_number, article;

SELECT *
FROM assignment01.bakery_sales AS bs
WHERE CAST(bs.sale_time AS text) LIKE '09:%'
