SELECT 'GDP', count(distinct(country))
FROM GM_GDP
WHERE gdp is not null;

SELECT 'LE', count(distinct(country))
FROM GM_LE
WHERE le is not null;

SELECT 'EL', count(distinct(country))
FROM GM_EL
WHERE el is not null;

SELECT 'POP', count(distinct(country))
FROM GM_POP
WHERE pop is not null;

SELECT 'HS', count(distinct(country))
FROM GM_HS
WHERE hs is not null;

