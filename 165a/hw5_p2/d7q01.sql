select E.continent, B.gm_country_name, min(latitude), max(latitude), round(avg(latitude),2)
from city CY, gm_bridge B, encompasses E 
where CY.country = B.mondial_country_code 
AND CY.country = E.country
group by E.continent, B.gm_country_name
order by E.continent, B.gm_country_name;
