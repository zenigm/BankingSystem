--Clauses
--so what are clauses?clauses a..you can see them as the intermediates that makes our work easier
--there  are of 5 types

--1)WHERE
--its used to locate the data or find/address the data by pointing towards it
SELECT Acc_holder,Acc_balance FROM "CreateSchema"."bank_records"
WHERE Acc_balance >=25000;


--2)DISTINCT
--its used to find the distinct sets of data in the table
--shows diff branch of banks.
SELECT DISTINCT Acc_branch FROM "CreateSchema"."bank_records";


--3)LIMIT
--limit is used to show only particular amount of allowed entries
--like here it show sonly 10 enries of our table
SELECT * FROM "CreateSchema"."bank_records" LIMIT 10;


--4)LIKE
--used to show those wntrie swhichis similar to our allowed entries
--like here we showing those entries whose accont are savings 
-- we gonna use two clauses together
SELECT Acc_type FROM "CreateSchema"."bank_records"
WHERE Acc_type LIKE 'Sal%';


--5)ORDER BY
--just simply arranges data in asceding or descending form but with your choice 
SELECT * FROM "CreateSchema"."bank_records" ORDER BY(Sr_no );
