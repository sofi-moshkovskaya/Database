--1.Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.
create function get_N_P_PU_f()
	returns table (title text,price real,office text,format text )
as
$$
Select cast(title as text), price, cast(office as text),cast(format as text) 
FROM books_code
NATURAL JOIN books_price
NATURAL JOIN books_office
NATURAL JOIN books
$$
language sql;

select *
from get_N_P_PU_f();



--2.Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.
create function get_T_C_N_Pu()
	returns table (topic text,category text,office text,format text )
as
$$
Select cast(topic as text),cast(category as text),cast(title as text),cast(office as text) 
FROM books_code
NATURAL JOIN books_price
NATURAL JOIN books_office
NATURAL JOIN books_category
NATURAL JOIN books_topic
ORDER BY topic,category
$$
language sql;

Select * from get_T_C_N_Pu()



--3.Вивести книги видавництва 'BHV', видані після 2000 р
create function get_BHV_publiching_after_2000()
	returns table (title text,office text)
as
$$
Select cast(title as text),cast(office as text) 
FROM books_code
NATURAL JOIN books_office
WHERE (EXTRACT(YEAR FROM date)>=2000 AND office='BHV%')
$$
language sql;

Select * from get_BHV_publiching_after_2000()



--4.Вивести загальну кількість сторінок по кожній назві категорії. 
create function get_page_count_by_category()
	returns table (category text, pages integer)
as
$$
Select cast(category as text), cast(sum(pages) as integer)
FROM books_code
NATURAL JOIN books_category
NATURAL JOIN books_pages
GROUP BY category
ORDER BY SUM(pages) DESC;
$$
language sql;

Select * from get_page_count_by_category()



--5.Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.
create function get_avg_price_by_topic_and_category()
	returns table (avg_price numeric)
as
$$
Select cast(avg(price::numeric) as numeric)
FROM books_code as bc
NATURAL JOIN books_price 
natural join books_topic
natural join books_category
where
topic like '%%Використання ПК%%' and category like '%%Linux%%'
$$
language sql;

Select * from get_avg_price_by_topic_and_category()



--6.Вивести всі дані універсального відносини.
create function get_universaly_relation()
	returns table (code integer, title text, date date, topic text, category text, office text)
as
$$
Select cast(bc.code as integer), cast(title as text), cast(date as date), cast(topic as text),cast (category as text),cast(office as text) 
from books_code as bc
INNER JOIN books_price bp ON bc.code=bp.code
INNER JOIN books_topic bt ON bc.topic_id=bt.topic_id
INNER JOIN books_category bcat ON bc.category_id=bcat.category_id
INNER JOIN books_pages bpages ON bc.code=bpages.code
INNER JOIN books_office bo ON bc.office_id=bo.office_id;
$$
language sql;
Select * from get_universaly_relation()



--7.Вивести пари книг, що мають однакову кількість сторінок.
create function get_book_with_same_page_count()
	returns table (Bbook text, Abook text)
as
$$
SELECT cast(A.title as text), cast(B.title as text)
FROM books_code as A
INNER JOIN books_code as B ON A.code>B.code
INNER JOIN books_pages AS Apages ON A.code=Apages.code
INNER JOIN books_pages AS Bpages ON B.code=Bpages.code
WHERE Apages.pages=Bpages.pages;
$$
language sql;
Select * from get_book_with_same_page_count()



--8.Вивести тріади книг, що мають однакову ціну.
create function get_book_3_with_same_price()
	returns table (abook text, Bbook text, cbook text, price real)
as
$$
SELECT cast(A.title as text), cast(B.title as text), cast(C.title as text), Aprice.price
FROM books_code as A
INNER JOIN books_code as B ON A.code>B.code
INNER JOIN books_code as C ON C.code>B.code AND C.code>A.code
INNER JOIN books_price AS Aprice ON A.code=Aprice.code
INNER JOIN books_price AS Bprice ON B.code=Bprice.code
INNER JOIN books_price AS Cprice ON C.code=Cprice.code
WHERE Aprice.price=Bprice.price AND Bprice.price=Cprice.price;
$$
language sql;

Select * from  get_book_3_with_same_price()



--9.Вивести всі книги категорії 'C ++'.
create function get_C_books()
	returns table(title text, category text)
as
$$
SELECT cast(title as text), cast(category as text)
FROM books_code
NATURAL JOIN books_category
WHERE category_id=(SELECT category_id 
			   FROM books_category
			   WHERE category='C & C ++')
$$
language sql;
Select * from get_C_books()



--10.Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.
create function get_P_pages_more_then_400()
	returns table (office text)
as
$$

SELECT distinct(cast(office as text))  
FROM books_code
INNER JOIN books_office ON books_code.office_id=books_office.office_id
INNER JOIN books_pages ON books_code.code=books_pages.code
WHERE books_code.code=(
			SELECT code
			FROM books_pages
			WHERE pages>400)
$$
language sql;

Select * from get_P_pages_more_then_400()


--11.Вивести список категорій за якими більше 3-х книг.
create function get_category_where_books_more_then_3()
	returns table (category text,book_count int)
as
$$
SELECT cast(category as text) ,cast(count(*) as int)  
FROM books_code
NATURAL JOIN books_category
GROUP BY category
HAVING (COUNT(category)>=3)
$$
language sql;
Select * from get_category_where_books_more_then_3()



--12.Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.
create function get_book_BHV_publiching()
	returns table(title text, office text)
as
$$
SELECT cast(title as text), cast(office as text)
FROM books_code
natural join books_office
WHERE  EXISTS(SELECT title 
			FROM books_code
			WHERE office_id=books_office.office_id AND office='BHV С.-Петербург')
$$
language sql;

Select * from get_book_BHV_publiching()



--13.Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.
create function get_book_NOT_BHV_publiching()
		returns table(title text, office text)
as
$$
SELECT cast(title as text), cast(office as text)
FROM books_code
natural join books_office
WHERE NOT EXISTS(SELECT title 
			FROM books_code
			WHERE office_id=books_office.office_id AND office='BHV С.-Петербург')
$$
language sql;
Select * from get_book_NOT_BHV_publiching()



--14.Вивести відсортоване загальний список назв тем.
create function get_all_topic()
	returns table (topic text)
as
$$
SELECT cast(topic as text) FROM books_topic
UNION
SELECT cast(category as text) FROM books_category
$$
language sql;

Select * from get_all_topic()



--15.Вивести в зворотному порядку загальний список неповторяющихся перших слів назв книг і категорій.
create function get_all_list_first_word()
	returns table (type text,name text)
as
$$
SELECT DISTINCT  cast('book' AS text),cast(substring(title from 0 for position(' ' in title)) as text) 
FROM books_code UNION SELECT 'category' AS TYPE, 
cast(substring(category from 0 for position(' ' in category)) as text)  FROM books_category 
$$
language sql;

Select * from  get_all_list_first_word()










