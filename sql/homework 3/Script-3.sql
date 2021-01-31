
-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”
-- Задание 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

 
alter table users add column created_at datetime ;
alter table users add column updated_at datetime ;

update users 
set created_at = now(); 

update users 
set updated_at = now(); 


--Задание 2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом
--VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

alter table users modify created_at varchar(20);
alter table users modify updated_at varchar(20);

alter table users modify created_at datetime;
alter table users modify updated_at datetime;



-- Задание 3  В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.


drop table if exists storehouses_product;
create table storehouses_product 
(id int unsigned not null auto_increment unique, 
name varchar(100),
value int unsigned,
price int unsigned);

INSERT INTO `storehouses_product` VALUES ('1','itaque','29','18576'),
('2','excepturi','5','15044'),
('3','ipsam','28','2454'),
('4','exercitationem','3','26651'),
('5','quis','30','25548'),
('6','omnis','29','1142'),
('7','quia','29','23486'),
('8','alias','29','13604'),
('9','maxime','9','33402'),
('10','repudiandae','16','10988'),
('11','et','11','14098'),
('12','recusandae','20','6276'),
('13','itaque','4','19260'),
('14','dicta','9','5499'),
('15','cum','26','20182'),
('16','omnis','2','11978'),
('17','eos','12','14018'),
('18','doloremque','28','18956'),
('19','quibusdam','29','8971'),
('20','quaerat','9','12683'),
('21','numquam','28','29755'),
('22','quo','6','20738'),
('23','veniam','10','12817'),
('24','et','24','18230'),
('25','ea','16','2347'),
('26','libero','6','8044'),
('27','eos','29','12372'),
('28','vitae','13','34690'),
('29','doloremque','29','13250'),
('30','amet','26','33037'),
('31','odit','28','31926'),
('32','dolor','8','27946'),
('33','est','19','21976'),
('34','voluptas','0','29590'),
('35','ea','15','18746'),
('36','laudantium','0','8085'),
('37','aliquid','25','7688'),
('38','quia','24','23598'),
('39','dolore','4','25770'),
('40','quam','17','18226'); 

select * from storehouses_product order by IF(value > 0, 0, 1), value;



-- Задание 4
-- (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

select concat(firstname, ' ', lastname) as name
from users, profiles
where users.id = profiles.user_id and  MONTHNAME(birthday) in ('May', 'August')
;







-- Практическое задание теме “Агрегация данных”
-- 1. Подсчитайте средний возраст пользователей в таблице users
select (YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) / count(*) as average_age from profiles; 

