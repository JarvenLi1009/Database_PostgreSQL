-- Create a Schema called "schulich"
CREATE SCHEMA schulich;

-- Create a Schema but it will do nothing (except issuing a notice)
-- if a schema with the same name already exists
CREATE SCHEMA IF NOT EXISTS schulich;

-- Remove a Schema
DROP SCHEMA schulich;

-- Remove a Schema without getting an error if the schema no longer exists
DROP SCHEMA IF EXISTS schulich;


-- Creating two schemas requires separate commands,
CREATE SCHEMA IF NOT EXISTS yorku;
CREATE SCHEMA IF NOT EXISTS library;

-- It's possible to drop multiple schemas with a single command
DROP SCHEMA IF EXISTS yorku, library;


-- Useful References
-- https://www.postgresql.org/docs/13/sql-createschema.html