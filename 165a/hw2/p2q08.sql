select country
from country_continent
where continent like '%Europe%'
intersect
select country
from country_continent
where  continent like '%Asia%'

