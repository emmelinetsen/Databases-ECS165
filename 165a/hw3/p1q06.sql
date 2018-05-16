select R.Name, ROUND((SUM(R.Percentage * C.Population)/ --gets total number of people who are of that religion 
		(select SUM(C2.Population)
			from COUNTRY C2
			)),2) --divide by total population
from RELIGION R, COUNTRY C
where R.Country = C.Code
group by R.Name --group by each religion name
