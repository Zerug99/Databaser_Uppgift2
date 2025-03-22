# Databaser – Uppgift 2
**Patryk Jersak YH24**

Detta projekt bygger på en databaslösning och innehåller den nödvändiga SQL-koden för att lösa uppgift 2.

## Innehåll

- Reflektion

- SQL-skript

- Backup


## Relationer

**Relation 1 (1:N) mellan Kunder och Beställningar:**
En kund kan ha flera beställningar, men varje beställning tillhör endast en kund. Därför finns `KundID` som en främmande nyckel (FK) i tabellen Beställningar. Två kunder kan alltså inte dela på samma beställning.

**Relation mellan Beställningar och Orderrader (1:N):**
En beställning kan innehålla flera orderrader. Varje orderrad tillhör en specifik beställning, vilket kopplas genom `OrderID` som FK i Orderrader.

**Relation mellan Orderrader och Böcker (N:1):**
Varje orderrad hänvisar till en bok (via `ISBN`), men en bok kan förekomma i många orderrader. Därför har vi `ISBN` som en FK i Orderrader.
Orderrader fungerar som en kopplingstabell som binder ihop Böcker och Beställningar, och därigenom även kopplas till Kunder via Beställningar.

Jag testade först att skapa relationerna utan en mellanliggande tabell (bridge table), men fick flera felmeddelanden om att tabellen man försökte referera till inte existerade. Därför blev lösningen med Orderrader som kopplingstabell både logisk och nödvändig.

## Constraint

Jag implementerade ett `CHECK`-villkor i databasen för att förhindra att man anger pris 0 på böcker. Det gör att man inte kan lägga till en bok utan värde.


En förbättring hade kunnat vara att sätta ett ännu högre minsta pris, eftersom 1 eller 2 kronor fortfarande är väldigt billigt. Alternativt hade man kunnat sätta olika regler för olika typer av böcker eller specifika ISBN.

## Trigger
Syftet med triggern i databasen var att automatiskt minska lagersaldot i `Böcker` varje gång en ny orderrad läggs till. 
Trigger använder `NEW.Antal` för att veta antalet och `NEW.ISBN` för vilken bok det är. Dessa värden går vidare till `UPDATE`-sats som minskar kolumnen `Lagerstatus` som finns i tabellen `Böcker`
Det var riktigt smidigt med triggers och man kanske skulle kunna lägg till en trigger som loggar en varning när lagersaldo gå ner ett viss nivå. 
Då kan inköpare beställa nya böcker innan det tar helt slut i lagersaldot. 

På så sätt behöver man inte manuellt justera lagret vid varje beställning.
Ju mindre man behöver ändra manuellt, desto mindre är risken för fel. Denna typ av automatisk uppdatering gör databasen mer robust och pålitlig.


Lite svårt med att veta vart går gränserna med sql och känns som man kan hamna i ett rabbit hål lätt.


** Framtiden 

När butiken skulle ha växt till flera tusen kunder skulle jag lägga index på flera ställen som t.ex `KundID`,`ISBN` och `OrderID` Så det skulle förbättra sökningen. 
Viktigt att inte hämta all data med `Select *` för det skulle möjligtvis sänka ner servern. Man skulle helt enkelt inte ha sammma fritid som man hade med ett litet databas.
Jag skulle också bli mer specifikt på storleken på fält som definieras, det ska vara rimligt längd för `VARCHAR` Man minskar helt enkelt onödig datalagring. 
Blivit mer sträng med backups, skulle man förlora data på alla ordrar när man har flera tusen kunder så skulle det inte uppskattas av någon. Möjligtvis en trigger som gör ett backup ett viss tid som passar. 
Sist men inte minst skulle jag automatisera med att inserta values t.ex för kunder, för det känns inte optimalt att göra det manuellt. 


