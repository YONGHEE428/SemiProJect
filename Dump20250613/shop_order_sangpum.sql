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
-- Table structure for table `order_sangpum`
--

DROP TABLE IF EXISTS `order_sangpum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_sangpum` (
  `order_sangpum_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `option_id` int NOT NULL,
  `cnt` int NOT NULL,
  `price` int NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT '주문접수',
  PRIMARY KEY (`order_sangpum_id`),
  KEY `fk_order_sangpum_order` (`order_id`),
  KEY `fk_order_sangpum_product` (`product_id`),
  KEY `fk_order_sangpum_option` (`option_id`),
  CONSTRAINT `fk_order_sangpum_option` FOREIGN KEY (`option_id`) REFERENCES `product_option` (`option_id`),
  CONSTRAINT `fk_order_sangpum_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_sangpum_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_sangpum`
--

LOCK TABLES `order_sangpum` WRITE;
/*!40000 ALTER TABLE `order_sangpum` DISABLE KEYS */;
INSERT INTO `order_sangpum` VALUES (18,12,73,76,1,100,'반품접수'),(19,12,69,69,1,10,'주문접수'),(20,13,69,68,1,10,'반품접수'),(21,14,69,68,1,10,'주문접수'),(22,15,73,76,1,100,'주문접수'),(23,16,73,76,1,100,'주문접수'),(24,17,73,76,1,100,'주문접수'),(25,18,73,76,1,100,'주문접수'),(26,19,67,65,3,600,'반품접수'),(27,19,77,82,1,120,'주문접수'),(28,19,86,100,2,140,'반품접수'),(29,19,69,68,3,30,'주문접수'),(30,20,72,75,1,5800,'반품접수'),(31,20,73,76,1,100,'반품접수'),(32,21,106,192,1,12000,'반품접수'),(33,22,73,76,1,100,'주문접수');
/*!40000 ALTER TABLE `order_sangpum` ENABLE KEYS */;
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

-- Dump completed on 2025-06-13 16:13:36
