CREATE VIEW GMH (CountryName, year, LE, POP, GDP, HS, EL) as 
select M.CountryName, M.year, (Select N.data from GMV N where M.CountryName=N. CountryName and M.year=N. year and indicator = 'LE'), 
(Select X.data from GMV X where M.CountryName=X. CountryName and M.year=X. year and indicator = 'POP'), 
(Select Z.data from GMV Z where M.CountryName=Z. CountryName and M.year=Z. year and indicator = 'GDP'),
(Select A.data from GMV A where M.CountryName=A. CountryName and M.year=A. year and indicator = 'HS'),
(Select B.data from GMV B where M.CountryName=B. CountryName and M.year=B. year and indicator = 'EL')
from GMV M;

