-- Create a Table called "instructors" within the "schulich" schema
CREATE TABLE schulich.instructors (
    instructor_id  INTEGER,
    first_name     VARCHAR(255),
    last_name      VARCHAR(255),
    date_of_birth  DATE,
    annual_salary  NUMERIC
);


-- Create a table using IF NOT EXISTS
-- This will not throw an error if a table with the same name already exists; only a notice is issued in this case.
-- Note that there is no guarantee that the existing table is anything like the one that would have been created.
CREATE TABLE IF NOT EXISTS schulich.instructors (
    instructor_id  INTEGER,
    first_name     VARCHAR(255),
    last_name      VARCHAR(255),
    date_of_birth  DATE,
    annual_salary  NUMERIC
);


-- CREATE another table called "courses" under the "schulich" schema
CREATE TABLE IF NOT EXISTS schulich.courses (
    course_id       INTEGER,
    course_name     VARCHAR(255),
    course_credits  NUMERIC
);


-- CREATE another table called "students" under the "schulich" schema
CREATE TABLE IF NOT EXISTS schulich.students (
    student_id     INTEGER,
    first_name     VARCHAR(255),
    last_name      VARCHAR(255),
    date_of_birth  DATE,
    program        VARCHAR(255)
);


-- Remove the "instructors" table withing the "schulich" schema
DROP TABLE schulich.instructors;


-- Remove the "instructors" table withing the "schulich" schema
-- but without getting an error if the table no longer exists
DROP TABLE IF EXISTS schulich.instructors;


-- Remove multiple tables with a single command
-- This example removes the courses and students table
-- within the schulich schema from the database
DROP TABLE IF EXISTS schulich.courses, schulich.students;