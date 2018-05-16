select year,count(value)
from GMV
where value is not null
group by year
order by year;

