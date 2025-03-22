CREATE DATABASE pj_bokhandel; 

USE pj_bokhandel; 

-- Nedanför ser man skapandet av en av tabellerna Kunder. Inom parenteserna anger man varje attribut med vilken datatyp som ska användas.
CREATE TABLE kunder (  -- Kunder är Entitet och nedanför anger man attributer 

KundID INT AUTO_INCREMENT PRIMARY KEY, -- skapar attributen och anger det som PK och automatisk utdelning av INT, alltså det delar ut en unikt siffra och man slipper göra det manuellt . PK står för primärnyckel och är som ett unikt identifierar för varje rad. 

Namn VARCHAR (255) NOT NULL, --  VARCHAR betyder att man kommer anger datatyp (tecken) och 255 är hur många tecken det får bli, NOT NULL betyder att namn måste alltid ha ett värde och får inte vara NOT NULL
E_POST VARCHAR (150) UNIQUE,-- UNIQUE betyder att en kund kan inte använda en existerande E_Post. Det ska vara unika. 
Telefon VARCHAR (50) NOT NULL, 
Adress VARCHAR (255) NOT NULL
);


CREATE TABLE böcker ( -- Här skapas en ny tabell och datatypen här är DECIMAL (10,2,) detta anger hur många siffror det får vara totalt 10 och 2 står för hur många decimaler det får vara. (  ); Inom dessa skriver man koden och avlsutar på );

ISBN VARCHAR(20) PRIMARY KEY, 
Titel VARCHAR(255) NOT NULL,
Författare VARCHAR(255) NOT NULL,
Pris DECIMAL(10,2)NOT NULL, 
Lagerstatus INT NOT NULL
);


CREATE TABLE beställningar (

OrderID INT AUTO_INCREMENT PRIMARY KEY,
KundID INT NOT NULL,
Datum DATE NOT NULL,
Totalbelopp DECIMAL(10,2) NOT NULL,
FOREIGN KEY (KundID) REFERENCES Kunder(KundID) -- Här anger man En FK och pekar ut vart den ska referera till vilket är då till tabellen där PK finns och själva namnet på PK. Detta skapar en relation mellan tabellen. Beställning är kopplad till 1 kund. Viktigt att man anger rätt value i KundID, där ska det inte vara på auto.  
) AUTO_INCREMENT = 100; -- Detta är till att den ska börja dela ut siffror från 100 så det blir lite snyggare i tabellen sen. 


CREATE TABLE orderrader ( -- Detta är vårt brygg - tabell som indirekt kopplar ihop beställningar och böcker. Orderrader tabellen är också kopplad till dem.  

OrderradID INT AUTO_INCREMENT PRIMARY KEY,
ISBN VARCHAR (20) NOT NULL,
OrderID INT NOT NULL,
Antal INT NOT NULL,
FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN), -- Här kopplar vi igen som vi gjorde innan fast nu i böcker tabellen 
FOREIGN KEY (OrderID) REFERENCES beställningar(OrderID)
);

CREATE TABLE KundLogg (
LoggID INT AUTO_INCREMENT PRIMARY KEY, 
KundID INT, 
RegTid TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Meddelande VARCHAR (255),
FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);

ALTER TABLE Böcker 
ADD CONSTRAINT kolla_pris
CHECK (pris > 0);
    
    
 DELIMITER $$

CREATE TRIGGER logga_ny_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO KundLogg (KundID, Meddelande)
    VALUES (
        NEW.KundID,
        CONCAT('Ny kund registrerad: ', NEW.Namn)
    );
END $$

DELIMITER ;
    
    
    
    
DELIMITER $$
CREATE TRIGGER minskalager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
 UPDATE Böcker
 SET Lagerstatus = Lagerstatus - NEW.Antal
 WHERE ISBN = NEW.ISBN;
END $$
DELIMITER ;
    

-- kod för att inserta value för att sedan kunna hämta upp den senare i rad 77

INSERT INTO Kunder (Namn, E_Post, Telefon, Adress) VALUES -- Man srkiver först vilken tabell man vill lägga in datan och sedan vilka attributer som ska få sinna values.
("Patryk Jersak", "patryk@test.com", 0123456789, "Algatan 46"); -- Viktigt att ha (); för att se början av radet och slutet. Man srkiver i ordning och använder " " mellan stringen. Symbolen , markerar slutet av värde 

-- Uppgift_2 Vi fortsätter med att lägga in datan i alla 


