create database lab6;

create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

INSERT INTO locations (street_address, postal_code, city, state_province) VALUES
  ('123 Main St', '12345', 'CityA', 'StateA'),
  ('456 Oak St', '67890', 'CityB', 'StateB'),
  ('789 Pine St', '98765', 'CityC', 'StateC'),
  ('321 Elm St', '54321', 'CityD', 'StateD'),
  ('654 Birch St', '23456', 'CityE', 'StateE');

INSERT INTO departments (department_name, budget, location_id, department_id) VALUES
  ('Marketing', 50000, 1, 30),
  ('Finance', 75000, 2, 50),
  ('IT', 60000, 3, 60),
  ('HR', 80000, 4, 70),
  ('Sales', 90000, 5, 80);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id, employee_id) VALUES
  ('John', 'Doe', 'john.doe@email.com', '555-1234', 60000, 30, 616),
  ('Jane', 'Smith', 'jane.smith@email.com', '555-5678', 70000, 50, 617),
  ('Bob', 'Johnson', 'bob.johnson@email.com', '555-9012', 80000, 60, 618),
  ('Alice', 'Williams', 'alice.williams@email.com', '555-3456', 90000, 70, 619),
  ('Charlie', 'Davis', 'charlie.davis@email.com', '555-7890', 100000, 80, 620);

select first_name, last_name, e.department_id, d.department_name
from employees as e, departments as d
where e.department_id = d.department_id;

select first_name, last_name, e.department_id, d.department_name
from employees as e, departments as d
where e.department_id = d.department_id and (d.department_id = 30 or d.department_id = 80);

select first_name, last_name, d.department_name, l.city, l.state_province
from locations l, departments d, employees e
where e.department_id = d.department_id and d.location_id = l.location_id;

select *
from departments d, employees e
where d.department_id = e.department_id or d.department_id not in (select department_id from employees);

select first_name, last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id or e.department_id is null;

select first_name, last_name
from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id and l.city = 'Moscow';

select d.department_name, count(*) as employees
from departments d left join employees e
on d.department_id = e.department_id;