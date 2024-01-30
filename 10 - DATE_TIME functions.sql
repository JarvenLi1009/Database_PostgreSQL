-- DATE/TIME FUNCTIONS
SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIMESTAMP;
SELECT NOW();
SELECT AGE(CAST('1984-01-01' AS DATE));
SELECT AGE(timestamp '1984-01-01');


-- DATE/TIME FUNCTIONS: DATE_PART()
SELECT CURRENT_DATE AS current_unix_date,
       DATE_PART('year', CURRENT_DATE)  AS current_unix_year,
       DATE_PART('month', CURRENT_DATE) AS current_unix_month,
       DATE_PART('day', CURRENT_DATE)   AS current_unix_day;


SELECT bs.ticket_number,
       bs.sale_datetime,
       DATE_PART('year', bs.sale_datetime) AS sale_year,
       DATE_PART('month', bs.sale_datetime) AS sale_month,
       DATE_PART('day', bs.sale_datetime) AS sale_day,
       DATE_PART('hour', bs.sale_datetime) AS sale_hour,
       DATE_PART('minute', bs.sale_datetime) AS sale_minute,
       DATE_PART('second', bs.sale_datetime) AS sale_second,
       DATE_PART('millisecond', bs.sale_datetime) AS sale_millisecond,
       DATE_PART('microsecond', bs.sale_datetime) AS sale_microsecond
FROM assignment01.bakery_sales AS bs;


-- DATE/TIME FUNCTIONS: EXTRACT
SELECT bs.ticket_number,
       bs.sale_datetime,
       EXTRACT('year' FROM bs.sale_datetime) AS sale_year,
       EXTRACT('month' FROM bs.sale_datetime) AS sale_month,
       EXTRACT('day' FROM bs.sale_datetime) AS sale_day,
       EXTRACT('hour' FROM bs.sale_datetime) AS sale_hour,
       EXTRACT('minutes' FROM bs.sale_datetime) AS sale_minute,
       EXTRACT('seconds' FROM bs.sale_datetime) AS sale_second,
       EXTRACT('milliseconds'  FROM bs.sale_datetime) AS sale_millisecond,
       EXTRACT('microseconds' FROM bs.sale_datetime) AS sale_microsecond
FROM assignment01.bakery_sales AS bs;


SELECT bs.ticket_number,
       bs.sale_datetime,
       EXTRACT(year FROM bs.sale_datetime) AS sale_year,
       EXTRACT(month FROM bs.sale_datetime) AS sale_month,
       EXTRACT(day FROM bs.sale_datetime) AS sale_day,
       EXTRACT(hour FROM bs.sale_datetime) AS sale_hour,
       EXTRACT(minutes FROM bs.sale_datetime) AS sale_minute,
       EXTRACT(seconds FROM bs.sale_datetime) AS sale_second,
       EXTRACT(milliseconds  FROM bs.sale_datetime) AS sale_millisecond,
       EXTRACT(microseconds FROM bs.sale_datetime) AS sale_microsecond
FROM assignment01.bakery_sales AS bs;


-- CALCULATE Revenue by Year and Month
SELECT DATE_PART('year', bs.sale_datetime) AS sale_year,
       DATE_PART('month', bs.sale_datetime) AS sale_month,
       SUM(bs.quantity*bs.unit_price) AS revenue
FROM assignment01.bakery_sales AS bs
GROUP BY sale_year, sale_month
ORDER BY sale_year, sale_month;


-- CALCULATE AVG monthly revenue for each year of sales
WITH monthly_sales AS (
    SELECT date_part('year', bs.sale_datetime) AS sale_year,
           date_part('month', bs.sale_datetime) AS sale_month,
           SUM(bs.quantity*bs.unit_price) AS revenue
    FROM assignment01.bakery_sales AS bs
    GROUP BY sale_year, sale_month
    ORDER BY sale_year, sale_month
)
SELECT sale_year,
       ROUND(AVG(revenue),2) AS avg_monthly_revenue
FROM monthly_sales
GROUP BY sale_year;
