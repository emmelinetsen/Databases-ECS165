SELECT country, province, name
from CITY 
where population is not null
and population >= all (select population
			from CITY CY2
			where population is not null
			and CITY.country = CY2.country)

--in order to accomodate for each country otherwise this would just find the single city with the largest population (and not looking at any more countries)
