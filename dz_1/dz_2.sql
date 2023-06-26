/*
1 Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными.
*/
-- Создаём базу данных
create database dz2;
-- Выбираем данную базу данных
use dz2;
-- Создаём таблицу
drop table if exists sales;
create table sales (
id serial primary key,
order_data varchar(10),
count_product int
);
-- Заполняем таблицу данными
insert into sales (order_data, count_product)
values
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);
/*
2 Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
меньше 100 - Маленький заказ; 
от 100 до 300 - Средний заказ; 
больше 300 - Большой заказ.
*/
select 
	id AS 'id заказа',
	case
		when count_product < 100 then 'Маленький заказ'
        when 100 < count_product < 300 then 'Средний заказ' 
        when count_product > 300 then 'Большой заказ'
        end as 'Тип заказа'
from sales;
/*
3 Создайте таблицу “orders”, заполните ее значениями. 
Выберите все заказы. 
В зависимости от поля order_status выведите столбец full_order_status: 
OPEN – «Order is in open state» ; 
CLOSED - «Order is closed»; 
CANCELLED - «Order is cancelled»
*/
-- Выбираю базу данных 
use dz2;
-- Создаю таблицу
create table orders (
id serial primary key,
employee_id varchar(3),
amount double,
order_status varchar(20)
);
-- Заполняем таблицу данными
insert into orders (employee_id, amount, order_status)
values
('e03',15.00,'open'),
('e01',25.50,'open'),
('e05',100.70,'closed'),
('e02',22.18,'open'),
('e04',9.50,'cancelled');
-- Вывод необходимых столбцов
select 
	*,
    if(order_status = 'open','Order is in open state',
		if(order_status = 'closed','Order is closed',
			if(order_status = 'cancelled','Order is cancelled', 'null'
				)))
	as full_order_status
from orders;
/*
4 Чем NULL отличается от 0?
*/
-- null это отсутствие любого значения
-- 0 это значение