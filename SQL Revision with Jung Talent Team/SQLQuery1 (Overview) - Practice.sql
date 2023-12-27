----------------------------------------------
-- Practice Zone (Basic Level)
----------------------------------------------

-- How to drop table to remove table that we don't need.
drop TABLE Students; 

-- How to create table 
CREATE TABLE Students (
student_id int,
last_name varchar(255),
first_name varchar(255),
email varchar(255),
address varchar(255)
);


-- Adding more columns:
ALTER TABLE Students ADD 
Phone_number int,
Parent_name varchar(255);


-- How to drop column name:
ALTER TABLE Students DROP COLUMN
Parent_name;
--SELECT * FROM Students;



--------------------------------------------------------------------------------
-- Import CSV files and View top 10 from schema
-- To view the schema, we call the database name . dbo . and then the table name
SELECT TOP 10 * FROM Clients_name;

--------------------------------------------------------------------------------
