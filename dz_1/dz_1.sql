/*
1. Создайте таблицу с мобильными телефонами (mobile_phones), 
используя графический интерфейс. Заполните БД данными. 
Добавьте скриншот на платформу в качестве ответа на ДЗ 
*/
-- используем нужную базу данных
USE lesson_1;
-- проверяем наличее и удаляем таблицу
DROP TABLE IF EXISTS mobile_phonex;
-- создаём таблицу со столбцами
CREATE TABLE mobile_phonex (
	id int not null,
    product_name varchar(45),
    manufacturer varchar(45),
    product_count int,
    price int,
    primary key (id));
 -- заполняем таблицу данными   
insert into mobile_phonex (id, product_name, manufacturer, product_count, price)
values
(1, 'Iphone X', 'Apple', 3, 76000),
(2, 'Iphone 8', 'Apple', 2, 51000),
(3, 'Galaxy s9', 'Samsung', 2, 56000),
(4, 'Galaxy s8', 'Samsung', 1, 41000),
(5, 'P20 Pro', 'Huawei', 5, 36000);
/*
2. Выведите название, производителя и цену для товаров, количество которых превышает 2
*/
select product_name, manufacturer, price 
from mobile_phonex 
where product_count > 2;
/*
3.  Выведите весь ассортимент товаров марки “Samsung”
*/
select product_name 
from mobile_phonex 
where manufacturer = 'Samsung';
/*
4. (по желанию)* С помощью регулярных выражений найти:
	4.1. Товары, в которых есть упоминание "Iphone"
	4.2. Товары, в которых есть упоминание "Samsung"
	4.3.  Товары, в которых есть ЦИФРЫ
	4.4.  Товары, в которых есть ЦИФРА "8"  
*/


