--1)SWITCH CASE
SELECT * FROM "CreateSchema"."bank_records";
SELECT acc_holder,acc_balance,
CASE
     WHEN acc_balance > 100000 THEN 'HIGH'
	 ELSE 'LOW'
END AS labell
FROM "CreateSchema"."bank_records";


SELECT * FROM "CreateSchema"."transcation";
SELECT Acc_no FROM "CreateSchema"."transcation";

SELECT "Acc_no",amount_deposited,amount_withdrawed,
CASE
     WHEN amount_deposited > 10000 AND amount_withdrawed <20000 THEN 'Wasting'
	 ELSE 'Not_Wasting'
END AS Quality
FROM "CreateSchema"."transcation";


