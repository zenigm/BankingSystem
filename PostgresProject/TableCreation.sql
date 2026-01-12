
CREATE TABLE "CreateSchema".bank_records(
Sr_no SERIAL NOT NULL,
UNIQUE(Sr_no),
Acc_no VARCHAR(12) PRIMARY KEY,
Acc_holder VARCHAR(20),
Acc_created DATE NOT NULL,
Acc_type VARCHAR(15) NOT NULL DEFAULT 'Savings',
Acc_balance NUMERIC(20),
Acc_branch VARCHAR(25) NOT NULL DEFAULT 'Main Branch(New Delhi)'
);

CREATE TABLE "CreateSchema".cards(
Credit_cardNo VARCHAR(19) NOT NULL,
Credit_score DECIMAL(4,2),
Debit_card VARCHAR(3) NOT NULL DEFAULT 'No',
Debit_cardNo VARCHAR(19) NOT NULL DEFAULT '-',
UNIQUE (Credit_cardNo, Debit_cardNo),
Acc_no VARCHAR(12),
FOREIGN KEY (Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)
);

CREATE TABLE "CreateSchema".customer(
Fathers_name VARCHAR(24),
Mothers_name VARCHAR(24),
Phone_no NUMERIC(12),
Email_id VARCHAR(25),
UNIQUE (Phone_no, Email_id),
Address VARCHAR(30),
Acc_no VARCHAR(12),
FOREIGN KEY (Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)
);

CREATE TABLE "CreateSchema".adhaar_card(
Acc_no VARCHAR(12),
Adhaar_card VARCHAR(14) PRIMARY KEY,
FOREIGN KEY(Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)																																																		
);

CREATE TABLE "CreateSchema".pan_card(
Acc_no VARCHAR(12),
Pan_card VARCHAR(14) PRIMARY KEY,

FOREIGN KEY (Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)		
);

CREATE TABLE "CreateSchema".transcation(
Acc_no VARCHAR(12),
FOREIGN KEY (acc_no) REFERENCES "CreateSchema".bank_records(Acc_no),
Amount_deposited NUMERIC(15),
Amount_withdrawed NUMERIC(10)
);
