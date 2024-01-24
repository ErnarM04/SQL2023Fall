create database lab8;

create table countries (
    country_id serial primary key,
    name varchar(255) not null
);

insert into countries (name)
values
    ('Kazakhstan'),
    ('Japan'),
    ('Brazil'),
    ('Egypt'),
    ('Australia');


create table employees (
    employee_id serial primary key,
    name varchar(255) not null,
    surname varchar(255) not null,
    salary decimal(10, 2) not null,
    department_id int not null
);

insert into employees (name, surname, salary, department_id) values
    ('John', 'Doe', 50000.00, 1),
    ('Jane', 'Smith', 60000.00, 2),
    ('Bob', 'Johnson', 70000.00, 1),
    ('Alice', 'Jones', 55000.00, 2),
    ('Charlie', 'Brown', 80000.00, 3),
    ('Eva', 'White', 65000.00, 2);


create table departments (
    department_id serial primary key,
    budget decimal(15, 2) not null
);

insert into departments (budget) values
    (100000.00),
    (120000.00),
    (90000.00),
    (110000.00),
    (95000.00),
    (150000.00);

-- Query 1
create index countries_name on countries (name);

select * from countries WHERE name = 'Japan';

-- Query 2
create index employees_name on employees (name, surname);

select * from employees where name = 'John' and surname = 'Doe';

-- Query 3
create unique index employees_salary on employees (salary) where salary > 50000 and salary < 65000;

select * from employees where salary < 65000 and salary > 50000;

-- Query 4
create index employees_name_substr on employees using btree (substring(name from 1 for 4));

select * from employees where substring(name from 1 for 4) = 'Eva';

-- Query 5
create index employees_departments on employees (department_id, salary);
create index departments_budget on departments (budget);

select * from employees e join departments d on d.department_id = e.department_id where d.budget > 95000.00 and e.salary < 70000.00;
