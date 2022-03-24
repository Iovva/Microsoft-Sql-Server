/*
Extrage perechile distincte Client-Instrument, plasate de clienti
din Romania, pentru una din cele 2 modele de chitara electrica:
Express sau EC-1000.
*/
USE InstrumentDatabase
GO

SELECT DISTINCT C.clientName, P.productName
FROM Client C 
INNER JOIN ClientAddress CA ON C.idAdress = CA.idClientAdress
INNER JOIN PurchaseHistory PH ON PH.idClient = C.idClient
INNER JOIN Product P ON P.idProduct = PH.idProduct
WHERE P.idProduct = 10 OR P.idProduct = 17
GROUP BY CA.country, C.clientName, P.productName
HAVING CA.country = 'Romania';


/*
Afiseaza toti angajatii pt managerii
cu numele de familie Cercel (tata si fiu).
*/
USE InstrumentDatabase
GO

SELECT DISTINCT E.nameEmployee, M.managerName
FROM Employee E
INNER JOIN InstrumentShop I on E.idShop = I.idShop
INNER JOIN Manager M on M.idManager = I.idManager
GROUP BY E.nameEmployee, M.managerName
HAVING M.managerName like 'Cercel%';


/*
Afiseaza toate produsele disponibile la toate magazinele.
*/
USE InstrumentDatabase
GO 

SELECT I.shopName, P.productName
FROM InstrumentShop I 
INNER JOIN Product_Shop PS ON PS.idShop = I.idShop
INNER JOIN Product P ON PS.idProduct = P.idProduct;


/*
Afiseaza numarul de produse achizitionate de fiecare 
client.
*/
USE InstrumentDatabase
GO 

SELECT C.clientName, COUNT(PH.idProduct) InstrumentsPurchased
FROM PurchaseHistory PH
INNER JOIN Client C ON PH.idClient = C.idClient
GROUP BY C.clientName;



/*
Afiseaza numele magzinului si adresa acestiuia, pentru
managerii cu mai putin de 6 ani in acest rol.
*/
USE InstrumentDatabase
GO 

SELECT M.managerName, I.shopName, SA.country, SA.county, SA.street, SA.number, SA.storey FROM
Manager M
INNER JOIN InstrumentShop I ON I.idManager= M.idManager
INNER JOIN ShopAdress SA ON SA.idShopAdress = I.idAdress
WHERE M.yearsOfService < 6;


/*
Afiseaza angajatii care lucreaza la un magazin
din Romania.
*/
USE InstrumentDatabase
GO 

SELECT E.nameEmployee FROM
Employee E
INNER JOIN InstrumentShop I ON E.idShop = I.idShop
INNER JOIN ShopAdress SA ON SA.idShopAdress = I.idAdress
WHERE SA.country = 'Romania';


/*
Afiseaza conditia si data in care au fost livrate
instrumentele mai scumpe de 1300 de dolari.
*/
USE InstrumentDatabase
GO 

SELECT IC.companyName, PS.conditionOfArrival, PS.dateOfArrival FROM
InstrumentCompany IC
INNER JOIN Product P ON IC.idCompany = P.idCompany
INNER JOIN Product_Shop PS ON PS.idProduct = P.idProduct
WHERE P.price > 1300;



/*
Afiseaza numele angajatilor si anii de experienta,
pentru managerii cu mai mult de 5 ani experienta.
*/
USE InstrumentDatabase
GO 

SELECT E.nameEmployee, E.yearsOfService, M.managerName, M.yearsOfService
FROM Employee E
INNER JOIN InstrumentShop I ON I.idShop = E.idShop
INNER JOIN Manager M ON M.idManager = I.idManager
WHERE M.yearsOfService > 5;


/*
Afiseaza pretul si reducerea pentru toate instrumentele
la reducere.
*/
USE InstrumentDatabase
GO 

SELECT P.productName, P.descriptionProduct, P.price, P.discount
FROM Product P
WHERE DISCOUNT > 0;


/*
Afiseaza numarul de magazine ale bussiness-ului.
*/
USE InstrumentDatabase
GO 

SELECT COUNT(SA.idShopAdress) 'NumberOfLocations'
FROM ShopAdress SA;




/* 
 10 interogari, dintre care:
- 6 interogări ce folosesc where
- 3 interogări ce folosesc group by
- 2 interogări ce folosesc distinct
- 2 interogări cu having
- 7 interogări ce extrag informaţii din mai mult de 2 tabele
- 4 interogări pe tabele alfate în relaţie m-n.
*/