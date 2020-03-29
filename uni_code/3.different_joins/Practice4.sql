﻿use movies;

/*
За всеки актьор и/или продуцент да се изведе името му,
рождената му дата и networth:
*/
-- coalesce - функция, която връща първи елемент, различен от null
-- поне един от аргументите му трябва да е not null, иначе гърми 
select coalesce(mstar.name, mexec.name) as name, mstar.birthdate, mexec.networth
from moviestar as mstar
full outer join movieexec as mexec ON mstar.name = mexec.name;

use ships;

/*
За всяка държава да се изведат имената на корабите, които
никога не са участвали в битка
from classes
inner join ships on classes.class = ships.class
left outer join outcomes on ships.name = outcomes.ship
where outcomes.ship is null;
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship
where outcomes.ship is null;
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship;
from outcomes
right outer join ships on outcomes.ship = ships.name
inner join classes on classes.class = ships.class
where outcomes.ship is null;
(на класовете) и имената на всички битки, в които са
участвали кораби от този клас.
Ако даден клас няма кораби или има, но те не са участвали
в битка, също да се изведат (със стойност NULL за име на
битката).
from outcomes
inner join ships on outcomes.ship = ships.name
right join classes
 on ships.class = classes.class
where country = 'Gt.Britain';
един от тях е OUTER JOIN, редът на прилагането им има значение
from classes
left outer join (select ships.class, outcomes.battle
				 from ships
				 join outcomes on ship = name) as ships_and_outcomes
on classes.class = ships_and_outcomes.class
where classes.country = 'Gt.Britain';
на всички негови кораби, пуснати през 1916 г.
да пише null
*/
from classes
left join ships
on classes.class = ships.class
where launched = 1916;
from classes
left join ships
on classes.class = ships.class and launched = 1916;
from classes
left join (select *
		   from ships
		   where launched = 1916) ships1916
on classes.class = ships1916.class;
При INNER JOIN няма
*/

/* Rule of thumb:
(При LEFT JOIN) Ползваме
– условие в ON, ако условието е за дясната таблица
– условие в WHERE, ако условието е за лявата таблица