CREATE DATABASE LAB9;
CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    department VARCHAR(100),
    salary DECIMAL(10, 2)
);
INSERT INTO employee (name, age, department, salary) VALUES
    ('John Doe', 30, 'IT', 50000.00),
    ('Alice Smith', 28, 'HR', 45000.00),
    ('Bob Johnson', 35, 'Finance', 60000.00),
    ('Emily Brown', 32, 'Marketing', 52000.00),
    ('Michael Davis', 29, 'Sales', 48000.00);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);
INSERT INTO products (name, category, price) VALUES
    ('Product 1', 'Electronics', 499.99),
    ('Product 2', 'Clothing', 39.99),
    ('Product 3', 'Electronics', 899.99),
    ('Product 4', 'Home Decor', 129.99),
    ('Product 5', 'Clothing', 59.99);
select * from products;

--1
create or replace function increase_value(value int)
       returns int as
$$
begin
    return value + 10;
end;
$$
    language plpgsql;
select increase_value(5);

--2
create or replace function compare_numbers(a int, b int)
       returns text as
$$
begin
    if a > b then
        return 'Greater';
    elsif a < b then
        return 'Lesser';
    else
        return 'Equal';
    end if;
end;
$$ language plpgsql;
select compare_numbers(4,5);

--3
create or replace function number_series(n int)
returns table (series_number int) as
$$
declare
    i int := 1;
begin
    while i < n LOOP
        series_number := i;
        return NEXT;
        i := i + 1;
    end loop;
end;
$$ language plpgsql;
select number_series(8);

--4
CREATE OR REPLACE FUNCTION find_employee(emp_name VARCHAR)
RETURNS TABLE (employee_id INT, employee_name VARCHAR, employee_age INT, employee_department VARCHAR, employee_salary DECIMAL) AS $$
BEGIN
    RETURN QUERY SELECT id, name, age, department, salary
                 FROM Employee
                 WHERE name = emp_name;
END;
$$ LANGUAGE plpgsql;
select * from find_employee('Alice Smith');

--5
CREATE OR REPLACE FUNCTION list_products(prod_category VARCHAR)
RETURNS TABLE (product_id INT, product_name VARCHAR, product_category VARCHAR, product_price DECIMAL) AS $$
BEGIN
    RETURN QUERY SELECT id, name, category, price FROM products WHERE category = prod_category;
END;
$$ LANGUAGE plpgsql;
select * from list_products('Electronics');

--6
CREATE TABLE employeeNew (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

CREATE TABLE Bonus (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    bonus_amount DECIMAL(10, 2),
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

INSERT INTO EmployeeNew (name, salary) VALUES
    ('John Doe', 50000.00),
    ('Alice Smith', 45000.00),
    ('Bob Johnson', 60000.00),
    ('Emily Brown', 52000.00),
    ('Michael Davis', 48000.00);
select * from EmployeeNew;

CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INT)
RETURNS int AS $$
DECLARE
    bonus DECIMAL;
BEGIN
    SELECT salary * 0.75 INTO bonus
    FROM Employee
    WHERE id = employee_id;

    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(employee_id INT)
RETURNS VOID AS $$
DECLARE
    bonus_amount DECIMAL;
    new_salary DECIMAL;
BEGIN
    bonus_amount := calculate_bonus(employee_id);

    SELECT salary INTO new_salary
    FROM Employee
    WHERE id = employee_id;

    UPDATE Employee SET salary = new_salary + bonus_amount WHERE id = employee_id;
END;
$$ LANGUAGE plpgsql;

SELECT update_salary(1);
SELECT * FROM Employee WHERE id = 1;

--7
create or replace function complex_calculation(value1 int, value2 varchar)
returns text as
$$
declare
    result_text text;
    result_numeric int;
begin
    <<main_block>>
    begin
        <<string_manipulation_block>>
        begin
            result_text := 'Value: ' || value1 || ' + ' || value2;
        end string_manipulation_block;
        <<numeric_computation_block>>
        begin
            result_numeric := value1 + length(value2);
        end numeric_computation_block;

        if result_numeric >= 0 then
            result_text := result_text || ' Result Numeric: ' || result_numeric;
        else
            result_text := result_text || ' Error in numeric computation';
        end if;
    end main_block;
    return result_text;
end;
$$ language plpgsql;

select complex_calculation(1,'Teacher');