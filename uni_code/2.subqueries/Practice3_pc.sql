use pc;

/*
1. Напишете заявка, която извежда
производителите на персонални компютри с
честота на процесора поне 500 MHz.
*/
select distinct maker
from product
where exists(select code
			 from pc
			 where pc.model = product.model
			 and speed >= 500);

select distinct maker
from pc
join product
on pc.model = product.model;

/*
2. Напишете заявка, която извежда лаптопите,
чиято честота на CPU е по-ниска от
честотата на който и да е персонален
компютър.*/
select *
from laptop
where speed < all (select speed
				   from pc);

/*
3. Напишете заявка, която извежда модела на
продукта (PC, лаптоп или принтер) с най-висока цена.
*/
select top 1 model
from (select model, price
	  from laptop
	  union
	  select model, price
	  from pc
	  union
	  select model, price
	  from printer) as models_and_prices
order by price desc;

/*
4. Напишете заявка, която извежда
производителите на цветните принтери с
най-ниска цена.
*/
select maker
from product
where model in (select model
				from printer
				where color = 'y'
				and price <= all (select price
							  from printer
							  where color = 'y'));

/*
5. Напишете заявка, която извежда
производителите на тези персонални
компютри с най-малко RAM памет, които
имат най-бързи процесори.
*/
select distinct maker
from product
where exists(select code
			 from pc
			 where pc.model = product.model
			 and pc.ram <= all (select ram from pc as pc1)
			 and pc.speed >= all (select speed from pc as pc2 where pc2.ram = pc.ram));

select *
from pc
order by ram asc, speed desc;

select maker, model
from product;









