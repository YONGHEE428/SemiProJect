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
-- Table structure for table `cartlist`
--

DROP TABLE IF EXISTS `cartlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartlist` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `option_id` int NOT NULL,
  `member_id` varchar(45) NOT NULL,
  `cnt` int NOT NULL,
  `writeday` timestamp NOT NULL,
  `buyok` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idx`),
  KEY `product_id_idx` (`product_id`),
  KEY `option_id_idx` (`option_id`),
  CONSTRAINT `fk_option_id` FOREIGN KEY (`option_id`) REFERENCES `product_option` (`option_id`),
  CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartlist`
--

LOCK TABLES `cartlist` WRITE;
/*!40000 ALTER TABLE `cartlist` DISABLE KEYS */;
INSERT INTO `cartlist` VALUES (15,69,70,'test',1,'2025-06-10 01:40:41',1),(20,100,142,'test',1,'2025-06-11 02:33:31',0),(55,108,195,'dyd',54,'2025-06-11 07:53:15',0),(58,80,87,'dyd',1,'2025-06-11 08:33:09',0),(59,80,87,'dyd',2,'2025-06-11 08:33:14',0),(60,76,81,'dyd',5,'2025-06-11 08:44:01',0),(62,69,69,'dyd',1,'2025-06-12 00:14:44',1),(63,73,76,'dyd',1,'2025-06-12 00:14:53',1),(64,69,68,'dyd',1,'2025-06-12 03:58:20',1),(65,69,68,'dyd',1,'2025-06-12 05:45:02',1),(66,73,76,'dyd',1,'2025-06-12 06:53:22',1),(67,73,76,'son',1,'2025-06-12 07:25:55',1),(68,108,195,'son',1,'2025-06-12 07:28:37',0),(69,73,76,'son',1,'2025-06-12 07:39:21',1),(70,73,76,'son',5,'2025-06-12 07:41:08',0),(71,70,70,'juxxi',1,'2025-06-12 08:15:45',0),(73,82,91,'juxxi',5,'2025-06-12 08:16:26',0),(74,90,107,'juxxi',1,'2025-06-12 08:19:56',0),(75,90,107,'juxxi',2,'2025-06-12 08:20:01',0),(76,100,142,'juxxi',3,'2025-06-12 08:21:15',0),(77,100,142,'juxxi',1,'2025-06-12 08:21:20',0),(78,73,76,'juxxi',1,'2025-06-12 08:21:47',1),(79,73,76,'son',5,'2025-06-12 08:36:06',0),(80,78,83,'dyd',1,'2025-06-13 00:19:08',0),(81,106,192,'dyd',5,'2025-06-13 00:22:58',0),(82,106,192,'hyeon',2,'2025-06-13 00:25:38',0),(83,78,83,'hyeon',2,'2025-06-13 00:25:49',0),(86,69,68,'hyeon',3,'2025-06-13 00:38:08',1),(87,86,100,'hyeon',2,'2025-06-13 00:40:07',1),(88,77,82,'hyeon',1,'2025-06-13 00:40:18',1),(89,67,65,'hyeon',3,'2025-06-13 00:40:30',1),(90,73,76,'hyeon',1,'2025-06-13 00:43:29',1),(91,72,75,'hyeon',1,'2025-06-13 00:43:39',1),(92,106,192,'son',1,'2025-06-13 00:43:40',0),(93,106,192,'hyeon',2,'2025-06-13 01:39:28',0),(94,90,107,'hyeon',2,'2025-06-13 01:39:35',0),(95,76,81,'juxxi',5,'2025-06-13 01:49:09',0),(96,76,81,'juxxi',5,'2025-06-13 01:49:15',0),(97,73,76,'son',1,'2025-06-13 01:57:49',0),(98,73,76,'dyd',1,'2025-06-13 02:04:28',1),(99,76,81,'juxxi',2,'2025-06-13 02:20:11',0),(100,76,81,'juxxi',2,'2025-06-13 02:20:18',0),(101,106,192,'hyeon',1,'2025-06-13 02:39:48',1),(102,108,195,'dyd',2,'2025-06-13 05:10:01',0);
/*!40000 ALTER TABLE `cartlist` ENABLE KEYS */;
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

-- Dump completed on 2025-06-13 16:13:35
