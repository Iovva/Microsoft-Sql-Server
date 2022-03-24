CREATE OR ALTER FUNCTION validate_client_adress(@country varchar(30), @county varchar(30), @street varchar(30), @number int, @storey int)
RETURNS INT
BEGIN
IF LEN(@country) = 0 OR LEN(@county) = 0 OR LEN(@street) = 0 OR @number <= 0 OR @storey <= 0
    RETURN 0
RETURN 1
END

GO

CREATE OR ALTER PROCEDURE CRUD_client_adress
@country VARCHAR(30),
@county VARCHAR(30),
@street VARCHAR(30),
@number INT,
@storey INT,
@NoRows INT
AS
BEGIN

--VALIDARE
DECLARE @validator INT = (SELECT dbo.validate_client_adress(@country, @county, @street, @number, @storey))
IF @Validator = 0
BEGIN
    PRINT 'Eroare la validarea datelor!'
    RETURN
END

--CREATE
DECLARE @I INT = 0
WHILE @I < @NoRows
BEGIN
    INSERT INTO ClientAddress(country, county, street, number, storey)
    VALUES (@country, @county, @street, @number, @storey)
    SET @I = @I + 1
END

--READ
SELECT * FROM ClientAddress
WHERE country = @country
AND county = @county
AND street = @street
AND number = @number
AND storey = @storey

--UPDATE
UPDATE ClientAddress
SET country = 'Australia'
WHERE country = @country
AND county = @county
AND street = @street
AND number = @number
AND storey = @storey

--DELETE
DELETE FROM ClientAddress
WHERE country = 'Australia'
AND county = @county
AND street = @street
AND number = @number
AND storey = @storey

PRINT 'Operatiile CRUD pentru tabelul ClientAdress au fost facute cu succes!'
END

-- testele


dbcc checkident ('ClientAddress', reseed, 1000);
EXEC CRUD_client_adress '', 'County', 'Street', 1, 1, 40 -- fail
EXEC CRUD_client_adress 'Country', '', 'Street', 1, 1, 40 -- fail
EXEC CRUD_client_adress 'Country', 'County', '', 1, 1, 40 -- fail
EXEC CRUD_client_adress 'Country', 'County', 'Street', -1, 1, 40 -- fail
EXEC CRUD_client_adress 'Country', 'County', 'Street', 1, -1, 40 -- fail


dbcc checkident ('ClientAddress', reseed, 1000);
EXEC CRUD_client_adress 'Country', 'County', 'Street', 1, 1, 40 -- succes

select * from ClientAddress;



-------


go

CREATE OR ALTER FUNCTION validate_client (@clientName VARCHAR(30), @idAdress INT)
RETURNS INT
BEGIN
--IF NOT EXISTS (SELECT * FROM Client WHERE clientName = @clientName AND idAdress = @idAdress)
--    RETURN 0
IF NOT EXISTS (SELECT * FROM ClientAddress WHERE idClientAdress = @idAdress)
    RETURN 0
IF LEN(@clientName) = 0
    RETURN 0
RETURN 1
END

GO

CREATE OR ALTER PROCEDURE CRUD_client
@clientName VARCHAR(30),
@idAdress INT,
@NoRows INT
AS
BEGIN

--VALIDARE
DECLARE @Validator INT = (SELECT dbo.validate_client(@clientName, @idAdress))
IF @Validator = 0
BEGIN
    PRINT 'Eroare la validarea datelor!'
    RETURN
END

--CREATE
DECLARE @I INT = 0
WHILE @I < @NoRows
BEGIN
    INSERT INTO Client(clientName, idAdress)
    VALUES (@clientName, @idAdress)
    SET @I = @I + 1
END

--READ
SELECT * FROM Client
WHERE clientName = @clientName
AND idAdress = @idAdress

--UPDATE
UPDATE Client
SET clientName = 'Nume random'
WHERE clientName = @clientName
AND idAdress = @idAdress

--DELETE
DELETE FROM Client
WHERE clientName = 'Nume random'
AND idAdress = @idAdress

PRINT 'Operatiile CRUD pentru tabelul Client au fost facute cu succes!'
END

