use [test]
-- 1.hangi sehirlerde 40 yas ustu yasayan var ?
SELECT distinct city as city_1
FROM Table_1
where age > 40;
--1a
SELECT city as city_1a
FROM Table_1
where age > 40;
--1b
SELECT city as city_1b
FROM Table_1
group by city,age
having age > 40;
--1c
SELECT distinct city as city_1c
FROM Table_1
group by city,age
having age > 40;

--2. hangi sehirlerde 40 yas ustu yasayan var --ve bu sehirlerin max yasi ne? 
SELECT city as city_2,max(age) as max
FROM Table_1
where age>40
group by city;

--3. hangi sehirlerde 40 yas ustu yasayan var --ve bu sehirlerin ortalama yasi ne? 
SELECT city as city_3,avg (age) as avg
FROM Table_1
where city in (SELECT distinct city
				FROM Table_1
				where age > 40)
group by city;
  
--4. hangi sehirlerde sadece 40 yas ustu yasayan var? 
SELECT distinct city as city_4
FROM Table_1
where city not in (SELECT distinct city
					FROM Table_1
					where age <= 40);
--4.a#####
SELECT distinct y.city as city_4a
FROM Table_1 as y 
left outer join (SELECT distinct city
					FROM Table_1
					where age <= 40) as x 
  on y.city=x.city
where x.city is null;

--5. hangi sehirlerde sadece 40 yas ustu yasayan var --ve bu sehirlerin ortalama yasi ne? 
SELECT city as city_5,avg(age) as avg
FROM Table_1
where city not in (SELECT distinct city
					FROM Table_1
					where age <= 40)
group by city;

--6. 30 yas ustu yasayanin oldugu sehirlerin hagilerinde ortalama yas 45'in ve max yas 60'in uzerinde? 
SELECT city as city_6,max(age) as max, avg(age) as avg
FROM Table_1
where age>30
group by city
having avg(age) >45 and max(age) >60   ;
--6a
SELECT city as city_6a,max(age) as max, avg(age) as avg
FROM Table_1
where age>30
group by city;