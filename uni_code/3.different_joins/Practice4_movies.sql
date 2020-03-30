use movies;

/*
1. Напишете заявка, която за всеки филм,
по-дълъг от 120 минути, извежда
заглавие, година, име и адрес на студио.
*/
select movie.title, movie.year, studio.name, studio.address
from movie
left outer join studio
on movie.studioname = studio.name
where movie.length > 120;

/*
2. Напишете заявка, която извежда името
на студиото и имената на актьорите,
участвали във филми, произведени от
това студио, подредени по име на студио.
*/
select studio.name, studiostar.starname
from studio
left outer join (select movie.studioname, starsin.starname
				 from movie
				 inner join starsin
				 on movie.title = starsin.movietitle
				 and movie.year = starsin.movieyear) as studiostar
on studio.name = studiostar.studioname
order by studio.name;

/*
3. Напишете заявка, която извежда имената
на продуцентите на филмите, в които е
играл Harrison Ford.
*/
-- 1st way: with filtering subquery and then join
select distinct movieexec.name
from
((select starsin.movietitle, starsin.movieyear
  from starsin
  where starname = 'Harrison Ford') as harrison_movie
 join movie
 on movie.title = harrison_movie.movietitle
 and movie.year = harrison_movie.movieyear
 join movieexec
 on movie.producerc# = movieexec.cert#);

-- 2nd way: with join on condition
select distinct movieexec.name
from movieexec
join movie
on movie.producerc# = movieexec.cert#
join starsin
on starsin.movietitle = movie.title
and starsin.movieyear = movie.year
and starsin.starname = 'Harrison Ford';

-- 3rd way: with join and then condition (all joins are inner so it works)
select distinct movieexec.name
from movieexec
join movie
on movie.producerc# = movieexec.cert#
join starsin
on starsin.movietitle = movie.title
and starsin.movieyear = movie.year
where starsin.starname = 'Harrison Ford';

/*
4. Напишете заявка, която извежда имената
на актрисите, играли във филми на MGM.
*/
select movie.title, movie.year, name
from moviestar
inner join starsin
on starsin.starname = moviestar.name
right outer join movie
on movie.title = starsin.movietitle
and movie.year = starsin.movieyear
where gender = 'f'
and movie.studioname = 'MGM';

-- better solution if we also want to print names of movies by the studio
-- in which no female moviestar takes part in
select movie.title, movie.year, actresses.name
from
(select name
 from moviestar
 where gender = 'f') as actresses
inner join starsin
on starsin.starname = actresses.name
right outer join movie
on starsin.movietitle = movie.title
and starsin.movieyear = movie.year
where movie.studioname = 'MGM'

-- another way to do the same thing
select movie.title, movie.year, moviestar.name
from starsin
inner join moviestar
on starsin.starname = moviestar.name
and moviestar.gender = 'f'
right outer join movie
on starsin.movietitle = movie.title
and starsin.movieyear = movie.year
where movie.studioname = 'MGM'

/*
5. Напишете заявка, която извежда името
на продуцента и имената на филмите,
продуцирани от продуцента на ‘Star Star
Wars’.
*/

-- here inner join is enough because we know the producer has at least one movie
-- so the results wouldn't be different with outer join
select movieexec.name, movie.title, movie.year
from movieexec
inner join movie
on movie.producerc# = movieexec.cert#
where movieexec.cert# = (select top 1 producerc#
						 from movie
						 where title = 'Star Wars');

/*
6. Напишете заявка, която извежда имената
на актьорите, които не са участвали в
нито един филм. 
*/
select moviestar.name
from moviestar
left outer join starsin
on moviestar.name = starsin.starname
where starsin.movietitle is null;

-- or with right join:
select moviestar.name
from starsin
right outer join moviestar
on starsin.starname = moviestar.name
where starsin.movietitle is null;

