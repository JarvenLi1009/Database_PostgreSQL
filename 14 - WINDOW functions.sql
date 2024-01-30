-- RANK, DENSE_RANK, ROW
-- Write a query to get the top 3 earners (people with the highest salaries)
SELECT c.first_name,
       c.last_name,
       c.salary,
       RANK() OVER (ORDER BY c.salary DESC) AS salary_rank,
       DENSE_RANK() OVER (ORDER BY c.salary DESC) AS salary_dense_rank,
       ROW_NUMBER() OVER (ORDER BY c.salary DESC) AS salary_row_number
FROM simpsons.characters AS c
WHERE c.salary IS NOT NULL
ORDER BY c.salary DESC;


-- PARTITION BY helps us rank at the family level
SELECT c.last_name,
       c.first_name,
       c.salary,
       RANK() OVER (PARTITION BY c.last_name ORDER BY c.salary DESC) AS salary_rank
FROM simpsons.characters AS c
WHERE c.salary IS NOT NULL
ORDER BY c.last_name ASC, c.salary DESC;


-- Rank families by Total Income
SELECT c.last_name,
       SUM(c.salary) AS total_income,
       RANK() OVER (ORDER BY SUM(c.salary) DESC) AS family_rank
FROM simpsons.characters AS c
GROUP BY c.last_name;


-- Age rank
SELECT c.first_name,
       c.last_name,
       c.date_of_birth,
       RANK() OVER (ORDER BY AGE(c.date_of_birth)) AS age_rank
FROM simpsons.characters AS c;


-- Get the top 3 products based on sales volume and sales revenue
WITH ranked_products AS (
SELECT bs.article,
       SUM(bs.quantity) AS sales_volume,
       RANK() OVER (ORDER BY SUM(bs.quantity) DESC) AS volume_rank
FROM assignment01.bakery_sales AS bs
WHERE bs.unit_price IS NOT NULL
GROUP BY bs.article
)
SELECT *
FROM ranked_products
WHERE volume_rank <= 3;
