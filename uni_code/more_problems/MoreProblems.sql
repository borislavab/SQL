use ships;

/*
Имената и годините на пускане на всички кораби, 
които имат същото име като своя клас
*/
select name, launched
from ships
where name = class;

use movies;

/*
Всички филми, чието заглавие съдържа едновременно думите 'Star' и 'Trek' (не
непременно в този ред). Резултатите да се подредят по година (първо най-новите
филми), а филмите от една и съща година - по азбучен ред.
*/
select *
from movie
where title like '%Star%' and title like '%Trek%'
order by year desc, title asc;

/*
Заглавията и годините на филмите, в които са играли звезди, родени между
1.1.1970 и 1.7.1980.
*/
select distinct movietitle, movieyear
from starsin
inner join moviestar
on starsin.starname = moviestar.name
where moviestar.birthdate >= '1970-01-01'
and moviestar.birthdate <= '1980-07-01';

use ships;

/*
Имената на всички кораби, за които едновременно са изпълнени следните
условия: (1) участвали са в поне една битка и (2) имената им (на корабите)
започват с C или K.
*/
select distinct ship
from outcomes
where ship like 'C%' or ship like 'K%';

/*
Всички държави, които имат потънали в битка кораби
*/
select distinct country
from classes
inner join ships
on classes.class = ships.class
inner join outcomes
on ships.name = outcomes.ship
where result = 'sunk';

/*
Всички държави, които нямат нито един потънал кораб
*/
(select country
from classes)
except
(select country
from classes
inner join ships
on classes.class = ships.class
inner join outcomes
on ships.name = outcomes.ship
and result = 'sunk');

/*
Имената на класовете, за които няма кораб, пуснат на вода
(launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва
да излезе в резултата
*/
select classes.class
from classes
left outer join ships
on classes.class = ships.class
and launched = 1921
where ships.name is null;

/*
Името, държавата и калибъра (bore) на всички класове кораби с 6, 8 или 10
оръдия. Калибърът да се изведе в сантиметри (1 инч е приблизително 2.54 см
*/
select class, country, bore * 2.54 as bore_cm
from classes
where numguns in (6, 8, 10);

/*
Държавите, които имат класове с различен калибър (напр. САЩ имат клас с 14
калибър и класове с 16 калибър, докато Великобритания има само класове с 15).
*/
select distinct country
from classes as first_class
where exists (select second_class.class
			  from classes as second_class
			  where second_class.country = first_class.country
			  and second_class.bore <> first_class.bore);

/*
Страните, които произвеждат кораби с най-голям брой оръдия (numguns).
*/
select distinct country
from classes
where numguns >= all (select numguns from classes);

use pc;

/*
Компютрите, които са по-евтини от всеки лаптоп на същия производител
*/
select pc.*
from pc
inner join product
on pc.model = product.model
left outer join laptop
on product.maker = (select product_2.maker 
					from product as product_2 
					where product_2.model = laptop.model)
and laptop.price <= pc.price
where laptop.code is null;

-- see resulting table:
select *
from pc
inner join product
on pc.model = product.model
left outer join laptop
on product.maker = (select product_2.maker 
					from product as product_2 
					where product_2.model = laptop.model)
and laptop.price <= pc.price;

-- see laptops + makers information:
select laptop.price, product.maker
from laptop
inner join product
on laptop.model = product.model
order by maker;

/*
Компютрите, които са по-евтини от всеки лаптоп и принтер на същия
производител.
*/
select pc.*
from pc
inner join product
on pc.model = product.model
left outer join laptop
on product.maker = (select product_2.maker 
					from product as product_2 
					where product_2.model = laptop.model)
and laptop.price <= pc.price
left outer join printer
on product.maker = (select product_3.maker
					from product as product_3
					where product_3.model = printer.model)
and printer.price <= pc.price
where laptop.code is null and printer.code is null;

-- see resulting table:
select *
from pc
inner join product
on pc.model = product.model
left outer join laptop
on product.maker = (select product_2.maker 
					from product as product_2 
					where product_2.model = laptop.model)
and laptop.price <= pc.price
left outer join printer
on product.maker = (select product_3.maker
					from product as product_3
					where product_3.model = printer.model)
and printer.price <= pc.price