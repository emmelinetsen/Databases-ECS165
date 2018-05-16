create or replace view neighboring_countries(C1, C2) as
select country1, country2
from symmetric_borders b
where b.country1 = (
select country
from city c
where c.name = 'Khartoum'); --making a view with countries C'
                        --that directly border C
                        --C2 is set to the bordering country


create or replace view neighbors(countryName) as
--find all neighboring countries C'' of C'
select a.country2
from symmetric_borders a, neighboring_countries c
where a.country1 = c.C2
--subtracting the C' countries themselves
and a.country2 in (select country
                        from encompasses
                        where continent = 'Africa')
except
(select C2
from neighboring_countries
union
select C1
from neighboring_countries);


select sum(ceil(population/100000))
from country CY, neighbors N
where CY.code = N.countryName
