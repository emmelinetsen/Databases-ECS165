select CY.cityId, CY.pop, C.countryCode
from CITY CY, COUNTRY C, country_continent
where C.capital = CY.cityId
and continent like '%Africa%'
and CY.country = country_continent.country
