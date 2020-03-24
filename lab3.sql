--1.Вивести книги у яких не введена ціна або ціна дорівнює 0
SELECT * FROM books WHERE price=0 OR price=null;

--2.Вивести книги у яких введена ціна, але не введений тираж
SELECT * FROM books WHERE price<>0 AND pages=null;

--3.Вивести книги, про дату видання яких нічого не відомо.
SELECT * FROM books WHERE date=null;

--4.Вивести книги, з дня видання яких пройшло не більше року.
SELECT * FROM books WHERE (CURRENT_DATE-date)<365;

--5.Вивести список книг-новинок, відсортоване за зростанням ціни
SELECT * FROM books WHERE newness='Yes' ORDER BY price;

--6.Вивести список книг з числом сторінок від 300 до 400, відсортоване в зворотному алфавітному порядку назв
SELECT * FROM books WHERE pages BETWEEN 300 AND 400 ORDER BY title DESC;

--7.Вивести список книг з ціною від 20 до 40, відсортоване в спаданням дати
SELECT * FROM books WHERE pages BETWEEN 20 AND 40 ORDER BY date DESC;

--8.Вивести список книг, відсортованих в алфавітному порядку назв і ціною по спадаючій
SELECT * FROM books ORDER BY title ASC, price DESC; 

--9.Вивести книги, у яких ціна однієї сторінки <10 копійок.
SELECT * FROM books WHERE (price/pages)<0.1;

--10.Вивести значення наступних колонок: число символів в назві, перші 20 символів назви великими літерами
SELECT length(title), UPPER(SUBSTRING(title, 1,20)) FROM books GROUP BY title;

--11.Вивести значення наступних колонок: перші 10 і останні 10 символів назви прописними буквами, розділені '...'
SELECT CONCAT(UPPER(SUBSTRING(title, 1,20)),'...',UPPER(RIGHT(title,20))) FROM books;

--12.Вивести значення наступних колонок: назва, дата, день, місяць, рік
SELECT title, date, EXTRACT(year FROM date) AS year, EXTRACT(month FROM date) AS month, EXTRACT(day FROM date) AS day FROM books;

--13.Вивести значення наступних колонок: назва, дата, дата в форматі 'dd / mm / yyyy'
SELECT title, date, TO_CHAR(date, 'DD/MM/YYYY') as date FROM books;

--14.Вивести значення наступних колонок: код, ціна, ціна в грн., Ціна в євро, ціна в руб.
SELECT code, price, TO_CHAR(price, '9999D99 грн') as гривны, TO_CHAR((price*26.64), '9999D99 €') as евро, TO_CHAR((price*2.62), '9999D99 ₽') as рубли FROM books;

--15.Вивести значення наступних колонок: код, ціна, ціна в грн. без копійок, ціна без копійок огругленная
SELECT code, price,  TO_CHAR(FLOOR(price), '9999D99 грн') as "floor", CEIL(price) FROM books;

--16.Додати інформацію про нову книгу (всі колонки), Додати інформацію про нову книгу (колонки обов'язкові для введення)
INSERT INTO books values(293,	4687,	'No',	'Ефективне використаня вашого часу. 10 причин не вступати до ВНЗ',	10.60,	'ДМК',	240,	'70х100 / 16',	'2005/2/3',	5000,	'програмування',	'C & C ++');

--18.Видалити книги, видані до 1990 року
DELETE FROM books WHERE EXTRACT(year FROM date)<1990;

--19.Проставити поточну дату для тих книг, у яких дата видання відсутній
UPDATE books
SET date=CURRENT_DATE
WHERE date=null;

--20.Встановити ознака новинка для книг виданих після 2005 року
UPDATE books
SET newness='Yes'
WHERE EXTRACT(year FROM date)>2005;



























