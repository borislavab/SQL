use movies;

/*
1. Напишете заявка, която извежда
адреса на студио ‘MGM’
*/

SELECT ADDRESS
FROM STUDIO
WHERE NAME = 'MGM';

/*
2. Напишете заявка, която извежда
рождената дата на актрисата Sandra
Bullock
*/

SELECT BIRTHDATE
FROM MOVIESTAR
WHERE NAME = 'Sandra Bullock';

/*
3. Напишете заявка, която извежда
имената на всички филмови звезди,
които са участвали във филм през
1980, в заглавието на които има
думата ‘Empire’
*/

SELECT DISTINCT STARNAME
FROM STARSIN
WHERE MOVIEYEAR=1980
AND MOVIETITLE LIKE '%Empire%';

/*
4. Напишете заявка, която извежда
имената на всички изпълнители на
филми с нетна стойност над
10 000 000 долара
*/

SELECT NAME
FROM MOVIEEXEC
WHERE NETWORTH > 10000000;

/*
5. Напишете заявка, която извежда
имената на всички актьори, които са
мъже или живеят в Malibu
*/

SELECT *
FROM MOVIESTAR
WHERE GENDER='M'
OR ADDRESS LIKE '%Malibu%';