CREATE DATABASE lab1;
CREATE TABLE users(
    id INT,
    firstname varchar(50),
    lastname varchar(50)
);
ALTER TABLE users
ADD COLUMN isadmin INT;

ALTER TABLE users
alter column isadmin type bool using isadmin::bool;

alter table users
alter column id type reset ;

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT false;

CREATE TABLE tasks(
    id SERIAL PRIMARY KEY ,
    name varchar(50),
    user_id INT
);

INSERT INTO users(firstname, lastname) VALUES ('Ernar', 'Mukhtaruly');
SELECT * FROM users;

















alter table users
add constraint users_pk primary key (id)


