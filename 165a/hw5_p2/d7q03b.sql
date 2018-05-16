select cc.Continent, round((sum(GDP.gdp*POP.pop)/ sum(POP.pop)),2)
from encompasses cc, gm_bridge BT, GM_GDP GDP, GM_POP pop
where BT.mondial_country_code = cc.country
AND GDP.country = BT.gm_country_name
AND GDP.year = 2000
AND pop.country = BT.gm_country_name
AND pop.year = 2000
Group by cc.Continent;
