use movies;

SELECT * 
FROM MOVIE;

-- until end of line
/*
	multiple line comment
*/

SELECT LENGTH, INCOLOR
FROM MOVIE;

SELECT LENGTH/60.0 as hours, INCOLOR as colourful
FROM MOVIE;

SELECT *
FROM STARSIN;

SELECT *
FROM STARSIN
WHERE MOVIEYEAR >= 1983;

SELECT *
FROM STUDIO;

SELECT *
FROM STUDIO
WHERE NAME='Fox' OR PRESC#=1;

SELECT *
FROM MOVIESTAR;

SELECT *
FROM MOVIESTAR
WHERE GENDER='M' AND BIRTHDATE>='1955-05-05 00:00:00.000';

SELECT *
FROM MOVIESTAR
WHERE GENDER='M' AND BIRTHDATE>='1955-05-05';

SELECT *
FROM MOVIESTAR
WHERE GENDER='M' AND BIRTHDATE>='1955';

/* Fails, cannot convert to a date
SELECT *
FROM MOVIESTAR
WHERE GENDER='M' AND BIRTHDATE>='1955-05';
*/

SELECT *
FROM MOVIEEXEC;

-- lexicographic comparison of strings
SELECT *
FROM MOVIEEXEC
WHERE NAME>='George Lucas';

-- case insensitive even for strings
SELECT *
FROM MOVIEEXEC
WHERE NAME>='george lucas';

SELECT *
FROM MOVIEEXEC
WHERE NAME<='stephen';

/*
string LIKE pattern
– Шаблони – низове, в които може да се използват:
● % - всякаква последователност от 0 или повече символи;
● _ - покриване на 1 произволен символ.

Отрицанието на LIKE е NOT LIKE
*/

SELECT *
FROM MOVIEEXEC 
WHERE NAME LIKE 'CAL%E';

SELECT *
FROM MOVIEEXEC 
WHERE ADDRESS LIKE '________'; -- 8 underlines

-- function year for date
SELECT *
FROM MovieStar
WHERE year(birthdate)=1977;

-- function month for date
SELECT *
FROM MovieStar
WHERE month(birthdate)>=07;

SELECT *
FROM MovieStar
WHERE month(birthdate)>=7;

-- function day for date
SELECT *
FROM MovieStar
WHERE day(birthdate)=7;

-- всеки тип поддържа NULL стойности
-- няма нужда от проверки за null
-- NULL не удовлетворява никое условие освен IS NULL !!
-- Внимание – грешка: = NULLSELECT LENGTH
FROM MOVIEWHERE LENGTH IS NULL;/*SELECT LENGTH
FROM MOVIEWHERE LENGTH = NULL;НЕ РАБОТИ!*/-- ORDER BY клауза в края на заявката-- Може по няколко критерия
-- За всеки от тях може да се укаже посока – ASC или DESC
-- По подразбиране – ASC (нарастващ ред)SELECT title, year, length
FROM Movie
WHERE length > 60
ORDER BY length DESC, title;

SELECT *
FROM MovieStar
ORDER BY month(birthdate);