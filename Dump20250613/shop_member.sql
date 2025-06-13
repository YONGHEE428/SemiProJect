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
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `num` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `id` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `hp` varchar(45) NOT NULL,
  `birth` date NOT NULL,
  `role` varchar(45) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`num`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,'관리자','admin','1234','admin@gmail.com','02-000-0000','2025-05-28','admin'),(2,'박용희','dyd','1234','dydwns@gmail.com','010-1234-1234','2025-04-28','user'),(4,'테스트','test','1234','test@gmail.com','010-111-1111','1999-09-29','uesr'),(7,'원주희','juxxi','1234','juxxi@gmail.com','010-1234-5678','2025-06-11','user'),(8,'손현정','son','1234','son@gmail.com','010-1234-5678','2025-06-11','user'),(9,'현승윤','hyeon','1234','hyeon@gmail.com','010-1234-5678','2025-06-11','user'),(10,'박용희','dydwns4280','dydwns1127','dydwns4280@gmail.com','010-8337-5432','2025-06-13','user'),(11,'박용희','asdss','0000','dydwns4280@gmail.com','01083375432','2025-06-13','user'),(12,'박창배','dyd','1234','asd@naver.com','01066514771','2025-06-13','user');
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
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
