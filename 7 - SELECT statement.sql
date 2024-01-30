SELECT *
FROM assignment01.bakery_sales as bs;


SELECT DISTINCT bs.article
FROM assignment01.bakery_sales as bs
ORDER BY bs.article ASC;


-- Write a query to return sale datetime, ticket number, article, quantity, revenue
-- For all tickets in January 2022
SELECT bs.sale_datetime,
       bs.ticket_number,
       bs.article,
       bs.quantity,
       bs.unit_price* bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
WHERE bs.sale_date BETWEEN '2022-01-01' AND '2022-01-31'
ORDER BY bs.sale_date DESC;


SELECT bs.sale_datetime,
       bs.ticket_number,
       bs.article,
       bs.quantity,
       bs.unit_price* bs.quantity AS revenue
FROM assignment01.bakery_sales AS bs
WHERE bs.ticket_number = 150063
ORDER BY 5 DESC;