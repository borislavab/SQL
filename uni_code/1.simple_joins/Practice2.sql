use movies;

SELECT *
FROM MOVIE;

SELECT *
FROM STUDIO;

-- декартово произведение
SELECT *
FROM MOVIE, STUDIO
WHERE STUDIONAME = NAME;

SELECT *
FROM MOVIE
JOIN STUDIO ON STUDIONAME = NAME;

SELECT *
FROM MOVIE
JOIN STUDIO ON NAME = 'Fox';

SELECT *
FROM MOVIE AS M1, MOVIE AS M2;


SELECT *
FROM MOVIE M1, MOVIE M2;

/*
всички филми, които са цветни и/или
в тях е играл Харисън Форд:
*/


(SELECT title, year
FROM Movie
WHERE incolor = 'y')
UNION
(SELECT movietitle, movieyear
FROM StarsIn
WHERE starname = 'Harrison Ford');

-- union - обединение на резултатите от два селекта (таблица от редовете на върнатите таблици)
-- прави множество от резултатите, без дубликати
(SELECT title, year
FROM Movie
WHERE incolor = 'y')
UNION
(SELECT title, year
FROM Movie);

-- а ако в оригиналната заявка има? nope, пак без дубликати
-- също незадължителни скоби
SELECT INCOLOR
FROM MOVIE
UNION
SELECT INCOLOR
FROM MOVIE;


--intersect - сечение на резултатите от два селекта 
(SELECT name, address
FROM MovieStar
WHERE gender = 'F')
INTERSECT
(SELECT name, address
FROM MovieExec
WHERE networth > 10000000);

-- пак прави множество 
SELECT INCOLOR
FROM MOVIE
INTERSECT
SELECT INCOLOR
FROM MOVIE;

-- EXCEPT - разлика на резултатите
-- пак множество
SELECT INCOLOR
FROM MOVIE
EXCEPT
SELECT INCOLOR
FROM MOVIE
WHERE INCOLOR = 'N';

-- като има обединение, сечение, разлика, селект клаузите на които се прилагат се наричат подзаявки
-- те не могат да се сортират индивидуално
-- но целия резултат от всичките може
SELECT title, year
FROM Movie
WHERE incolor = 'y'
UNION
SELECT movietitle, movieyear
FROM StarsIn
WHERE starname = 'Harrison Ford'
ORDER BY YEAR;

-- distinct - за да махнем повторенията (т.е. да получим множество от редове вместо мултимножество)
-- веднага след select
SELECT DISTINCT incolor
FROM MOVIE;

use ships;

-- Имената на всички битки, в които има потънал кораб:
-- (в някои битки може да има повече от един потънал ама не искаме два пъти да я изкарваме)
SELECT DISTINCT battle
FROM Outcomes
WHERE result = 'sunk';

use movies;

-- UNION ALL - ако искаме обединение, което не премахва повторения
-- няма ALL варианти за сечение и разлика в sql server
SELECT INCOLOR
FROM MOVIE
UNION ALL
SELECT INCOLOR
FROM MOVIE;
