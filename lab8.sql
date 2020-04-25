--1.Кількість тем може бути в діапазоні від 5 до 10.
CREATE FUNCTION topic_range() RETURNS trigger AS  $topic_range$
	DECLARE 
    count_t integer; 
	BEGIN
		Select count(topic_id) INTO count_t FROM books_topic;
		New.count= count_t;
		IF (count_t<5 or count_t>10 ) THEN
			RAISE EXCEPTION 'Topic range can be from 5 to 10';
		END IF;
		RETURN NEW;
	END;
$topic_range$ LANGUAGE plpgsql;

CREATE TRIGGER topic_range BEFORE INSERT OR UPDATE or DELETE ON books_topic
    FOR EACH ROW EXECUTE PROCEDURE topic_range();
 

--2.Новинкою може бути тільки книга видана в поточному році.
CREATE FUNCTION new_book() RETURNS trigger AS  $new_book$
	BEGIN
			IF (EXTRACT (YEAR FROM New.book_data)!=EXTRACT(YEAR FROM current_date)) and (New.book_new=true) THEN
				RAISE EXCEPTION 'Новинкою може бути тільки книга видана в поточному році.';
				END IF;	
		RETURN NEW;
	END;
$new_book$ LANGUAGE plpgsql;

CREATE TRIGGER new_book BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE new_book();


--3.Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 3 00 - 3 0 $.
CREATE FUNCTION pages_price() RETURNS trigger AS  $pages_price$
	BEGIN
			IF (New.books_pages.pages<100)and(New.books_price.price >money(10)) THEN
				RAISE EXCEPTION 'Книга з кількістю сторінок до 100 не може коштувати більше 10 $';
				END IF;	
			IF (New.books_pages.pages<200)and(New.books_price.price >money(20)) THEN
				RAISE EXCEPTION 'Книга з кількістю сторінок до 200 не може коштувати більше 20 $';
				END IF;	
			IF (New.books_pages.pages<300)and(New.books_price.price >money(30)) THEN
				RAISE EXCEPTION 'Книга з кількістю сторінок до 300 не може коштувати більше 30 $';
				END IF;	
				
		RETURN NEW;
	END;
$pages_price$ LANGUAGE plpgsql;

CREATE TRIGGER pages_price BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE pages_price();


--4.Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000.
CREATE FUNCTION publiching_circulation() RETURNS trigger AS  $publiching_circulation$
	BEGIN
			IF (New.books_office.office like '%%BHV С.-Петербург%%' )and(New.books_circulation<5000) THEN
				RAISE EXCEPTION 'Видавництво "BHV" не випускає книги накладом меншим 5000';
				END IF;	
			IF (New.books_ofice.office like '%%DiaSoft%%' )and(New.books_circulation<10000) THEN
				RAISE EXCEPTION 'Видавництво Diasoft не випускає книги накладом меншим 10000';
				END IF;	
			
				
		RETURN NEW;
	END;
$publiching_circulation$ LANGUAGE plpgsql;

CREATE TRIGGER publiching_circulation BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE publiching_circulation();


--5.Книги з однаковим кодом повинні мати однакові дані.
CREATE FUNCTION same__books() RETURNS trigger AS  $same__books$
	BEGIN
			IF (New.books_code.code not like old.books_code.code )and(New.title not like old.title) and
			(New.date!=old.date)and(New.category_id!=old.category_id)and(New.topic_id!=Old.topic_id)and
			(New.office_id!=Old.office_id)
			THEN
			RAISE EXCEPTION 'Книги з однаковим кодом повинні мати однакові дані.';
			END IF;
			
				
		RETURN NEW;
	END;
$same__books$ LANGUAGE plpgsql;

CREATE TRIGGER same__books BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE same__books();

--6.Видавництва ДМК і Еком підручники не видають.
CREATE FUNCTION publiching() RETURNS trigger AS  $publiching$
	BEGIN
			IF (New.books_office.office like '%%ДМК%%' )and(New.books_category like'%%підручники%%') THEN
				RAISE EXCEPTION 'Видавництва ДМК і Еком підручники не видають.';
				END IF;	
			IF (New.books_office.office like '%%Еком%%' )and(New.books_category like'%%підручники%%') THEN
				RAISE EXCEPTION 'Видавництва ДМК і Еком підручники не видають.';
				END IF;	
			
				
		RETURN NEW;
	END;
$publiching$ LANGUAGE plpgsql;

CREATE TRIGGER publiching BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE publiching();


--7.Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року.
CREATE FUNCTION check_newness() RETURNS trigger AS  $check_newness$
	BEGIN
			IF (count(old.books_code.newness like 'yes')>10 ) and (old.books_code where date_part('year', old.books_code.date) = date_part('year', CURRENT_DATE))
			and (old.books_code where date_part('month', old.books_code.date) = date_part('month', CURRENT_DATE) THEN
				RAISE EXCEPTION 'Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року.'
				END IF						
				
		RETURN NEW
	END
$check_newness$ LANGUAGE plpgsql

CREATE TRIGGER check_newness BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE check_newness();


--8.видавництво BHV не випускає книги формату 60х88 / 16.
CREATE FUNCTION publiching_format() RETURNS trigger AS  $publiching_format$
	BEGIN
			IF (New.books_office.office like '%%BHV С.-Петербург%%' )and(New.books_format like'%%60х88 / 16%%') THEN
				RAISE EXCEPTION 'видавництво BHV не випускає книги формату 60х88 / 16.';
				END IF;	
			
				
		RETURN NEW;
	END;
$publiching_format$ LANGUAGE plpgsql;

CREATE TRIGGER publiching_format BEFORE INSERT OR UPDATE or DELETE ON books_code
    FOR EACH ROW EXECUTE PROCEDURE publiching_format();





