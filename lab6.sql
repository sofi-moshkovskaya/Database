--1.Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.
SELECT title,price,office
FROM books_code
INNER JOIN books_price ON books_code.code=books_price.code
INNER JOIN books_office ON books_code.office_id=books_office.office_id;

--2.Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT title,category
FROM books_code
INNER JOIN books_category ON books_code.category_id=books_category.category_id;

--3.Вивести значення наступних колонок: назва книги, ціна, назва видавництвa, формат.
SELECT title, price,office,format
FROM books_code
NATURAL JOIN books_price
NATURAL JOIN books_office
NATURAL JOIN books;

--4.Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництво. 
SELECT topic, category, title, office
FROM books_code
NATURAL JOIN books_price
NATURAL JOIN books_office
NATURAL JOIN books_category
NATURAL JOIN books_topic;

--5.Вивести книги видавництва 'BHV', видані після 2000 р
SELECT title, office, date
FROM books_code
NATURAL JOIN books_office
WHERE (EXTRACT(YEAR FROM date)>=2000 AND office='BHV%');

--6.Вивести загальну кількість сторінок по кожній назві категорії. Фільтр за спаданням кількості сторінок.
SELECT category, SUM(pages)
FROM books_code
NATURAL JOIN books_category
NATURAL JOIN books_pages
GROUP BY category
ORDER BY SUM(pages) DESC;

--7.Вивести середню вартість книг по темі 'Використання ПК'.
SELECT AVG(price),topic
FROM books_code as bc
NATURAL JOIN books_price 
NATURAL JOIN books_topic
WHERE topic='Використання ПК в цілому'
GROUP BY topic;


--8.Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.
--9.Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.
SELECT bc.code, title, date, price, pages, topic, category
from books_code as bc
INNER JOIN books_price bp ON bc.code=bp.code
INNER JOIN books_topic bt ON bc.topic_id=bt.topic_id
INNER JOIN books_category bcat ON bc.category_id=bcat.category_id
INNER JOIN books_pages bpages ON bc.code=bpages.code
INNER JOIN books_office bo ON bc.office_id=bo.office_id;

--10.Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / rigth join.
SELECT bc.code, title, date, price, pages, topic, category
from books_code as bc
RIGHT JOIN books_price bp ON bc.code=bp.code
RIGHT JOIN books_topic bt ON bc.topic_id=bt.topic_id
RIGHT JOIN books_category bcat ON bc.category_id=bcat.category_id
RIGHT JOIN books_pages bpages ON bc.code=bpages.code
RIGHT JOIN books_office bo ON bc.office_id=bo.office_id;

--11.Вивести пари книг, що мають однакову кількість сторінок. Використовувати самооб'єднання і аліаси (self join).
SELECT A.title, B.title, Apages.pages
FROM books_code as A
INNER JOIN books_code as B ON A.code>B.code
INNER JOIN books_pages AS Apages ON A.code=Apages.code
INNER JOIN books_pages AS Bpages ON B.code=Bpages.code
WHERE Apages.pages=Bpages.pages;

--12.Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).
SELECT A.title, B.title, C.title, Apages.pages
FROM books_code as A
INNER JOIN books_code as B ON A.code>B.code
INNER JOIN books_code as C ON C.code>B.code AND C.code>A.code
INNER JOIN books_pages AS Apages ON A.code=Apages.code
INNER JOIN books_pages AS Bpages ON B.code=Bpages.code
INNER JOIN books_pages AS Cpages ON C.code=Cpages.code
WHERE Apages.pages=Bpages.pages AND Bpages.pages=Cpages.pages;

--13.Вивести всі книги категорії 'C ++'. використовувати підзапити (Subquery).
SELECT title
FROM books_code
NATURAL JOIN books_category
WHERE category_id=(SELECT category_id 
			   FROM books_category
			   WHERE category='C & C ++');

--14.Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (Subquery).
SELECT title
FROM books_code
NATURAL JOIN books_office
WHERE date IN (SELECT date 
			   FROM books_code 
			   WHERE EXTRACT(YEAR FROM date)>=2000) AND office='BHV%';
			   
--15.Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery)
SELECT office, pages
FROM books_code
INNER JOIN books_office ON books_code.office_id=books_office.office_id
INNER JOIN books_pages ON books_code.code=books_pages.code
WHERE books_code.code=(
			SELECT code
			FROM books_pages
			WHERE pages>400);

--16.Вивести список категорій за якими більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).
SELECT category, COUNT(category) as amount
FROM books_code
NATURAL JOIN books_category
GROUP BY category
HAVING (COUNT(category)>=3);

--17.Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists.
SELECT title, office
FROM books_code
NATURAL JOIN books_office
WHERE EXISTS(SELECT title 
			FROM books_code
			WHERE office_id=books_office.office_id AND office='BHV С.-Петербург');

--18.Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. використовувати not exists.
SELECT title, office
FROM books_code
NATURAL JOIN books_office
WHERE NOT EXISTS(SELECT title 
			FROM books_code
			WHERE office_id=books_office.office_id AND office='BHV С.-Петербург');

--19.Вивести відсортоване загальний список назв тем і категорій. Використовувати union.
SELECT topic FROM books_topic
UNION
SELECT category FROM books_category;

--20.Вивести відсортоване в зворотному порядку загальний список  перших слів назв книг (що не повторюються) і категорій. Використовувати union.
SELECT category FROM books_category
UNION 
SELECT DISTINCT SUBSTRING(title, 1, strpos(title, ' ')) FROM books_code
ORDER BY SUBSTRING(title, 1, strpos(title, ' ')) DESC;





