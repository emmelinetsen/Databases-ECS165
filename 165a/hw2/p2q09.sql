select C1.country
from country_continent C1, country_continent C2
where C1.country = C2.country
and C1.continent not in (C2.continent)
