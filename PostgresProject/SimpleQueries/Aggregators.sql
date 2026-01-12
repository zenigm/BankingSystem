--Aggregaters
--now in thi spart i am gonna show what and how i used differ types of aggregators

--1)SUM
--here,is the sum operations
SELECT SUM(amount_deposited) FROM "CreateSchema"."transcation";

--so,its just the total sum of amount_deposited column but lets make it look good
SELECT SUM(amount_deposited) AS total_deposited FROM "CreateSchema"."transcation";
--with aggregates we can only do thi smuch here


--2)AVERAGE
--aHere this will give the average of our oprratios like
SELECT AVG(acc_balance) FROM "CreateSchema"."bank_records";
--or like this 
SELECT AVG(acc_balance) AS total_balance FROM "CreateSchema"."bank_records";


--3)COUNT
--Basically it does count the alll no of enrties so you dont have hard time to scroll to search no of entries 
--copy above and past here
SELECT COUNT(acc_balance) FROM "CreateSchema"."bank_records";
--or like this 
SELECT COUNT(acc_balance) AS total_entries FROM "CreateSchema"."bank_records";


--4)BETWEEN and AND and OR and IN
--this is operation that works to set a particular rangel limit or 2 observatios we want 
--AND just supports the BETWEEN to work s intermediate or like to compare
--it is a little diff from above 3
SELECT * FROM "CreateSchema"."bank_records"
WHERE acc_balance BETWEEN '50000' AND '100000';

--lets see how you use OR /IN
SELECT * FROM "CreateSchema"."bank_records"
WHERE acc_branch IN('Mumbai Branch','Bangalore Branch');

--OR Case
-- in this case too it will bring both mumbai branch and bangalore branch
SELECT * FROM "CreateSchema"."bank_records"
WHERE acc_branch = 'Mumbai Branch'
   OR acc_branch = 'Bangalore Branch';


--5)Max and Min 
-- they are use to find the directly value whichre wither highest or lowest among the given data
SELECT MAX(acc_balance) FROM "CreateSchema"."bank_records"
SELECT MIN(acc_balance) FROM "CreateSchema"."bank_records"


