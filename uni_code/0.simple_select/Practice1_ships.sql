﻿use ships;

/*
1. Напишете заявка, която извежда името на
класа и държавата за всички класове с брой
на оръдията, по-малък от 10*/SELECT CLASS, COUNTRYFROM CLASSESWHERE NUMGUNS < 10;/*2. Напишете заявка, която извежда имената на
всички кораби, пуснати на вода преди 1918.
Задайте псевдоним на колоната shipName*/SELECT NAME AS shipNameFROM SHIPSWHERE LAUNCHED < 1918;/*3. Напишете заявка, която извежда имената на
корабите, потънали в битка, и имената на
битките, в които са потънали*/SELECT SHIP, BATTLEFROM OUTCOMESWHERE RESULT = 'sunk';/*4. Напишете заявка, която извежда имената на
корабите с име, съвпадащо с името на
техния клас
*/

SELECT NAME
FROM SHIPS
WHERE NAME = CLASS;

/*
5. Напишете заявка, която извежда имената на
всички кораби, започващи с буквата R
*/

SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';

/*
6. Напишете заявка, която извежда имената на
всички кораби, чието име е съставено от
точно две думи
*/

SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %'
AND NAME NOT LIKE '% % %';