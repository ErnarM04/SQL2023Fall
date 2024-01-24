create database lab_4;

create table Warehouses(
    code serial primary key,
    location varchar(255),
    capacity integer
);

create table Packs(
    code char(4),
    contents varchar(255),
    value real,
    warehouses integer references Warehouses(code)
);

INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);

select * from Packs;

select * from Packs where value > 190;

select distinct from Packs group by contents;

select w.code, count(*) as count
from Warehouses w inner join Packs p on w.code = p.warehouses
group by w.code
order by w.code;

select code, count
from (select w.code, count(*) as count
from Warehouses w inner join Packs p on w.code = p.warehouses
group by w.code
order by w.code)
where count > 2;

insert into  Warehouses(code, location, capacity) values (6, 'Texas', 5);

insert into Packs(code, contents, value, warehouses) values ('H5RT', 'Papers', 150, 2);

select (value * 0.82) as Answer
from Packs
order by value desc limit 1 offset 2;

delete from Packs
where value < 150
returning *;

delete from Packs
using warehouses
where warehouses.code = Packs.warehouses and warehouses.location = 'Chicago'
returning *;