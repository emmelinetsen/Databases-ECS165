select code, count(country2)
--from borders b1 left outer join borders b2
--on b2.country2 is null
--from borders b 
from country 
left outer join symmetric_borders
on code = country1
group by code
