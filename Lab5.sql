create database lab5;

create table salesmen(
    salesman_id int primary key,
    name varchar(100),
    city varchar,
    commission float
);

create table customers(
    customers_id int primary key ,
    cust_name varchar(100),
    city varchar,
    grade int,
    salesman_id int references salesmen(salesman_id)
);

create table orders(
    ord_no int,
    purch_amt float,
    ord_date date,
    customer_id int references customers(customers_id),
    salesman_id int references salesmen(salesman_id)
);

INSERT INTO salesmen (salesman_id, name, city, commission) VALUES (5001, 'James Hoog', 'New York', 0.15);
INSERT INTO salesmen (salesman_id, name, city, commission) VALUES (5002, 'Nail Knite', 'Paris', 0.13);
INSERT INTO salesmen (salesman_id, name, city, commission) VALUES (5005, 'Pit Alex', 'London', 0.11);
INSERT INTO salesmen (salesman_id, name, city, commission) VALUES (5006, 'Mc Lyon', 'Paris', 0.14);
INSERT INTO salesmen (salesman_id, name, city, commission) VALUES (5003, 'Lauson Hen', NULL, 0.12);
INSERT INTO salesmen (salesman_id, name, city, commission) VALUES (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3002, 'Nick Rimando', 'New York', 100, 5001);
INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3005, 'Graham Zusi', 'California', 200, 5002);
INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3001, 'Brad Guzan', 'London', NULL, 5005);
INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3004, 'Fabian Johns', 'Paris', 300, 5006);
INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3007, 'Brad Davis', 'New York', 200, 5001);
INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3009, 'Geoff Camero', 'Berlin', 100, 5003);
INSERT INTO customers (customers_id, cust_name, city, grade, salesman_id) VALUES (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70001, 150.5, '2012-10-05', 3005, 5002);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70009, 270.65, '2012-09-10', 3001, 5005);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70002, 65.26, '2012-10-05', 3002, 5001);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70004, 110.5, '2012-08-17', 3009, 5003);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70007, 948.5, '2012-09-10', 3005, 5002);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70005, 2400.6, '2012-07-27', 3007, 5001);
INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES (70008, 5760, '2012-09-10', 3002, 5001);

select sum(purch_amt) from orders;

select avg(purch_amt) from orders;

select count(cust_name) from customers;

select min(purch_amt) from orders;

select * from customers where cust_name like '_b';

select * from orders inner join customers on orders.customer_id = customers.customers_id;

select * from customers inner join orders on customers.customers_id = orders.customer_id
where purch_amt > 10;

select sum(grade) from customers;

select * from customers
where cust_name notnull;

select max(grade) from customers;