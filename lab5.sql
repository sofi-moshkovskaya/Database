DROP TABLE IF EXISTS books_code;
CREATE TABLE books_code(
	code INTEGER PRIMARY KEY UNIQUE,
	title CHAR(1000),
	date DATE,
	category_id INTEGER,
	office_id INTEGER,
	topic_id INTEGER,
	FOREIGN KEY (category_id) REFERENCES books_category(category_id),
	FOREIGN KEY (office_id) REFERENCES books_office(office_id),	
	FOREIGN KEY (topic_id) REFERENCES books_topic(topic_id)
);

INSERT INTO books_code values(5110, 'Апаратні засоби мультимедія. відеосистема РС', '2000-07-24', 1, 1,1);
INSERT INTO books_code values(4985,	'Освой самостійно модернізацію і ремонт ПК за 24 години, 2-е вид.', '2000-7-7', 1, 2,1);
INSERT INTO books_code values(5141,	'Структури даних і алгоритми.', '2000-09-24', 1, 2,1);
INSERT INTO books_code values(5111,	'Апаратні засоби мультимедія. відеосистема РС', '2000-6-15', 2, 1,1);
INSERT INTO books_code values(5199,	'Залізо IBM 2001.', '2000-07-24', 2, 3,1);
INSERT INTO books_code values(3851,	'Захист інформації і безпека комп`ютерних систем', '2000-12-2',3,4,1);
INSERT INTO books_code values(3932,	'Як перетворити персональний комп`ютер у вимірювальний комплекс', '1999-2-4', 4,5,1);
INSERT INTO books_code values(4713,	'Plug- ins. Вбудовувані додатки для музичних програм', '1999-6-9', 4, 5,1);
INSERT INTO books_code values(5217,	'Windows МЕ. Новітні версії програм', '2000-2-22', 5,2);
INSERT INTO books_code values(4829,	'Windows 2000 Professional крок за кроком з ЗD', '2000-8-25', 5,2);
INSERT INTO books_code values(5170,	'Linux Російські версії', '2000-4-28', 6,1,2);
INSERT INTO books_code values(8603,	'Операційна система UNIX', '2000-9-29', 3,4,2);
INSERT INTO books_code values(4407,	'Відповіді на актуальні питання по OS / 2 Warp', '1997-5-5', 7,3,2);
INSERT INTO books_code values(5176,	'Windows Ме. супутник користувача', '1996-3-20', 7,4,2);
INSERT INTO books_code values(5462,	'Мова програмування С ++. Лекції і вправи', '2000-10-10', 8,4,3);
INSERT INTO books_code values(4982,	'Мова програмування С. Лекції і вправи', '2000-12-12', 8,5,3);
INSERT INTO books_code values(4687,	'Ефективне використання C ++ .50 рекомендацій щодо поліпшення ваших програм і проектів', '2019-12-8', 8,1,3);

select *from books_code;




DROP TABLE IF EXISTS books_price;
CREATE TABLE books_price(
	code INTEGER,
	price REAL,
	FOREIGN KEY(code) REFERENCES books_code(code)
);

INSERT INTO books_price values(5110, '15.51');
INSERT INTO books_price values(4985, '18.90');
INSERT INTO books_price values(5141, '37.80');
INSERT INTO books_price values(5111, 15.51);
INSERT INTO books_price values(5199, '30.07');
INSERT INTO books_price values(3851, '26.00');
INSERT INTO books_price values(3932, '7.65');
INSERT INTO books_price values(4713, 11.41);
INSERT INTO books_price values(5217, 16.57);
INSERT INTO books_price values(4829, 27.25);
INSERT INTO books_price values(5170, 24.43);
INSERT INTO books_price values(8603, 3.50);
INSERT INTO books_price values(4407, 5.00);
INSERT INTO books_price values(5176, 12.79);
INSERT INTO books_price values(5462, 29.00);
INSERT INTO books_price values(4982, 29.00);
INSERT INTO books_price values(4687, 17.60);




DROP TABLE IF EXISTS books_office;
CREATE TABLE books_office(
	office_id INTEGER PRIMARY KEY UNIQUE,
	office CHAR(500)
);

INSERT INTO books_office values(1,   'BHV С.-Петербург');
INSERT INTO books_office values(2,	'Вільямс');
INSERT INTO books_office values(3,	'МікроАрт');
INSERT INTO books_office values(4,	'DiaSoft');
INSERT INTO books_office values(5,	'ДМК');


DROP TABLE IF EXISTS books_topic;
CREATE TABLE books_topic(
	topic_id INTEGER PRIMARY KEY UNIQUE,
	topic CHAR(500)
);

INSERT INTO books_topic values(1,   'Використання ПК в цілому');
INSERT INTO books_topic values(2,	'Операційні системи');
INSERT INTO books_topic values(3,	'програмування');




DROP TABLE IF EXISTS books_category ;
CREATE TABLE books_category(
	category_id INTEGER UNIQUE,
	category CHAR(100),
	PRIMARY KEY (category_id)
);

INSERT INTO books_category values(1, 'підручники');
INSERT INTO books_category values(2, 'Апаратні засоби ПК');
INSERT INTO books_category values(3, 'Захист і безпека ПК');
INSERT INTO books_category values(4, 'інші книги');
INSERT INTO books_category values(5, 'Windows 2000');
INSERT INTO books_category values(6, 'Linux');
INSERT INTO books_category values(7, 'Інші операційні системи');
INSERT INTO books_category values(8, 'C & C ++');




DROP TABLE IF EXISTS books_pages;
CREATE TABLE books_pages(
	code INTEGER,
	pages INTEGER,
	FOREIGN KEY(code) REFERENCES books_code(code)
);

INSERT INTO books_pages values(5110, 320);
INSERT INTO books_pages values(4985, 197);
INSERT INTO books_pages values(5141, 232);
INSERT INTO books_pages values(5111, 399);
INSERT INTO books_pages values(5199, 400);
INSERT INTO books_pages values(3851, 311);
INSERT INTO books_pages values(3932, 265);
INSERT INTO books_pages values(4713, 144);
INSERT INTO books_pages values(5217, 289);
INSERT INTO books_pages values(4829, 144);
INSERT INTO books_pages values(5170, 371);
INSERT INTO books_pages values(8603, 392);
INSERT INTO books_pages values(4407, 352);
INSERT INTO books_pages values(5176, 306);
INSERT INTO books_pages values(5462, 656);
INSERT INTO books_pages values(4982, 432);
INSERT INTO books_pages values(4687, 240);













































