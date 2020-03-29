use movies;

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
никога не са участвали в битка*/-- verboseselect country, name
from classes
inner join ships on classes.class = ships.class
left outer join outcomes on ships.name = outcomes.ship
where outcomes.ship is null;-- same, less verboseselect country, name
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship
where outcomes.ship is null;-- to see full table after joinsselect *
from classes
join ships on classes.class = ships.class
left join outcomes on name = ship;-- same as before, but tables are joined in reverse orderselect country, name
from outcomes
right outer join ships on outcomes.ship = ships.name
inner join classes on classes.class = ships.class
where outcomes.ship is null;/*За всеки клас британски кораби да се изведат имената им
(на класовете) и имената на всички битки, в които са
участвали кораби от този клас.
Ако даден клас няма кораби или има, но те не са участвали
в битка, също да се изведат (със стойност NULL за име на
битката).*/select distinct classes.class, outcomes.battle
from outcomes
inner join ships on outcomes.ship = ships.name
right join classes
 on ships.class = classes.class
where country = 'Gt.Britain';-- the following doesn't work because it gives an output for each ship-- so if one ship from a class has participated in a battle and another hasn't-- we'll get as a result both a battle and a null value for the classselect distinct classes.class, outcomes.battlefrom classesleft outer join shipson classes.class = ships.classleft outer join outcomeson ships.name = outcomes.shipwhere country = 'Gt.Britain';/* Когато в една заявка има повече от един оператор JOIN и поне
един от тях е OUTER JOIN, редът на прилагането им има значениеАко са само INNER JOIN – няма*/-- this works:select distinct classes.class, ships_and_outcomes.battle
from classes
left outer join (select ships.class, outcomes.battle
				 from ships
				 join outcomes on ship = name) as ships_and_outcomes
on classes.class = ships_and_outcomes.class
where classes.country = 'Gt.Britain';-- where condition vs join on condition:/*За всеки клас да се изведат името му, държавата и имената
на всички негови кораби, пуснати през 1916 г.Ако клас няма нито един кораб от 1916, в полето за кораби
да пише null
*/-- с join и после where e грешно:select classes.class, classes.country, ships.name
from classes
left join ships
on classes.class = ships.class
where launched = 1916;-- ако клас няма кораб от 1916 няма да изведе ред за него-- с join и допълнително условие в on е вярно:select classes.class, classes.country, ships.name
from classes
left join ships
on classes.class = ships.class and launched = 1916;-- important thing is to see in which case you want values-- to be null with left/right outer join -- (this is when the condition in the "on" clause is not met)-- друго решение: (филтриране с where по условие преди join)select classes.class, classes.country, ships1916.name
from classes
left join (select *
		   from ships
		   where launched = 1916) ships1916
on classes.class = ships1916.class; -- or we can filter out the values that don't satisfy the -- condition we're looking for beforehand with where -- and then do a simple outer join just based on matching keys -- includes a subquery and nesting which makes it clumpier/* Recap:При OUTER JOIN има разлика дали дадено условие ще бъде в ON или в WHERE
При INNER JOIN няма
*/

/* Rule of thumb:
(При LEFT JOIN) Ползваме
– условие в ON, ако условието е за дясната таблица
– условие в WHERE, ако условието е за лявата таблица*/