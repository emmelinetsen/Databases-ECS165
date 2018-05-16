create table GM_GDP(name varchar(50), year integer, data double precision, constraint income_pk PRIMARY KEY (name,year));
create table GM_HS(name varchar(50), year integer, data double precision, constraint health_pk PRIMARY KEY (name,year));
create table GM_EL(name varchar(50), year integer, data double precision, constraint electricity_pk PRIMARY KEY (name,year));
create table GM_POP(name varchar(50), year integer, data double precision, constraint pop_pk PRIMARY KEY (name,year));
create table GM_LE(name varchar(50), year integer, data double precision, constraint le_pk PRIMARY KEY (name,year));
