select country1, count(country2) 
from symmetric_borders
group by country1 
having count(country2) >= 4
