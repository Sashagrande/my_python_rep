drop database if exists example;
create database example;
use example;

drop table if exists users;
create table users( 
id serial primary key,
name varchar(255) );


insert into users values
	(null, 'Egor'),
	(null,'Ivan');


select * from users;



