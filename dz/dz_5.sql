use lesson_4;
/*
1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.
*/
select * from oldname;
	create view oldname
		as select concat('Имя:',firstname,'  Фамилия:',lastname,'  Город:', hometown, '  Пол:', gender) as 'INFA'
		from users u 
		join profiles p on u.id = p.user_id
		where timestampdiff(year, birthday, now())>20
		group by u.id;	
/*
2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь, 
указав указать имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге 
(первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)
*/
select  
	concat('Имя:',firstname,' Фамилия:',lastname) as 'Пользователь',
	count(from_user_id) as 'Кол-во сообщений',
	dense_rank() over (order by count(from_user_id) desc) as 'Рейтинг'
	from users u
	join messages m on u.id = m.from_user_id
	group by u.id;
/*
3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) 
и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)
*/
select body , created_at  
	from messages 
	order by timestampdiff(second, created_at, now()) desc;
