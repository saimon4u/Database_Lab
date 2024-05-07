DROP TABLE borrower;
DROP TABLE depositor;
DROP TABLE loan;
DROP TABLE account;
DROP TABLE customer;
DROP TABLE branch;

CREATE TABLE branch (
    branch_name varchar2(30),
    branch_city varchar2(30),
    assets number(15),
    CONSTRAINT branch_pk PRIMARY KEY (branch_name)
);

CREATE TABLE customer(
    customer_name varchar2(30),
    customer_street varchar2(30),
    customer_city varchar2(30),
    CONSTRAINT customer_pk PRIMARY KEY(customer_name)
);


CREATE TABLE loan(
    loan_number varchar2(15),
    branch_name varchar2(30),
    amount number(15),
    CONSTRAINT loan_pk PRIMARY KEY(loan_number),
    CONSTRAINT loan_fk FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
);


CREATE TABLE account (
    account_number varchar2(20),
    branch_name varchar2(30),
    balance number(15),
    CONSTRAINT account_pk PRIMARY KEY(account_number),
    CONSTRAINT account_fk FOREIGN KEY(branch_name) REFERENCES branch(branch_name)
);

CREATE TABLE depositor(
    customer_name varchar2(30),
    account_number varchar2(20),
    CONSTRAINT depositor_pk PRIMARY KEY(customer_name,account_number)
);


CREATE TABLE borrower(
    customer_name varchar2(30),
    loan_number varchar2(15),
    CONSTRAINT borrower_pk PRIMARY KEY(customer_name, loan_number)
);

INSERT INTO branch  VALUES ('Brighton', 'Brooklyn', 7100000);
INSERT INTO branch  VALUES ('Downtown', 'Brooklyn', 9000000);
INSERT INTO branch  VALUES ('Mianus', 'Horseneck', 400000);
INSERT INTO branch  VALUES ('North Town', 'Rye', 3700000);
INSERT INTO branch  VALUES ('Perryridge', 'Horseneck', 1700000);
INSERT INTO branch  VALUES ('Pownal', 'Bennington', 300000);
INSERT INTO branch  VALUES ('Redwood', 'Palo Alto', 2100000);
INSERT INTO branch  VALUES ('Round Hill', 'Horseneck', 8000000);

INSERT INTO customer  VALUES ('Adams', 'Spring', 'Pittsfield');
INSERT INTO customer  VALUES ('Brooks', 'Senator', 'Brooklyn');
INSERT INTO customer  VALUES ('Curry', 'North', 'Rye');
INSERT INTO customer  VALUES ('Glenn', 'Sand Hill', 'Woodside');
INSERT INTO customer  VALUES ('Green', 'Walnut', 'Stamford');
INSERT INTO customer  VALUES ('Hayes', 'Main', 'Harrison');
INSERT INTO customer  VALUES ('Johnson', 'Alma', 'Palo Alto');
INSERT INTO customer  VALUES ('Jones', 'Main', 'Harrison');
INSERT INTO customer  VALUES ('Lindsay', 'Park', 'Pittsfield');
INSERT INTO customer  VALUES ('Smith', 'North', 'Rye');
INSERT INTO customer  VALUES ('Turner', 'Putnam', 'Stamford');
INSERT INTO customer  VALUES ('Williams', '707 Sky Rd', 'Princeton');

INSERT INTO loan  VALUES ('L-11', 'Round Hill', 900);
INSERT INTO loan  VALUES ('L-14', 'Downtown', 1500);
INSERT INTO loan  VALUES ('L-15', 'Perryridge', 1500);
INSERT INTO loan  VALUES ('L-17', 'Perryridge', 1300);
INSERT INTO loan  VALUES ('L-23', 'Redwood', 2000);
INSERT INTO loan  VALUES ('L-93', 'Mianus', 500);

INSERT INTO account  VALUES ('A-101', 'Downtown', 500);
INSERT INTO account  VALUES ('A-102', 'Perryridge', 400);
INSERT INTO account  VALUES ('A-201', 'Brighton', 900);
INSERT INTO account  VALUES ('A-215', 'Mianus', 700);
INSERT INTO account  VALUES ('A-217', 'Brighton', 750);
INSERT INTO account  VALUES ('A-222', 'Redwood', 700);
INSERT INTO account  VALUES ('A-305', 'Round Hill', 30);
INSERT INTO account  VALUES ('A-218', 'Downtown', 500);

INSERT INTO depositor  VALUES ('Hayes', 'A-102');
INSERT INTO depositor  VALUES ('Johnson', 'A-101');
INSERT INTO depositor  VALUES ('Johnson', 'A-201');
INSERT INTO depositor  VALUES ('Jones', 'A-217');
INSERT INTO depositor  VALUES ('Jones', 'A-218');
INSERT INTO depositor  VALUES ('Lindsay', 'A-222');
INSERT INTO depositor  VALUES ('Smith', 'A-215');
INSERT INTO depositor  VALUES ('Turner', 'A-305');

INSERT INTO borrower  VALUES ('Adams', 'L-16');
INSERT INTO borrower  VALUES ('Curry', 'L-93');
INSERT INTO borrower  VALUES ('Hayes', 'L-15');
INSERT INTO borrower  VALUES ('Jackson', 'L-14');
INSERT INTO borrower  VALUES ('Jones', 'L-17');
INSERT INTO borrower  VALUES ('Smith', 'L-11');
INSERT INTO borrower  VALUES ('Smith', 'L-23');
INSERT INTO borrower  VALUES ('Williams', 'L-17');



/*
select loan_number
from loan
where branch_name='Perryridge' and amount>1200;

select customer_name,borrower.loan_number,amount
from borrower,loan
where borrower.loan_number = loan.loan_number and
      branch_name = 'Perryridge';

select customer_name,t.loan_number,s.amount
from borrower  t , loan  s
where t.loan_number = s.loan_number;


select distinct t.branch_name
from branch t,branch s
where s.branch_city='Brooklyn' and t.assets>s.assets;

select distinct customer_name
from borrower,loan
where borrower.loan_number = loan.loan_number
      and branch_name='Perryridge'
order by customer_name asc;


select branch_name,count(distinct customer_name)
from depositor,account
where depositor.account_number = account.account_number
group by branch_name;

select branch_name,avg(balance)
   from account
   group by branch_name
   having avg(balance) > 200;



select distinct customer_name
   from borrower
where customer_name in (select customer_name from depositor);


select distinct customer_name
    from borrower,loan
where borrower.loan_number= loan.loan_number and
branch_name = 'Perryridge' and
(branch_name,customer_name) in
       (select branch_name,customer_name
             from depositor,account
        where depositor.account_number= account.account_number);

select branch_name
     from branch
     where assets > all
     ( select assets 
       from branch
       where branch_city = 'Brooklyn');

*/

SELECT branch_name, avg_balance FROM 
    (SELECT branch_name, avg(balance) avg_balance FROM account GROUP BY branch_name)
        where avg_balance >= 700;