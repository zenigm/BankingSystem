--1)GROUP BY 
--this function is used when we want to group specific column of data field to find our slutions 
--problems like how many total balance the specic branch has,the total no of customer in particular branch,m 
--and in short to find the short piece of info in whole data under particular section 
SELECT acc_balance FROM "CreateSchema"."bank_records" GROUP BY acc_balance; 

--2)String functuiions 
SELECT CONCAT(acc_type,acc_balance) FROM "CreateSchema"."bank_records"; 
--CONCAT joins acc_type and acc_balance without separator (e.g., 'Savings1000')

SELECT CONCAT_WS(' -> ', acc_type, acc_balance) FROM "CreateSchema"."bank_records"; 
--CONCAT_WS adds ' -> ' separator between non-NULL values, skips NULLs

SELECT SUBSTR(acc_holder,0,3) FROM "CreateSchema"."bank_records"; 
--SUBSTR extracts substring from acc_holder starting at position 0, length 3

SELECT SUBSTRING(acc_holder,0,3) FROM "CreateSchema"."bank_records"; 
--SUBSTRING extracts first 3 characters from acc_holder (same as SUBSTR)

SELECT LEFT(acc_holder,5) FROM "CreateSchema"."bank_records"; 
--LEFT extracts 5 characters from start of acc_holder

SELECT RIGHT(acc_holder,0,3) FROM "CreateSchema"."bank_records"; 
--RIGHT extracts 3 characters from end of acc_holder

SELECT LENGTH(acc_holder) FROM "CreateSchema"."bank_records"; 
--LENGTH returns character count of acc_holder string

SELECT UPPER(acc_holder) FROM "CreateSchema"."bank_records"; 
--UPPER converts acc_holder to uppercase letters

SELECT LOWER(acc_holder) FROM "CreateSchema"."bank_records"; 
--LOWER converts acc_holder to lowercase letters

SELECT TRIM(acc_branch) FROM "CreateSchema"."bank_records"; 
--TRIM removes leading/trailing whitespace from acc_branch

SELECT POSITION('S' IN acc_holder) FROM "CreateSchema"."bank_records"; 
--POSITION finds position of 'S' in acc_holder (returns 0 if not found)

SELECT REVERSE(acc_holder) FROM "CreateSchema"."bank_records"; 
--REVERSE reverses complete acc_holder string characters

SELECT REPLACE(acc_holder,acc_holder, acc_branch) FROM "CreateSchema"."bank_records";
--REPLACE replaces first occurrence of acc_holder with acc_branch value in string
