/*
Работаем с таблицей staff
*/
use lesson_3;
/*
1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
*/
-- убывание 
select *
	from staff
    order by salary desc;
-- возростание 
select *
	from staff
    order by salary asc;
/*
2. Выведите 5 максимальных заработных плат (salary)
*/
select salary 
	as max_zp
	from staff
    order by salary desc
    limit 5;
/*
3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
*/
select
	post,
	sum(salary) as summ_salary 
    from staff
    group by post;
/*
4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
*/
select
	count(post)
    from staff
    where age <= 49 and age >= 24 and post = 'рабочий';
/* 
5. Найдите количество специальностей
*/
select
	count(distinct post)
    from staff;
/*
6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
*/
select  
	post
    from staff
    group by post
    having avg(age) < 30;
    
     