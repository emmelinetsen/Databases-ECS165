SELECT distinct(Country)
FROM GMH
WHERE LE is not null AND POP is not null 
AND EL is not null AND HS is not null 
AND GDP is not null;

