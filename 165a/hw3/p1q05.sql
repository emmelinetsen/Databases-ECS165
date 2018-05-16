select distinct island
from locatedOn LO 
where city <> all ( select city
			from located L
			where sea is not null
			and L.city = LO.city
			and L.province = LO.province
			and L.country = LO.country) --checking to make sure you're chosing the same city
