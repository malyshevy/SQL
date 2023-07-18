USE lesson_4;
/*
1.Создайте таблицу users_old, аналогичную таблице users.
 Создайте процедуру,  с помощью которой можно переместить любого (одного) 
 пользователя из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно).
*/
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия',
    email VARCHAR(120) UNIQUE
);

DROP PROCEDURE IF EXISTS user_transfer;
DELIMITER //
CREATE PROCEDURE user_transfer(u_id int,
OUT  tran_result varchar(100))

BEGIN
	
	DECLARE `_rollback` BIT DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100); 

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET `_rollback` = 1;
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
	END;

	START TRANSACTION;
	
    INSERT INTO users_old (id, firstname, lastname, email)
	SELECT id, firstname, lastname, email FROM users WHERE id = u_id;

	DELETE FROM users
	WHERE id=u_id;
     
	IF `_rollback` THEN
		SET tran_result = concat('УПС. Ошибка: ', code, ' Текст ошибки: ', error_string);
		ROLLBACK;
	ELSE
		SET tran_result = 'O K';
		COMMIT;
	END IF;
END//
DELIMITER ;

CALL user_transfer(1, @tran_result);
SELECT  @tran_result;
SELECT id, firstname, lastname, email FROM users_old;

/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
 с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TEXT NO SQL
BEGIN
	DECLARE time_now INT;
	SET time_now = HOUR(now());
	CASE
		WHEN time_now BETWEEN 0 AND 5 THEN 
			RETURN 'Доброй ночи!';
		WHEN time_now BETWEEN 6 AND 11 THEN 
			RETURN 'Доброе утро!';
		WHEN time_now BETWEEN 12 AND 17 THEN 
			RETURN 'Добрый день!';
		WHEN time_now BETWEEN 18 AND 23 THEN 
			RETURN 'Добрый вечер!';
	END CASE;
END//
DELIMITER ;
SELECT hello();


/* 3.Создайте таблицу logs типа Archive. Пусть при каждом создании записи в 
 таблицах users, communities и messages в таблицу logs помещается время и дата 
 создания записи, название таблицы, идентификатор первичного ключа.
*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	external_id BIGINT UNSIGNED,
	table_name VARCHAR(255),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE = archive;

DELIMITER //
DROP TRIGGER IF EXISTS log_insert_to_users//
CREATE TRIGGER log_insert_to_users
AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs(table_name, external_id)
	VALUES('users', NEW.id);
END//

DROP TRIGGER IF EXISTS log_insert_to_communities//
CREATE TRIGGER log_insert_to_communities
AFTER INSERT ON communities
FOR EACH ROW
BEGIN
	INSERT INTO logs(table_name, external_id)
	VALUES('communities', NEW.id);
END//

DROP TRIGGER IF EXISTS log_insert_to_messages//
CREATE TRIGGER log_insert_to_messages
AFTER INSERT ON messages
FOR EACH ROW
BEGIN
	INSERT INTO logs(table_name, external_id)
	VALUES('messages', NEW.id);
END//

DELIMITER ;

INSERT INTO users(name, birthday_at)
VALUES
	('Sam', '1981-12-03'),
	('Max', '2009-03-30');

INSERT INTO products(name)
VALUES
	('ASUS ROG 1234'),
	('MSI 9876');

INSERT INTO catalogs(name)
VALUES
	('Блок питвния'),
	('Система охлаждения');


