select le.country
from GM_LE le, GM_HS hs 
where le.year = 2000 
AND hs.year = 2000 
AND le.country = hs.country
AND le.le is not null
AND hs.hs is not null 
AND NOT EXISTS ( select le2.country from GM_LE le2, GM_HS hs2 
	where le2.year = 2000 AND hs2.year = 2000 
	AND le2.country = hs2.country 
	AND hs2.hs >= hs.hs
	AND le2.le >= le.le
	AND (le2.le > le.le OR hs2.hs > hs.hs )
);
