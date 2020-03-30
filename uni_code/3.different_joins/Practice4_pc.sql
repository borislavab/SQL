use pc;

/*
1. Напишете заявка, която извежда
производител, модел и тип на продукт 
за тези производители, за които 
съответният продукт не се продава
(няма го в таблиците PC, Laptop или Printer).
*/

-- first solution - union
select *
from product
where model not in 
((select model from laptop)
 union
 (select model from pc)
 union
 (select model from printer));

 -- second solution - except
select *
from product
where model in 
((select model from product)
 except
 (select model from laptop)
 except
 (select model from pc)
 except
 (select model from printer));

-- third solution - outer join
select product.*
from product
left outer join laptop
on product.model = laptop.model
left outer join pc
on product.model = pc.model
left outer join printer
on product.model = printer.model
where laptop.code is null
and pc.code is null
and printer.code is null;

-- fourth solution - outer join plus subqueries
-- removes unnecessary attributes from table
select product.*
from product
left outer join (select model from laptop) 
				 as laptop_models
on product.model = laptop_models.model
left outer join (select model from pc) 
				 as pc_models
on product.model = pc_models.model
left outer join (select model from printer) 
				 as printer_models
on product.model = printer_models.model
where laptop_models.model is null
and pc_models.model is null
and printer_models.model is null;

select *
from product
left outer join (select model from laptop) 
				 as laptop_models
on product.model = laptop_models.model
left outer join (select model from pc) 
				 as pc_models
on product.model = pc_models.model
left outer join (select model from printer) 
				 as printer_models
on product.model = printer_models.model

-- fifth solution:
-- we can use the type to optimize it
select model, maker, type
from
((
	select * from
	(select * from product where type = 'Laptop') as laptops
	 left outer join
	(select model as real_model from laptop) as real_laptops
	 on laptops.model = real_laptops.real_model
 )
  union
 (
	select * from
	(select * from product where type = 'PC') as pcs
	 left outer join
	(select model as real_model from pc) as real_pcs
	 on pcs.model = real_pcs.real_model
 )
  union
 (
	select * from
	(select * from product where type = 'Printer') as printers
	 left outer join
	(select model as real_model from printer) as real_printers
	 on printers.model = real_printers.real_model
 )
) all_models
where real_model is null;


-- see table from above here:
select *
from
((
	select * from
	(select * from product where type = 'Laptop') as laptops
	 left outer join
	(select model as real_model from laptop) as real_laptops
	 on laptops.model = real_laptops.real_model
 )
  union
 (
	select * from
	(select * from product where type = 'PC') as pcs
	 left outer join
	(select model as real_model from pc) as real_pcs
	 on pcs.model = real_pcs.real_model
 )
  union
 (
	select * from
	(select * from product where type = 'Printer') as printers
	 left outer join
	(select model as real_model from printer) as real_printers
	 on printers.model = real_printers.real_model
 )
) all_models;
