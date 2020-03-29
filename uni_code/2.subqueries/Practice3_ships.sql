use ships;

/*
1. Напишете заявка, която извежда
страните, чиито класове кораби са с
най-голям брой оръдия.*/select distinct countryfrom classeswhere numguns >= all (select numguns from classes);/*2. Напишете заявка, която извежда
имената на корабите с 16-инчови
оръдия (bore).*/select namefrom shipswhere (select bore from classes where classes.class = ships.class) = 16;select ships.namefrom classesjoin shipson classes.class = ships.classwhere bore = 16;/*3. Напишете заявка, която извежда
имената на битките, в които са
участвали кораби от клас ‘Kongo’.*/select battlefrom outcomeswhere (select class from ships where name = ship) = 'Kongo';/*4. Напишете заявка, която извежда
имената на корабите, чиито брой
оръдия е най-голям в сравнение с
корабите със същия калибър оръдия
(bore).*/select namefrom shipswhere (select numguns 	   from classes	   where classes.class = ships.class) >=	   all (select numguns			from classes			where classes.bore = (select bore								  from classes as class2								  where class2.class = ships.class))order by name;/*select * from classesorder by bore, numguns desc;bore 14 -> class Tennesseebore 15 -> class Bismarck, Revengebore 16 -> class North Carolinabore 18 -> class Yamatoselect namefrom shipswhere class in ('Tennessee','Bismarck','Revenge','North Carolina','Yamato')order by name;*/