use movies;

/*
1.Boby extended 
Напишете заявка, която
извежда имената на
актрисите, които имат продуценти с
нетна стойност, по-голяма от 10 милиона.
*/

select * from moviestar;

select name
from moviestar
where gender = 'f' 
	  and exists(select movietitle
	  			 from starsin
	  			 where starname = name
					   and (select networth
							from movieexec
							where cert# = (select producerc#
										   from movie
										   where title = movietitle
										         and year = movieyear)) > 10000000);

/*
1. Напишете заявка, която
извежда имената на
актрисите, които са
също и продуценти с
нетна стойност, по-голяма от 10 милиона.
*/
select name
from moviestar
where gender = 'f'
	  and exists(select 1
				 from movieexec
				 where movieexec.name = moviestar.name);

-- for testing, since none existed prior
insert into movieexec
values(444, 'Sandra Bullock', 'Somewhere', 3493873);

/*
2. Напишете заявка, която
извежда имената на
тези филмови звезди,
които не са продуценти.
*/
select name
from moviestar
where name not in (select name
				   from movieexec);

