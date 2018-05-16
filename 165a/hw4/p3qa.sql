create table BOM(
	PartId int,
	SuperPartId int,
	Price int);

insert into BOM values(1,null,100);
insert into BOM values(2,1,50);
insert into BOM values(3,1,30);
insert into BOM values(4,2,20);
insert into BOM values(5,2,10);
insert into BOM values(6,3,20);
