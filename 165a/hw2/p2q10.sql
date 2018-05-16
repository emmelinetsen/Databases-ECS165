select cityId
from CITY
where pop is not null
except
select C1.cityId
from CITY C1, CITY C2
where C1.pop < C2.pop
and C1.pop is not null
and C2.pop is not null
