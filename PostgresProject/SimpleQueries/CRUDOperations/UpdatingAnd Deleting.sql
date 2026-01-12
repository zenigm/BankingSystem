--CRUDE Operations

--1.)Creating and Reading the Element

--as,i am not showing operations here because both the following operations of CRUD is already shown by me in above 
--folders

--2.)Updating the Element
--lets first select the table to perform operation on it 
SELECT * FROM "CreateSchema"."transcation";

--now updating the first rows info of "amount_withdrawed" column.
UPDATE "CreateSchema"."transcation"
SET amount_withdrawed = 60000
WHERE acc_no = '002AER232222';

--now ,to see changes run below script becuase the update row will shifted to last rows
SELECT * FROM "CreateSchema"."transcation" WHERE acc_no = '002AER232222';


---3.)Deleting the Element

SELECT * FROM "CreateSchema"."transcation";
--see this table we are deleting the first row WHERE acc_no is "FY7K9JA1GQJU"

DELETE FROM "CreateSchema"."transcation" WHERE amount_deposited = 54807;
--above query deleted the whole row 

--Now,lets see cyanges 
SELECT * FROM "CreateSchema"."transcation" WHERE acc_no = 'FY7K9JA1GQJU'; --Eq.-1
--lets insert again 

INSERT INTO "CreateSchema"."transcation"(acc_no,amount_deposited,amount_withdrawed)
VALUES('FY7K9JA1GQJU','454600','12001'); --after this,re-run eq-1
--now,lets judt delete the specific column part in particular row and not the whole row

DELETE FROM "CreateSchema"."transcation" WHERE COLUMN amount_deposited = 12001;
--nah,you cant use this query here,because in postgres ,it justs dekete the whole row not the specific column in a row

--so you can use the trick,either use this 
UPDATE "CreateSchema"."transcation" SET amount_deposited = NULL WHERE amount_deposited = 12001;
--if you set te consytrains too ,not to be not null then sorry use ALTER keyword to change constrains or update the value




