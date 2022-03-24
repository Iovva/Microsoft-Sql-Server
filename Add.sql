USE InstrumentDatabase
GO

INSERT INTO InstrumentCompany (companyName) VALUES 
('ESP'),
('Gibson'),
('Fender'),
('Ibanez'),
('Epiphone');


USE InstrumentDatabase
GO 

INSERT INTO Product (productName, descriptionProduct, price, discount, idCompany) VALUES 
('LTD EC-1000', 'Ebony, double humbuckers', 
'950', '0', '1'),
('PHEONIX-1000', 'White, double humbuckers', 
'1200', '20', '1'),
('SG Standard', 'Cherry, double humbuckers', 
'1400', '0', '2'),
('57 LP Junior', 'Sunburst, single coils', 
'1400', '0', '2'),
('J. Hendrix Signature', 'White, double coils', 
'1400', '0', '3'),
('J. Root Signature', 'White, double humbuckers', 
'1300', '25', '3'),
('R3112', 'Rose, single humbucker', 
'2600', '0', '4'),
('Express VS', 'Sunburst, double humbuckers', 
'120', '25', '5');

USE InstrumentDatabase
GO

INSERT INTO ClientAddress(country, county, street, number, storey) VALUES 
('Romania','Vrancea','Cuza-Voda',13,2),
('U.S.A.','Arizona','Harlem',3,5),
('U.S.A.','Florida','Ale Street',2,1),
('Romania','Cluj','Ghioceilor',3,0),
('Romania','Iasi','Garoafeo',1,1),
('U.S.A.','Alaska','Wafers',4,1),
('U.K.','-','Queens Street',1,7),
('U.S.A.','California','Florence',7,27);

USE InstrumentDatabase
GO

INSERT INTO Client(clientName, idAdress) VALUES
('Samadaul Lucian', 1),
('Lennon John', 2),
('Adam Andrew', 3),
('Creanga Ionut', 4),
('Mincu Andrei',5),
('Kobain Curt',6),
('Sir Smith John the 3rd',7),
('Black Rebecca',8);

USE InstrumentDatabase
GO

INSERT INTO PurchaseHistory(idClient, idProduct, price, deliveryCost) VALUES
(2, 10, 950 ,15),
(2, 11, 1180 ,15),
(3, 11, 1180, 0),
(4, 14, 1400, 125),
(5, 17, 1400, 30),
(6, 14, 1400, 25),
(7, 17, 1275, 12),
(8, 13, 2600, 200),
(9, 10, 95, 140);

USE InstrumentDatabase
GO

INSERT INTO ShopAdress(country, county, street, number, storey) VALUES
('Romania','Bucharest','Mihai Eminscu', 13, 1),
('Romania','Vrancea','Florilor',1,4),
('U.K.','Cluj','Horea',164,5);

USE InstrumentDatabase
GO
INSERT INTO Manager(managerName, yearsOfService, bonus) VALUES 
('Cercel Petrica', 10, 20000),
('Cercel Ionut', 5, 2000),
('Nabo Ana', 1, 500);

USE InstrumentDatabase
GO
INSERT INTO InstrumentShop(shopName, idAdress, idManager) VALUES
('The Rolling Stone', 1, 1),
('AbraCadabre', 2, 2),
('Danse', 3, 3);

USE InstrumentDatabase
GO
INSERT INTO Employee(nameEmployee, yearsOfService, position, salary, idShop) VALUES
('Margu Ionut', 3, 'Janitor', 18000, 1),
('Berinu Octavian', 6, 'Clerk', 56000, 1),
('Ion Dragos', 8, 'Sound Check', 74000, 1),
('Bebu Stefan', 2, 'Clerk', 40000, 2),
('Merinde Beirut', 3, 'Maintenance', 69000, 2),
('Nabo Tifanny', 3, 'Clerk', 38000, 3);

USE InstrumentDatabase
GO
INSERT INTO Product_Shop(idProduct, idShop, dateOfArrival, conditionOfArrival) VALUES
(10,1, '2021-09-28 04:54:23', 'Prestine'),
(13,1, '2019-02-14 22:26:29','Minimal Wear'),
(14,1, '2020-11-15 21:28:48','Well Worn'),
(15,1, '2021-09-05 18:09:18','Factory New'),
(11,2, '2021-02-25 06:50:46','Well Worn'),
(12,2, '2019-10-27 20:46:50','Minimal Wear'),
(13,2, '2021-07-30 00:26:07','Well Worn'),
(11,3, '2019-03-12 20:15:52','Factory New'),
(15,3, '2019-06-29 06:20:32','Well Worn'),
(16,3, '2020-08-07 07:01:01','Factory New'),
(17,3, '2019-02-25 12:00:42','Factory New');

