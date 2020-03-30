use ships;

/*
1. Напишете заявка, която за всеки кораб извежда
името му, държавата, броя оръдия и годината на пускане (launched).
*/
-- here left outer join is a slight overkill since
-- the class attribute of the ships table cannot be null
-- so for every ship there will be a class and no ship will be skipped
select ships.name, classes.country, classes.numguns, ships.launched
from ships
left outer join classes
on ships.class = classes.class;

-- this works just as well:
select ships.name, classes.country, classes.numguns, ships.launched
from ships
inner join classes
on ships.class = classes.class;

/*
2. Напишете заявка, която извежда имената на
корабите, участвали в битка от 1942 г. 
*/

-- first solution - with subquery
select distinct ship
from outcomes
where (select year(battles.date) 
	   from battles 
	   where battles.name = outcomes.battle) 
	   = 1942;

-- second solution - with join and where
select distinct ship
from outcomes
inner join battles
on outcomes.battle = battles.name
where year(battles.date) = 1942;

-- third solution - just with join
select distinct ship
from outcomes
inner join battles
on outcomes.battle = battles.name
and year(battles.date) = 1942;