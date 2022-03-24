use InstrumentDatabase
go

create view vw_ClientAdress as
select C.country, C.county,
C.street, C.number, C.storey
from ClientAddress as C;

go

create view vw_ClientPurchaseHistory as
select C.clientName, C.idAdress,
P.deliveryCost, P.price
from Client as C
inner join PurchaseHistory as P
on P.idClient = C.idClient;

go

create view vw_ClientPurchaseHistoryGrouped as
select C.clientName as ClientName, count(P.idProduct) InstrumentsPurchased
from Client as C
inner join PurchaseHistory as P
on P.idClient = C.idClient
GROUP BY C.clientName

go

select * from vw_ClientAdress
select * from vw_ClientPurchaseHistory
select * from vw_ClientPurchaseHistoryGrouped


--------

insert into Tables (Name) values
('ClientAdress'),
('Client'),
('PurchaseHistory')

insert into Views (Name) values
('vw_ClientAdress'),
('vw_ClientPurchaseHistory'),
('vw_ClientPurchaseHistoryGrouped')

insert into Tests(Name) values
('delete_table'),
('insert_table'),
('select_view')

-----!!

delete from TestTables

insert into TestTables(TestID, TableID, NoOfRows, Position) values
('1','1','1000','1'),
('2','1','1000','1'),
('1','2','1000','2'),
('2','2','1000','2'),
('1','3','1000','3'),
('2','3','1000','3')


-----

insert into TestViews(TestID, ViewID) values
('3','1'),
('3','2'),
('3','3')

--

select * from PurchaseHistory
select * from Client
select * from ClientAddress

select * from Tables
select * from Views
select * from Tests
select * from TestTables
select * from TestViews
select * from TestRunTables
select * from TestRunViews
select * from TestRuns

