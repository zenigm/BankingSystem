# Banking Management System - PostgreSQL Database Setup

Complete documentation for creating and populating the banking database with all tables and sample data.

---

## Table of Contents
1. [Schema Creation](#schema-creation)
2. [Table Creation](#table-creation)
3. [Sample Data Insertion](#sample-data-insertion)
4. [Important Notes](#important-notes)

---

## Schema Creation

```sql
-- =============================================
-- CREATE SCHEMA
-- =============================================
-- This creates the main schema for all banking-related tables
CREATE SCHEMA IF NOT EXISTS "CreateSchema";
```

---

## Table Creation

### 1. Bank Records Table
Stores basic account information for all customers

```sql
-- =============================================
-- 1.) BANK RECORDS TABLE
-- =============================================
-- Purpose: Store primary account information
-- Primary Key: Acc_no (Account Number)
-- Constraints: Sr_no must be unique, Acc_created is mandatory

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
```

### 2. Cards Table
Stores credit and debit card information linked to bank accounts

```sql
-- =============================================
-- 2.) CARDS TABLE
-- =============================================
-- Purpose: Store credit and debit card details
-- Foreign Key: Links to bank_records.Acc_no
-- Constraints: Credit_cardNo and Debit_cardNo must be unique together

CREATE TABLE "CreateSchema".cards(
    Credit_cardNo VARCHAR(19) NOT NULL,
    Credit_score DECIMAL(4,2),
    Debit_card VARCHAR(3) NOT NULL DEFAULT 'No',
    Debit_cardNo VARCHAR(19) NOT NULL DEFAULT '-',
    UNIQUE (Credit_cardNo, Debit_cardNo),
    Acc_no VARCHAR(12),
    FOREIGN KEY (Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)
);
```

### 3. Customer Table
Stores customer personal information

```sql
-- =============================================
-- 3.) CUSTOMER TABLE
-- =============================================
-- Purpose: Store customer demographic and contact information
-- Foreign Key: Links to bank_records.Acc_no
-- Constraints: Phone_no and Email_id must be unique together

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
```

### 4. Aadhaar Card Table
Stores Aadhaar (Indian ID) information

```sql
-- =============================================
-- 4.) AADHAAR CARD TABLE
-- =============================================
-- Purpose: Store Aadhaar card details for identity verification
-- Primary Key: Adhaar_card (Aadhaar number)
-- Foreign Key: Links to bank_records.Acc_no

CREATE TABLE "CreateSchema".adhaar_card(
    Acc_no VARCHAR(12),
    Adhaar_card VARCHAR(14) PRIMARY KEY,
    FOREIGN KEY(Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)
);
```

### 5. PAN Card Table
Stores PAN (Permanent Account Number) information

```sql
-- =============================================
-- 5.) PAN CARD TABLE
-- =============================================
-- Purpose: Store PAN card details for tax identification
-- Primary Key: Pan_card (PAN number)
-- Foreign Key: Links to bank_records.Acc_no

CREATE TABLE "CreateSchema".pan_card(
    Acc_no VARCHAR(12),
    Pan_card VARCHAR(14) PRIMARY KEY,
    FOREIGN KEY (Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no)
);
```

### 6. Transaction Table
Stores deposit and withdrawal transaction records

```sql
-- =============================================
-- 6.) TRANSACTION TABLE
-- =============================================
-- Purpose: Store all deposit and withdrawal transactions
-- Foreign Key: Links to bank_records.Acc_no
-- Note: Fixed table name from 'transcation' to 'transaction'

CREATE TABLE "CreateSchema".transaction(
    Acc_no VARCHAR(12),
    FOREIGN KEY (Acc_no) REFERENCES "CreateSchema".bank_records(Acc_no),
    Amount_deposited NUMERIC(15),
    Amount_withdrawed NUMERIC(10)
);
```

---

## Sample Data Insertion

### Sample Entry Data (Single Records)

```sql
-- =============================================
-- SAMPLE ENTRY DATA (For Testing)
-- =============================================

-- 1.) Insert into Bank Records Table
INSERT INTO "CreateSchema"."bank_records"(Acc_no, Acc_holder, Acc_created, Acc_balance)
VALUES('002AER232222', 'Mr.Shubas', '2025-12-05', '600000');

-- 2.) Insert into Cards Table
INSERT INTO "CreateSchema"."cards"(Credit_cardNo, Credit_score, Debit_card, Debit_cardNo, Acc_no)
VALUES('0010-3122-4353-1323', '89.99', 'No', '-', '002AER232222');

-- 3.) Insert into Customer Table
INSERT INTO "CreateSchema"."customer"(Fathers_name, Mothers_name, Phone_no, Email_id, Address, Acc_no)
VALUES('Mr.Aditya', 'Mrs.Suhri', '9297222154', 'qwert23@gmail.com', 'Lucknow, India', '002AER232222');

-- 4.) Insert into Aadhaar Card Table
INSERT INTO "CreateSchema"."adhaar_card"(Acc_no, Adhaar_card)
VALUES('002AER232222', '1234-5678-9012');

-- 5.) Insert into PAN Card Table
INSERT INTO "CreateSchema"."pan_card"(Acc_no, Pan_card)
VALUES('002AER232222', 'ABCDE1234F');

-- 6.) Insert into Transaction Table
INSERT INTO "CreateSchema"."transaction"(Acc_no, Amount_deposited, Amount_withdrawed)
VALUES('002AER232222', '2025000', '44302');
```

### Bulk Data Insertion (100 Records Each)

```sql
-- =============================================
-- 1.) BANK RECORDS TABLE (100 entries)
-- =============================================

INSERT INTO "CreateSchema".bank_records (Acc_no, Acc_holder, Acc_created, Acc_type, Acc_balance, Acc_branch)
VALUES
('QCEP6AUJS2N8', 'Mr.PLRAWD', '2014-01-30', 'Salary', 1328225, 'Mumbai Branch'),
('WYQHDUQC8L1D', 'Mr.SXSKFS', '2012-01-05', 'Salary', 1205854, 'Bangalore Branch'),
('TTMRTRLDI3RZ', 'Mr.EZYRCJ', '2009-02-04', 'Salary', 908758, 'Mumbai Branch'),
('FY7K9JA1GQJU', 'Mr.YLFIRU', '2001-11-20', 'Current', 515118, 'Main Branch(New Delhi)'),
('SFCNOQPGQ5FO', 'Mr.SWREGZ', '2006-01-23', 'Savings', 1852029, 'Mumbai Branch'),
('9YC36OAW9E95', 'Mr.WCAIKM', '2005-05-11', 'Salary', 1992691, 'Chennai Branch'),
('75XDVTF74KSX', 'Mr.GLDCBR', '2021-02-10', 'Salary', 1603279, 'Bangalore Branch'),
('HZ9CC4OM12AP', 'Mr.XCVWAO', '2000-02-15', 'Salary', 1649236, 'Mumbai Branch'),
('604UZC9QMZL2', 'Mr.XIORZS', '2008-05-03', 'Salary', 1814415, 'Chennai Branch'),
('Y81VJT1P25AA', 'Mr.WUVBVI', '2004-09-23', 'Current', 390015, 'Bangalore Branch'),
('C69XYKEXZQV0', 'Mr.METLZA', '2019-09-23', 'Salary', 1371760, 'Bangalore Branch'),
('O5QMPQARUGSE', 'Mr.MSTLKF', '2004-05-18', 'Current', 189033, 'Bangalore Branch'),
('8UVK0Y0NZGQF', 'Mr.ADQVXP', '2022-12-19', 'Current', 1416400, 'Main Branch(New Delhi)'),
('7IV0GIGI0239', 'Mr.MSXSEL', '2008-02-04', 'Savings', 244907, 'Bangalore Branch'),
('MP1TEPWCD9YW', 'Mr.VKWMGY', '2020-10-03', 'Savings', 351361, 'Bangalore Branch'),
('ZV6JWI8PONSE', 'Mr.XYKSDS', '2019-10-30', 'Salary', 1151936, 'Chennai Branch'),
('M297GY8TJX8A', 'Mr.CJKNBQ', '2016-02-21', 'Salary', 1606427, 'Main Branch(New Delhi)'),
('4PBKTRE6K8S7', 'Mr.GSHQJM', '2021-12-13', 'Current', 1762522, 'Main Branch(New Delhi)'),
('THYP9HD8Y14D', 'Mr.PSODQF', '2020-05-16', 'Salary', 1055444, 'Bangalore Branch'),
('M7ROLO2GMFPX', 'Mr.VCZBAS', '2009-09-08', 'Salary', 175739, 'Chennai Branch'),
('801T88G3GFFE', 'Mr.WTSQDH', '2023-10-09', 'Savings', 230802, 'Chennai Branch'),
('PT7O197CE8D9', 'Mr.KLJVTK', '2004-09-26', 'Current', 1381265, 'Mumbai Branch'),
('KZ7IF1TI87YL', 'Mr.LWYDFC', '2025-02-11', 'Savings', 422658, 'Mumbai Branch'),
('HDEVSQBHYWX7', 'Mr.TTTVUF', '2007-02-19', 'Savings', 1548513, 'Mumbai Branch'),
('MN7K47W1APTX', 'Mr.VIFSEN', '2023-07-24', 'Savings', 1666824, 'Main Branch(New Delhi)'),
('YAJFBYBEAPP3', 'Mr.HHZSCD', '2008-11-13', 'Salary', 1324871, 'Main Branch(New Delhi)'),
('DN42Y6JA5ZX0', 'Mr.SCLNNZ', '2015-09-29', 'Current', 87079, 'Bangalore Branch'),
('4EM2REWRQU2S', 'Mr.AMWBGS', '2007-07-29', 'Current', 1979721, 'Main Branch(New Delhi)'),
('6NVGUUNC5LCV', 'Mr.UHDVZC', '2014-02-06', 'Current', 1614221, 'Bangalore Branch'),
('SAQUHU8AM4UW', 'Mr.BUCCVQ', '2024-08-10', 'Savings', 1233017, 'Mumbai Branch'),
('3H95N5X4EYI3', 'Mr.NSHZLH', '2012-01-27', 'Savings', 1443432, 'Main Branch(New Delhi)'),
('HZ805JUJGARJ', 'Mr.RUDLBG', '2012-02-22', 'Current', 897481, 'Chennai Branch'),
('EWVIFZ4VQDUH', 'Mr.GTLTGQ', '2009-06-23', 'Salary', 1494181, 'Main Branch(New Delhi)'),
('F4JZ0YE7041Z', 'Mr.UARQKL', '2011-04-26', 'Salary', 775758, 'Mumbai Branch'),
('EJ5R0O1FVEKQ', 'Mr.QEDTAI', '2007-01-09', 'Salary', 1519458, 'Chennai Branch'),
('Y1702QC9HLZZ', 'Mr.ZIYRUW', '2004-11-02', 'Savings', 533282, 'Bangalore Branch'),
('JGEGI7LIQUZI', 'Mr.XOTLFQ', '2015-04-13', 'Salary', 841796, 'Mumbai Branch'),
('OS0QLAELUPVS', 'Mr.YWNMCF', '2010-10-09', 'Savings', 90905, 'Chennai Branch'),
('EEYMUK8WPRWM', 'Mr.QXJYJC', '2009-06-23', 'Savings', 1599422, 'Bangalore Branch'),
('9F2IQMWJ2ATG', 'Mr.QICIGP', '2017-07-08', 'Current', 234930, 'Bangalore Branch'),
('PE89UBI7805D', 'Mr.MTRARF', '2018-03-03', 'Current', 1690473, 'Chennai Branch'),
('EPITLQVJ88OZ', 'Mr.TZKTCS', '2022-11-28', 'Salary', 840817, 'Mumbai Branch'),
('XIKF6FT0SD7A', 'Mr.ALPOYB', '2022-10-06', 'Savings', 513150, 'Main Branch(New Delhi)'),
('HIEGWKX6EONW', 'Mr.UCPSYL', '2004-12-08', 'Savings', 742551, 'Mumbai Branch'),
('PZ3QDXT1GKJV', 'Mr.ZNRDJI', '2013-04-16', 'Salary', 971578, 'Chennai Branch'),
('NUTQS8VHVH9A', 'Mr.SSJION', '2025-10-06', 'Savings', 417845, 'Bangalore Branch'),
('VA8QGX2CLHCS', 'Mr.GZXJQZ', '2024-11-17', 'Savings', 1353954, 'Bangalore Branch'),
('ZBBWMR1LV39S', 'Mr.JCWVFK', '2016-09-11', 'Savings', 1046972, 'Bangalore Branch'),
('9JUE0MG5NQFB', 'Mr.VXJCTV', '2015-01-17', 'Savings', 1230792, 'Bangalore Branch'),
('VYCR1BVMDXUR', 'Mr.QCUGXP', '2010-03-29', 'Savings', 179138, 'Main Branch(New Delhi)'),
('6VGOA8EDAHGM', 'Mr.AIPTME', '2019-10-09', 'Savings', 106986, 'Chennai Branch'),
('XXV7KKWDUCWA', 'Mr.QHVWFE', '2017-01-11', 'Current', 1727576, 'Chennai Branch'),
('R6CZVV73QA5D', 'Mr.BOMYNT', '2024-03-04', 'Savings', 494477, 'Bangalore Branch'),
('OEK9U1JYM9JI', 'Mr.NEKLKQ', '2024-06-10', 'Current', 826852, 'Bangalore Branch'),
('161U3FD1IZ39', 'Mr.FVHNUR', '2004-05-27', 'Savings', 1289496, 'Bangalore Branch'),
('7727X4CZUVG4', 'Mr.OOOXYF', '2000-09-20', 'Current', 1275568, 'Mumbai Branch'),
('NNMWAXA6AKSP', 'Mr.DIKWQD', '2018-02-08', 'Current', 1296778, 'Main Branch(New Delhi)'),
('CTJCRROW4DVI', 'Mr.CPNQNM', '2008-12-29', 'Salary', 1678651, 'Mumbai Branch'),
('M45AN9TRXJI0', 'Mr.QEFNTI', '2013-01-05', 'Savings', 1809061, 'Bangalore Branch'),
('558X4EKJ6PFT', 'Mr.CVACUC', '2009-11-26', 'Savings', 433986, 'Main Branch(New Delhi)'),
('8JU46P4TQCYW', 'Mr.HXCYRP', '2021-05-25', 'Salary', 120330, 'Main Branch(New Delhi)'),
('NG7223WC66E4', 'Mr.XVNYPX', '2000-04-09', 'Savings', 40216, 'Main Branch(New Delhi)'),
('HCPIH5ONWJQD', 'Mr.SSVHWM', '2025-01-08', 'Salary', 1232330, 'Bangalore Branch'),
('F4IPE9PN84CK', 'Mr.QSDMDR', '2020-05-15', 'Salary', 864108, 'Mumbai Branch'),
('X1EQHO7EEPFV', 'Mr.LLZCRN', '2014-05-21', 'Savings', 1535381, 'Chennai Branch'),
('WJUEUVUU6ICJ', 'Mr.YAMMAM', '2002-09-11', 'Salary', 1948909, 'Bangalore Branch'),
('9SSFOJGW37WJ', 'Mr.EPNILT', '2004-10-08', 'Salary', 1258540, 'Mumbai Branch'),
('QZPG1UMALASO', 'Mr.QTNGIT', '2001-01-08', 'Savings', 96858, 'Mumbai Branch'),
('J6CP20E8IBNY', 'Mr.NVGLVX', '2012-07-12', 'Savings', 1205438, 'Bangalore Branch'),
('T3Q0X2NMTKK4', 'Mr.LUQBFH', '2019-11-10', 'Salary', 667358, 'Main Branch(New Delhi)'),
('3HQUSHIT0HMP', 'Mr.UKVHBB', '2016-06-12', 'Savings', 1821458, 'Bangalore Branch'),
('G2IL65YP94QF', 'Mr.OHGBZY', '2002-06-24', 'Salary', 1431488, 'Main Branch(New Delhi)'),
('LXQYGECHPYLM', 'Mr.DKGPND', '2012-12-16', 'Salary', 240192, 'Bangalore Branch'),
('Z1QTNDRVYB82', 'Mr.FQFVYE', '2006-02-13', 'Savings', 775271, 'Mumbai Branch'),
('V3UNJ6QNW1KO', 'Mr.SHEJYP', '2017-01-08', 'Salary', 780648, 'Chennai Branch'),
('IAETBB0OEPPC', 'Mr.ADCELL', '2010-06-04', 'Savings', 1317449, 'Mumbai Branch'),
('WUWGFK3SS1JD', 'Mr.JXVGNT', '2009-02-23', 'Savings', 142192, 'Main Branch(New Delhi)'),
('2618OKD06QTQ', 'Mr.QMBUCM', '2007-01-15', 'Current', 475545, 'Bangalore Branch'),
('L0IYBMLVX69I', 'Mr.XTNNFK', '2022-03-24', 'Salary', 140866, 'Mumbai Branch'),
('0IJVYV68TCL9', 'Mr.HOXOBZ', '2016-06-21', 'Savings', 624661, 'Bangalore Branch'),
('Z30KP68BAENE', 'Mr.UIXTLS', '2005-03-04', 'Salary', 1924370, 'Bangalore Branch'),
('F0FKIYFVUAX7', 'Mr.IWFBLQ', '2000-04-06', 'Current', 892013, 'Chennai Branch'),
('9N8RBZT7E0O6', 'Mr.GHCFRF', '2000-05-27', 'Savings', 1344160, 'Bangalore Branch'),
('XBHB2XDI09U4', 'Mr.RCQYXB', '2017-08-15', 'Current', 160961, 'Chennai Branch'),
('GEIMPS6SVP08', 'Mr.KVLOVJ', '2020-10-24', 'Savings', 607952, 'Chennai Branch'),
('1F5TM5U7CDXS', 'Mr.AAYXJR', '2007-03-31', 'Salary', 1955268, 'Mumbai Branch'),
('OG992UAI3N97', 'Mr.ECSPCI', '2017-10-17', 'Savings', 1201979, 'Main Branch(New Delhi)'),
('RP6SUVGSSUMT', 'Mr.WBKOPQ', '2001-04-06', 'Savings', 1722538, 'Mumbai Branch'),
('68D50O98OSS1', 'Mr.NNUULD', '2002-04-22', 'Savings', 1936133, 'Main Branch(New Delhi)'),
('IK470ADNTRR0', 'Mr.JHLUPB', '2012-03-23', 'Salary', 583630, 'Main Branch(New Delhi)'),
('BDTM2QQK5761', 'Mr.CCDYBL', '2020-11-30', 'Salary', 1704743, 'Main Branch(New Delhi)'),
('1K6FUMGHF11U', 'Mr.UTLKIS', '2010-07-20', 'Salary', 765134, 'Bangalore Branch'),
('9MR4G4A290HZ', 'Mr.DMSSYR', '2023-08-09', 'Current', 592415, 'Mumbai Branch'),
('YV9N7PF1X3F4', 'Mr.BBNDVK', '2024-12-18', 'Savings', 1958531, 'Main Branch(New Delhi)'),
('M0MHOXA7VFKY', 'Mr.EJUGAH', '2020-12-08', 'Salary', 1260939, 'Mumbai Branch'),
('S7GSGGI04V72', 'Mr.ZDCGEM', '2002-02-19', 'Savings', 921242, 'Mumbai Branch'),
('S90JYRZG58S9', 'Mr.UMLKBK', '2015-03-12', 'Salary', 1009279, 'Chennai Branch'),
('T13X0432BPAS', 'Mr.JKZCGQ', '2001-09-19', 'Savings', 1398848, 'Chennai Branch'),
('MTCZG7PRVOBY', 'Mr.MVQXSO', '2020-07-27', 'Savings', 1796102, 'Bangalore Branch'),
('V3J9L5I1416C', 'Mr.XVGCTQ', '2014-06-14', 'Savings', 1465384, 'Main Branch(New Delhi)');
```

```sql
-- =============================================
-- 2.) CARDS TABLE (100 entries)
-- =============================================

INSERT INTO "CreateSchema".cards (Credit_cardNo, Credit_score, Debit_card, Debit_cardNo, Acc_no)
VALUES
('1500-1603-8442-2397', 60.36, 'No', '-', 'QCEP6AUJS2N8'),
('9120-2347-8515-6619', 94.27, 'No', '-', 'WYQHDUQC8L1D'),
('6239-8079-7800-1613', 86.71, 'No', '-', 'TTMRTRLDI3RZ'),
('3876-6990-1054-2535', 84.31, 'Yes', '1669-4110-1667-1797', 'FY7K9JA1GQJU'),
('2383-8810-8722-2393', 96.28, 'No', '-', 'SFCNOQPGQ5FO'),
('4990-7807-2738-1063', 56.58, 'No', '-', '9YC36OAW9E95'),
('4549-9744-4085-4468', 70.75, 'No', '-', '75XDVTF74KSX'),
('7836-9408-8396-3821', 92.82, 'Yes', '2499-5531-5138-9804', 'HZ9CC4OM12AP'),
('3441-8297-2014-4140', 64.13, 'Yes', '1611-9014-4450-4627', '604UZC9QMZL2'),
('6560-8512-6610-8558', 97.65, 'No', '-', 'Y81VJT1P25AA'),
('8149-1301-3085-7987', 77.34, 'No', '-', 'C69XYKEXZQV0'),
('6737-4395-7450-9606', 88.07, 'Yes', '4825-4601-7796-7042', 'O5QMPQARUGSE'),
('9283-6440-9411-2015', 56.24, 'Yes', '8738-5006-4457-3211', '8UVK0Y0NZGQF'),
('3504-6598-6848-8469', 51.34, 'No', '-', '7IV0GIGI0239'),
('2204-7659-1743-3869', 52.61, 'No', '-', 'MP1TEPWCD9YW'),
('7370-4965-9377-3733', 84.91, 'No', '-', 'ZV6JWI8PONSE'),
('2997-8751-1724-2251', 75.51, 'No', '-', 'M297GY8TJX8A'),
('5223-5940-5399-1251', 63.2, 'Yes', '4341-5347-8784-5045', '4PBKTRE6K8S7'),
('5678-1431-6351-1742', 98.33, 'Yes', '1766-6601-6777-3278', 'THYP9HD8Y14D'),
('4585-3805-2874-4356', 89.87, 'Yes', '8126-7694-7019-3187', 'M7ROLO2GMFPX'),
('1943-5455-2567-4959', 75.38, 'No', '-', '801T88G3GFFE'),
('7134-1008-1755-4987', 99.21, 'No', '-', 'PT7O197CE8D9'),
('3191-4012-4413-7262', 96.9, 'No', '-', 'KZ7IF1TI87YL'),
('7943-8291-3371-7421', 65.35, 'No', '-', 'HDEVSQBHYWX7'),
('7129-4597-5450-8028', 52.0, 'Yes', '3933-7102-6355-2150', 'MN7K47W1APTX'),
('5406-6443-1732-5425', 74.08, 'Yes', '1453-6001-4441-5461', 'YAJFBYBEAPP3'),
('5963-5249-4301-6071', 86.25, 'Yes', '9229-9622-5430-2971', 'DN42Y6JA5ZX0'),
('2221-5798-9093-9985', 93.75, 'Yes', '4067-9872-9389-9794', '4EM2REWRQU2S'),
('6771-2898-6643-3171', 91.18, 'Yes', '2584-7097-9476-4939', '6NVGUUNC5LCV'),
('3767-9683-2995-1897', 52.58, 'Yes', '4527-7728-8628-3001', 'SAQUHU8AM4UW'),
('2086-7449-4851-2114', 64.6, 'No', '-', '3H95N5X4EYI3'),
('5605-6373-1021-9288', 63.87, 'Yes', '1456-5343-5292-8256', 'HZ805JUJGARJ'),
('9824-9792-5926-8049', 89.98, 'No', '-', 'EWVIFZ4VQDUH'),
('4452-8490-4816-4755', 57.02, 'No', '-', 'F4JZ0YE7041Z'),
('8975-2054-3019-2868', 52.28, 'No', '-', 'EJ5R0O1FVEKQ'),
('4733-7736-1772-4214', 53.66, 'Yes', '4841-8025-6107-4121', 'Y1702QC9HLZZ'),
('5085-2637-3338-4213', 79.07, 'No', '-', 'JGEGI7LIQUZI'),
('4620-4242-5882-6314', 98.98, 'Yes', '5223-8381-4325-1241', 'OS0QLAELUPVS'),
('8092-7243-3458-9428', 79.97, 'No', '-', 'EEYMUK8WPRWM'),
('7505-8284-9691-8889', 55.64, 'No', '-', '9F2IQMWJ2ATG'),
('1612-8324-8299-9211', 55.59, 'Yes', '6018-1484-4792-4650', 'PE89UBI7805D'),
('8667-8353-4894-1809', 99.13, 'Yes', '3278-6416-4322-1494', 'EPITLQVJ88OZ'),
('1206-3262-1450-3807', 59.16, 'Yes', '6823-6197-8761-8409', 'XIKF6FT0SD7A'),
('4267-4418-8964-6535', 93.09, 'No', '-', 'HIEGWKX6EONW'),
('4237-2324-1110-5428', 79.86, 'Yes', '6807-3340-7280-9353', 'PZ3QDXT1GKJV'),
('9549-7600-5066-4641', 93.48, 'Yes', '8612-2056-8773-6722', 'NUTQS8VHVH9A'),
('1415-7193-2747-1739', 95.68, 'Yes', '9833-3380-1534-5840', 'VA8QGX2CLHCS'),
('2049-8405-3556-3118', 83.91, 'Yes', '4677-1601-3258-6863', 'ZBBWMR1LV39S'),
('7960-6737-7733-9969', 79.54, 'No', '-', '9JUE0MG5NQFB'),
('3477-8610-7624-5713', 75.48, 'No', '-', 'VYCR1BVMDXUR'),
('9863-3754-5816-8139', 54.09, 'Yes', '3740-1403-4758-9314', '6VGOA8EDAHGM'),
('3889-5012-3892-4681', 50.77, 'Yes', '6584-5070-5145-7608', 'XXV7KKWDUCWA'),
('3110-9972-9823-3492', 73.33, 'No', '-', 'R6CZVV73QA5D'),
('7555-2404-6899-8546', 66.46, 'Yes', '9717-5859-9283-4238', 'OEK9U1JYM9JI'),
('1448-4464-9657-4457', 84.79, 'No', '-', '161U3FD1IZ39'),
('9173-6376-5588-5900', 78.58, 'Yes', '6047-7261-9155-8897', '7727X4CZUVG4'),
('3849-9439-3128-1921', 71.88, 'Yes', '8253-2415-5659-4201', 'NNMWAXA6AKSP'),
('2835-2992-6760-1220', 82.75, 'Yes', '1185-2781-7481-4743', 'CTJCRROW4DVI'),
('1806-5187-1687-3179', 92.49, 'Yes', '7488-1653-4574-9008', 'M45AN9TRXJI0'),
('3966-4246-6324-3834', 72.26, 'Yes', '8027-6799-4398-2549', '558X4EKJ6PFT'),
('7723-2422-5133-6964', 54.66, 'No', '-', '8JU46P4TQCYW'),
('3536-3254-3979-7956', 55.05, 'Yes', '2978-1123-4741-2404', 'NG7223WC66E4'),
('1516-4200-2626-4897', 80.52, 'Yes', '3345-1890-1689-1330', 'HCPIH5ONWJQD'),
('6254-3040-2602-9297', 80.82, 'No', '-', 'F4IPE9PN84CK'),
('4120-7017-3603-6094', 76.16, 'Yes', '7483-6827-7069-3429', 'X1EQHO7EEPFV'),
('2596-2701-7138-9995', 55.2, 'No', '-', 'WJUEUVUU6ICJ'),
('1477-5711-8399-6778', 76.07, 'Yes', '7861-5177-1552-7991', '9SSFOJGW37WJ'),
('4050-2042-2119-5228', 82.26, 'No', '-', 'QZPG1UMALASO'),
('4227-3194-7297-7427', 69.66, 'No', '-', 'J6CP20E8IBNY'),
('1651-2820-1938-9203', 87.4, 'Yes', '7476-7512-6707-6636', 'T3Q0X2NMTKK4'),
('7260-6333-5951-3601', 96.7, 'No', '-', '3HQUSHIT0HMP'),
('8616-2449-2421-8511', 96.62, 'No', '-', 'G2IL65YP94QF'),
('9617-8408-5451-7525', 55.46, 'No', '-', 'LXQYGECHPYLM'),
('4593-4372-6407-3956', 81.94, 'No', '-', 'Z1QTNDRVYB82'),
('7373-2620-6656-8161', 69.4, 'Yes', '3463-1960-3809-9054', 'V3UNJ6QNW1KO'),
('2454-5091-5701-2263', 52.18, 'Yes', '4484-8293-7476-8004', 'IAETBB0OEPPC'),
('4969-2470-5893-6177', 86.16, 'Yes', '3130-9221-4182-4417', 'WUWGFK3SS1JD'),
('6932-8391-6124-4223', 74.86, 'No', '-', '2618OKD06QTQ'),
('8620-4988-5522-3092', 93.82, 'No', '-', 'L0IYBMLVX69I'),
('5577-4447-7204-9482', 54.02, 'Yes', '5142-5903-6236-2615', '0IJVYV68TCL9'),
('8127-2653-8545-5469', 78.28, 'Yes', '9918-3873-7110-9699', 'Z30KP68BAENE'),
('8680-2832-1232-7915', 78.39, 'No', '-', 'F0FKIYFVUAX7'),
('3288-8459-7253-6694', 75.7, 'Yes', '5972-2148-5391-7775', '9N8RBZT7E0O6'),
('3802-6107-8558-9075', 95.76, 'Yes', '6314-2633-3423-8959', 'XBHB2XDI09U4'),
('7495-1332-4822-9618', 81.8, 'Yes', '5383-6898-4260-9149', 'GEIMPS6SVP08'),
('7040-6858-4838-7812', 85.93, 'Yes', '8531-1526-5089-7857', '1F5TM5U7CDXS'),
('1416-8280-9096-3918', 72.62, 'No', '-', 'OG992UAI3N97'),
('9357-1849-7115-2609', 88.08, 'Yes', '3918-6059-1517-7188', 'RP6SUVGSSUMT'),
('9598-9881-1553-7645', 61.17, 'Yes', '7564-3825-1909-6508', '68D50O98OSS1'),
('9416-7615-2950-5296', 90.81, 'No', '-', 'IK470ADNTRR0'),
('9396-4972-6373-2922', 57.67, 'Yes', '3486-7869-8966-9562', 'BDTM2QQK5761'),
('2359-1186-7561-5187', 74.08, 'Yes', '1529-9678-3738-3313', '1K6FUMGHF11U'),
('9751-1742-6939-3227', 57.38, 'No', '-', '9MR4G4A290HZ'),
('2893-6628-7822-6194', 98.14, 'No', '-', 'YV9N7PF1X3F4'),
('5532-5408-8138-5819', 62.97, 'No', '-', 'M0MHOXA7VFKY'),
('3764-7613-8059-6581', 99.26, 'Yes', '4264-1569-8452-5231', 'S7GSGGI04V72'),
('9549-7720-2780-7566', 90.88, 'No', '-', 'S90JYRZG58S9'),
('3652-2162-1169-2140', 69.76, 'Yes', '4627-6548-7905-2407', 'T13X0432BPAS'),
('2374-6922-4331-7865', 89.26, 'Yes', '7616-5563-8960-1473', 'MTCZG7PRVOBY'),
('8246-8895-4453-9097', 64.18, 'Yes', '1679-6533-1789-8210', 'V3J9L5I1416C');
```

```sql
-- =============================================
-- 3.) CUSTOMER TABLE (100 entries)
-- =============================================

INSERT INTO "CreateSchema".customer (Fathers_name, Mothers_name, Phone_no, Email_id, Address, Acc_no)
VALUES
('Mr.QMFKGRP', 'Mrs.PNQRXXA', '9711193633', 'wnosbjxr@gmail.com', 'Ahmedabad, India', 'QCEP6AUJS2N8'),
('Mr.BOMWKDV', 'Mrs.MZUIGCD', '2930984002', 'zuudyrpq@gmail.com', 'Jaipur, India', 'WYQHDUQC8L1D'),
('Mr.AHGJBYA', 'Mrs.JLKYLVJ', '8461208727', 'fzusxjla@gmail.com', 'Ahmedabad, India', 'TTMRTRLDI3RZ'),
('Mr.KQRJZOL', 'Mrs.ICFXDSG', '4106903789', 'ttfnzara@gmail.com', 'Bangalore, India', 'FY7K9JA1GQJU'),
('Mr.RIFMSUG', 'Mrs.SDKNEFJ', '7745836549', 'gtctelsg@gmail.com', 'Kolkata, India', 'SFCNOQPGQ5FO'),
('Mr.HBSKGXW', 'Mrs.SKRJRXU', '6057685668', 'xwdlkltw@gmail.com', 'Kolkata, India', '9YC36OAW9E95'),
('Mr.TOSNXNY', 'Mrs.RHHURTP', '1883213777', 'iammcgrw@gmail.com', 'Pune, India', '75XDVTF74KSX'),
('Mr.GARRCAC', 'Mrs.ATQDKVE', '7011261858', 'wczcohmn@gmail.com', 'Pune, India', 'HZ9CC4OM12AP'),
('Mr.AYHFDBW', 'Mrs.FKIJAES', '1810101093', 'wfjreuzo@gmail.com', 'Kolkata, India', '604UZC9QMZL2'),
('Mr.LDVKYWE', 'Mrs.LZNDPBQ', '2460275667', 'wzwemxxg@gmail.com', 'Lucknow, India', 'Y81VJT1P25AA'),
('Mr.KPBHWFH', 'Mrs.JOOSPNC', '7726607495', 'jqwqjblh@gmail.com', 'Mumbai, India', 'C69XYKEXZQV0'),
('Mr.KMTZIKJ', 'Mrs.PHYUADE', '8388269131', 'gqzhuqah@gmail.com', 'Delhi, India', 'O5QMPQARUGSE'),
('Mr.SGJPGQI', 'Mrs.ZWCPWAX', '0266675925', 'npgzjxok@gmail.com', 'Chennai, India', '8UVK0Y0NZGQF'),
('Mr.UWXTDPW', 'Mrs.KXCKXOJ', '8479636013', 'fnhdwcox@gmail.com', 'Pune, India', '7IV0GIGI0239'),
('Mr.RWXVYTD', 'Mrs.NMINWMK', '7354019739', 'hqwpazkk@gmail.com', 'Lucknow, India', 'MP1TEPWCD9YW'),
('Mr.YPIEPPE', 'Mrs.SANVUHM', '7638968989', 'cejwqfpz@gmail.com', 'Lucknow, India', 'ZV6JWI8PONSE'),
('Mr.BPHEJWQ', 'Mrs.HYLJEBJ', '7664158472', 'aaphfobs@gmail.com', 'Ahmedabad, India', 'M297GY8TJX8A'),
('Mr.WLRYSHS', 'Mrs.PTHADAG', '5344313048', 'ysiuwzsy@gmail.com', 'Ahmedabad, India', '4PBKTRE6K8S7'),
('Mr.ICLZJPE', 'Mrs.MJXSGXL', '5003677785', 'jmxalzix@gmail.com', 'Hyderabad, India', 'THYP9HD8Y14D'),
('Mr.NQQECYC', 'Mrs.KXQDHRZ', '3668000102', 'ufgnbudx@gmail.com', 'Lucknow, India', 'M7ROLO2GMFPX'),
('Mr.YPUNLUE', 'Mrs.ADROXNI', '1941325348', 'mjzryazh@gmail.com', 'Jaipur, India', '801T88G3GFFE'),
('Mr.PAJVICZ', 'Mrs.RJZZRGN', '7210656525', 'cklzdref@gmail.com', 'Jaipur, India', 'PT7O197CE8D9'),
('Mr.UUTQSTA', 'Mrs.QPYVRMH', '6949618785', 'juizmbqy@gmail.com', 'Delhi, India', 'KZ7IF1TI87YL'),
('Mr.LLCUYAE', 'Mrs.MIYOQVP', '0009197337', 'cyfqjend@gmail.com', 'Chennai, India', 'HDEVSQBHYWX7'),
('Mr.ETUAZUG', 'Mrs.NHKBQTS', '9312967499', 'ajrtckob@gmail.com', 'Pune, India', 'MN7K47W1APTX'),
('Mr.JSHPGND', 'Mrs.WJBMEJD', '8459037677', 'rmjvivkk@gmail.com', 'Pune, India', 'YAJFBYBEAPP3'),
('Mr.DFFHRFR', 'Mrs.QWVQOAL', '0282118939', 'wgvshjlm@gmail.com', 'Ahmedabad, India', 'DN42Y6JA5ZX0'),
('Mr.OLCKWAL', 'Mrs.ZKNLEJJ', '9699240649', 'njjvmwqt@gmail.com', 'Pune, India', '4EM2REWRQU2S'),
('Mr.DHYRHPV', 'Mrs.KMVZDYN', '2655540118', 'nrztorgv@gmail.com', 'Delhi, India', '6NVGUUNC5LCV'),
('Mr.QCHKIKF', 'Mrs.XFMCVTR', '6477706899', 'fqeevrrl@gmail.com', 'Ahmedabad, India', 'SAQUHU8AM4UW'),
('Mr.LONTYHU', 'Mrs.EFQSHAY', '7612344413', 'rbipvtmk@gmail.com', 'Kolkata, India', '3H95N5X4EYI3'),
('Mr.SSDHOEW', 'Mrs.FKVAFBJ', '7858290231', 'tdtbtjbb@gmail.com', 'Hyderabad, India', 'HZ805JUJGARJ'),
('Mr.THXRDAC', 'Mrs.WHZPEKL', '7948482235', 'iabqfesq@gmail.com', 'Jaipur, India', 'EWVIFZ4VQDUH'),
('Mr.QMZZBHQ', 'Mrs.OLZQGRB', '9254957516', 'epmhcuma@gmail.com', 'Jaipur, India', 'F4JZ0YE7041Z'),
('Mr.AQOWNEG', 'Mrs.QQLZOIV', '2617843055', 'hywlivae@gmail.com', 'Mumbai, India', 'EJ5R0O1FVEKQ'),
('Mr.UJXJJOG', 'Mrs.VZBVHFH', '5982947693', 'zpuvbyks@gmail.com', 'Ahmedabad, India', 'Y1702QC9HLZZ'),
('Mr.FLQWAGY', 'Mrs.ZGVAHMQ', '4526025298', 'ephjtcyc@gmail.com', 'Jaipur, India', 'JGEGI7LIQUZI'),
('Mr.AANGZGQ', 'Mrs.DNEQJCP', '4113962325', 'hmvgsyag@gmail.com', 'Hyderabad, India', 'OS0QLAELUPVS'),
('Mr.RILJAZY', 'Mrs.TORYQUD', '1302361417', 'cfqzromp@gmail.com', 'Kolkata, India', 'EEYMUK8WPRWM'),
('Mr.KGWGORI', 'Mrs.XSVUPPP', '5286043884', 'iihdfspy@gmail.com', 'Lucknow, India', '9F2IQMWJ2ATG'),
('Mr.MNOBMSI', 'Mrs.LLDKOCU', '4759443845', 'bkxbsbwh@gmail.com', 'Bangalore, India', 'PE89UBI7805D'),
('Mr.ABQNTBN', 'Mrs.UQDUGQC', '8299815201', 'kqdublfv@gmail.com', 'Pune, India', 'EPITLQVJ88OZ'),
('Mr.NBVRUAM', 'Mrs.YVXTYXE', '1541970745', 'qsbcbtpd@gmail.com', 'Kolkata, India', 'XIKF6FT0SD7A'),
('Mr.ALFOLLT', 'Mrs.LDSCINQ', '5800766720', 'zuyuussh@gmail.com', 'Lucknow, India', 'HIEGWKX6EONW'),
('Mr.NNIATNF', 'Mrs.RHJFSRI', '1646077262', 'bqtdtqhv@gmail.com', 'Delhi, India', 'PZ3QDXT1GKJV'),
('Mr.NDABLGW', 'Mrs.YUDIEZS', '5402395200', 'wnkhswpl@gmail.com', 'Lucknow, India', 'NUTQS8VHVH9A'),
('Mr.IKHYFSM', 'Mrs.CDLJDVK', '2398647889', 'mlwvffhy@gmail.com', 'Ahmedabad, India', 'VA8QGX2CLHCS'),
('Mr.BGJKSXF', 'Mrs.XLIMGWX', '3211045206', 'bxpgtbgv@gmail.com', 'Kolkata, India', 'ZBBWMR1LV39S'),
('Mr.JMVRZCD', 'Mrs.MTEOOPK', '5990636119', 'msnlfovo@gmail.com', 'Hyderabad, India', '9JUE0MG5NQFB'),
('Mr.UPTALBS', 'Mrs.ZBXDXVQ', '5196146713', 'dfljfmle@gmail.com', 'Pune, India', 'VYCR1BVMDXUR'),
('Mr.ZURQREJ', 'Mrs.GKTLVPJ', '7924746078', 'nluxhsgb@gmail.com', 'Lucknow, India', '6VGOA8EDAHGM'),
('Mr.LGHGBFU', 'Mrs.FUNHOOE', '9486542273', 'tpnrxhfs@gmail.com', 'Mumbai, India', 'XXV7KKWDUCWA'),
('Mr.QNUVAZW', 'Mrs.LVLQERH', '8303928881', 'ntzwpnyd@gmail.com', 'Chennai, India', 'R6CZVV73QA5D'),
('Mr.QVZJMTY', 'Mrs.CSWJYRE', '1845870469', 'iexoxzlc@gmail.com', 'Jaipur, India', 'OEK9U1JYM9JI'),
('Mr.YMPQVOR', 'Mrs.UNMYQTE', '0974339353', 'hdwmsnhd@gmail.com', 'Lucknow, India', '161U3FD1IZ39'),
('Mr.EOVNOUG', 'Mrs.UEYNKFQ', '7691855367', 'giczdzkl@gmail.com', 'Delhi, India', '7727X4CZUVG4'),
('Mr.GNEAIQA', 'Mrs.DQEXSFQ', '2332863692', 'tdjwzasi@gmail.com', 'Pune, India', 'NNMWAXA6AKSP'),
('Mr.RJCFKVC', 'Mrs.QMBVTAK', '4863572070', 'vsmyzpwt@gmail.com', 'Jaipur, India', 'CTJCRROW4DVI'),
('Mr.EITYHXF', 'Mrs.ONTXQLC', '5666926845', 'llmgacmz@gmail.com', 'Delhi, India', 'M45AN9TRXJI0'),
('Mr.BSMIBOH', 'Mrs.KLHGHLV', '7236136837', 'temgxqos@gmail.com', 'Kolkata, India', '558X4EKJ6PFT'),
('Mr.KWRILUC', 'Mrs.YJIJESJ', '5936394851', 'yglyykmo@gmail.com', 'Delhi, India', '8JU46P4TQCYW'),
('Mr.SQDVVVS', 'Mrs.SMMHLEG', '4907656865', 'cqwujoyf@gmail.com', 'Bangalore, India', 'NG7223WC66E4'),
('Mr.JSMQFFO', 'Mrs.ZMIVVGG', '9346653970', 'tdmhyory@gmail.com', 'Kolkata, India', 'HCPIH5ONWJQD'),
('Mr.LVPUOPQ', 'Mrs.DEHCNWK', '6388492646', 'ysmdbbwb@gmail.com', 'Delhi, India', 'F4IPE9PN84CK'),
('Mr.JDUBUUT', 'Mrs.RAZKWFQ', '1356332594', 'vztqnnue@gmail.com', 'Lucknow, India', 'X1EQHO7EEPFV'),
('Mr.RRLRMXZ', 'Mrs.PIFIMZP', '0210758315', 'zvckneqd@gmail.com', 'Delhi, India', 'WJUEUVUU6ICJ'),
('Mr.KWGMHNS', 'Mrs.PBHYJZF', '3241077637', 'dkqtgrrk@gmail.com', 'Delhi, India', '9SSFOJGW37WJ'),
('Mr.EWWMNBB', 'Mrs.SZVGYQS', '2857373825', 'kfnneddx@gmail.com', 'Pune, India', 'QZPG1UMALASO'),
('Mr.NDRMNCP', 'Mrs.COQILLY', '5796379367', 'byboyddn@gmail.com', 'Ahmedabad, India', 'J6CP20E8IBNY'),
('Mr.XNVHBSD', 'Mrs.CLAASFG', '4948429228', 'kkpqrbyx@gmail.com', 'Delhi, India', 'T3Q0X2NMTKK4'),
('Mr.WVGKDJE', 'Mrs.YCMUVAS', '4290957464', 'lezssgnq@gmail.com', 'Mumbai, India', '3HQUSHIT0HMP'),
('Mr.COGTNQD', 'Mrs.FOCVEDQ', '2918815150', 'nxybhbft@gmail.com', 'Jaipur, India', 'G2IL65YP94QF'),
('Mr.QZCUARZ', 'Mrs.ACLNMHF', '1529642855', 'bxasxhpy@gmail.com', 'Pune, India', 'LXQYGECHPYLM'),
('Mr.DSLNVNR', 'Mrs.URYMURL', '9781430816', 'jmkzcobt@gmail.com', 'Ahmedabad, India', 'Z1QTNDRVYB82'),
('Mr.HWLEIUL', 'Mrs.VJYEJZZ', '9389102182', 'nrllqnve@gmail.com', 'Pune, India', 'V3UNJ6QNW1KO'),
('Mr.EKFAJFR', 'Mrs.ILQYBKQ', '1518231685', 'burpnldk@gmail.com', 'Ahmedabad, India', 'IAETBB0OEPPC'),
('Mr.JBCHQAK', 'Mrs.MQFVRLY', '5267553491', 'stybyeed@gmail.com', 'Lucknow, India', 'WUWGFK3SS1JD'),
('Mr.SNMWSPF', 'Mrs.JTJYROM', '2043795607', 'vfnvwxmn@gmail.com', 'Chennai, India', '2618OKD06QTQ'),
('Mr.IMNITJO', 'Mrs.KAPDLAE', '9136207286', 'vlfalmdz@gmail.com', 'Kolkata, India', 'L0IYBMLVX69I'),
('Mr.MBIGERG', 'Mrs.CCJFZZU', '7100989113', 'emvombmt@gmail.com', 'Chennai, India', '0IJVYV68TCL9'),
('Mr.GKLTYHA', 'Mrs.XTQUCJZ', '2208637819', 'wxfeuwaw@gmail.com', 'Delhi, India', 'Z30KP68BAENE'),
('Mr.PEHFLPU', 'Mrs.BPMRCVB', '1263348626', 'knjidaue@gmail.com', 'Jaipur, India', 'F0FKIYFVUAX7'),
('Mr.AWEKYXE', 'Mrs.HIFPDBT', '7785394428', 'hobejfyl@gmail.com', 'Delhi, India', '9N8RBZT7E0O6'),
('Mr.YWBJIAC', 'Mrs.NVDRGMF', '2812014215', 'diztljed@gmail.com', 'Chennai, India', 'XBHB2XDI09U4'),
('Mr.OWASXQG', 'Mrs.VJLPBBR', '2710607205', 'owpztxps@gmail.com', 'Pune, India', 'GEIMPS6SVP08'),
('Mr.QCUMLTT', 'Mrs.JRYKKPJ', '0059775837', 'hhexsunl@gmail.com', 'Ahmedabad, India', '1F5TM5U7CDXS'),
('Mr.WJQMSCI', 'Mrs.MEWMGBH', '9628550860', 'eyqklfeg@gmail.com', 'Jaipur, India', 'OG992UAI3N97'),
('Mr.ATXIZJB', 'Mrs.QQCPXKB', '3825052391', 'hvsdcqvv@gmail.com', 'Mumbai, India', 'RP6SUVGSSUMT'),
('Mr.QMAGWCB', 'Mrs.WTRMYNS', '9658242192', 'stwztxyr@gmail.com', 'Lucknow, India', '68D50O98OSS1'),
('Mr.CPASPKM', 'Mrs.SSVIRCK', '4580997903', 'xvwnlklc@gmail.com', 'Jaipur, India', 'IK470ADNTRR0'),
('Mr.OWPGQXA', 'Mrs.IIVXXZB', '2122646573', 'fsefoujj@gmail.com', 'Bangalore, India', 'BDTM2QQK5761'),
('Mr.TUBKBLC', 'Mrs.EYCLEJA', '0773722595', 'qyhhpfwr@gmail.com', 'Mumbai, India', '1K6FUMGHF11U'),
('Mr.DZRVGBE', 'Mrs.JTTANVT', '8712282828', 'zhgokkge@gmail.com', 'Chennai, India', '9MR4G4A290HZ'),
('Mr.DVMQQCA', 'Mrs.CGVQSWT', '1843874921', 'hfrtjpba@gmail.com', 'Delhi, India', 'YV9N7PF1X3F4'),
('Mr.KAAERJR', 'Mrs.PXNEFIB', '7523082432', 'lyfacseu@gmail.com', 'Jaipur, India', 'M0MHOXA7VFKY'),
('Mr.CXYRURI', 'Mrs.WTUZJAR', '4498665114', 'ieavplfc@gmail.com', 'Lucknow, India', 'S7GSGGI04V72'),
('Mr.VGOCMRZ', 'Mrs.XGDHQZA', '4554121745', 'uslwgldd@gmail.com', 'Bangalore, India', 'S90JYRZG58S9'),
('Mr.QBRZYVX', 'Mrs.GOEVOJD', '3984682400', 'vcbriols@gmail.com', 'Kolkata, India', 'T13X0432BPAS'),
('Mr.ZDKRRIK', 'Mrs.YRFTMXP', '3979765962', 'uesjqmcy@gmail.com', 'Pune, India', 'MTCZG7PRVOBY'),
('Mr.VDGYMAR', 'Mrs.HYDIINO', '8137577123', 'ngphbjou@gmail.com', 'Mumbai, India', 'V3J9L5I1416C');
```

```sql
-- =============================================
-- 4.) AADHAAR CARD TABLE (100 entries)
-- =============================================

INSERT INTO "CreateSchema".adhaar_card (Acc_no, Adhaar_card)
VALUES
('QCEP6AUJS2N8', '4502-4674-2303'),
('WYQHDUQC8L1D', '1640-7615-9818'),
('TTMRTRLDI3RZ', '4065-5917-8932'),
('FY7K9JA1GQJU', '9627-2856-5760'),
('SFCNOQPGQ5FO', '1558-1556-2915'),
('9YC36OAW9E95', '7259-7960-9778'),
('75XDVTF74KSX', '1452-6600-0021'),
('HZ9CC4OM12AP', '6069-8058-2530'),
('604UZC9QMZL2', '9659-6877-4529'),
('Y81VJT1P25AA', '0388-1897-0678'),
('C69XYKEXZQV0', '2440-8000-5545'),
('O5QMPQARUGSE', '3267-3343-2008'),
('8UVK0Y0NZGQF', '6489-2168-8028'),
('7IV0GIGI0239', '3685-0454-3801'),
('MP1TEPWCD9YW', '0645-1809-5764'),
('ZV6JWI8PONSE', '6496-0569-1568'),
('M297GY8TJX8A', '1301-1607-0017'),
('4PBKTRE6K8S7', '6757-6243-0658'),
('THYP9HD8Y14D', '0549-8503-2947'),
('M7ROLO2GMFPX', '3943-6536-3913'),
('801T88G3GFFE', '9609-3375-5941'),
('PT7O197CE8D9', '8196-5208-4080'),
('KZ7IF1TI87YL', '6864-3931-8576'),
('HDEVSQBHYWX7', '4839-9317-5280'),
('MN7K47W1APTX', '7289-0779-5584'),
('YAJFBYBEAPP3', '2450-2995-2637'),
('DN42Y6JA5ZX0', '6170-6460-7505'),
('4EM2REWRQU2S', '9802-8173-1765'),
('6NVGUUNC5LCV', '1998-5078-0365'),
('SAQUHU8AM4UW', '3068-1957-0000'),
('3H95N5X4EYI3', '5007-4594-9410'),
('HZ805JUJGARJ', '0537-0326-0941'),
('EWVIFZ4VQDUH', '4467-8260-0439'),
('F4JZ0YE7041Z', '3322-8993-0979'),
('EJ5R0O1FVEKQ', '6837-5373-6254'),
('Y1702QC9HLZZ', '5125-5244-2815'),
('JGEGI7LIQUZI', '5532-0542-8357'),
('OS0QLAELUPVS', '0945-4361-8096'),
('EEYMUK8WPRWM', '0062-6501-6891'),
('9F2IQMWJ2ATG', '4576-3305-6843'),
('PE89UBI7805D', '9863-3259-3992'),
('EPITLQVJ88OZ', '3278-8080-7997'),
('XIKF6FT0SD7A', '7436-2303-5809'),
('HIEGWKX6EONW', '1965-1989-3842'),
('PZ3QDXT1GKJV', '2603-4472-8348'),
('NUTQS8VHVH9A', '5342-0454-9707'),
('VA8QGX2CLHCS', '8574-3753-4324'),
('ZBBWMR1LV39S', '5430-5951-8027'),
('9JUE0MG5NQFB', '9566-3000-3613'),
('VYCR1BVMDXUR', '1727-6124-8974'),
('6VGOA8EDAHGM', '4720-0452-2804'),
('XXV7KKWDUCWA', '1442-6277-7829'),
('R6CZVV73QA5D', '1261-3040-6051'),
('OEK9U1JYM9JI', '7463-4605-9375'),
('161U3FD1IZ39', '9592-7046-8248'),
('7727X4CZUVG4', '5166-5040-8609'),
('NNMWAXA6AKSP', '7765-0641-0444'),
('CTJCRROW4DVI', '0317-7997-0296'),
('M45AN9TRXJI0', '3721-6749-7430'),
('558X4EKJ6PFT', '7783-5538-1424'),
('8JU46P4TQCYW', '1302-4107-4633'),
('NG7223WC66E4', '4311-5223-1859'),
('HCPIH5ONWJQD', '0539-7118-7447'),
('F4IPE9PN84CK', '2914-3047-0551'),
('X1EQHO7EEPFV', '7021-8925-1859'),
('WJUEUVUU6ICJ', '7105-3239-2178'),
('9SSFOJGW37WJ', '1758-6937-1947'),
('QZPG1UMALASO', '9101-1314-1066'),
('J6CP20E8IBNY', '9994-5404-3849'),
('T3Q0X2NMTKK4', '8498-0788-8061'),
('3HQUSHIT0HMP', '9601-5606-7120'),
('G2IL65YP94QF', '9901-9144-9430'),
('LXQYGECHPYLM', '3169-8699-5113'),
('Z1QTNDRVYB82', '2261-9990-9961'),
('V3UNJ6QNW1KO', '6708-8819-4039'),
('IAETBB0OEPPC', '7985-3717-2303'),
('WUWGFK3SS1JD', '6651-0296-9328'),
('2618OKD06QTQ', '3293-9428-6441'),
('L0IYBMLVX69I', '1163-5024-7371'),
('0IJVYV68TCL9', '0506-2344-6468'),
('Z30KP68BAENE', '7450-6128-8129'),
('F0FKIYFVUAX7', '1617-1615-4224'),
('9N8RBZT7E0O6', '4851-0038-1394'),
('XBHB2XDI09U4', '4138-1420-2398'),
('GEIMPS6SVP08', '8944-6820-2871'),
('1F5TM5U7CDXS', '8908-6851-4200'),
('OG992UAI3N97', '4303-5504-8263'),
('RP6SUVGSSUMT', '6055-7716-9541'),
('68D50O98OSS1', '6793-3288-9795'),
('IK470ADNTRR0', '8390-8172-0304'),
('BDTM2QQK5761', '6923-7888-8929'),
('1K6FUMGHF11U', '7053-6803-3312'),
('9MR4G4A290HZ', '2234-1605-7352'),
('YV9N7PF1X3F4', '1502-0705-4694'),
('M0MHOXA7VFKY', '8093-4860-0004'),
('S7GSGGI04V72', '6692-1955-1690'),
('S90JYRZG58S9', '7165-5791-6606'),
('T13X0432BPAS', '6627-3731-2082'),
('MTCZG7PRVOBY', '6888-1004-5938'),
('V3J9L5I1416C', '3695-0483-5644');
```

```sql
-- =============================================
-- 5.) PAN CARD TABLE (100 entries)
-- =============================================

INSERT INTO "CreateSchema".pan_card (Acc_no, Pan_card)
VALUES
('QCEP6AUJS2N8', 'SHLNR2796B'),
('WYQHDUQC8L1D', 'LDTWU1233L'),
('TTMRTRLDI3RZ', 'TCPVX4659L'),
('FY7K9JA1GQJU', 'NSOQA3468Y'),
('SFCNOQPGQ5FO', 'LIZKB9307F'),
('9YC36OAW9E95', 'QAUAZ2985N'),
('75XDVTF74KSX', 'VWUBZ4654U'),
('HZ9CC4OM12AP', 'FMGIG0373M'),
('604UZC9QMZL2', 'IAPVK8437G'),
('Y81VJT1P25AA', 'YIXHK3094E'),
('C69XYKEXZQV0', 'KGKLD8466O'),
('O5QMPQARUGSE', 'JCNJZ3651E'),
('8UVK0Y0NZGQF', 'WLNYV5248K'),
('7IV0GIGI0239', 'NRCHZ8508M'),
('MP1TEPWCD9YW', 'EYGDS7048P'),
('ZV6JWI8PONSE', 'FZVYM3546G'),
('M297GY8TJX8A', 'LCUXE0559S'),
('4PBKTRE6K8S7', 'XDLGT0540T'),
('THYP9HD8Y14D', 'BWDJX3110H'),
('M7ROLO2GMFPX', 'ZUNDT2596R'),
('801T88G3GFFE', 'PVNMG4873W'),
('PT7O197CE8D9', 'KHHHW2600Q'),
('KZ7IF1TI87YL', 'BTICU5973M'),
('HDEVSQBHYWX7', 'QSYBS9490D'),
('MN7K47W1APTX', 'GJCYG6731L'),
('YAJFBYBEAPP3', 'RVAFG6383R'),
('DN42Y6JA5ZX0', 'VMHNI2321V'),
('4EM2REWRQU2S', 'WOCLK2905U'),
('6NVGUUNC5LCV', 'RRRQU2319I'),
('SAQUHU8AM4UW', 'YTOSD3182A'),
('3H95N5X4EYI3', 'URMUA2444W'),
('HZ805JUJGARJ', 'WTHNA5799F'),
('EWVIFZ4VQDUH', 'NSZOE1595L'),
('F4JZ0YE7041Z', 'SGUMK5174I'),
('EJ5R0O1FVEKQ', 'YBRPP0684O'),
('Y1702QC9HLZZ', 'ASLQQ0233R'),
('JGEGI7LIQUZI', 'DSAQJ4029V'),
('OS0QLAELUPVS', 'ORTIK3314Q'),
('EEYMUK8WPRWM', 'WQMZE6934T'),
('9F2IQMWJ2ATG', 'RLJCE5005Y'),
('PE89UBI7805D', 'MPSAX3172J'),
('EPITLQVJ88OZ', 'XQOXL2663K'),
('XIKF6FT0SD7A', 'PEMJS6515M'),
('HIEGWKX6EONW', 'UYVBN6817F'),
('PZ3QDXT1GKJV', 'MQIMV5737D'),
('NUTQS8VHVH9A', 'BRPON6791Y'),
('VA8QGX2CLHCS', 'CKZAB5495S'),
('ZBBWMR1LV39S', 'UTHCX2890C'),
('9JUE0MG5NQFB', 'IUGWU3802C'),
('VYCR1BVMDXUR', 'YNMQM0421Q'),
('6VGOA8EDAHGM', 'QWEBM6603C'),
('XXV7KKWDUCWA', 'ZFEMP4893A'),
('R6CZVV73QA5D', 'ZFSCS1086H'),
('OEK9U1JYM9JI', 'JTZMF6630U'),
('161U3FD1IZ39', 'NNWUT4422M'),
('7727X4CZUVG4', 'REUVX1347V'),
('NNMWAXA6AKSP', 'CKEXU6143F'),
('CTJCRROW4DVI', 'DDNUB7082A'),
('M45AN9TRXJI0', 'NCCZR2244Q'),
('558X4EKJ6PFT', 'IAVNC7301L'),
('8JU46P4TQCYW', 'PJVQG3487X'),
('NG7223WC66E4', 'LBTJF7964P'),
('HCPIH5ONWJQD', 'DKCDJ0588M'),
('F4IPE9PN84CK', 'YJQEY9887S'),
('X1EQHO7EEPFV', 'OVEKP4227Z'),
('WJUEUVUU6ICJ', 'VMZZF9070S'),
('9SSFOJGW37WJ', 'OLKLI8530N'),
('QZPG1UMALASO', 'DJFPK0760J'),
('J6CP20E8IBNY', 'JIMCO1734H'),
('T3Q0X2NMTKK4', 'DOYQV2377I'),
('3HQUSHIT0HMP', 'EFCOA5142L'),
('G2IL65YP94QF', 'LWDNN4556K'),
('LXQYGECHPYLM', 'SSZJM1526Z'),
('Z1QTNDRVYB82', 'IOOEA8811R'),
('V3UNJ6QNW1KO', 'HGORB0695A'),
('IAETBB0OEPPC', 'DUHHO2651V'),
('WUWGFK3SS1JD', 'NFFMI4951E'),
('2618OKD06QTQ', 'IQUVE7334E'),
('L0IYBMLVX69I', 'DGYVA2364I'),
('0IJVYV68TCL9', 'JDQLD4823Y'),
('Z30KP68BAENE', 'PZXUO7097M'),
('F0FKIYFVUAX7', 'XSIMX4226D'),
('9N8RBZT7E0O6', 'GSETB9907G'),
('XBHB2XDI09U4', 'CLOIH7317T'),
('GEIMPS6SVP08', 'BSEDT2613G'),
('1F5TM5U7CDXS', 'OFWVG4188M'),
('OG992UAI3N97', 'QDNQZ2603M'),
('RP6SUVGSSUMT', 'FMRUX3356C'),
('68D50O98OSS1', 'PARKP7144L'),
('IK470ADNTRR0', 'XMGUR6841M'),
('BDTM2QQK5761', 'MFIWT2724H'),
('1K6FUMGHF11U', 'VZNZQ1391I'),
('9MR4G4A290HZ', 'SMNSK9606T'),
('YV9N7PF1X3F4', 'HFAFE7773K'),
('M0MHOXA7VFKY', 'BCNFC5931W'),
('S7GSGGI04V72', 'HXEWV9125G'),
('S90JYRZG58S9', 'VVEKR5313E'),
('T13X0432BPAS', 'PCAVT6529V'),
('MTCZG7PRVOBY', 'CEWYJ4705K'),
('V3J9L5I1416C', 'EJHVH5797I');
```

```sql
-- =============================================
-- 6.) TRANSACTION TABLE (100 entries)
-- =============================================

INSERT INTO "CreateSchema".transaction (Acc_no, Amount_deposited, Amount_withdrawed)
VALUES
('QCEP6AUJS2N8', 69570, 14093),
('WYQHDUQC8L1D', 50426, 23462),
('TTMRTRLDI3RZ', 23533, 47080),
('FY7K9JA1GQJU', 54807, 37740),
('SFCNOQPGQ5FO', 66761, 7192),
('9YC36OAW9E95', 77607, 8611),
('75XDVTF74KSX', 33300, 49969),
('HZ9CC4OM12AP', 41801, 19365),
('604UZC9QMZL2', 81748, 40739),
('Y81VJT1P25AA', 7132, 19417),
('C69XYKEXZQV0', 63322, 5164),
('O5QMPQARUGSE', 5471, 48691),
('8UVK0Y0NZGQF', 68393, 16563),
('7IV0GIGI0239', 54175, 47479),
('MP1TEPWCD9YW', 1537, 39641),
('ZV6JWI8PONSE', 20989, 6837),
('M297GY8TJX8A', 80396, 13687),
('4PBKTRE6K8S7', 37092, 33412),
('THYP9HD8Y14D', 50184, 38686),
('M7ROLO2GMFPX', 61828, 44374),
('801T88G3GFFE', 38205, 37100),
('PT7O197CE8D9', 74634, 39195),
('KZ7IF1TI87YL', 50994, 35336),
('HDEVSQBHYWX7', 60070, 38429),
('MN7K47W1APTX', 51862, 12731),
('YAJFBYBEAPP3', 70137, 17611),
('DN42Y6JA5ZX0', 5839, 13620),
('4EM2REWRQU2S', 69638, 42510),
('6NVGUUNC5LCV', 63436, 13902),
('SAQUHU8AM4UW', 67374, 25110),
('3H95N5X4EYI3', 15685, 29006),
('HZ805JUJGARJ', 69853, 37730),
('EWVIFZ4VQDUH', 55782, 19915),
('F4JZ0YE7041Z', 1871, 12282),
('EJ5R0O1FVEKQ', 23044, 30646),
('Y1702QC9HLZZ', 59322, 9776),
('JGEGI7LIQUZI', 24696, 8815),
('OS0QLAELUPVS', 13540, 24736),
('EEYMUK8WPRWM', 74469, 24687),
('9F2IQMWJ2ATG', 29498, 4195),
('PE89UBI7805D', 8222, 44255),
('EPITLQVJ88OZ', 5545, 2772),
('XIKF6FT0SD7A', 53922, 19930),
('HIEGWKX6EONW', 73558, 37071),
('PZ3QDXT1GKJV', 59772, 12604),
('NUTQS8VHVH9A', 90155, 3468),
('VA8QGX2CLHCS', 10371, 21909),
('ZBBWMR1LV39S', 96422, 32956),
('9JUE0MG5NQFB', 12859, 44702),
('VYCR1BVMDXUR', 45021, 10338),
('6VGOA8EDAHGM', 79218, 21499),
('XXV7KKWDUCWA', 61180, 3110),
('R6CZVV73QA5D', 62045, 16899),
('OEK9U1JYM9JI', 65226, 26496),
('161U3FD1IZ39', 65161, 27615),
('7727X4CZUVG4', 74061, 2394),
('NNMWAXA6AKSP', 30500, 37301),
('CTJCRROW4DVI', 35818, 24353),
('M45AN9TRXJI0', 66545, 29550),
('558X4EKJ6PFT', 41372, 9341),
('8JU46P4TQCYW', 78472, 7124),
('NG7223WC66E4', 61205, 45700),
('HCPIH5ONWJQD', 34889, 14291),
('F4IPE9PN84CK', 49271, 1690),
('X1EQHO7EEPFV', 99231, 21429),
('WJUEUVUU6ICJ', 24824, 21035),
('9SSFOJGW37WJ', 10216, 4260),
('QZPG1UMALASO', 57804, 26153),
('J6CP20E8IBNY', 15651, 44704),
('T3Q0X2NMTKK4', 73282, 20714),
('3HQUSHIT0HMP', 18192, 37356),
('G2IL65YP94QF', 99897, 29083),
('LXQYGECHPYLM', 63857, 28219),
('Z1QTNDRVYB82', 52965, 32560),
('V3UNJ6QNW1KO', 49303, 39869),
('IAETBB0OEPPC', 70358, 29450),
('WUWGFK3SS1JD', 56982, 44991),
('2618OKD06QTQ', 84803, 39430),
('L0IYBMLVX69I', 21867, 24088),
('0IJVYV68TCL9', 83747, 15243),
('Z30KP68BAENE', 31421, 35257),
('F0FKIYFVUAX7', 20176, 37411),
('9N8RBZT7E0O6', 35039, 35011),
('XBHB2XDI09U4', 87062, 10679),
('GEIMPS6SVP08', 93079, 5377),
('1F5TM5U7CDXS', 35863, 16009),
('OG992UAI3N97', 51779, 41795),
('RP6SUVGSSUMT', 22382, 12416),
('68D50O98OSS1', 28945, 40924),
('IK470ADNTRR0', 89450, 48353),
('BDTM2QQK5761', 24696, 17830),
('1K6FUMGHF11U', 18780, 47810),
('9MR4G4A290HZ', 22421, 42962),
('YV9N7PF1X3F4', 7510, 48375),
('M0MHOXA7VFKY', 94109, 21911),
('S7GSGGI04V72', 93909, 29387),
('S90JYRZG58S9', 81968, 36560),
('T13X0432BPAS', 71708, 15131),
('MTCZG7PRVOBY', 28082, 1773),
('V3J9L5I1416C', 77702, 21315);
```

---

## Important Notes

### ✅ Key Points to Remember

1. **Schema Setup**: Always create the schema first using the schema creation script
2. **Execution Order**: Create tables in this order for proper foreign key relationships:
   - bank_records (parent table)
   - cards, customer, adhaar_card, pan_card, transaction (child tables)

3. **Fixed Issues**:
   - Changed `transcation` to `transaction` for correct spelling
   - Fixed case consistency in Foreign Key references (acc_no → Acc_no)
   - Date format should be YYYY-MM-DD for PostgreSQL

4. **Table Relationships**:
   - All tables use `bank_records.Acc_no` as the primary reference
   - Maintains referential integrity through Foreign Key constraints
   - Supports cascading operations for data consistency

5. **Data Validation**:
   - Verify all 100 records per table are inserted correctly using:
     ```sql
     SELECT COUNT(*) FROM "CreateSchema".bank_records;
     SELECT COUNT(*) FROM "CreateSchema".cards;
     SELECT COUNT(*) FROM "CreateSchema".customer;
     SELECT COUNT(*) FROM "CreateSchema".adhaar_card;
     SELECT COUNT(*) FROM "CreateSchema".pan_card;
     SELECT COUNT(*) FROM "CreateSchema".transaction;
     ```

6. **Useful Queries**:
   - List all tables: `\dt "CreateSchema".*`
   - View table structure: `\d "CreateSchema".bank_records`
   - Check unique constraints: `SELECT * FROM information_schema.constraint_column_usage WHERE table_name = 'bank_records';`

---

## Quick Reference

| Table | Records | Primary Key | Foreign Keys |
|-------|---------|------------|--------------|
| bank_records | 100 | Acc_no | None (Parent) |
| cards | 100 | None | Acc_no → bank_records |
| customer | 100 | None | Acc_no → bank_records |
| adhaar_card | 100 | Adhaar_card | Acc_no → bank_records |
| pan_card | 100 | Pan_card | Acc_no → bank_records |
| transaction | 100 | None | Acc_no → bank_records |

---

**Total Data**: 600+ records across 6 tables with proper normalization and constraints.
