use movies;

/*
 За всеки актьор/актриса изведете броя на 
 различните студиа, с които са записвали филми.
 Включете и тези, за които няма информация в кои филми 
 са играли.
*/
select moviestar.name, count(distinct studioname) as studio_count
from movie
inner join starsin
on movie.title = starsin.movietitle
and movie.year = starsin.movieyear
right outer join moviestar
on starsin.starname = moviestar.name
group by moviestar.name;

insert into movie
values('Speed', 1994, 120, 'y', 'Fox', 199);

insert into starsin
values('Speed', 1994, 'Sandra Bullock');

/*
 Изведете имената на актьорите, участвали в поне 2 филма 
 след 1980 г.
*/
select starname
from starsin
where movieyear > 1980
group by starname
having count(movietitle) >= 2;

use pc;

/*
 Да се изведат различните модели компютри, подредени по цена 
 на най-скъпия конкретен компютър от даден модел.
*/
select model
from pc
group by model
order by max(price);

use ships;

/*
 Намерете броя на потъналите американски кораби 
 за всяка проведена битка с поне един 
 потънал американски кораб.
*/

select outcomes.battle, count(ships.name) as sunken_us_count
from outcomes
inner join ships
on outcomes.ship = ships.name
inner join classes
on ships.class = classes.class
where outcomes.result = 'sunk'
and classes.country = 'USA'
group by outcomes.battle;

/*
 Битките, в които са участвали поне 3 кораба 
 на една и съща страна.
*/
select distinct battle
from outcomes
inner join ships
on outcomes.ship = ships.name
inner join classes
on ships.class = classes.class
group by battle, country
having count(*) >= 3;

/*
 Имената на класовете, за които 
 няма кораб, пуснат на вода след 1921 г., 
 но имат пуснат поне един кораб.
*/
select class
from ships
group by class
having max(launched) <= 1921;

/*
 За всеки кораб броя на битките, в които е бил увреден 
 (result = 'damaged'). Ако корабът не е участвал в битки 
 или пък никога не е бил увреждан, в резултата да се вписва 0.
*/
select ships.name, count(outcomes.battle) as battle_count
from ships
left outer join outcomes
on ships.name = outcomes.ship
and result = 'damaged'
group by ships.name;

/*
  Намерете за всеки клас с поне 3 кораба 
  броя на корабите от този клас, които са
  победили в битка (result) за всяка = 'ok')
*/
select ships.class, count(outcomes.battle) as battles_won
from ships
left outer join outcomes
on ships.name = outcomes.ship
and result = 'ok'
group by ships.class
having count(distinct ships.name) >= 3;

/*
 За всяка битка да се изведе името на битката, 
 годината на битката и броят на потъналите кораби, 
 броят на повредените кораби и броят на корабите без промяна.
*/

select name, date,
(select count(*)
	from outcomes
	where outcomes.result = 'sunk'
	and outcomes.battle = name) as sunken,
(select count(*)
	from outcomes
	where outcomes.result = 'damaged'
	and outcomes.battle = name) as damaged,
(select count(*)
	from outcomes
	where outcomes.result = 'ok'
	and outcomes.battle = name) as ok
from battles;


-- second solution using unions and groups
select name, min(date) as date,
		count(sunken) as sunken_count, 
		count(damaged) as damaged, 
		count(ok) as undamaged
from
(select battles.name, battles.date, outcomes.result as sunken, null as damaged, null as ok
from battles
left outer join outcomes
on battles.name = outcomes.battle
and outcomes.result = 'sunk'
union all
select battles.name, battles.date, null as sunken, outcomes.result as damaged, null as ok
from battles
left outer join outcomes
on battles.name = outcomes.battle
and outcomes.result = 'damaged'
union all
select battles.name, battles.date, null as sunken, null as damaged, outcomes.result as ok
from battles
left outer join outcomes
on battles.name = outcomes.battle
and outcomes.result = 'ok') as battle_outcomes
group by battle_outcomes.name;

/*
 Намерете имената на битките, в които са участвали поне 3 кораба 
 с под 10 оръдия и от тях поне два са с резултат 'ok'.
*/
select numgun_outcomes.battle 
from (select outcomes.*
     from outcomes
     inner join ships
     on outcomes.ship = ships.name
     inner join classes
     on ships.class = classes.class
     where numguns <= 9) as numgun_outcomes
group by numgun_outcomes.battle
having count(*) >= 3
and (select count(*)
     from outcomes
     inner join ships
     on outcomes.ship = ships.name
     inner join classes
     on ships.class = classes.class
     where numguns <= 9
	 and outcomes.battle = numgun_outcomes.battle
	 and outcomes.RESULT = 'ok') >= 2;

-- to check the answer:
select *
from outcomes
inner join ships
on outcomes.ship = ships.name
inner join classes
on ships.class = classes.class
order by battle, result;