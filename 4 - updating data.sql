-- The modification of data that is already in the database can be executed
-- with the UPDATE statement. It's possible to update individual rows,
-- all the rows in a table, or a subset of them


-- This example updates all records in the instructor table where
-- first_name = 'Richard' and last_name = 'Feynman' to have instructor_id = 5
UPDATE schulich.instructors
SET instructor_id = 5
WHERE first_name = 'Richard'
  AND last_name = 'Feynman';


-- You can also update more than one column in an UPDATE command.
-- In this example wie update the date_of_birth and annual_salary
-- columns for Richard Feynman in the instructors table located
-- within the schulich schema
UPDATE schulich.instructors
SET date_of_birth = '1918-05-11',
    annual_salary = 225000
WHERE first_name = 'Richard'
  AND last_name = 'Feynman';


--  The new value of a column can be any scalar expression. For example,
--  if you want to raise the annual salary of all instructors by 10% you could use
UPDATE schulich.instructors
SET annual_salary = annual_salary * 1.10;