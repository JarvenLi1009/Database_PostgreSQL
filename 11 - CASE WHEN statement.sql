-- CASE/WHEN statement
SELECT c.first_name,
       c.last_name,
       c.date_of_birth,
       c.salary,
       CASE
           WHEN c.salary < 50000 THEN '0-50k'
           WHEN c.salary BETWEEN 50000 AND 100000 THEN '50k-100k'
           WHEN c.salary > 100000 THEN '100k+'
           ELSE 'Unknown'
       END AS salary_range,
       EXTRACT('year' from AGE(c.date_of_birth)) AS age
FROM simpsons.characters AS c
ORDER BY c.salary ASC;
