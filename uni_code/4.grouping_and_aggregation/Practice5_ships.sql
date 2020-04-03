use ships;

/*
1. Напишете заявка, която извежда броя на
класовете кораби.
*/
select count(class) as classes_count
from classes;

/*
2. Напишете заявка, която извежда средния
брой на оръдията (numguns) за всички
кораби, пуснати на вода (т.е. изброени са в
таблицата Ships).
*/
select avg(classes.numguns) as avg_ship_numguns
from ships
inner join classes
on ships.class = classes.class;

/*
3. Напишете заявка, която извежда за всеки
клас първата и последната година, в която
кораб от съответния клас е пуснат на вода.
*/
select classes.class, min(ships.launched) as first_year, 
					  max(ships.launched) as last_year
from classes
left outer join ships
on classes.class = ships.class
group by classes.class;

/*
4. Напишете заявка, която за всеки клас
извежда броя на корабите, потънали в
битка.
*/
select classes.class, count(sunken_ships.name) as ships_sunken
from classes
left outer join
(select distinct ships.name, ships.class
 from ships
 inner join outcomes
 on ships.name = outcomes.ship
 and outcomes.result = 'sunk') sunken_ships
on classes.class = sunken_ships.class
group by classes.class;

/*
5. Напишете заявка, която за всеки клас с над
4 пуснати на вода кораба извежда броя на
корабите, потънали в битка.*/
select classes.class, count(distinct outcomes.ship) as sunken_ships
from classes
left outer join ships
on classes.class = ships.class
left outer join outcomes
on ships.name = outcomes.ship
and outcomes.result = 'sunk'
group by classes.class
having count(distinct ships.name) > 4;

/*
6. Напишете заявка, която извежда средното
тегло на корабите (displacement) за всяка страна. 
*/
select classes.country, avg(displacement * ships.launched / ships.launched) as avg_weight
from classes
left outer join ships
on classes.class = ships.class
group by classes.country;
-- the "* ships.launched / ships.launched" is to not count displacement
-- for rows where there is a country but not a ship attached