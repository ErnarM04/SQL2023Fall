create database lab7;

create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

--a
select * from client where priority < 300;

--b
select * from dealer left join client on client.dealer_id = dealer.id;

--c
select d.name as dealer_name, c.name as client_name, city, c.priority, s.date, s.amount
from dealer d join client c
on d.id = c.dealer_id join sell s
on d.id = s.dealer_id
order by d.name;

--d
select d.name, c.name, city
from dealer d join client c
on d.id = c.dealer_id
where city = location;

--e
select s.id, amount, c.name, city
from client c inner join sell s on c.id = s.client_id
where s.amount between 200 and 500;

--f
select d.name as dealer_name, c.name as client_name, c.city
from dealer d full outer join client c on d.id = c.dealer_id;

--g
select c.name as client_name, city, d.name as dealer_name, commission
from client c inner join dealer d on d.id = c.dealer_id;

--h
select c.name as client_name, city, d.name as dealer_name, commission
from dealer d join client c on d.id = c.dealer_id
where commission > 0.13;

--i
select c.name as client_name, city, s.id as sell_id, date, amount, d.name as dealer_name, commission
from client c, sell s, dealer d
where c.id not in (select client_id from sell);

--j
select c.name as client_name, c.priority, d.id as dealer_id, s.id as sell_id, s.amount, count(c) as count
from dealer d join client c on d.id = c.dealer_id
join sell s on c.id = s.client_id
where amount > 2000
group by c.name, c.priority, d.id, s.id;

--a
create view client_purchase_summary as
select s.date, count(c.id) as unique_clients, avg(s.amount) as average_purchase, sum(s.amount) as total_purchase
from sell s
join client c on s.client_id = c.id
group by s.date;

select * from client_purchase_summary;

--b
create view top5_dates as
select date, sum(amount) as total_sell
from sell where date = date
group by date
order by total_sell desc
limit 5;

select * from top5_dates;

--c
create view dealers_sales as
select dealer.name, count(sell.id) as number_of_sales, avg(amount) as average_amount, sum(amount) as total_amount
from dealer inner join sell on sell.dealer_id = dealer.id
group by dealer.name;;

select * from dealers_sales;

--d
create view dealers_money as
select dealer.name, (sum(sell.amount * dealer.commission)) as earned, location
from dealer join sell on dealer.id = sell.dealer_id
group by dealer.name, location;

select * from dealers_money;

--e
create view sales_made as
select dealer.location, count(sell), avg(amount), (sum(sell.amount * dealer.commission)) as earned
from dealer join sell on dealer.id = sell.dealer_id
group by location;

select * from sales_made;

--f
create view client_expenses as
select city, count(sell), avg(amount), sum(sell.amount) as earned
from client join sell on client.id = sell.client_id
group by city;

select * from client_expenses;

--g
create view cities_with_more_expenses as
select city, ce.earned
from client_expenses ce
where ce.earned > (
    select sum(sm.earned)
    from sales_made sm
    where sm.location = ce.city)
group by city, ce.earned
order by ce.earned desc;

drop view cities_with_more_expenses;

select * from cities_with_more_expenses;























create view top5 as
select date, sum(amount) as total
from sell
where date = date
group by date
order by total desc
limit 5;

select * from top5;