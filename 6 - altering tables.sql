-- Use the ALTER TABLE command to add an address column to the
-- "instructors" table within the "schulich" schema
ALTER TABLE schulich.instructors ADD COLUMN address VARCHAR(20);


-- You can IF NOT EXISTS to prevent getting an error if the
-- column has been added previously
ALTER TABLE schulich.instructors ADD COLUMN IF NOT EXISTS address VARCHAR(20);


-- To add a column and fill it with a specific value.
ALTER TABLE schulich.instructors ADD COLUMN status varchar(10) DEFAULT 'retired';


-- Use the ALTER command to rename a column
ALTER TABLE schulich.instructors RENAME COLUMN status TO current_status;


-- The ALTER command can also be used to change the data type of a column
ALTER TABLE schulich.instructors
    ALTER COLUMN address TYPE varchar(255),
    ALTER COLUMN status TYPE varchar(30);


-- You can also use ALTER TABLE to remove a column from a table
-- and you can only remove a column at a time
ALTER TABLE schulich.instructors DROP COLUMN address RESTRICT;
ALTER TABLE schulich.instructors DROP COLUMN status RESTRICT;


-- You can also IF EXISTS to remove a column only if it still exists.
-- This will make sure you don't get an error if the column no longer exists
ALTER TABLE schulich.instructors DROP COLUMN IF EXISTS address RESTRICT;
ALTER TABLE schulich.instructors DROP COLUMN IF EXISTS status RESTRICT;
