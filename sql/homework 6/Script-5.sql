
-- 1.
-- Пусть задан некоторый пользователь.
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).

set @user_id = 5;

select to_user_id as 'user', counts 
from  -- сделал вложеный запрос, потому что в отличие от ВТОРОГО ВАРИАНТА тут хотябы одного выдает
	(select to_user_id, count(*) as 'counts'
	from messages
	where from_user_id = @user_id
	group by to_user_id 
	) tb1
having counts = max(counts) -- почему выдает только один результат? я сделал так, чтобы в моей таблице было два пользователя,
-- которым @user_id отправил по 6 сообщений, если вместо max(counts) ставлю намеренно 6, то выдает двоих, а когда вместо max(counts) подставляется цифра 6, 
-- то выдает одного пользователя
;

select to_user_id as user, count(*) as 'counts'  -- ВТОРОЙ ВАРИАНТ, не выдает ни одного
from messages
where from_user_id = @user_id
group by to_user_id 
having counts = max(counts) 
; -- тут вообще пустое поле, видимо нельзя в одном запросе применять max к alias так как alias возможно еще не сформировался
-- как сделать так, чтобы выдал нескольких пользователей, если @user_id отправил им одинаковое количество сообщений? 




-- -----------------------------------------------------------------------

-- 2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет..

select count(*) as 'Количество лайков'
from likes l 
where media_id in (  -- список id медиа, чьи владельцы моложе 10 лет
	select id
	from media m 
	where user_id in (  -- список user_id чей возраст меньше 10 лет
		select user_id 
		from profiles
		where (birthday + interval 10 year) > now() 
)
);



-- -----------------------------------------------------------------------
-- 3
-- Определить кто больше поставил лайков (всего): мужчины или женщины.

select gender, max(c)
from (
	select id, user_id, gender, count(*) as 'c' -- выдает лайки пользователей и гендеры пользователей
	from likes, ( 
		select user_id as 'u_id', gender -- выдает список user_id и их гендеры
		from profiles p) tb1
	where user_id = u_id
	group by gender ) tb2
;



