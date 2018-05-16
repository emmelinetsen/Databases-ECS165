CREATE VIEW GMV(CountryName, year, indicator, data) as
select name, year, 'POP', data from GM_POP
union
select name, year, 'LE', data from GM_LE
union
select name, year, 'EL', data from GM_EL
union
select name, year, 'GDP', data from GM_GDP
union
select name, year, 'HS', data from GM_HS;


