create database lab2; --DDL
create table employees( --DDL
    birth_date date,
    first_name varchar(14),
    last_name varchar(16),
    gender char,
    hire_date date,
    emp_no integer primary key
);
create table titles(
    emp_no integer,
    title varchar(50),
    from_date date,
    to_date date,
    foreign key (emp_no) references employees(emp_no)
);
create table salaries(
    emp_no integer,
    salary integer,
    from_date date,
    to_date date,
    foreign key (emp_no) references employees(emp_no)
);
create table departments(
    dept_name varchar(40),
    dept_no char(4) primary key
);
create table dept_emp(
    emp_no integer,
    dept_no char(4),
    from_date date,
    to_date date,
    foreign key (dept_no) references departments(dept_no),
    foreign key (emp_no) references employees(emp_no)

);
create table dept_manager(
    emp_no integer,
    dept_no char(4),
    from_date date,
    to_date date,
    foreign key (dept_no) references departments(dept_no),
    foreign key (emp_no) references employees(emp_no)
);

insert into employees(first_name, last_name,gender,birth_date,emp_no) values ('Ernar', 'Mukhtaruly', 'm', '2004-11-20', '1'); --DML
select * from employees; --DML
update employees set hire_date = '2023-09-28'; --DML
select * from employees; --DML






create table students(
    full_name varchar,
    age integer,
    birth_date date,
    gender varchar(4) check (gender in ('Boy', 'Girl')),
    average_grade float,
    nationality varchar,
    phone_number varchar(10),
    social_category varchar
);
create table instructors(
    full_name varchar,
    spoken_languages varchar,
    work_experience varchar,
    remote_lessons boolean
);
create table student_relatives(
    full_name varchar,
    address varchar,
    phone_number varchar(10),
    position varchar
);
create table student_social_data(
    school varchar,
    graduation_date date,
    address varchar,
    region varchar(20),
    country varchar(20),
    GPA float,
    honors varchar
);
drop database lab2; --DDL
















create table OR_StudentStatuses(
    Name varchar,
    NameID int,
    ID int primary key
);

create table OR_Students(
    StudentID int references OR_StudentStatuses(ID)
);
