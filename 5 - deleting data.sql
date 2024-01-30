-- We can use the DELETE command to remove rows

-- To remove all rows from the schulich.instructos table where
-- instructor_id = 5, we use:
DELETE FROM schulich.instructors
WHERE instructor_id = 5;


-- You can also remove all records from the table without removing the table
DELETE FROM schulich.instructors;


-- To remove duplicated records without a unique ID we can use the DELETE
-- and USING statements together with the physical location of
-- the row version within its table provided by the cdit "hidden column"
DELETE FROM schulich.instructors AS t1
USING schulich.instructors AS t2
WHERE t1.ctid < t2.ctid
  AND t1.instructor_id = t2.instructor_id;


