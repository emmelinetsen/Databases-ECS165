select distinct X.country
from country_religion X
where not exists (
	select distinct religion from UDEF_RELIGION
	except
	select distinct Y.religion from country_religion Y
	where Y.country = X.country 
)
