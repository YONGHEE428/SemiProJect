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
-- Table structure for table `takeback`
--

DROP TABLE IF EXISTS `takeback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `takeback` (
  `takeback_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `order_sangpum_id` int NOT NULL,
  `payment_idx` int NOT NULL,
  `member_num` int NOT NULL,
  `receiver_name` varchar(50) NOT NULL,
  `receiver_hp` varchar(20) NOT NULL,
  `receiver_addr` varchar(200) NOT NULL,
  `refund_amount` int DEFAULT '0',
  `return_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pickup_date` date DEFAULT NULL,
  `pickup_request` varchar(200) DEFAULT NULL,
  `takeback_status` varchar(30) NOT NULL DEFAULT '신청',
  PRIMARY KEY (`takeback_id`),
  KEY `fk_takeback_order` (`order_id`),
  KEY `fk_takeback_payment` (`payment_idx`),
  KEY `fk_takeback_member` (`member_num`),
  KEY `fk_takeback_sangpum` (`order_sangpum_id`),
  CONSTRAINT `fk_takeback_member` FOREIGN KEY (`member_num`) REFERENCES `member` (`num`),
  CONSTRAINT `fk_takeback_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_takeback_payment` FOREIGN KEY (`payment_idx`) REFERENCES `payment` (`idx`),
  CONSTRAINT `fk_takeback_sangpum` FOREIGN KEY (`order_sangpum_id`) REFERENCES `order_sangpum` (`order_sangpum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takeback`
--

LOCK TABLES `takeback` WRITE;
/*!40000 ALTER TABLE `takeback` DISABLE KEYS */;
INSERT INTO `takeback` VALUES (13,19,28,32,9,'현승윤','01012345678','16923,경기 용인시 기흥구 진산로 124,굿',0,'2025-06-13 00:44:53','2025-06-13','16923,경기 용인시 기흥구 진산로 124,굿','신청'),(14,20,30,33,9,'현승윤','01012345678','16923,경기 용인시 기흥구 진산로 124,굿',2800,'2025-06-13 01:49:56','2025-06-13','16923,경기 용인시 기흥구 진산로 124,굿','신청'),(15,19,26,32,9,'현승윤','01012345678','16923,경기 용인시 기흥구 진산로 124,굿',0,'2025-06-13 02:36:29','2025-06-13','16923,경기 용인시 기흥구 진산로 124,굿','신청'),(16,20,31,33,9,'현승윤','01012345678','16923,경기 용인시 기흥구 진산로 124,굿',0,'2025-06-13 02:38:19','2025-06-13','16923,경기 용인시 기흥구 진산로 124,굿','신청'),(17,21,32,34,9,'현승윤','01012345678','16923,경기 용인시 기흥구 진산로 124,굿',9000,'2025-06-13 02:47:44','2025-06-13','16923,경기 용인시 기흥구 진산로 124,굿','신청');
/*!40000 ALTER TABLE `takeback` ENABLE KEYS */;
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
