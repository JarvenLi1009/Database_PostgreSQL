/* Assignment1

Group members:
Xinyuan Liang
Jiawen Li
Wei Lu
Yuntong Zhu
*/

--Q1.Identify the items with the highest and lowest (non-zero) unit price?
--Highest unit price item
WITH a AS (SELECT bs.article,
                  bs.unit_price,
                  RANK() OVER (ORDER BY bs.unit_price DESC) AS unit_price_rank
           FROM assignment01.bakery_sales AS bs
           WHERE bs.unit_price IS NOT NULL
                    AND bs.unit_price <> 0)
SELECT *
FROM a
WHERE unit_price_rank = 1;

--Lowest unit price item
WITH a AS (SELECT bs.article,
                  bs.unit_price,
                  RANK() OVER (ORDER BY bs.unit_price) AS unit_price_rank
           FROM assignment01.bakery_sales AS bs
           WHERE bs.unit_price IS NOT NULL
                    AND bs.unit_price <> 0)
SELECT *
FROM a
WHERE unit_price_rank = 1;



--Q2.Write a SQL query to report the second most sold item from the bakery table. If there is no second most sold item, the query should report NULL.
WITH a AS (SELECT bs.article,
                  SUM(bs.quantity) AS total_quantity_sold,
                  DENSE_RANK() OVER(ORDER BY SUM(bs.quantity) DESC) AS total_quantity_sold_rank
           FROM assignment01.bakery_sales AS bs
           WHERE bs.quantity IS NOT NULL
           GROUP BY bs.article)
SELECT *
FROM a
WHERE total_quantity_sold_rank = 2;



--Q3.Write a SQL query to report the top 3 most sold items for every month in 2022 including their monthly sales.
WITH ranked_monthly_sales AS (SELECT EXTRACT(MONTH FROM bs.sale_date) AS month_of_2022,
                                     bs.article,
                                     SUM(bs.quantity * bs.unit_price) AS monthly_sales,
                                     DENSE_RANK() OVER (
                                         PARTITION BY EXTRACT(MONTH FROM bs.sale_date)
                                         ORDER BY SUM(bs.quantity * bs.unit_price) DESC
                                         )                            AS monthly_sales_rank
                              FROM assignment01.bakery_sales AS bs
                              WHERE bs.sale_date >= '2022-01-01'
                                AND bs.sale_date <= '2022-12-31'
                                AND bs.unit_price <> 0
                                AND bs.unit_price IS NOT NULL
                              GROUP BY EXTRACT(MONTH FROM bs.sale_date), bs.article)
SELECT *
FROM ranked_monthly_sales
WHERE monthly_sales_rank <= 3;



--Q4.Write a SQL query to report all the tickets with 5 or more articles in August 2022 including the number of articles in each ticket.
SELECT bs.ticket_number,
       COUNT(DISTINCT bs.article) AS num_articles
FROM assignment01.bakery_sales AS bs
WHERE bs.sale_date >= '2022-08-01' AND bs.sale_date <= '2022-08-31'
GROUP BY bs.ticket_number
HAVING COUNT(DISTINCT bs.article) >= 5;



--Q5.Write a SQL query to calculate the average sales per day in August 2022?
SELECT EXTRACT(DAY FROM bs.sale_date) AS day_of_Aug_2022,
       SUM(bs.quantity * bs.unit_price)/COUNT(bs.unit_price) AS average_sales_per_day
FROM assignment01.bakery_sales AS bs
WHERE bs.sale_date >= '2022-08-01' AND bs.sale_date <= '2022-08-31'
    AND bs.unit_price <> 0 AND bs.unit_price IS NOT NULL
GROUP BY EXTRACT(DAY FROM bs.sale_date);



--Q6.Write a SQL query to identify the day of the week with more sales?
WITH ranked_dow_sales AS (SELECT DATE_PART('dow', bs.sale_date)   AS day_of_week,
                                 SUM(bs.quantity * bs.unit_price) AS sales,
                                 DENSE_RANK() OVER (
                                     ORDER BY SUM(bs.quantity * bs.unit_price) DESC
                                     )                            AS sales_rank
                          FROM assignment01.bakery_sales AS bs
                          WHERE bs.unit_price <> 0 AND bs.unit_price IS NOT NULL
                          GROUP BY DATE_PART('dow', bs.sale_date))
