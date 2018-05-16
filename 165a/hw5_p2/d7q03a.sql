select cc.Continent, round(avg(GDP.gdp),2)
from encompasses cc, gm_bridge BT, GM_GDP GDP
where BT.mondial_country_code = cc.country
AND GDP.country = BT.gm_country_name
AND year = 2000
Group by cc.Continent;
