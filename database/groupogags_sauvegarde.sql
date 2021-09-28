-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: groupogags
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(30) DEFAULT NULL,
  `date` datetime NOT NULL,
  `comment` text NOT NULL,
  `on_gag` smallint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `on_gag_id` (`on_gag`),
  CONSTRAINT `on_gag_id` FOREIGN KEY (`on_gag`) REFERENCES `gags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (81,'Benjamin','2021-07-01 12:12:57','Premier commentaire !',66),(88,'Ibrahim','2021-07-01 18:18:26','zeaeazezae',74);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gags`
--

DROP TABLE IF EXISTS `gags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gags` (
  `id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `op` varchar(40) DEFAULT NULL,
  `likes` smallint unsigned DEFAULT NULL,
  `dislikes` smallint unsigned DEFAULT NULL,
  `nb_of_comments` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gags`
--

LOCK TABLES `gags` WRITE;
/*!40000 ALTER TABLE `gags` DISABLE KEYS */;
INSERT INTO `gags` VALUES (66,'Miaaaaam','http://localhost:3000/images/puree-de-piment-carolina-reaper-hellicious1624049575754.jpg','2021-06-18 22:52:55','Ibrahim',2,0,1),(74,'wot','http://localhost:3000/images/31625140172736.gif','2021-07-01 13:49:32','Benjamin',1,1,1);
/*!40000 ALTER TABLE `gags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `like_dislike`
--

DROP TABLE IF EXISTS `like_dislike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `like_dislike` (
  `user_id_fk` varchar(40) NOT NULL,
  `gag_id_fk` smallint unsigned NOT NULL,
  `likeType` tinyint NOT NULL,
  PRIMARY KEY (`user_id_fk`,`gag_id_fk`),
  KEY `fk_gag_id` (`gag_id_fk`),
  CONSTRAINT `fk_gag_id` FOREIGN KEY (`gag_id_fk`) REFERENCES `gags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id_fk`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `like_dislike`
--

LOCK TABLES `like_dislike` WRITE;
/*!40000 ALTER TABLE `like_dislike` DISABLE KEYS */;
INSERT INTO `like_dislike` VALUES ('28024423-f119-4c16-9152-971fe4d99a1d',66,1),('28024423-f119-4c16-9152-971fe4d99a1d',74,1),('8b57a07c-a8d1-473c-a62e-b1583ab6d519',66,1),('8b57a07c-a8d1-473c-a62e-b1583ab6d519',74,-1);
/*!40000 ALTER TABLE `like_dislike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(40) NOT NULL,
  `user` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(72) NOT NULL,
  `privilege` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('28024423-f119-4c16-9152-971fe4d99a1d','Benjamin','castaladi@gmail.com','azeazeaze',NULL),('85312737-2268-428e-908e-d46aed9d72b0','Maurice','maurice@gmail.com','azeazeaze',NULL),('8b57a07c-a8d1-473c-a62e-b1583ab6d519','Ibrahim','benjamindm@hotmail.fr','azeazeaze',1),('df0bf559-ca46-4801-a292-20cb49000478','zeeeeeee','ibburhani@gmail.com','$2b$10$UTR/J6ZeuG2zlYHhzL4OjOSFpETGl9kjbScPau7iVHmmHDlh.29Vq',NULL),('e46e22fd-96a9-41d7-8261-45c06521fb25','Raba','rara@gmail.com','$2b$10$y9gc.9SAMemD8UTwJDW/buf6fsEjQiug2gClLGKLnk2fJpv0uNlm.',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-02 11:56:30
