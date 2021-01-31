select firstname from users group by firstname; -- II задание



alter table profiles -- III задание 
add is_active bool 
default true;

update profiles 
set is_active = false
where (YEAR(CURRENT_DATE) - YEAR(birthday)) - (DATE_FORMAT(CURRENT_DATE, '%m%d') < DATE_FORMAT(birthday, '%m%d')) < 18;



delete from messages -- IV задание 
where created_at > now();