INSERT INTO Kunder (Namn, E_Post, Telefon, Adress) VALUES -- OBS vi lägger inte till KundID här för vi har gjort att nummerfördelning sker automatiskt, så då behövs inte manuellt INSERT 
("David Miletic","david99@hotmail.com",233346688,"Perstorpsvägen 7"),
("Adam Svensson","adam.svensson42@gmail.com",291246299,"Kungshallsvägen 42"),
("Alma Petersson", "alma10@hotmailc.com", 22334411, "Törnvägen 8"); -- Nu har vi lagt in totalt 3 Kunder, man lägger in datan i den ordningen man har skrivit sina attributter i rad 76. Viktigt o lägga in rätt datatyp i raden. 

INSERT INTO böcker (ISBN, Titel, författare, Pris, Lagerstatus) VALUES
("9789198616880", "Alvblod", "Andrzej Sapkowski", 234.00, 10),
("9781407132082", "The Hunger Games", "Suzanne Collins", 150.00, 10),
("9789189516076", "Fourth Wing", "Rebecca Yarros", 340.50, 10);

INSERT INTO beställningar (KundID, Datum, Totalbelopp) VALUES -- Jag anger inte PK för den kommer automatiskt men viktigt med att det man pekar ut rätt värde på FK, alltså redan ett edxisterande värde som finns in tabellen kunder :)
(1, "2025-03-12", 234.00),
(2, "2025-03-13", 150.00),
(3, "2025-03-15", 340.50),
(3, "2025-03-15", 150.00),
(3, "2025-03-15",234.00);

INSERT INTO Orderrader (ISBN, orderID, Antal) VALUES -- Det som är viktigt att man tänker logiskt och matar in datan rätt, vi vet att orderraderID kommer automatiskt mata in nummer. Vitkgit nu att ange ett rätt ISBN Nummer och rätt OrderID
("9789198616880", 100 , 1), -- Här syftar jag till ISBN, orderID och antal, ISBN och OrderID måste 
("9781407132082",101, 1),
("9789189516076",102, 2),
("9781407132082",102, 1),
("9789189516076",102,1);

CREATE INDEX idx_epost ON Kunder(E_Post);


SELECT * -- hämtar all datan från kunder och beställningar, seperatta tabeller 
FROM beställningar;
Select * 
FROM Kunder;

SELECT -- Filtrera kund med specifik namn
Namn,
E_post
FROM Kunder
WHERE Namn = "Patryk Jersak";

SELECT -- Filtrera kund med specifik E_post
Namn,
E_post
FROM Kunder
WHERE E_Post = "patryk@test.com";

SELECT -- Filtrera frön större än 150 och ASC
Totalbelopp
From beställningar
WHERE Totalbelopp >150
ORDER BY Totalbelopp ASC;

SELECT -- Filtrerar från högst upp till ner 
Totalbelopp
From beställningar
ORDER BY Totalbelopp DESC;

SELECT * FROM KUNDER;


SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0; -- autocommit var igång, stäng av med att skriva 0 efter

START TRANSACTION; 
UPDATE Kunder
SET E_Post = "tdsdsdsdsd@com" WHERE Namn = "Patryk Jersak";
SELECT E_Post FROM Kunder WHERE Namn = "Patryk Jersak";

ROLLBACK;
COMMIT;


----------------------------
-- allt matchande och börjar från Orderrader
SELECT
Orderrader.orderradID,
Beställningar.OrderID,
Böcker.titel,
Orderrader.Antal,
Kunder.KundID,
Kunder.Namn,
Kunder.E_post
FROM Orderrader -- Relektion, det jag tog upp om från första uppgiften är att Kunder bedhöver inte läggas på orrderrader för att den får ddet genom beställningarna för att kunder läggs på deras tabell. ochj sedan går det vidare. 
INNER JOIN Böcker ON Orderrader.ISBN = Böcker.ISBN
INNER JOIN Beställningar ON Orderrader.OrderID = Beställningar.OrderID
INNER JOIN Kunder ON Beställningar.KundID = Kunder.KundID;

SELECT -- omatchad data som börjar från kunder. Reflektion här är att det är inte lätt att göra ett left joins än right joins. 
Kunder.KundID,
Orderrader.orderradID,
Böcker.titel,
Orderrader.Antal,
Kunder.Namn,
Kunder.E_post
FROM Kunder
LEFT JOIN Beställningar ON Kunder.KundID = Beställningar.kundID
LEFT JOIN Orderrader ON Beställningar.OrderID = Orderrader.OrderID
LEFT JOIN Böcker ON Orderrader.ISBN = Böcker.ISBN;

SELECT 
Beställningar.KundID, 
 COUNT(Beställningar.OrderID) AS Antal_Beställningar
FROM Beställningar
GROUP BY Beställningar.KundID;

SELECT
Beställningar.KundID,
COUNT(Beställningar.OrderID) AS Totalt_beställningar
FROM Beställningar
Group BY Beställningar.KundID
having totalt_beställningar >2;
------------------------------------ 

    
    