-- testele


select * from ClientAddress

EXEC CRUD_Client '', 1, 40 -- fail
EXEC CRUD_Client 'Nume', 10000, 40 -- fail


dbcc checkident ('Client', reseed, 1000);
EXEC CRUD_Client 'Nume', 1, 40 -- succes

select * from Client



---



go

CREATE OR ALTER FUNCTION validate_purchase_history (@idClient INT, @idProduct INT, @price int, @deliveryCost int)
RETURNS INT
BEGIN
IF NOT EXISTS (SELECT * FROM Client WHERE idClient = @idClient)
    RETURN 0
IF NOT EXISTS (SELECT * FROM Product WHERE idProduct = @idProduct)
    RETURN 0
IF @price <= 0 OR @deliveryCost <= 0
    RETURN 0
RETURN 1
END

GO

CREATE OR ALTER PROCEDURE CRUD_purchase_history
@idClient INT,
@idProduct INT,
@price INT,
@deliveryCost INT,
@NoRows INT
AS
BEGIN

--VALIDARE
DECLARE @Validator INT = (SELECT dbo.validate_purchase_history(@idClient, @idProduct, @price, @deliveryCost))
IF @Validator = 0
BEGIN
    PRINT 'Eroare la validarea datelor!'
    RETURN
END

--CREATE
DECLARE @I INT = 0
WHILE @I < @NoRows
BEGIN

    INSERT INTO PurchaseHistory(idClient, idProduct, price, deliveryCost)
    VALUES (@idClient, @idProduct + @I, @price, @deliveryCost)
	SET @I = @I + 1
END

--READ
SELECT * FROM PurchaseHistory
WHERE idClient = @idClient
AND idProduct >= @idProduct
AND @idProduct <= @idProduct + @NoRows
AND price = @price
AND deliveryCost = @deliveryCost

--UPDATE
UPDATE PurchaseHistory
SET price = 69
WHERE idClient = @idClient
AND idProduct >= @idProduct
AND @idProduct <= @idProduct + @NoRows
AND price = @price
AND deliveryCost = @deliveryCost

--DELETE
DELETE FROM PurchaseHistory
WHERE idClient = @idClient
AND idProduct <= @idProduct + @NoRows
AND price = 69
AND deliveryCost = @deliveryCost

PRINT 'Operatiile CRUD pentru tabelul PurchaseHistory au fost facute cu succes!'
END

-- testele


--INSERT INTO Product (productName, descriptionProduct, price, discount, idCompany) VALUES 
--('LTD EC-1', 'E, double h', 
--'950', '0', '1')

select * from Client
select * from Product


EXEC CRUD_purchase_history 1000, 18, 100, 10, 18 -- fail
EXEC CRUD_purchase_history 1, 1000, 100, 10, 18 -- fail
EXEC CRUD_purchase_history 1, 18, -1, 10, 18 -- fail
EXEC CRUD_purchase_history 1, 18, 100, -1, 18 -- fail


EXEC CRUD_purchase_history 1, 18, 100, 10, 18 -- succes

select * from PurchaseHistory




------index

go

CREATE NONCLUSTERED INDEX IX_Client_Adress_asc ON 
ClientAddress (idClientAdress ASC)
INCLUDE (country, county,
street, number, storey)

CREATE NONCLUSTERED INDEX IX_Client_Purchase_History_asc ON 
PurchaseHistory (idClient ASC, idProduct ASC)
INCLUDE (price, deliveryCost)


DROP INDEX IX_Client_Adress_asc ON ClientAddress;
DROP INDEX IX_Client_Purchase_History_asc ON PurchaseHistory;

----views

go

create or alter view vw_ClientAdress as
select C.country, C.county,
C.street, C.number, C.storey
from ClientAddress as C;

go

create or alter view vw_ClientPurchaseHistory as
select C.clientName, C.idAdress,
P.deliveryCost, P.price
from Client as C
inner join PurchaseHistory as P
on P.idClient = C.idClient;

go

select * from vw_ClientAdress
select * from vw_ClientPurchaseHistory



