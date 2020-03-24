DROP TABLE IF EXISTS books_code;
CREATE TABLE books_code(
	code INTEGER PRIMARY KEY UNIQUE,
	title CHAR(1000),
	date DATE
);

INSERT INTO books_code values(5110, 'Апаратні засоби мультимедія. відеосистема РС', '2000-07-24');
INSERT INTO books_code values(4985,	'Освой самостійно модернізацію і ремонт ПК за 24 години, 2-е вид.', '2000-7-7');
INSERT INTO books_code values(5141,	'Структури даних і алгоритми.', '2000-09-24');
INSERT INTO books_code values(5111,	'Апаратні засоби мультимедія. відеосистема РС', '2000-6-15');
INSERT INTO books_code values(5199,	'Залізо IBM 2001.', '2000-07-24');
INSERT INTO books_code values(3851,	'Захист інформації і безпека комп`ютерних систем', '2000-12-2');
INSERT INTO books_code values(3932,	'Як перетворити персональний комп`ютер у вимірювальний комплекс', '1999-2-4');
INSERT INTO books_code values(4713,	'Plug- ins. Вбудовувані додатки для музичних програм', '1999-6-9');
INSERT INTO books_code values(5217,	'Windows МЕ. Новітні версії програм', '2000-2-22');
INSERT INTO books_code values(4829,	'Windows 2000 Professional крок за кроком з ЗD', '2000-8-25');
INSERT INTO books_code values(5170,	'Linux Російські версії', '2000-4-28');
INSERT INTO books_code values(8603,	'Операційна система UNIX', '2000-9-29');
INSERT INTO books_code values(4407,	'Відповіді на актуальні питання по OS / 2 Warp', '1997-5-5');
INSERT INTO books_code values(5176,	'Windows Ме. супутник користувача', '1996-3-20');
INSERT INTO books_code values(5462,	'Мова програмування С ++. Лекції і вправи', '2000-10-10');
INSERT INTO books_code values(4982,	'Мова програмування С. Лекції і вправи', '2000-12-12');
INSERT INTO books_code values(4687,	'Ефективне використання C ++ .50 рекомендацій щодо поліпшення ваших програм і проектів', '2019-12-8');

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
	code INTEGER,
	office CHAR(500),
	FOREIGN KEY(code) REFERENCES books_code(code)
);

INSERT INTO books_office values(5110,  'BHV С.-Петербург');
INSERT INTO books_office values(4985,	'Вільямс');
INSERT INTO books_office values(5141,	'Вільямс');
INSERT INTO books_office values(5111,	'BHV С.-Петербург');
INSERT INTO books_office values(5199,	'МікроАрт');
INSERT INTO books_office values(3851,	'DiaSoft');
INSERT INTO books_office values(3932,	'ДМК');
INSERT INTO books_office values(4713,	'ДМК');
INSERT INTO books_office values(5217,	'Тріумф');
INSERT INTO books_office values(4829,	'Еком');
INSERT INTO books_office values(5170,	'ДМК');
INSERT INTO books_office values(8603,	'BHV С.-Петербург');
INSERT INTO books_office values(4407,	'DiaSoft');
INSERT INTO books_office values(5176,	'Російська редакція');
INSERT INTO books_office values(5462,	'DiaSoft');
INSERT INTO books_office values(4982,	'DiaSoft');
INSERT INTO books_office values(4687,	'ДМК');


DROP TABLE IF EXISTS books_topic;
CREATE TABLE books_topic(
	code INTEGER,
	topic CHAR(500),
	FOREIGN KEY(code) REFERENCES books_code(code)
);

INSERT INTO books_topic values(5110,    'Використання ПК в цілому');
INSERT INTO books_topic values(4985,	'Використання ПК в цілому');
INSERT INTO books_topic values(5141,	'Використання ПК в цілому');
INSERT INTO books_topic values(5111,	'Використання ПК в цілому');
INSERT INTO books_topic values(5199,	'Використання ПК в цілому');
INSERT INTO books_topic values(3851,	'Використання ПК в цілому');
INSERT INTO books_topic values(3932,	'Використання ПК в цілому');
INSERT INTO books_topic values(4713,	'Використання ПК в цілому');
INSERT INTO books_topic values(5217,	'Операційні системи');
INSERT INTO books_topic values(4829,	'Операційні системи');
INSERT INTO books_topic values(5170,	'Операційні системи');
INSERT INTO books_topic values(8603,	'Операційні системи');
INSERT INTO books_topic values(4407,	'Операційні системи');
INSERT INTO books_topic values(5176,	'Операційні системи');
INSERT INTO books_topic values(5462,	'програмування');
INSERT INTO books_topic values(4982,	'програмування');
INSERT INTO books_topic values(4687,	'програмування');




DROP TABLE IF EXISTS books_category;
CREATE TABLE books_category(
	code INTEGER,
	category CHAR(100),
	FOREIGN KEY(code) REFERENCES books_code(code)
);

INSERT INTO books_category values(5110, 'підручники');
INSERT INTO books_category values(4985,	'підручники');
INSERT INTO books_category values(5141,	'підручники');
INSERT INTO books_category values(5111,	'Апаратні засоби ПК');
INSERT INTO books_category values(5199,	'Апаратні засоби ПК');
INSERT INTO books_category values(3851,	'Захист і безпека ПК');
INSERT INTO books_category values(3932,	'інші книги');
INSERT INTO books_category values(4713,	'інші книги');
INSERT INTO books_category values(5217,	'Windows 2000');
INSERT INTO books_category values(4829,	'Windows 2000');
INSERT INTO books_category values(5170,	'Linux');
INSERT INTO books_category values(8603,	'Unix');
INSERT INTO books_category values(4407,	'Інші операційні системи');
INSERT INTO books_category values(5176,	'Інші операційні системи');
INSERT INTO books_category values(5462,	'C & C ++');
INSERT INTO books_category values(4982,	'C & C ++');
INSERT INTO books_category values(4687,	'C & C ++');


