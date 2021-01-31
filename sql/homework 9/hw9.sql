# 1.
# В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
# Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
####################### Используем бд sample

-- USE sample;
-- START TRANSACTION;
-- 
-- INSERT INTO sample.users (name)
-- select name from shop.users where shop.users.id = 1;
-- 
-- COMMIT;
-- 
-- SELECT * FROM users;


# 2.
#Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
####################### Используем бд shop

--  USE shop;
--  DROP VIEW IF EXISTS prod;
--  CREATE VIEW prod (name, catalogs) AS
--  SELECT p.name, c2.name
--  FROM products p
--  INNER JOIN catalogs c2 ON c2.id = p.catalog_id ;
--  
--  SELECT * FROM prod;
--  DROP VIEW IF EXISTS prod;


# 4.
# (по желанию) Пусть имеется любая таблица с календарным полем created_at.
# Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
####################### Используем бд vk

-- USE vk;
-- 
-- DROP VIEW IF EXISTS mess;
-- CREATE VIEW mess (created_at) AS SELECT created_at FROM messages
-- ORDER BY created_at DESC 
-- LIMIT 5;
-- 
-- DELETE FROM messages 
-- WHERE created_at NOT IN (SELECT created_at FROM mess);
-- DROP VIEW IF EXISTS mess;
-- 
-- 
-- SELECT * FROM messages;
# для демонстрации задания можно было обойтись без реального удаления данных используя транзакции, только додумался я не сразу


-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
-- 
-- DROP FUNCTION IF EXISTS vk.sf_hello;
-- 
-- DELIMITER $$
-- $$
-- CREATE FUNCTION vk.sf_hello()
-- RETURNS varchar(12) reads sql data
-- BEGIN
-- 	declare now_time varchar(2);
-- 	declare hi varchar(12);
-- 	set now_time = date_format(curtime() , '%k'); 
-- 	if now_time between 6 and 12 
-- 		then set hi = 'Доброе утро';
-- 	elseif now_time between 12 and 18
-- 		then set hi = 'Добрый день';
-- 	elseif now_time between 0 and 6
-- 		then set hi = 'Доброй ночи';
-- 	else set hi = 'Добрый вечер';
-- 		end if;
-- 	return hi;
-- 	
-- END$$
-- DELIMITER ;
-- 
-- 
-- 
-- select sf_hello();


-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.



-- DROP TRIGGER IF EXISTS shop.not_null;
-- USE shop;
-- 
-- DELIMITER $$
-- $$
-- CREATE DEFINER=`root`@`localhost` TRIGGER `not_null` AFTER INSERT ON `products` FOR EACH ROW begin 	
-- 	if new.description is null or new.name is null then 
-- 		signal sqlstate '45000'
-- 			set MESSAGE_TEXT = 'Операция отменена';
-- 	end if;
-- end$$
-- DELIMITER ;
-- 
-- 
-- 
-- insert into products (id, name, description, price, catalog_id, created_at, updated_at)
-- values (null, 'процессор спутник', null , 5168, 2, now(), now());

