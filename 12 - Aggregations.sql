-- Aggregations with COUNT, COUNT DISTINCT, MIN, MAX, AVG, SUM

SELECT COUNT(bs.*) AS no_of_records
FROM assignment01.bakery_sales AS bs;

SELECT COUNT(DISTINCT bs.ticket_number)
FROM assignment01.bakery_sales AS bs;

SELECT MIN(bs.unit_price) AS min_unit_price
FROM assignment01.bakery_sales AS bs;

SELECT MAX(bs.unit_price) AS max_unit_price,
FROM assignment01.bakery_sales AS bs;

SELECT AVG(bs.unit_price) AS avg_unit_price,
FROM assignment01.bakery_sales AS bs;

SELECT SUM(bs.quantity) AS total_articles_sold
FROM assignment01.bakery_sales AS bs;

SELECT MIN(bs.unit_price) AS min_unit_price,
       MAX(bs.unit_price) AS max_unit_price,
       AVG(bs.unit_price) AS avg_unit_price,
       SUM(bs.quantity)   AS total_articles_sold
FROM assignment01.bakery_sales AS bs;

SELECT MIN(bs.quantity) AS min_quantity,
       MAX(bs.quantity) AS max_quantity
FROM assignment01.bakery_sales AS bs
WHERE bs.article = 'BAGUETTE';
