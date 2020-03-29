/*
1. Напишете заявка, която извежда производителя и
честотата на процесора на лаптопите с размер на
харддиска поне 9 GB.*/use pc;select * from laptop;select * from product;select maker, speedfrom laptopjoin producton laptop.model = product.modelwhere hd > 9;/*2. Напишете заявка, която извежда номер на модел
и цена на всички продукти, произведени от
производител с име ‘B’. Сортирайте резултата B’. Сортирайте резултата
така, че първо да се изведат най-скъпите
продукти.
*/

(
	select product.model, price
	from product
	join laptop
	on product.model = laptop.model
	where maker = 'B'
)
union
(
	select product.model, price
	from product
	join pc
	on product.model = pc.model
	where maker = 'B'
)
union
(
	select product.model, price
	from product
	join printer
	on product.model = printer.model
	where maker = 'B'
)

/*
3. Напишете заявка, която извежда размерите на
тези харддискове, които се предлагат в поне два
компютъра.
*/

select distinct pc1.hd
from pc as pc1
join pc as pc2
on pc1.hd = pc2.hd
and pc1.code != pc2.code;

/*
4. Напишете заявка, която извежда всички двойки
модели на компютри, които имат еднаква честота
на процесора и памет. Двойките трябва да се
показват само по веднъж, например ако вече е
изведена двойката (i, j), не трябва да се извежда
(j, i)
*/

select pc1.model, pc2.model
from pc as pc1
join pc as pc2
on pc1.speed = pc2.speed
and pc1.ram = pc2.ram
and pc1.code < pc2.code;

/*
5. Напишете заявка, която извежда
производителите на поне два различни
компютъра с честота на процесора поне 600MHz.
*/

select distinct maker
from product
join pc
on product.model = pc.model
join pc as pc2
on product.model = pc2.model
and pc2.code < pc.code
where pc.speed >= 600
and pc2.speed >= 600;



