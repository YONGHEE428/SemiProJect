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
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `imp_uid` varchar(100) NOT NULL,
  `merchant_uid` varchar(100) NOT NULL,
  `member_num` int NOT NULL,
  `amount` int NOT NULL,
  `cancelled_amount` int NOT NULL DEFAULT '0' COMMENT '누적 취소 금액',
  `addr` varchar(200) DEFAULT NULL,
  `delivery_msg` varchar(300) DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `hp` varchar(20) DEFAULT NULL,
  `buyer_email` varchar(100) DEFAULT NULL,
  `buyer_name` varchar(50) DEFAULT NULL,
  `paymentday` timestamp NOT NULL,
  `last_refund_date` timestamp NULL DEFAULT NULL COMMENT '마지막 환불 처리 일시',
  PRIMARY KEY (`idx`),
  UNIQUE KEY `imp_uid_UNIQUE` (`imp_uid`),
  KEY `member_num_idx` (`member_num`),
  CONSTRAINT `member_num` FOREIGN KEY (`member_num`) REFERENCES `member` (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (28,'imp_000269713333','ORD20250612-CB2029',2,3100,0,'서울 강북구 도봉로89길 1,일단나와동,01074','3100 주소 테스트중','paid','0288889999','kimupmin@gmail.com','김상민','2025-06-12 06:55:11',NULL),(29,'imp_641266019958','ORD20250612-886DDE',8,3100,0,'[01678],서울 노원구 노원로34길 9,sadasd','부재 시 경비실에 맡겨주세요.','paid','01012345678','son@gmail.com','손현정','2025-06-12 07:28:11',NULL),(30,'imp_837005104685','ORD20250612-5FDC6B',8,3100,0,'63534,제주특별자치도 서귀포시 가가로 14,감귤리 153','부재 시 경비실에 맡겨주세요.','paid','01094999949','yjyj0345@naver.com','손연재','2025-06-12 07:40:35',NULL),(31,'imp_096597749173','ORD20250612-5354EA',7,3050,0,'06035,서울 강남구 가로수길 5,2층','문 앞에 놔두고 가세요.','paid','01012345678','juxxi@gmail.com','원주희','2025-06-12 08:24:03',NULL),(32,'imp_220344861278','ORD20250613-69ADDC',9,3890,0,'16923,경기 용인시 기흥구 진산로 124,굿','부재 시 경비실에 맡겨주세요.','paid','01012345678','hyeon@gmail.com','현승윤','2025-06-13 00:42:53',NULL),(33,'imp_157434788705','ORD20250613-D50243',9,8900,0,'16923,경기 용인시 기흥구 진산로 124,굿','부재 시 경비실에 맡겨주세요.','paid','01012345678','hyeon@gmail.com','현승윤','2025-06-13 00:44:25',NULL),(34,'imp_161431009372','ORD20250613-6F1DE0',9,15000,0,'16923,경기 용인시 기흥구 진산로 124,굿','부재 시 경비실에 맡겨주세요.','paid','01012345678','hyeon@gmail.com','현승윤','2025-06-13 02:41:07',NULL),(35,'imp_205056922144','ORD20250613-8E1F35',2,3080,0,'서울 강북구 도봉로89길 1,일단나와동,01074','부재 시 경비실에 맡겨주세요.','paid','01012341234','dydwns@gmail.com','박용희','2025-06-13 06:28:29',NULL);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
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
