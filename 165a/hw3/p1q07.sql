select distinct C1.Code, C2.Code
from Country C1, Country C2, isMember I1, isMember I2
where C1.Code < C2.Code
and I1.country = C1.Code
and I2.country = C2.Code --make sure looking at same countries
and not exists
((	(select Organization
	from isMember
	where country = C1.Code)
	except
	(select Organization
	from isMember
	where country = C2.Code))
	union
	((select Organization
	from isMember
	where country = C2.Code)
	except
	(select Organization
	from isMember
	where country = C1.Code)) --checking to make sure 
) --getting countries that are members of same organization
--if both really is in the same organization, then the output would be null
order by C1.Code, C2.Code
