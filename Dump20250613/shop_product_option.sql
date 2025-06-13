-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: shop.c9a8cage4o0m.ap-northeast-2.rds.amazonaws.com    Database: shop
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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `product_option`
--

DROP TABLE IF EXISTS `product_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_option` (
  `option_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `color` varchar(50) NOT NULL,
  `size` varchar(50) NOT NULL,
  `stock_quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `product_id` (`product_id`,`color`,`size`),
  CONSTRAINT `product_option_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=213 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_option`
--

LOCK TABLES `product_option` WRITE;
/*!40000 ALTER TABLE `product_option` DISABLE KEYS */;
INSERT INTO `product_option` VALUES (64,67,'검정','M',34),(65,67,'검정','L',33),(66,68,'White/Obsidian Grey','240',24),(67,68,'White/Obsidian Grey','250',45),(68,69,'Navy','M',657),(69,69,'Navy','L',2),(70,70,'Silver','M',33),(72,71,'Black','M',766),(73,71,'Black','L',22),(74,72,'Silver','M',2),(75,72,'Silver','L',4),(76,73,'White','M',32),(77,74,'Blue','S',54),(78,74,'Blue','M',4),(79,75,'Camo','FREE',54),(80,76,'Mid Blue','M',23),(81,76,'Mid Blue','L',545),(82,77,'Khaki','FREE',342),(83,78,'White','M',34),(84,79,'Blue','M',34),(85,79,'Blue','L',4545),(86,80,'Mocha','M',343),(87,80,'Mocha','L',546),(88,81,'Ice Blue','M',23),(89,81,'Ice Blue','L',234),(90,81,'Ice Blue','XL',56),(91,82,'Slate','M',34),(92,82,'Slate','L',56),(93,83,'Slate Blue','M',345),(94,83,'Slate Blue','L',6577),(95,84,'Charcoal','S',34),(96,84,'Charcoal','L',544),(97,85,'Blue','M',55),(98,85,'Blue','L',76),(99,86,'Black','M',343),(100,86,'Black','L',65),(101,87,'Green','S',54),(102,87,'Green','M',76),(103,88,'Camo','M',54),(104,88,'Camo','L',45),(105,89,'Mustard','M',34),(106,89,'Mustard','L',65),(107,90,'Black/White','M',55),(108,90,'Black/White','L',76),(109,91,'Melange Grey','M',57),(110,91,'Melange Grey','L',767),(111,92,'Black','M',65),(112,92,'Black','L',67),(113,92,'Black','XL',877),(114,93,'Dark Grey','230',65),(115,93,'Dark Grey','240',56),(116,93,'Dark Grey','250',55),(117,93,'Dark Grey','260',4),(142,100,'Chanvre','240',4),(191,106,'블랙','M',34),(192,106,'블랙','L',645),(195,108,'인디고','FREE',54),(207,112,'검정','M',233),(208,112,'검정','L',0);
/*!40000 ALTER TABLE `product_option` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-13 16:13:37
