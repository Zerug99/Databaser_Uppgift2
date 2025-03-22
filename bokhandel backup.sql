-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: pj_bokhandel
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `beställningar`
--

DROP TABLE IF EXISTS `beställningar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `beställningar` (
  `OrderID` int NOT NULL AUTO_INCREMENT,
  `KundID` int NOT NULL,
  `Datum` date NOT NULL,
  `Totalbelopp` decimal(10,2) NOT NULL,
  PRIMARY KEY (`OrderID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `beställningar_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beställningar`
--

LOCK TABLES `beställningar` WRITE;
/*!40000 ALTER TABLE `beställningar` DISABLE KEYS */;
INSERT INTO `beställningar` VALUES (100,1,'2025-03-12',234.00),(101,2,'2025-03-13',150.00),(102,3,'2025-03-15',340.50),(103,3,'2025-03-15',150.00),(104,3,'2025-03-15',234.00);
/*!40000 ALTER TABLE `beställningar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `böcker`
--

DROP TABLE IF EXISTS `böcker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `böcker` (
  `ISBN` varchar(20) NOT NULL,
  `Titel` varchar(255) NOT NULL,
  `Författare` varchar(255) NOT NULL,
  `Pris` decimal(10,2) NOT NULL,
  `Lagerstatus` int NOT NULL,
  PRIMARY KEY (`ISBN`),
  CONSTRAINT `kolla_pris` CHECK ((`pris` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `böcker`
--

LOCK TABLES `böcker` WRITE;
/*!40000 ALTER TABLE `böcker` DISABLE KEYS */;
INSERT INTO `böcker` VALUES ('9781407132082','The Hunger Games','Suzanne Collins',150.00,8),('9789189516076','Fourth Wing','Rebecca Yarros',340.50,7),('9789198616880','Alvblod','Andrzej Sapkowski',234.00,9);
/*!40000 ALTER TABLE `böcker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kunder`
--

DROP TABLE IF EXISTS `kunder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kunder` (
  `KundID` int NOT NULL AUTO_INCREMENT,
  `Namn` varchar(255) NOT NULL,
  `E_POST` varchar(150) DEFAULT NULL,
  `Telefon` varchar(50) NOT NULL,
  `Adress` varchar(255) NOT NULL,
  PRIMARY KEY (`KundID`),
  UNIQUE KEY `E_POST` (`E_POST`),
  KEY `idx_epost` (`E_POST`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kunder`
--

LOCK TABLES `kunder` WRITE;
/*!40000 ALTER TABLE `kunder` DISABLE KEYS */;
INSERT INTO `kunder` VALUES (1,'Patryk Jersak','patryk@test.com','123456789','Algatan 46'),(2,'David Miletic','david99@hotmail.com','233346688','Perstorpsvägen 7'),(3,'Adam Svensson','adam.svensson42@gmail.com','291246299','Kungshallsvägen 42'),(4,'Alma Petersson','alma10@hotmailc.com','22334411','Törnvägen 8');
/*!40000 ALTER TABLE `kunder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kundlogg`
--

DROP TABLE IF EXISTS `kundlogg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kundlogg` (
  `LoggID` int NOT NULL AUTO_INCREMENT,
  `KundID` int DEFAULT NULL,
  `RegTid` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Meddelande` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LoggID`),
  KEY `KundID` (`KundID`),
  CONSTRAINT `kundlogg_ibfk_1` FOREIGN KEY (`KundID`) REFERENCES `kunder` (`KundID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kundlogg`
--

LOCK TABLES `kundlogg` WRITE;
/*!40000 ALTER TABLE `kundlogg` DISABLE KEYS */;
INSERT INTO `kundlogg` VALUES (1,1,'2025-03-22 18:11:32','Ny kund registrerad: Patryk Jersak'),(2,2,'2025-03-22 18:11:32','Ny kund registrerad: David Miletic'),(3,3,'2025-03-22 18:11:32','Ny kund registrerad: Adam Svensson'),(4,4,'2025-03-22 18:11:32','Ny kund registrerad: Alma Petersson');
/*!40000 ALTER TABLE `kundlogg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderrader`
--

DROP TABLE IF EXISTS `orderrader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderrader` (
  `OrderradID` int NOT NULL AUTO_INCREMENT,
  `ISBN` varchar(20) NOT NULL,
  `OrderID` int NOT NULL,
  `Antal` int NOT NULL,
  PRIMARY KEY (`OrderradID`),
  KEY `ISBN` (`ISBN`),
  KEY `OrderID` (`OrderID`),
  CONSTRAINT `orderrader_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `böcker` (`ISBN`),
  CONSTRAINT `orderrader_ibfk_2` FOREIGN KEY (`OrderID`) REFERENCES `beställningar` (`OrderID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderrader`
--

LOCK TABLES `orderrader` WRITE;
/*!40000 ALTER TABLE `orderrader` DISABLE KEYS */;
INSERT INTO `orderrader` VALUES (1,'9789198616880',100,1),(2,'9781407132082',101,1),(3,'9789189516076',102,2),(4,'9781407132082',102,1),(5,'9789189516076',102,1);
/*!40000 ALTER TABLE `orderrader` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-22 19:11:47
