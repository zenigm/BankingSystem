--1)Altering Table or column
--ALTER TABLE commands modify existing table structure - add/remove/rename columns or change data types
--These are DDL (Data Definition Language) operations that permanently change table schema

ALTER TABLE "CreateSchema"."bank_records"
ADD COLUMN category VARCHAR(18);
--ADD COLUMN creates new column 'category' with VARCHAR(18) type, initially NULL for all rows

ALTER TABLE "CreateSchema"."bank_records"
RENAME COLUMN category TO categories;
--RENAME COLUMN changes column name from 'category' to 'categories' (singular to plural)

ALTER TABLE "CreateSchema"."bank_records"
ALTER COLUMN categories TYPE VARCHAR(18)
USING categories::VARCHAR(20);
--ALTER COLUMN changes data type of 'categories' column from VARCHAR(18) to VARCHAR(20)
--USING clause specifies how to convert existing data (type casting)

ALTER TABLE "CreateSchema"."bank_records"
DROP COLUMN categories;
--DROP COLUMN permanently removes 'categories' column and all its data from table

--wecan also do it same for schema and tables
--Same ALTER syntax applies to RENAME schema/table names (ALTER SCHEMA/ALTER TABLE RENAME TO)
--Example: ALTER TABLE "CreateSchema"."bank_records" RENAME TO bank_accounts;



--2.)Consrains
--Constraints enforce data integrity rules on table columns during INSERT/UPDATE
--Types include CHECK (custom conditions), NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY
--CHECK ensures specific business rules like valid phone length or non-empty names

ALTER TABLE "CreateSchema"."bank_records"
ADD CONSTRAINT acc_holder CHECK(acc_holder != NULL); 
--Adds named CHECK constraint requiring acc_holder never NULL (like NOT NULL but custom)

ALTER TABLE "CreateSchema"."bank_records"
DROP CONSTRAINT acc_holder;
--Drops specific named constraint acc_holder from bank_records table


--CREATE TABLE random(
-- mob_no NUMERIC(15)
--CONSRAINT mob_no CHEXK(LENGTH(mob_no::TXT) <= 10)
--);
--Commented: Syntax errors - misspelled CONSTRAINT/CHECK/TXT; inline syntax wrong

--CREATE TABLE random(
 --   mob_no NUMERIC(15) CHECK(LENGTH(mob_no::TEXT) <= 10)
--);
--Commented: Inline CHECK validates mob_no length <=10 chars when cast to TEXT

