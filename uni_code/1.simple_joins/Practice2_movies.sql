/*
1. Напишете заявка,
която извежда имената
на актрисите,
участвали в Terms of
Endearment.*/select namefrom moviestarjoin starsin on name = starnamewhere gender = 'f'and movietitle = 'Terms of Endearment';/*2. Напишете заявка,
която извежда имената
на филмовите звезди,
участвали във филми
на студио MGM през
1995 г.
*/

select starname
from starsin
join movie 
on movietitle = title 
and movieyear = year
where studioname = 'MGM'
and movieyear = 1995;

select starname
from movie
join starsin
on movietitle = title 
and movieyear = year
where studioname = 'MGM'
and movieyear = 1995;

-- both work, so it doesn't matter which is joined to which

