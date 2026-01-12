--Sample Entry Data

--1.)Bank Table
INSERT INTO "CreateSchema"."bank_records"(Acc_no,Acc_holder,Acc_created,Acc_balance)
VALUES('002AER232222','Mr.Shubas','13/12/05','600000');


--2.)Credit/Debit Card Table
INSERT INTO "CreateSchema"."cards"(Credit_cardNo,Credit_score,Debit_card,Debit_cardNo,Acc_no)
VALUES('0010-3122-4353-1323','89.99','No','-','002AER232222');


--3.)Customer Table
INSERT INTO "CreateSchema"."customer"(Fathers_name,Mothers_name,Phone_no,Email_id,Address,Acc_no)
VALUES('Mr.Aditya','Mrs.Suhri','929722215490','qwert23@gmail.com','Lucknow,India','002AER232222')


--4.)Adhaar Card Table
INSERT INTO "CreateSchema"."adhaar_card"(Acc_no,Adhaar_card)
VALUES('002AER232222','1234-5678-9012');


--5.)Pan Card Table
INSERT INTO "CreateSchema"."pan_card"(Acc_no,Pan_card)
VALUES('002AER232222','ABCDE1234F');


--6.)Transcation Table
INSERT INTO "CreateSchema"."transcation"(Acc_no,Amount_deposited,Amount_withdrawed)
VALUES('002AER232222','2025000','44302');

