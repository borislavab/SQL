use ships;
/*
1. Напишете заявка, която извежда името
на корабите, по-тежки (displacement) от
35000.*/select name from shipsjoin classeson ships.class = classes.classwhere displacement > 35000;/*2. Напишете заявка, която извежда
имената, водоизместимостта и броя
оръдия на всички кораби, участвали в
битката при Guadalcanal.
*/

select name, displacement, numguns
from ships
join classes
on ships.class = classes.class
join outcomes
on outcomes.ship = name
where battle = 'Guadalcanal';

/*
3. Напишете заявка, която извежда
имената на тези държави, които имат
класове кораби от тип 'bb' и 'bc'
едновременно.
*/

select * from classes;

select distinct class1.country
from classes as class1
join classes as class2
on class1.type = 'bb'
and class2.type = 'bc'
and class1.country = class2.country;

/*
4. Напишете заявка, която извежда
имената на тези кораби, които са били
повредени в една битка, но по-късно са
участвали в друга битка.
*/

select distinct earlier_outcome.ship
from outcomes as earlier_outcome
join battles as earlier_battle
on earlier_outcome.battle = earlier_battle.name
join outcomes as later_outcome
on earlier_outcome.ship = later_outcome.ship
and earlier_outcome.battle != later_outcome.battle
join battles as later_battle
on later_outcome.battle = later_battle.name
and earlier_battle.date < later_battle.date;

select * from outcomes
where ship = 'California';

select name, date
from battles
where name = 'Guadalcanal'
union
select name, date
from battles
where name like 'Surigao%';

