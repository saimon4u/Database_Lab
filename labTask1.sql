CREATE TABLE branch (
    branch_name varchar2(30),
    branch_city varchar2(30),
    assets number(15),
    CONSTRAINT branch_pk PRIMARY KEY (branch_name)
);

CREATE TABLE customer (
    customer_name varchar2(30),
    customer_street varchar2(30),
    customer_city varchar2(30),
    CONSTRAINT customer_pk PRIMARY KEY(customer_name)
);


CREATE TABLE loan(
    loan_number number(15),
    branch_name varchar2(30),
    amount number(15),
    CONSTRAINT loan_pk PRIMARY KEY(loan_number),
    CONSTRAINT loan_fk FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
);


CREATE TABLE account (
    account_number number(20),
    branch_name varchar2(30),
    balance number(15),
    CONSTRAINT account_pk PRIMARY KEY(account_number),
    CONSTRAINT account_fk FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
);

CREATE TABLE depositor(
    customer_name varchar2(30),
    account_number number(20),
    CONSTRAINT depositor_pk PRIMARY KEY(customer_name,account_number)
);


CREATE TABLE borrower(
    customer_name varchar2(30),
    loan_number number(15),
    CONSTRAINT borrower_pk PRIMARY KEY(customer_name, loan_number)
);


INSERT INTO branch  VALUES ('DhakaMainBranch', 'Dhaka', 1500000);
INSERT INTO branch  VALUES ('ChittagongBranch', 'Chittagong', 1200000);
INSERT INTO branch  VALUES ('SylhetBranch', 'Sylhet', 900000);
INSERT INTO branch  VALUES ('RajshahiBranch', 'Rajshahi', 800000);
INSERT INTO branch  VALUES ('KhulnaBranch', 'Khulna', 700000);
INSERT INTO branch  VALUES ('BarisalBranch', 'Barisal', 600000);
INSERT INTO branch  VALUES ('RangpurBranch', 'Rangpur', 500000);
INSERT INTO branch  VALUES ('ComillaBranch', 'Comilla', 400000);
INSERT INTO branch  VALUES ('JessoreBranch', 'Jessore', 300000);
INSERT INTO branch  VALUES ('BograBranch', 'Bogra', 200000);

INSERT INTO customer  VALUES ('Md. Rahman', '123 Main Rd', 'Dhaka');
INSERT INTO customer  VALUES ('Fatima Akhter', '456 Hill Rd', 'Chittagong');
INSERT INTO customer  VALUES ('Abdul Ali', '789 Valley Rd', 'Sylhet');
INSERT INTO customer  VALUES ('Nusrat Jahan', '101 River Rd', 'Rajshahi');
INSERT INTO customer  VALUES ('Kamal Hasan', '202 Ocean Rd', 'Khulna');
INSERT INTO customer  VALUES ('Nazia Ahmed', '303 Lake Rd', 'Barisal');
INSERT INTO customer  VALUES ('Rahim Khan', '404 Forest Rd', 'Rangpur');
INSERT INTO customer  VALUES ('Ayesha Khan', '505 Park Rd', 'Comilla');
INSERT INTO customer  VALUES ('Moinul Islam', '606 Garden Rd', 'Jessore');
INSERT INTO customer  VALUES ('Farida Begum', '707 Sky Rd', 'Bogra');

INSERT INTO loan  VALUES (101, 'DhakaMainBranch', 50000);
INSERT INTO loan  VALUES (102, 'ChittagongBranch', 75000);
INSERT INTO loan  VALUES (103, 'SylhetBranch', 100000);
INSERT INTO loan  VALUES (104, 'RajshahiBranch', 120000);
INSERT INTO loan  VALUES (105, 'KhulnaBranch', 90000);
INSERT INTO loan  VALUES (106, 'BarisalBranch', 60000);
INSERT INTO loan  VALUES (107, 'RangpurBranch', 80000);
INSERT INTO loan  VALUES (108, 'ComillaBranch', 70000);
INSERT INTO loan  VALUES (109, 'JessoreBranch', 40000);
INSERT INTO loan  VALUES (110, 'BograBranch', 30000);

INSERT INTO account  VALUES (10001, 'DhakaMainBranch', 150000);
INSERT INTO account  VALUES (10002, 'ChittagongBranch', 200000);
INSERT INTO account  VALUES (10003, 'SylhetBranch', 100000);
INSERT INTO account  VALUES (10004, 'RajshahiBranch', 120000);
INSERT INTO account  VALUES (10005, 'KhulnaBranch', 70000);
INSERT INTO account  VALUES (10006, 'BarisalBranch', 90000);
INSERT INTO account  VALUES (10007, 'RangpurBranch', 80000);
INSERT INTO account  VALUES (10008, 'ComillaBranch', 50000);
INSERT INTO account  VALUES (10009, 'JessoreBranch', 30000);
INSERT INTO account  VALUES (10010, 'BograBranch', 40000);

INSERT INTO depositor  VALUES ('Md. Rahman', 10001);
INSERT INTO depositor  VALUES ('Fatima Akhter', 10002);
INSERT INTO depositor  VALUES ('Abdul Ali', 10003);
INSERT INTO depositor  VALUES ('Nusrat Jahan', 10004);
INSERT INTO depositor  VALUES ('Kamal Hasan', 10005);
INSERT INTO depositor  VALUES ('Nazia Ahmed', 10006);
INSERT INTO depositor  VALUES ('Rahim Khan', 10007);
INSERT INTO depositor  VALUES ('Ayesha Khan', 10008);
INSERT INTO depositor  VALUES ('Moinul Islam', 10009);
INSERT INTO depositor  VALUES ('Farida Begum', 10010);

INSERT INTO borrower  VALUES ('Md. Rahman', 101);
INSERT INTO borrower  VALUES ('Fatima Akhter', 102);
INSERT INTO borrower  VALUES ('Abdul Ali', 103);
INSERT INTO borrower  VALUES ('Nusrat Jahan', 104);
INSERT INTO borrower  VALUES ('Kamal Hasan', 105);
INSERT INTO borrower  VALUES ('Nazia Ahmed', 106);
INSERT INTO borrower  VALUES ('Rahim Khan', 107);
INSERT INTO borrower  VALUES ('Ayesha Khan', 108);
INSERT INTO borrower  VALUES ('Moinul Islam', 109);
INSERT INTO borrower  VALUES ('Farida Begum', 110);