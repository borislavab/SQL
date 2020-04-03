use pc;

/*
1. Напишете заявка, която извежда средната честота на процесорите
на компютрите.*/select avg(speed) as pc_average_speedfrom pc;/*2. Напишете заявка, която за всеки производител извежда средния
размер на екраните на неговите лаптопи.
*/
select product.maker, avg(laptop.screen) as average_laptop_screen
from product
left outer join laptop
on product.model = laptop.model
group by product.maker;

/*
3. Напишете заявка, която извежда средната честота на лаптопите с
цена над 1000.*/select avg(speed) as avg_speedfrom laptopwhere price > 1000;/*4. Напишете заявка, която извежда средната цена на компютрите,
произведени от производител ‘A’.
*/

select avg(pc.price) as avg_pc_price
from pc
inner join product
on pc.model = product.model
where product.maker = 'A';

/*
5. Напишете заявка, която извежда средната цена на компютрите и
лаптопите на производител ‘B’ (едно число).
*/
select avg(price) as avg_price
from ((select model, price
	  from laptop)
	 union
	 (select model, price
	  from pc)) laptops_and_pcs
inner join product
on laptops_and_pcs.model = product.model
and product.maker = 'B';

/*
6. Напишете заявка, която извежда средната цена на компютрите
според различните им честоти на процесорите.*/select speed, avg(price)from pcgroup by speed;/*7. Напишете заявка, която извежда производителите, които са
произвели поне по 3 различни модела компютъра.
*/
select maker
from product
where type = 'PC'
group by maker
having count(model) >= 3;


-- makers who have produced at least 3 pcs:
select product.maker, count(pc.code) as pc_count
from product
left outer join pc
on product.model = pc.model
group by product.maker
having count(pc.code) >= 3;

/*
8. Напишете заявка, която извежда производителите на компютрите с
най-висока цена.
*/
select product.maker
from pc
inner join product
on pc.model = product.model
where pc.price = (select max(price) from pc);

/*
9. Напишете заявка, която извежда средната цена на компютрите за
всяка честота, по-голяма от 800 MHz.*/select speed, avg(price) as avg_pricefrom pcwhere speed > 800group by speed;-- or using having instead of where:select speed, avg(price) as avg_pricefrom pcgroup by speedhaving speed > 800;/*10. Напишете заявка, която извежда средния размер на диска на тези
компютри, произведени от производители, които произвеждат и
принтери.
*/
select avg(pc.hd) as avg_disk_size
from pc
inner join product
on pc.model = product.model
and exists(select other_product.model 
		   from product as other_product 
		   where other_product.maker = product.maker
		   and other_product.type = 'Printer');

/*
11. Напишете заявка, която за всеки размер на лаптоп намира
разликата в цената на най-скъпия и най-евтиния лаптоп със същия
размер.
*/
select screen as screen_size, max(price) - min(price) as price_difference
from laptop
group by screen;





