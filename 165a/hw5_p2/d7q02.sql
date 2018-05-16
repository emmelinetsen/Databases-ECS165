select E.continent, B.gm_country_name, min(latitude), max(latitude), round(avg(latitude),2), 
(select LE.le 
from gm_bridge BT, GM_LE LE 
where BT.gm_country_name = B.gm_country_name 
AND LE.country = BT.gm_country_name AND LE.year = 2000),
(select GDP.gdp 
from gm_bridge BTG, GM_GDP GDP 
where BTG.gm_country_name = B.gm_country_name 
AND GDP.country = BTG.gm_country_name AND GDP.year = 2000),
(select EL.el 
from gm_bridge BTX, GM_EL EL 
where BTX.gm_country_name = B.gm_country_name 
AND EL.country = BTX.gm_country_name AND EL.year = 2000)
from city CY, gm_bridge B, encompasses E
where CY.country = B.mondial_country_code AND CY.country = E.country 
group by E.continent, B.gm_country_name
order by E.continent, B.gm_country_name;
