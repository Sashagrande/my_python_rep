
-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.


select u.id, name
from users u
inner join orders o2 on u.id = o2.user_id ;


-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
select p.name as 'Товар', c.name  as 'Категория'
from products p 
inner join catalogs c on p.catalog_id = c.id;
 
