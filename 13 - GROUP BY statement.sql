-- Calculate the min/max unit price by article
SELECT bs.article,
       MIN(bs.unit_price) AS min_price,
       MAX(bs.unit_price) AS max_price
FROM assignment01.bakery_sales AS bs
GROUP BY bs.article;


-- Calculate min/max unit price for all Baguettes
SELECT bs.article,
       MIN(bs.unit_price) AS min_unit_price,
       MAX(bs.unit_price) AS max_unit_price
FROM assignment01.bakery_sales AS bs
WHERE bs.article LIKE '%BAGUETTE%'
GROUP BY bs.article;


-- Calculate revenue by ticket for 3 specific tickets
SELECT bs.ticket_number,
       SUM(bs.quantity*bs.unit_price) AS ticket_total
FROM assignment01.bakery_sales AS bs
WHERE ticket_number IN (150043, 150886, 162195)
GROUP BY bs.ticket_number;


-- Calculate revenue by article and sort by revenue in descending order
SELECT bs.article,
       SUM(bs.quantity*bs.unit_price) AS total_revenue
FROM assignment01.bakery_sales AS bs
WHERE article <> '.'
GROUP BY bs.article
ORDER BY 2 desc;



-- Calculate number of tickets by sale_date
SELECT bs.sale_date,
       COUNT(DISTINCT bs.ticket_number) AS ticket_count
FROM assignment01.bakery_sales as bs
GROUP BY bs.sale_date
ORDER BY bs.sale_date DESC;


-- Calculate number of tickets by month and year
SELECT DATE_PART('year', bs.sale_date) AS sale_year,
       DATE_PART('month', bs.sale_date) AS sale_month,
       COUNT(DISTINCT bs.ticket_number)
FROM assignment01.bakery_sales AS bs
GROUP BY 1,2
ORDER BY 1,2;


WITH monthly_ticket_count AS (
    SELECT DATE_PART('year', bs.sale_date) AS sale_year,
           DATE_PART('month', bs.sale_date) AS sale_month,
           COUNT(DISTINCT bs.ticket_number) AS ticket_count
    FROM assignment01.bakery_sales AS bs
    GROUP BY 1,2
    ORDER BY 1,2
)
SELECT mtc.sale_year,
       ROUND(AVG(mtc.ticket_count),2) AS avg_monthly_ticket_count
FROM monthly_ticket_count AS mtc
GROUP BY mtc.sale_year;
