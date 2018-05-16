select C.countryCode
from COUNTRY C, CITY CY
where CY.pop > 1000000
and C.countryCode = CY.country 
