CREATE DATABASE  IF NOT EXISTS `dsic` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `dsic`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: dsic
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `postid` int NOT NULL AUTO_INCREMENT,
  `img` varchar(1000) COLLATE utf8mb3_bin NOT NULL,
  `comment` varchar(300) COLLATE utf8mb3_bin NOT NULL,
  `userid` varchar(30) COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`postid`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (38,'dd541196-4b8d-476f-949a-5efb13a61c3e.avif df17d1fc-69e3-4a5b-8463-798f9dd00799.jpg ','','aaa'),(45,'1b83f55c-ed12-4298-8fa1-6ffe47a706ae.png f4d9fe67-b3a4-4319-96ea-2c6072b62284.png 5711859c-3b38-45da-82c2-2f694e45aa4b.png ','ㅎㅎ','aaa'),(51,'62427fa7-9e88-4141-9cc1-d9abfceff12c.png ','성향','aaa'),(52,'dec8ed98-62e5-478d-b5f4-8479369ecdda.png 991046cd-9e31-401f-8016-bcf2d574fd14.png  ','test22','bbb'),(53,'6750bf38-573a-4b42-8fc0-1657182c13dd.jpeg ','프로필 변경테스트','bbb'),(54,'88987af1-ec00-47e0-96e0-8f4fec769d61.png c1715532-1bcc-4316-8b85-d23c442b502e.png 3c753ed8-cc06-42ce-8042-cb111458072b.png ','테스트이미지','bbb'),(55,'3500b881-55a9-4155-bc52-8a82654c713c.png 4524030f-a7cf-4363-a34b-9ab8856bcee1.png c59db864-a5ec-4a6d-afb6-35ae95f1e39f.png ae240f23-851f-4212-a544-7e75b75f0c88.png c60577e1-b245-404f-bc4d-8faf700c393e.png 38808219-133e-47ed-9f28-0aa2c083639d.png ','345','bbb'),(57,'5548bb5e-3ec5-4151-9b7d-91667a89d278.avif c3a3bb88-ec07-47af-b980-6ec113934869.jpg be582efe-a064-4846-b38d-bbb5c09bb72d.jpeg ','길이\r\n테스트\r\n중입니다','aaa'),(58,'ed556370-9233-42d6-b863-94a01244cf36.jpeg 2ef0fed9-bb6a-48a6-ae08-56024fad7d85.png ','ㅎㅇ','aaa'),(59,'bd438b25-d60a-42e4-8bf9-b72b40aa8ef7.jpeg a4699db1-ba05-4df0-980f-d4cd0e519f1f.jpeg ','gd','aabb1'),(60,'701075da-a54b-44d8-835d-a6eb1e8d31b8.png c86c730a-a6b2-426c-8f37-6fbe34321a36.jpeg 97b2119b-ec35-49d1-ba22-057eaa25939c.png 25cc7dad-a7c3-43e3-95f0-359854da8a2a.png e5bd2b33-e48d-4c8d-b5e5-f32a7fc605d9.jpg ','test4','aaa'),(61,'10409a07-07ac-4ec3-a809-610d09fb6b2a.png 5139f1c0-6c26-4f3b-a8d3-a50997f8c43f.png ','1번 2번 업로드!','aabb1'),(64,'14e3c2bc-4b26-45c8-90d6-7c441d796c0d.avif 1ad21450-7a24-4d05-8d94-66c90c2dbebf.jpg 40d09aa6-f8e7-4ff9-b9ba-60f2805de95a.jpeg ','test','test1234');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(30) COLLATE utf8mb3_bin NOT NULL,
  `pw` varchar(45) COLLATE utf8mb3_bin NOT NULL,
  `nm` varchar(45) COLLATE utf8mb3_bin NOT NULL,
  `img` varchar(50) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('aaa','aaa','test_user','ba81af8f-99fc-4b77-816d-00f6ff2fe36a.avif'),('aabb1','1234','abcd','09108c2c-6822-4694-9905-8c4078bc0e13.jpeg'),('asdf1234','1234','asdf',NULL),('bbb','bbb','bbb','c19dcd61-8eb4-4a7f-9bea-bfbf9256d005.jpeg'),('test1234','1234','aaaa','7f21c854-5642-481c-a76f-06ec7d616194.jpeg');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'dsic'
--

--
-- Dumping routines for database 'dsic'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-16  9:04:44
