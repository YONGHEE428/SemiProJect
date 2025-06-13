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
-- Table structure for table `Q_A`
--

DROP TABLE IF EXISTS `Q_A`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Q_A` (
  `inquiry_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` varchar(50) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` text,
  `is_private` tinyint(1) DEFAULT '0',
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`inquiry_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `Q_A_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Q_A`
--

LOCK TABLES `Q_A` WRITE;
/*!40000 ALTER TABLE `Q_A` DISABLE KEYS */;
INSERT INTO `Q_A` VALUES (1,106,'dyd','사이즈 문의','문의 합니다',0,'1234','2025-06-12 00:48:16'),(2,106,'dyd','사이즈 문의','문의 합니다',0,'1234','2025-06-12 00:48:26'),(3,106,'dyd','사이즈 문의','문의합니다',0,'1234','2025-06-12 00:52:43'),(4,106,'dyd','사이즈 문의','문의',0,'1234','2025-06-12 00:59:35'),(5,79,'dyd','재입고 문의','문의합니다',1,'1234','2025-06-12 14:58:57'),(6,78,'dyd','재입고 문의','문의합니다',1,'1234','2025-06-12 15:03:32'),(11,79,'dyd','문의드립니다','제품 사이즈 알려주세요',0,'','2025-06-13 10:14:11'),(12,78,'juxxi','사이즈 문의','상세 사이즈 문의드려요',0,'','2025-06-13 10:37:56'),(13,76,'juxxi','재입고 문의','재입고 문의 드려요',0,'','2025-06-13 10:49:44'),(14,73,'juxxi','상세 사이즈 문의','문의드려요',1,'1234','2025-06-13 10:50:50'),(15,73,'juxxi','사이즈 문의드려요','문의드려요',0,'','2025-06-13 11:21:32');
/*!40000 ALTER TABLE `Q_A` ENABLE KEYS */;
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
