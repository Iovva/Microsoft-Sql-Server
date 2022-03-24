CREATE DATABASE InstrumentDatabase
GO
USE InstrumentDatabase
GO

CREATE TABLE InstrumentCompany(
idCompany INT PRIMARY KEY IDENTITY,
companyName VARCHAR(30)
);

CREATE TABLE ShopAdress(
idShopAdress INT PRIMARY KEY IDENTITY,
country VARCHAR(30),
county VARCHAR(30),
street VARCHAR(30),
number INT,
storey INT
);


CREATE TABLE ClientAddress(
idClientAdress INT PRIMARY KEY IDENTITY,
country VARCHAR(30),
county VARCHAR(30),
street VARCHAR(30),
number INT,
storey INT
)


CREATE TABLE Manager(
idManager INT PRIMARY KEY IDENTITY,
managerName VARCHAR(30),
yearsOfService INT,
bonus INT
);


CREATE TABLE InstrumentShop(
idShop INT PRIMARY KEY IDENTITY,
shopName VARCHAR(20),
idAdress INT FOREIGN KEY REFERENCES ShopAdress(idShopAdress),
idManager INT FOREIGN KEY REFERENCES Manager(idManager)
);

CREATE TABLE Product(
idProduct INT PRIMARY KEY IDENTITY,
productName VARCHAR(30),
descriptionProduct VARCHAR(30),
price FLOAT,
discount FLOAT,
idCompany INT FOREIGN KEY REFERENCES InstrumentCompany(idCompany)
);

CREATE TABLE Product_Shop(
idProduct INT FOREIGN KEY REFERENCES Product(idProduct),
idShop INT FOREIGN KEY REFERENCES InstrumentShop(idShop),
dateOfArrival DATETIME,
conditionOfArrival VARCHAR(30),
CONSTRAINT pk_ProductShop PRIMARY KEY (idProduct, idShop)
)


CREATE TABLE Client (
idClient INT PRIMARY KEY IDENTITY,
clientName VARCHAR(30),
idAdress INT FOREIGN KEY REFERENCES ClientAddress(idClientAdress)
)

CREATE TABLE PurchaseHistory(
idTransaction INT PRIMARY KEY IDENTITY,
idClient INT FOREIGN KEY REFERENCES Client(idClient),
idProduct INT FOREIGN KEY REFERENCES Product(idProduct),
price FLOAT,
deliveryCost FLOAT,
)


ALTER TABLE PurchaseHistory
DROP CONSTRAINT PK__Purchase__A0DB88154B532DAB;

ALTER TABLE PurchaseHistory
ALTER COLUMN idClient INT NOT NULL;

ALTER TABLE PurchaseHistory
ALTER COLUMN idProduct INT NOT NULL;

ALTER TABLE PurchaseHistory
ADD CONSTRAINT pk_PurchaseHistory PRIMARY KEY (idClient, idProduct);

ALTER TABLE PurchaseHistory
DROP COLUMN idTransaction



CREATE TABLE Employee(
idEmployee INT PRIMARY KEY IDENTITY,
nameEmployee VARCHAR(30),
yearsOfService INT,
position VARCHAR(30),
salary FLOAT,
idShop INT FOREIGN KEY REFERENCES InstrumentShop(idShop)
)

USE MASTER
GO
DROP DATABASE InstrumentDatabase

USE InstrumentDatabase
GO
DROP TABLE ClientAddress;
DROP TABLE Client;
DROP TABLE ProductsSold;
DROP TABLE PurchaseHistory;
DROP TABLE ClientAddress;