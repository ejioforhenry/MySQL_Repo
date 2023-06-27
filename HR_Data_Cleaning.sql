CREATE DATABASE human_resource;

USE human_resource;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id TEXT NULL;

SELECT * FROM hr;

-- list column names and datatype.alter
DESCRIBE hr;

-- explore birthdate column
SELECT birthdate FROM hr;

-- set sql safe updates to 0
SET sql_safe_updates = 0;
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';

-- birthdate has inconsistent date format, hence needs cleaning.
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE null
END;

SELECT * FROM hr;

-- change birthdate datatype from text/string to date datatype

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

DESCRIBE hr;
SELECT * FROM hr;

-- hire_date has inconsistent date format, hence needs cleaning.
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

SELECT * FROM hr;

-- change hire_date datatype from text/string to date datatype
ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

DESCRIBE hr;
SELECT * FROM hr;

-- explore termdate column
SELECT termdate FROM hr;

-- fill missing values
UPDATE hr
SET termdate = '0000-00-00 00:00:00 UTC'
WHERE termdate = '';

SELECT termdate FROM hr;

-- change termdate format
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'));

SELECT termdate FROM hr;

DESCRIBE hr;

-- change hire_date datatype from text/string to date datatype
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

DESCRIBE hr;

-- add a column for age
ALTER TABLE hr ADD COLUMN age INT;

DESCRIBE hr;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT age FROM hr;

-- check for wrong age
SELECT birthdate, age FROM hr
WHERE age < 0;

-- count number of rows of age less than 18
SELECT COUNT(*) FROM hr
WHERE age < 18;

DESCRIBE hr;
SELECT * FROM hr;

SELECT MIN(age) AS youngest, MAX(age) AS oldest
FROM hr
WHERE age >= 18