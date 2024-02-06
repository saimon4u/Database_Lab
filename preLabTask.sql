/*
Creating all the table sequentially
*/

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

/*
Droping all the table sequentially
*/
DROP TABLE borrower;
DROP TABLE depositor;
DROP TABLE account;
DROP TABLE loan;
DROP TABLE customer;
DROP TABLE branch;


/*
Executing another sql script
*/

@D:\My_Files\Academic\Semester_4\Database_Lab\labTask1.sql