select c2.code, c2.population, 
	(select sum(c.population) --looknig into the population for country2
		from country c, symmetric_borders sb
		where c.code = sb.country2 --look into the 2nd country
		and c2.code = sb.country1
		group by c2.code)
from country c2