SELECT *
FROM ranked_dow_sales
WHERE sales_rank = 1;



--Q7.What time of the day is the traditional Baguette more popular?
WITH ranked_tod_popular AS (SELECT DATE_PART('hour', bs.sale_time) AS time_of_day,
                                   bs.article,
                                   SUM(bs.quantity)               AS quantity_sold,
                                   DENSE_RANK() OVER (
                                       PARTITION BY DATE_PART('hour', bs.sale_time)
                                       ORDER BY SUM(bs.quantity) DESC
                                       )                           AS quantity_sold_rank
                            FROM assignment01.bakery_sales AS bs
                            GROUP BY DATE_PART('hour', bs.sale_time), bs.article
                            ORDER BY 1)
SELECT *
FROM ranked_tod_popular
WHERE quantity_sold_rank = 1 AND article = 'TRADITIONAL BAGUETTE';



--Q8.Write a SQL query to find the articles with the lowest sales in each month?
WITH ranked_monthly_sales AS (SELECT EXTRACT(MONTH FROM bs.sale_date) AS month,
                                     bs.article,
                                     SUM(bs.quantity * bs.unit_price) AS monthly_sales,
                                     DENSE_RANK() OVER (
                                         PARTITION BY EXTRACT(MONTH FROM bs.sale_date)
                                         ORDER BY SUM(bs.quantity * bs.unit_price)
                                         )                            AS monthly_sales_rank
                              FROM assignment01.bakery_sales AS bs
                              WHERE bs.unit_price <> 0 AND bs.unit_price IS NOT NULL
                              GROUP BY EXTRACT(MONTH FROM bs.sale_date), bs.article)
SELECT *
FROM ranked_monthly_sales
WHERE monthly_sales_rank = 1;



--Q9.Write a query to calculate the percentage of sales for each item between 2022-01-01 and 2022-01-31

SELECT bs.article,
       SUM(bs.quantity * bs.unit_price) AS sales,
       ROUND((SUM(bs.quantity * bs.unit_price) /
            (SELECT SUM(quantity * unit_price)
             FROM assignment01.bakery_sales
             WHERE sale_date >= '2022-01-01'
                    AND sale_date <= '2022-01-31'
                    AND unit_price <> 0 AND unit_price IS NOT NULL))*100, 2) || '%'
            AS percentage_of_sales
FROM assignment01.bakery_sales AS bs
WHERE bs.sale_date >= '2022-01-01'
        AND bs.sale_date <= '2022-01-31'
        AND bs.unit_price <> 0
        AND bs.unit_price IS NOT NULL
GROUP BY bs.article;



--Q10.The order rate is computed by dividing the volume of a specific article divided by the total amount of items ordered in a specific date. Calculate the order rate for the Banette for every month during 2022.
WITH a AS (SELECT EXTRACT(MONTH FROM bs.sale_date) AS month,
                  SUM(bs.quantity)                 AS banette_order_volume
           FROM assignment01.bakery_sales AS bs
           WHERE bs.sale_date >= '2022-01-01'
             AND bs.sale_date <= '2022-12-31'
             AND bs.article = 'BANETTE'
             AND bs.quantity <> 0
             AND bs.quantity IS NOT NULL
           GROUP BY EXTRACT(MONTH FROM bs.sale_date))
SELECT a.month,
       a.banette_order_volume,
       b.total_order_volume,
       ROUND(CAST(a.banette_order_volume AS DECIMAL(10,2)) /
             CAST(b.total_order_volume AS DECIMAL(10,2))*100,2) || '%' AS banette_monthly_order_rate
FROM a LEFT JOIN (SELECT EXTRACT(MONTH FROM bs.sale_date) AS month,
                         SUM(bs.quantity)                 AS total_order_volume
                  FROM assignment01.bakery_sales AS bs
                  WHERE bs.sale_date >= '2022-01-01'
                            AND bs.sale_date <= '2022-12-31'
                            AND bs.quantity <> 0
                            AND bs.quantity IS NOT NULL
                  GROUP BY EXTRACT(MONTH FROM bs.sale_date)) AS b ON a.month = b.month;


