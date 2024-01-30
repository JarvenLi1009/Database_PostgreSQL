-- Let's work with an instructors table previously created within the
-- schulich schema with the following command
CREATE TABLE IF NOT EXISTS schulich.instructors (
    instructor_id  INTEGER,
    first_name     VARCHAR(255),
    last_name      VARCHAR(255),
    date_of_birth  DATE,
    annual_salary  NUMERIC
);


-- Inserting a row can be done with the INSERT INTO command
-- followed by the VALUES statement
INSERT INTO schulich.instructors VALUES (1, 'Albert', 'Einstein', '1879-03-14', 250000);


-- In the previous example the data values must be listed in the order
-- in which the columns appear in the table and separated by commas.
-- But if you don't know the order of the columns in the table you can
-- also list the columns explicitly for which you need to add values.
-- For example, both of the following commands have the same effect as
-- the one above:
INSERT INTO schulich.instructors (instructor_id, first_name, last_name, date_of_birth, annual_salary)
VALUES (1, 'Albert', 'Einstein', '1879-03-14', 250000);

INSERT INTO schulich.instructors (first_name, last_name, date_of_birth, instructor_id, annual_salary)
VALUES ('Albert', 'Einstein', '1879-03-14', 1, 250000);


-- You don't have to insert values if you don't have them. For example,
-- you can add a record with first_name and last_name only
INSERT INTO schulich.instructors (first_name, last_name)
VALUES ('Richard', 'Feynman');


-- You can insert multiple rows in a single command
INSERT INTO schulich.instructors (instructor_id, first_name, last_name, date_of_birth, annual_salary)
VALUES (2, 'Marie', 'Curie', '1867-11-07', 300000),
       (3, 'Pierre', 'Curie', '1859-05-15', 200000),
       (4, 'Marjorie', 'Browne', '1914-09-09', 200000);
