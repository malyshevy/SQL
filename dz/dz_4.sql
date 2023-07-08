use lesson_4

/* 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.*/
select count(*) as 'кол-во лайков'
	from likes lik
	join media med on lik.media_id = med.id 
	join profiles prof on prof.user_id = med.user_id 
	where timestampdiff(year,prof.birthday,now())<12;

/*2. Определить кто больше поставил лайков (всего): мужчины или женщины.*/
select count(lik.id) as 'кол-во лайков', pro.gender as 'пол'
	from likes lik
	join profiles pro on lik.user_id = pro.user_id
	group by pro.gender 
	order by count(lik.id) desc;

/*3. Вывести всех пользователей, которые не отправляли сообщения.*/
select us.id as 'номер пользователя', concat(us.firstname,' ',us.lastname) as 'ИФ пользователя'
	from users us
	left join messages mes on us.id = mes.from_user_id 
	where mes.id is null;

/*4. (по желанию)* Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.*/
select mes.from_user_id as 'номер пользователя', concat(us.firstname,' ',us.lastname) as 'ИФ пользователя', count(*) as 'кол-во' 
	from messages mes
	join users us on us.id = mes.from_user_id 
	join friend_requests fr 
		on (fr.initiator_user_id = mes.to_user_id and fr.target_user_id = mes.from_user_id) 
		or (fr.initiator_user_id = mes.from_user_id and fr.target_user_id = mes.to_user_id)
	where fr.status = 'approved' and mes.to_user_id = 1
	group by mes.from_user_id 
	order by count(*) desc
	limit 1;















