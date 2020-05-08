--1.	Розробити та перевірити скалярну (scalar) функцію, що повертає загальну вартість книг виданих в певному році.
CREATE FUNCTION price_sum(a int)
RETURNS REAL
AS
$$
SELECT SUM(books_price.price) 
	   FROM books_code
	   NATURAL JOIN books_price
	   WHERE extract(year from date)=a;
$$
LANGUAGE sql;

select * from price_sum(2000);


--2.	Розробити і перевірити табличну (inline) функцію, яка повертає список книг виданих в певному році.
CREATE FUNCTION book_by_year(a int)
RETURNS TABLE(name char, date date)
AS
$$
SELECT title, date FROM books_code WHERE extract(year from date)=a;
$$
LANGUAGE sql;

select * from book_by_year(2000);


--3.	Розробити і перевірити функцію типу multi-statement, яка буде:
	--a.	приймати в якості вхідного параметра рядок, що містить список назв видавництв, розділених символом ‘;’;  
	--b.	виділяти з цього рядка назву видавництва;
	--c.	формувати нумерований список назв видавництв.
CREATE FUNCTION numeric_list_publishments(str char(200))
RETURNS TABLE(office char)
AS
$$
SELECT unnest(string_to_array(str, ';'));
$$
LANGUAGE sql;

select * from numeric_list_publishments('DiaSoft;ДМК;МікроАрт');


--4.	Виконати набір операцій по роботі з SQL курсором: оголосити курсор;
	--a.	використовувати змінну для оголошення курсору;
	--b.	відкрити курсор;
	--c.	переприсвоїти курсор іншої змінної;
	--d.	виконати вибірку даних з курсору;
	--e.	закрити курсор;
--5.	звільнити курсор. Розробити курсор для виводу списка книг виданих у визначеному році.


CREATE OR REPLACE FUNCTION cursor_funс(book_year int) 
  RETURNS SETOF varchar
  AS 
  $$
  DECLARE 
    book_names text default '';
    rec_book record;
    curs1 CURSOR(book_year int) FOR select title, date from books_code where EXTRACT(YEAR from books_code.date)=book_year;
    
  BEGIN
    OPEN curs1(book_year);
    LOOP
      FETCH curs1 INTO rec_book;
      EXIT WHEN NOT FOUND;
      book_names:=rec_book.title||':'||EXTRACT (YEAR from rec_book.date);
      return next book_names;
    END LOOP;
    CLOSE curs1;
    
  END;
$$
language plpgsql;

SELECT cursor_func(2000);








