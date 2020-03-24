SELECT * FROM books;

--1.Вивести статистику: загальна кількість всіх книг, їх вартість, їх середню вартість, мінімальну і максимальну ціну
SELECT COUNT(*) as "всего книг", price, AVG(price), MAX(price), MIN(price) FROM books Group by price;

--2.Вивести загальна кількість всіх книг без урахування книг з непроставленою ціною
SELECT COUNT(title) FROM books WHERE price!=null;

--3.Вивести статистику (див. 1) для книг новинка / не новинка
SELECT COUNT(*) as "всего книг", price, AVG(price), MAX(price), MIN(price) 
FROM books
WHERE newness='Yes' 
Group by price; --newness!='No'

--4.Вивести статистику (див. 1) для книг за кожним роком видання
SELECT COUNT(*) as "всего книг", date, price, AVG(price), MAX(price), MIN(price) 
FROM books 
Group by date, price;

--5.Змінити п.4, виключивши з статистики книги з ціною від 10 до 20
SELECT COUNT(*) as "всего книг", date, price, AVG(price), MAX(price), MIN(price) 
FROM books 
Where price not between 10 and 20
Group by date, price;

--6.Змінити п.4. Відсортувати статистику за спаданням кількості.
SELECT COUNT(*) as "всего книг", date, price, AVG(price), MAX(price), MIN(price) 
FROM books 
Group by date, price
ORDER BY "всего книг" DESC;

--7.Вивести загальну кількість кодів книг і кодів книг, що не повторюються
SELECT COUNT(code) as codes, COUNT(DISTINCT code) as unique FROM books;

--8.Вивести статистику: загальна кількість і вартість книг по першій букві її назви
SELECT LEFT(title,1), COUNT(LEFT(title,1)) as amount, SUM(price)
from books 
GROUP BY LEFT(title,1)
ORDER BY LEFT(title,1) ASC;

--9.Змінити п. 8, виключивши з статистики назви починаються з англ. букви і з цифри.
SELECT LEFT(title,1) as letter, COUNT(LEFT(title,1)) as amount, SUM(price)
from books 
WHERE LEFT(title,1) !~* '\A[A-Z0-9]*\Z'
GROUP BY LEFT(title,1)
ORDER BY LEFT(title,1) ASC;

--10.Змінити п. 9 так щоб до складу статистики потрапили дані з роками великими 2000.
SELECT LEFT(title,1) as letter, COUNT(LEFT(title,1)) as amount, SUM(price)
from books 
WHERE LEFT(title,1) !~* '\A[A-Z0-9]*\Z' AND  EXTRACT(year FROM date)>2000
GROUP BY LEFT(title,1)
ORDER BY LEFT(title,1) ASC;

--11.Змінити п. 10. Відсортувати статистику за спаданням перших букв назви.
SELECT LEFT(title,1) as letter, COUNT(LEFT(title,1)) as amount, SUM(price)
from books 
WHERE LEFT(title,1) !~* '\A[A-Z0-9]*\Z' AND  EXTRACT(year FROM date)>2000
GROUP BY LEFT(title,1)
ORDER BY LEFT(title,1) DESC;

--12.Вивести статистику (див. 1) по кожному місяцю кожного року.
SELECT EXTRACT(year FROM date) as год, EXTRACT(month FROM date) as месяц, COUNT(*) as "всего книг", price, AVG(price), MAX(price), MIN(price) 
FROM books 
Group by price, EXTRACT(year FROM date), EXTRACT(month FROM date);

--13.Змінити п. 12 так щоб до складу статистики не були дані з незаповненими датами.
SELECT EXTRACT(year FROM date) as год, EXTRACT(month FROM date) as месяц, COUNT(*) as "всего книг", price, AVG(price), MAX(price), MIN(price) 
FROM books
WHERE date!=null
Group by price, EXTRACT(year FROM date), EXTRACT(month FROM date);

--14.Змінити п. 12. Фільтр за спаданням року і зростанням місяця.
SELECT EXTRACT(year FROM date) as год, EXTRACT(month FROM date) as месяц, COUNT(*) as "всего книг", price, AVG(price), MAX(price), MIN(price)
FROM books 
Group by price, EXTRACT(year FROM date), EXTRACT(month FROM date)
Order by EXTRACT(year FROM date) DESC, EXTRACT(month FROM date)ASC;

--15.Вивести статистику для книг новинка / не новинка: загальна ціна, загальна ціна в грн. / Євро / руб. Колонкам запиту дати назви за змістом.
SELECT price, TO_CHAR(price, '9999D99 грн') as гривны, TO_CHAR((price*26.64), '9999D99 €') as евро, TO_CHAR((price*2.62), '9999D99 ₽') as рубли 
FROM books
WHERE newness='Yes';

SELECT price, TO_CHAR(price, '9999D99 грн') as гривны, TO_CHAR((price*26.64), '9999D99 €') as евро, TO_CHAR((price*2.62), '9999D99 ₽') as рубли 
FROM books
WHERE newness='No';

--16.Змінити п. 15 так щоб виводилася округлена до цілого числа (дол. / Грн. / Євро / руб.) Ціна.
SELECT price, TO_CHAR(CEIL(price), '9999D99 грн') as гривны, TO_CHAR((CEIL(price*26.64)), '9999D99 €') as евро, TO_CHAR((CEIL(price*2.62)), '9999D99 ₽') as рубли 
FROM books
WHERE newness='Yes';

--17.Вивести статистику (див. 1) по видавництвах.
SELECT COUNT(publishing_office) as "всего книг", publishing_office, price, AVG(price), MAX(price), MIN(price)
FROM books
Group by publishing_office, price;

--18.Вивести статистику (див. 1) за темами і видавництвам. Фільтр по видавництвам.
SELECT COUNT(publishing_office) as "всего книг", publishing_office, category, price, AVG(price), MAX(price), MIN(price)
FROM books
Group by publishing_office, category, price;

--19.Вивести статистику (див. 1) за категоріями, тем і видавництвам. Фільтр по видавництвам, тем, категорій.
SELECT COUNT(publishing_office) as "всего книг", publishing_office, category, price, AVG(price), MAX(price), MIN(price)
FROM books
Group by publishing_office, category, price;

--20.Вивести список видавництв, у яких огруглено до цілого ціна однієї сторінки більше 10 копійок.
SELECT publishing_office, CEIL(price/pages) as price
FROM books 
WHERE (price/pages)>0.1;




