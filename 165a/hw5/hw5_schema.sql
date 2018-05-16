create table INCOME(name varchar(50), year integer, data double precision, constraint income_pk PRIMARY KEY (name,year));
create table HEALTH_SPENDING(name varchar(50), year integer, data double precision, constraint health_pk PRIMARY KEY (name,year));
create table ELECTRICITY(name varchar(50), year integer, data double precision, constraint electricity_pk PRIMARY KEY (name,year));
create table POPULATION(name varchar(50), year integer, data double precision, constraint pop_pk PRIMARY KEY (name,year));
create table LIFE_EXPECTANCY(name varchar(50), year integer, data double precision, constraint le_pk PRIMARY KEY (name,year));
