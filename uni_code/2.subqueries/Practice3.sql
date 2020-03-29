-- подзаявките за обикновени заявки вложени в други заявки
-- ако са с 1 ред и 1 стълб може да се използват като скалари
-- но ще изгърмят runtime ако са друг вид таблица и използвани като скалари
-- ограждат се в скоби

/*
Да се изведат заглавията на всички филми, 
които са по-дълги от Star Wars:
*/

use movies;

-- скаларна подзаявка
SELECT title
FROM movie
WHERE length >	(SELECT length
				 FROM movie
				 WHERE title = 'Star Wars');

SELECT name
FROM MovieStar
WHERE EXISTS (SELECT 1
			  FROM StarsIn
			  WHERE MovieStar.name = starname
					AND movieyear >=
					YEAR(MovieStar.birthdate) + 40);

SELECT DISTINCT name
FROM MovieStar
JOIN StarsIn ON name = starname
WHERE movieyear >= YEAR(birthdate) + 40;

-- execution plans same

select title, length
from movie;

select title, length
from movie
where length in (select length
				 from movie);

-- null skipped

select title, length
from movie
where length not in (select length
				 from movie);

-- no results, null skipped again?

select title, length
from movie
where length not in (111, 238);

-- null again skipped

select title, length
from movie
where length >= all (select length
					from movie);
-- returns empty list because there's a null value and the result for >= null is unknown, not true

select title, year
from movie
where year >= all (select year
					from movie);
-- returns a single row as a result because every year is not null and can be compared

select title, length
from movie
where length > any (select length
					from movie);
-- returns all but null and the smallest non null length

select title, length
from movie
where length > any (111, 238);

-- does not work

select title, length
from movie
where length > all (111, 238);

-- does not work

select title, length
from movie
where length in (111, 238);

select title, length
from movie
where length not in (111, 238);

-- works

use pc;

-- Всички принтери с най-висока цена:
select *
from printer
where price >= all (select price
					from printer);

-- Точно един принтер с най-висока цена
select top 1 *
from printer
where price >= all (select price
					from printer);

use ships;

-- Класовете, на които поне един от
-- корабите им е потънал в битка
select distinct class
from ships
where name in (select ship
			   from outcomes
			   where result = 'sunk');

/*
Класовете, на които нито един от
корабите им не е потънал в битка
– Има кораби, които не са участвали в битки
– Има дори класове без кораби
*/
select class
from classes
where class not in (select distinct class
					from ships
					where name in (select ship
								   from outcomes
								   where result = 'sunk'));

-- Оператор EXISTS (подзаявка)
-- Връща стойност TRUE, ако в резултата от подзаявката има поне един ред

use movies;

-- Подзаявки във FROM клаузата
SELECT movietitle, starname, birthdate
FROM StarsIn, (SELECT name, birthdate
			   FROM MovieStar
			   WHERE gender = 'F') Actresses
WHERE starname = name;

-- Задължително трябва да укажем име на таблицата!

-- корелативни подзаявки
-- подзаявка, която използва стойности от външната заявка
/*
 заявка, която извежда тези заглавия на
филми, които са използвани в поне два филма (от
различни години, напр. King Kong от 1933 и от 2005):*/
SELECT DISTINCT title
FROM Movie M
WHERE year < ANY (SELECT year
				  FROM Movie
				  WHERE title = M.title);

-- for testing
insert into movie
values('Star Wars', 2019, 150, 'Y', 'Disney', 555);

/*
Да се изведат имената на всички филмови звезди, които са играли във филм
след навършване на 40-годишна възраст
*/
select name
from moviestar
where exists(select *
			 from starsin
			 where starname = name
			 and movieyear - year(birthdate) >= 40);

select movieyear, starname, birthdate
from starsin
join moviestar
on name = starname;

/*
Да се изведат имената на всички филмови звезди, които са играли във филм
преди да се родят
*/
select name
from moviestar
where exists(select *
			 from starsin
			 where starname = name
			 and movieyear < year(birthdate));

-- друго решение
-- btw select 1 извежда ред със стойност 1 за всеки намерен ред, не че извежда един ред
SELECT name
FROM MovieStar
WHERE EXISTS (SELECT 1
			  FROM StarsIn
			  WHERE MovieStar.name = starname
			  AND movieyear >=
			  YEAR(MovieStar.birthdate) + 40);

