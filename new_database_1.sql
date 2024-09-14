-- MySQL dump 10.13  Distrib 8.3.0, for macos12.6 (x86_64)
--
-- Host: localhost    Database: laravel
-- ------------------------------------------------------
-- Server version	8.3.0

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
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `course_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_user_id_foreign` (`user_id`),
  KEY `carts_course_id_foreign` (`course_id`),
  CONSTRAINT `carts_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_courses`
--

DROP TABLE IF EXISTS `class_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_courses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_next_step` tinyint(1) NOT NULL,
  `session_id` bigint unsigned DEFAULT NULL,
  `student_id` bigint unsigned NOT NULL,
  `teacher_id` bigint unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `platform_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_courses_session_id_foreign` (`session_id`),
  KEY `class_courses_student_id_foreign` (`student_id`),
  KEY `class_courses_teacher_id_foreign` (`teacher_id`),
  KEY `class_courses_platform_id_foreign` (`platform_id`),
  CONSTRAINT `class_courses_platform_id_foreign` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`),
  CONSTRAINT `class_courses_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `user_available_sessions` (`id`) ON DELETE SET NULL,
  CONSTRAINT `class_courses_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`),
  CONSTRAINT `class_courses_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_courses`
--

LOCK TABLES `class_courses` WRITE;
/*!40000 ALTER TABLE `class_courses` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counseling_types`
--

DROP TABLE IF EXISTS `counseling_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `counseling_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counseling_types`
--

LOCK TABLES `counseling_types` WRITE;
/*!40000 ALTER TABLE `counseling_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `counseling_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `counsels`
--

DROP TABLE IF EXISTS `counsels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `counsels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `counseling_type_id` bigint unsigned NOT NULL,
  `session_id` bigint unsigned DEFAULT NULL,
  `client_id` bigint unsigned NOT NULL,
  `counselor_id` bigint unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `platform_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `counsels_counseling_type_id_foreign` (`counseling_type_id`),
  KEY `counsels_session_id_foreign` (`session_id`),
  KEY `counsels_client_id_foreign` (`client_id`),
  KEY `counsels_counselor_id_foreign` (`counselor_id`),
  KEY `counsels_platform_id_foreign` (`platform_id`),
  CONSTRAINT `counsels_client_id_foreign` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`),
  CONSTRAINT `counsels_counseling_type_id_foreign` FOREIGN KEY (`counseling_type_id`) REFERENCES `counseling_types` (`id`),
  CONSTRAINT `counsels_counselor_id_foreign` FOREIGN KEY (`counselor_id`) REFERENCES `users` (`id`),
  CONSTRAINT `counsels_platform_id_foreign` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `counsels_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `user_available_sessions` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counsels`
--

LOCK TABLES `counsels` WRITE;
/*!40000 ALTER TABLE `counsels` DISABLE KEYS */;
/*!40000 ALTER TABLE `counsels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_categories`
--

DROP TABLE IF EXISTS `course_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` bigint unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `course_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `course_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_categories`
--

LOCK TABLES `course_categories` WRITE;
/*!40000 ALTER TABLE `course_categories` DISABLE KEYS */;
INSERT INTO `course_categories` VALUES (1,'Ms. Maddison Abernathy Sr.',NULL,NULL,1,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(2,'Kari Graham',NULL,1,1,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(3,'Prof. Edwin Stokes I',NULL,1,1,'2024-09-05 09:10:47','2024-09-05 09:10:47');
/*!40000 ALTER TABLE `course_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_user`
--

DROP TABLE IF EXISTS `course_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_user_course_id_foreign` (`course_id`),
  KEY `course_user_user_id_foreign` (`user_id`),
  CONSTRAINT `course_user_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_user`
--

LOCK TABLES `course_user` WRITE;
/*!40000 ALTER TABLE `course_user` DISABLE KEYS */;
INSERT INTO `course_user` VALUES (1,1,1,0,NULL,NULL),(2,2,1,0,NULL,NULL),(3,3,1,0,NULL,NULL),(4,4,1,0,NULL,NULL),(5,5,1,0,NULL,NULL),(6,1,2,0,NULL,NULL),(7,2,2,0,NULL,NULL),(8,3,2,0,NULL,NULL),(9,4,2,0,NULL,NULL),(10,5,2,0,NULL,NULL),(11,1,3,0,NULL,NULL),(12,2,3,0,NULL,NULL),(13,3,3,0,NULL,NULL),(14,4,3,0,NULL,NULL),(15,5,3,0,NULL,NULL),(16,1,4,0,NULL,NULL),(17,2,4,0,NULL,NULL),(18,3,4,0,NULL,NULL),(19,4,4,0,NULL,NULL),(20,5,4,0,NULL,NULL),(21,1,5,0,NULL,NULL),(22,2,5,0,NULL,NULL),(23,3,5,0,NULL,NULL),(24,4,5,0,NULL,NULL),(25,5,5,0,NULL,NULL),(26,1,6,0,NULL,NULL),(27,2,6,0,NULL,NULL),(28,3,6,0,NULL,NULL),(29,4,6,0,NULL,NULL),(30,5,6,0,NULL,NULL),(31,1,7,0,NULL,NULL),(32,2,7,0,NULL,NULL),(33,3,7,0,NULL,NULL),(34,4,7,0,NULL,NULL),(35,5,7,0,NULL,NULL),(36,1,8,0,NULL,NULL),(37,2,8,0,NULL,NULL),(38,3,8,0,NULL,NULL),(39,4,8,0,NULL,NULL),(40,5,8,0,NULL,NULL),(41,1,9,0,NULL,NULL),(42,2,9,0,NULL,NULL),(43,3,9,0,NULL,NULL),(44,4,9,0,NULL,NULL),(45,5,9,0,NULL,NULL),(46,1,10,0,NULL,NULL),(47,2,10,0,NULL,NULL),(48,3,10,0,NULL,NULL),(49,4,10,0,NULL,NULL),(50,5,10,0,NULL,NULL),(51,1,11,0,NULL,NULL),(52,2,11,0,NULL,NULL),(53,3,11,0,NULL,NULL),(54,4,11,0,NULL,NULL),(55,5,11,0,NULL,NULL),(56,1,12,0,NULL,NULL),(57,2,12,0,NULL,NULL),(58,3,12,0,NULL,NULL),(59,4,12,0,NULL,NULL),(60,5,12,0,NULL,NULL),(61,1,13,0,NULL,NULL),(62,2,13,0,NULL,NULL),(63,3,13,0,NULL,NULL),(64,4,13,0,NULL,NULL),(65,5,13,0,NULL,NULL),(66,1,14,0,NULL,NULL),(67,2,14,0,NULL,NULL),(68,3,14,0,NULL,NULL),(69,4,14,0,NULL,NULL),(70,5,14,0,NULL,NULL),(71,1,15,0,NULL,NULL),(72,2,15,0,NULL,NULL),(73,3,15,0,NULL,NULL),(74,4,15,0,NULL,NULL),(75,5,15,0,NULL,NULL),(76,1,16,0,NULL,NULL),(77,2,16,0,NULL,NULL),(78,3,16,0,NULL,NULL),(79,4,16,0,NULL,NULL),(80,5,16,0,NULL,NULL),(81,1,17,0,NULL,NULL),(82,2,17,0,NULL,NULL),(83,3,17,0,NULL,NULL),(84,4,17,0,NULL,NULL),(85,5,17,0,NULL,NULL),(86,1,18,0,NULL,NULL),(87,2,18,0,NULL,NULL),(88,3,18,0,NULL,NULL),(89,4,18,0,NULL,NULL),(90,5,18,0,NULL,NULL),(91,1,19,0,NULL,NULL),(92,2,19,0,NULL,NULL),(93,3,19,0,NULL,NULL),(94,4,19,0,NULL,NULL),(95,5,19,0,NULL,NULL),(96,1,20,0,NULL,NULL),(97,2,20,0,NULL,NULL),(98,3,20,0,NULL,NULL),(99,4,20,0,NULL,NULL),(100,5,20,0,NULL,NULL),(101,1,21,0,NULL,NULL),(102,2,21,0,NULL,NULL),(103,3,21,0,NULL,NULL),(104,4,21,0,NULL,NULL),(105,5,21,0,NULL,NULL),(106,1,22,0,NULL,NULL),(107,2,22,0,NULL,NULL),(108,3,22,0,NULL,NULL),(109,4,22,0,NULL,NULL),(110,5,22,0,NULL,NULL),(111,1,23,0,NULL,NULL),(112,2,23,0,NULL,NULL),(113,3,23,0,NULL,NULL),(114,4,23,0,NULL,NULL),(115,5,23,0,NULL,NULL),(116,1,24,0,NULL,NULL),(117,2,24,0,NULL,NULL),(118,3,24,0,NULL,NULL),(119,4,24,0,NULL,NULL),(120,5,24,0,NULL,NULL),(121,1,25,0,NULL,NULL),(122,2,25,0,NULL,NULL),(123,3,25,0,NULL,NULL),(124,4,25,0,NULL,NULL),(125,5,25,0,NULL,NULL),(126,1,26,0,NULL,NULL),(127,2,26,0,NULL,NULL),(128,3,26,0,NULL,NULL),(129,4,26,0,NULL,NULL),(130,5,26,0,NULL,NULL),(131,1,27,0,NULL,NULL),(132,2,27,0,NULL,NULL),(133,3,27,0,NULL,NULL),(134,4,27,0,NULL,NULL),(135,5,27,0,NULL,NULL),(136,1,28,0,NULL,NULL),(137,2,28,0,NULL,NULL),(138,3,28,0,NULL,NULL),(139,4,28,0,NULL,NULL),(140,5,28,0,NULL,NULL),(141,1,29,0,NULL,NULL),(142,2,29,0,NULL,NULL),(143,3,29,0,NULL,NULL),(144,4,29,0,NULL,NULL),(145,5,29,0,NULL,NULL),(146,1,30,0,NULL,NULL),(147,2,30,0,NULL,NULL),(148,3,30,0,NULL,NULL),(149,4,30,0,NULL,NULL),(150,5,30,0,NULL,NULL),(151,6,31,0,NULL,NULL),(152,7,31,0,NULL,NULL),(153,8,31,0,NULL,NULL),(154,9,31,0,NULL,NULL),(155,10,31,0,NULL,NULL),(156,6,32,0,NULL,NULL),(157,7,32,0,NULL,NULL),(158,8,32,0,NULL,NULL),(159,9,32,0,NULL,NULL),(160,10,32,0,NULL,NULL),(161,6,33,0,NULL,NULL),(162,7,33,0,NULL,NULL),(163,8,33,0,NULL,NULL),(164,9,33,0,NULL,NULL),(165,10,33,0,NULL,NULL),(166,6,34,0,NULL,NULL),(167,7,34,0,NULL,NULL),(168,8,34,0,NULL,NULL),(169,9,34,0,NULL,NULL),(170,10,34,0,NULL,NULL),(171,6,35,0,NULL,NULL),(172,7,35,0,NULL,NULL),(173,8,35,0,NULL,NULL),(174,9,35,0,NULL,NULL),(175,10,35,0,NULL,NULL),(176,6,36,0,NULL,NULL),(177,7,36,0,NULL,NULL),(178,8,36,0,NULL,NULL),(179,9,36,0,NULL,NULL),(180,10,36,0,NULL,NULL),(181,6,37,0,NULL,NULL),(182,7,37,0,NULL,NULL),(183,8,37,0,NULL,NULL),(184,9,37,0,NULL,NULL),(185,10,37,0,NULL,NULL),(186,6,38,0,NULL,NULL),(187,7,38,0,NULL,NULL),(188,8,38,0,NULL,NULL),(189,9,38,0,NULL,NULL),(190,10,38,0,NULL,NULL),(191,6,39,0,NULL,NULL),(192,7,39,0,NULL,NULL),(193,8,39,0,NULL,NULL),(194,9,39,0,NULL,NULL),(195,10,39,0,NULL,NULL),(196,6,40,0,NULL,NULL),(197,7,40,0,NULL,NULL),(198,8,40,0,NULL,NULL),(199,9,40,0,NULL,NULL),(200,10,40,0,NULL,NULL),(201,6,41,0,NULL,NULL),(202,7,41,0,NULL,NULL),(203,8,41,0,NULL,NULL),(204,9,41,0,NULL,NULL),(205,10,41,0,NULL,NULL),(206,6,42,0,NULL,NULL),(207,7,42,0,NULL,NULL),(208,8,42,0,NULL,NULL),(209,9,42,0,NULL,NULL),(210,10,42,0,NULL,NULL),(211,6,43,0,NULL,NULL),(212,7,43,0,NULL,NULL),(213,8,43,0,NULL,NULL),(214,9,43,0,NULL,NULL),(215,10,43,0,NULL,NULL),(216,6,44,0,NULL,NULL),(217,7,44,0,NULL,NULL),(218,8,44,0,NULL,NULL),(219,9,44,0,NULL,NULL),(220,10,44,0,NULL,NULL),(221,6,45,0,NULL,NULL),(222,7,45,0,NULL,NULL),(223,8,45,0,NULL,NULL),(224,9,45,0,NULL,NULL),(225,10,45,0,NULL,NULL),(226,6,46,0,NULL,NULL),(227,7,46,0,NULL,NULL),(228,8,46,0,NULL,NULL),(229,9,46,0,NULL,NULL),(230,10,46,0,NULL,NULL),(231,6,47,0,NULL,NULL),(232,7,47,0,NULL,NULL),(233,8,47,0,NULL,NULL),(234,9,47,0,NULL,NULL),(235,10,47,0,NULL,NULL),(236,6,48,0,NULL,NULL),(237,7,48,0,NULL,NULL),(238,8,48,0,NULL,NULL),(239,9,48,0,NULL,NULL),(240,10,48,0,NULL,NULL),(241,6,49,0,NULL,NULL),(242,7,49,0,NULL,NULL),(243,8,49,0,NULL,NULL),(244,9,49,0,NULL,NULL),(245,10,49,0,NULL,NULL),(246,6,50,0,NULL,NULL),(247,7,50,0,NULL,NULL),(248,8,50,0,NULL,NULL),(249,9,50,0,NULL,NULL),(250,10,50,0,NULL,NULL),(251,6,51,0,NULL,NULL),(252,7,51,0,NULL,NULL),(253,8,51,0,NULL,NULL),(254,9,51,0,NULL,NULL),(255,10,51,0,NULL,NULL),(256,6,52,0,NULL,NULL),(257,7,52,0,NULL,NULL),(258,8,52,0,NULL,NULL),(259,9,52,0,NULL,NULL),(260,10,52,0,NULL,NULL),(261,6,53,0,NULL,NULL),(262,7,53,0,NULL,NULL),(263,8,53,0,NULL,NULL),(264,9,53,0,NULL,NULL),(265,10,53,0,NULL,NULL),(266,6,54,0,NULL,NULL),(267,7,54,0,NULL,NULL),(268,8,54,0,NULL,NULL),(269,9,54,0,NULL,NULL),(270,10,54,0,NULL,NULL),(271,6,55,0,NULL,NULL),(272,7,55,0,NULL,NULL),(273,8,55,0,NULL,NULL),(274,9,55,0,NULL,NULL),(275,10,55,0,NULL,NULL),(276,6,56,0,NULL,NULL),(277,7,56,0,NULL,NULL),(278,8,56,0,NULL,NULL),(279,9,56,0,NULL,NULL),(280,10,56,0,NULL,NULL),(281,6,57,0,NULL,NULL),(282,7,57,0,NULL,NULL),(283,8,57,0,NULL,NULL),(284,9,57,0,NULL,NULL),(285,10,57,0,NULL,NULL),(286,6,58,0,NULL,NULL),(287,7,58,0,NULL,NULL),(288,8,58,0,NULL,NULL),(289,9,58,0,NULL,NULL),(290,10,58,0,NULL,NULL),(291,6,59,0,NULL,NULL),(292,7,59,0,NULL,NULL),(293,8,59,0,NULL,NULL),(294,9,59,0,NULL,NULL),(295,10,59,0,NULL,NULL),(296,6,60,0,NULL,NULL),(297,7,60,0,NULL,NULL),(298,8,60,0,NULL,NULL),(299,9,60,0,NULL,NULL),(300,10,60,0,NULL,NULL),(301,11,61,0,NULL,NULL),(302,12,61,0,NULL,NULL),(303,13,61,0,NULL,NULL),(304,14,61,0,NULL,NULL),(305,15,61,0,NULL,NULL),(306,11,62,0,NULL,NULL),(307,12,62,0,NULL,NULL),(308,13,62,0,NULL,NULL),(309,14,62,0,NULL,NULL),(310,15,62,0,NULL,NULL),(311,11,63,0,NULL,NULL),(312,12,63,0,NULL,NULL),(313,13,63,0,NULL,NULL),(314,14,63,0,NULL,NULL),(315,15,63,0,NULL,NULL),(316,11,64,0,NULL,NULL),(317,12,64,0,NULL,NULL),(318,13,64,0,NULL,NULL),(319,14,64,0,NULL,NULL),(320,15,64,0,NULL,NULL),(321,11,65,0,NULL,NULL),(322,12,65,0,NULL,NULL),(323,13,65,0,NULL,NULL),(324,14,65,0,NULL,NULL),(325,15,65,0,NULL,NULL),(326,11,66,0,NULL,NULL),(327,12,66,0,NULL,NULL),(328,13,66,0,NULL,NULL),(329,14,66,0,NULL,NULL),(330,15,66,0,NULL,NULL),(331,11,67,0,NULL,NULL),(332,12,67,0,NULL,NULL),(333,13,67,0,NULL,NULL),(334,14,67,0,NULL,NULL),(335,15,67,0,NULL,NULL),(336,11,68,0,NULL,NULL),(337,12,68,0,NULL,NULL),(338,13,68,0,NULL,NULL),(339,14,68,0,NULL,NULL),(340,15,68,0,NULL,NULL),(341,11,69,0,NULL,NULL),(342,12,69,0,NULL,NULL),(343,13,69,0,NULL,NULL),(344,14,69,0,NULL,NULL),(345,15,69,0,NULL,NULL),(346,11,70,0,NULL,NULL),(347,12,70,0,NULL,NULL),(348,13,70,0,NULL,NULL),(349,14,70,0,NULL,NULL),(350,15,70,0,NULL,NULL),(351,11,71,0,NULL,NULL),(352,12,71,0,NULL,NULL),(353,13,71,0,NULL,NULL),(354,14,71,0,NULL,NULL),(355,15,71,0,NULL,NULL),(356,11,72,0,NULL,NULL),(357,12,72,0,NULL,NULL),(358,13,72,0,NULL,NULL),(359,14,72,0,NULL,NULL),(360,15,72,0,NULL,NULL),(361,11,73,0,NULL,NULL),(362,12,73,0,NULL,NULL),(363,13,73,0,NULL,NULL),(364,14,73,0,NULL,NULL),(365,15,73,0,NULL,NULL),(366,11,74,0,NULL,NULL),(367,12,74,0,NULL,NULL),(368,13,74,0,NULL,NULL),(369,14,74,0,NULL,NULL),(370,15,74,0,NULL,NULL),(371,11,75,0,NULL,NULL),(372,12,75,0,NULL,NULL),(373,13,75,0,NULL,NULL),(374,14,75,0,NULL,NULL),(375,15,75,0,NULL,NULL),(376,11,76,0,NULL,NULL),(377,12,76,0,NULL,NULL),(378,13,76,0,NULL,NULL),(379,14,76,0,NULL,NULL),(380,15,76,0,NULL,NULL),(381,11,77,0,NULL,NULL),(382,12,77,0,NULL,NULL),(383,13,77,0,NULL,NULL),(384,14,77,0,NULL,NULL),(385,15,77,0,NULL,NULL),(386,11,78,0,NULL,NULL),(387,12,78,0,NULL,NULL),(388,13,78,0,NULL,NULL),(389,14,78,0,NULL,NULL),(390,15,78,0,NULL,NULL),(391,11,79,0,NULL,NULL),(392,12,79,0,NULL,NULL),(393,13,79,0,NULL,NULL),(394,14,79,0,NULL,NULL),(395,15,79,0,NULL,NULL),(396,11,80,0,NULL,NULL),(397,12,80,0,NULL,NULL),(398,13,80,0,NULL,NULL),(399,14,80,0,NULL,NULL),(400,15,80,0,NULL,NULL),(401,11,81,0,NULL,NULL),(402,12,81,0,NULL,NULL),(403,13,81,0,NULL,NULL),(404,14,81,0,NULL,NULL),(405,15,81,0,NULL,NULL),(406,11,82,0,NULL,NULL),(407,12,82,0,NULL,NULL),(408,13,82,0,NULL,NULL),(409,14,82,0,NULL,NULL),(410,15,82,0,NULL,NULL),(411,11,83,0,NULL,NULL),(412,12,83,0,NULL,NULL),(413,13,83,0,NULL,NULL),(414,14,83,0,NULL,NULL),(415,15,83,0,NULL,NULL),(416,11,84,0,NULL,NULL),(417,12,84,0,NULL,NULL),(418,13,84,0,NULL,NULL),(419,14,84,0,NULL,NULL),(420,15,84,0,NULL,NULL),(421,11,85,0,NULL,NULL),(422,12,85,0,NULL,NULL),(423,13,85,0,NULL,NULL),(424,14,85,0,NULL,NULL),(425,15,85,0,NULL,NULL),(426,11,86,0,NULL,NULL),(427,12,86,0,NULL,NULL),(428,13,86,0,NULL,NULL),(429,14,86,0,NULL,NULL),(430,15,86,0,NULL,NULL),(431,11,87,0,NULL,NULL),(432,12,87,0,NULL,NULL),(433,13,87,0,NULL,NULL),(434,14,87,0,NULL,NULL),(435,15,87,0,NULL,NULL),(436,11,88,0,NULL,NULL),(437,12,88,0,NULL,NULL),(438,13,88,0,NULL,NULL),(439,14,88,0,NULL,NULL),(440,15,88,0,NULL,NULL),(441,11,89,0,NULL,NULL),(442,12,89,0,NULL,NULL),(443,13,89,0,NULL,NULL),(444,14,89,0,NULL,NULL),(445,15,89,0,NULL,NULL),(446,11,90,0,NULL,NULL),(447,12,90,0,NULL,NULL),(448,13,90,0,NULL,NULL),(449,14,90,0,NULL,NULL),(450,15,90,0,NULL,NULL);
/*!40000 ALTER TABLE `course_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `platform_id` bigint unsigned NOT NULL,
  `capacity` int NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` bigint unsigned DEFAULT NULL,
  `demo` bigint unsigned DEFAULT NULL,
  `course_category_id` bigint unsigned DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `publish_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_slug_unique` (`slug`),
  KEY `courses_platform_id_foreign` (`platform_id`),
  KEY `courses_course_category_id_foreign` (`course_category_id`),
  CONSTRAINT `courses_course_category_id_foreign` FOREIGN KEY (`course_category_id`) REFERENCES `course_categories` (`id`) ON DELETE SET NULL,
  CONSTRAINT `courses_platform_id_foreign` FOREIGN KEY (`platform_id`) REFERENCES `platforms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Prof. Anahi Prosacco MD','Exercitationem consequatur impedit consequatur est nobis minus. A consequatur aliquam qui est explicabo consectetur dolores mollitia.','eveniet-et-ducimus-deserunt-et-et-architecto-dignissimos-nam','Dr. Amina O\'Connell',3,200,'307',NULL,NULL,2,1,NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(2,'Carlos Moen','Rerum quia omnis aspernatur corrupti beatae est. Sit deserunt ut praesentium quia in. Magni et sunt sapiente ut beatae. Ullam non nostrum tempora pariatur eos recusandae excepturi.','nobis-quo-explicabo-dolor-labore-accusamus-eos','Lexus Reilly III',4,185,'981',NULL,NULL,2,2,NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(3,'Gracie Jacobs','Necessitatibus beatae dolores consequatur eum. Rerum delectus ut fugit et est. Expedita illo laboriosam ea exercitationem aliquid. Id inventore voluptates blanditiis quo quisquam.','et-tenetur-temporibus-assumenda','Randall Larkin',2,63,'786',NULL,NULL,1,0,NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(4,'Selmer Wilderman','Voluptas provident atque nemo esse ad perspiciatis. Enim et ex qui reprehenderit nihil. Enim blanditiis esse occaecati quis quos. Nobis omnis voluptatibus at eaque.','totam-qui-nam-nesciunt-odio-velit','Prof. Alba Macejkovic',5,103,'431',NULL,NULL,1,0,NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(5,'Lukas Haley','Reprehenderit aut minima nemo adipisci eos eos voluptatem. Assumenda aut quae rerum et consequatur. Reprehenderit rerum temporibus quos quod sed sapiente nostrum.','tempore-sed-maxime-id-aut','Verna Wehner',2,186,'162',NULL,NULL,1,0,NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(6,'Quincy Schneider','Id rerum sed ad similique illum. Quia ut necessitatibus in impedit. Rerum non ipsam dolorem eius est doloribus architecto.','sed-aspernatur-nihil-eum-eaque','Ronny Leuschke',4,16,'272',NULL,NULL,3,3,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(7,'Claudine Kuhn','Eligendi ut unde eos in. Maiores nihil odio omnis nesciunt eum voluptate. Voluptas deleniti qui modi necessitatibus.','sunt-praesentium-cupiditate-rerum-deserunt-ut','Leatha DuBuque',3,185,'250',NULL,NULL,3,3,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(8,'Adriana Wiegand','Totam quia quae vel asperiores saepe autem. Qui sint qui quisquam error veritatis voluptatem. Et in ut delectus consectetur. Nam sunt aliquid velit reiciendis quis.','modi-eos-dolore-doloribus-nemo-sunt-ut-cum','Vicky Price',5,196,'506',NULL,NULL,1,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(9,'Mr. Gerald Schamberger','Voluptas similique mollitia a. Dolor voluptas maiores perferendis itaque eum maxime illo. A rerum error quis sunt animi magni.','magnam-autem-sint-non-consequuntur-omnis-et-beatae','Nicola Goodwin',3,40,'317',NULL,NULL,3,1,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(10,'Lambert Satterfield','Reiciendis fuga error consequuntur molestiae corporis. Deserunt quam repellat voluptatem quia laboriosam aliquam harum. Autem mollitia quos qui. Voluptas perspiciatis deleniti aut nemo non quod.','tenetur-velit-ut-aliquid-eos-quae-aut','Dr. Santos Waters MD',2,31,'738',NULL,NULL,1,2,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(11,'Obie Greenholt','Molestiae veniam autem debitis esse eveniet ea. Dolorem velit perferendis quis facere. Dignissimos provident amet ut nihil.','eos-aperiam-earum-debitis-eos','Antonio Hyatt',1,191,'631',NULL,NULL,1,3,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(12,'Clair Waters','Dolorem esse repellat saepe. Officiis quis nulla consequatur voluptas. Explicabo aspernatur dolores ullam. Iure dolorem sit temporibus totam et libero.','hic-est-expedita-mollitia-maiores-quia','Olen Herzog',5,40,'225',NULL,NULL,2,1,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(13,'Reese Hyatt','Corrupti odit at natus non qui in beatae tenetur. Ut ut quas soluta adipisci. Sint cum ut aut ab.','libero-et-eos-laudantium-repellat-soluta-occaecati','Mrs. Marianne Willms II',1,93,'489',NULL,NULL,2,3,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(14,'Ms. Miracle Kuphal','Dicta soluta atque dolores consequatur ullam ex non. In sed exercitationem neque voluptas. Eum consectetur est quae odio quidem.','impedit-doloribus-inventore-expedita-molestiae-voluptatibus-debitis-fugit','Madalyn Bechtelar',4,182,'556',NULL,NULL,2,2,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(15,'Ms. Aurelie Skiles DDS','Odio omnis quos porro earum animi. Consequatur ab quas illum veniam enim facilis ut. Odio adipisci distinctio veritatis.','excepturi-dignissimos-itaque-facere-non-atque-eaque','Ms. Carolanne Parker',3,153,'948',NULL,NULL,1,2,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(16,'Ms. Theresia Schinner IV','Distinctio doloribus eum et. Voluptatem aut facere praesentium hic et. Eum et aut harum eos. Corrupti in quis reprehenderit ullam debitis voluptate autem.','quia-qui-suscipit-consectetur-aut-laudantium-officiis','Fatima Fritsch',3,72,'332',NULL,NULL,2,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(17,'Mrs. Elena Waters MD','Voluptatum quis id deleniti deleniti ex. Culpa molestias rerum laborum in laborum impedit nesciunt fugiat. Veniam repudiandae autem architecto quia beatae sunt quo qui.','et-quia-provident-nam-et','Ms. Alaina Schamberger',5,154,'676',NULL,NULL,3,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(18,'Euna Sawayn','Blanditiis odio dolorem quis blanditiis exercitationem ut. Ea neque sit dolorum est. Nostrum suscipit occaecati labore et adipisci.','et-ab-cumque-sed-hic','Rick Gleason',3,61,'703',NULL,NULL,1,3,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(19,'Kenya D\'Amore','At odit aperiam et voluptatem earum. Qui aut qui animi doloribus aut non. Saepe laudantium maxime voluptatem at rerum voluptatem unde. Minus ut et ut sed sed ducimus labore.','laborum-libero-impedit-nemo-neque-iusto','Fernando Kunze',5,121,'106',NULL,NULL,2,2,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(20,'Ms. Dayna Smith II','Quo quia sed consequatur. Porro minima odio reiciendis voluptas. Unde et maiores sit quidem qui omnis. Qui voluptas fugit veniam neque est aut.','eligendi-et-maxime-ab-est-cum-eligendi','Dayana Rempel',1,124,'816',NULL,NULL,1,3,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_codes`
--

DROP TABLE IF EXISTS `discount_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discount_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(1) NOT NULL,
  `amount` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_for` tinyint NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_codes`
--

LOCK TABLES `discount_codes` WRITE;
/*!40000 ALTER TABLE `discount_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(1) NOT NULL,
  `status` tinyint NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `files_user_id_foreign` (`user_id`),
  CONSTRAINT `files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'Diego Schultz',NULL,1,2,2,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(2,'Ray Hartmann',NULL,0,0,4,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(3,'Birdie Smith',NULL,1,2,5,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(4,'Estel Langworth',NULL,0,2,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(5,'Leon Wiza Sr.',NULL,1,2,1,'2024-09-05 09:10:53','2024-09-05 09:10:53');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` bigint unsigned DEFAULT NULL,
  `upload_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_user_id_foreign` (`user_id`),
  KEY `invoices_upload_id_foreign` (`upload_id`),
  CONSTRAINT `invoices_upload_id_foreign` FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `invoices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES (1,'12.3','portal','354082964','890299170',0,3,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(2,'57.2','debit','529529649','820973972',0,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(3,'90.4','portal','808846653','561916644',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(4,'68','debit','662191654','501129937',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(5,'33','portal','809782352','914029508',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(6,'23.1','portal','167937308','749117440',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(7,'61.4','portal','399794490','645624645',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(8,'52.9','portal','851225794','845724237',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(9,'27.1','debit','350651341','102779118',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(10,'16.8','debit','332248008','162412350',1,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(11,'33.4','debit','456564104','226121057',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(12,'79.3','debit','180038527','364642541',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(13,'95.3','portal','816577220','330889837',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(14,'55.1','debit','719410553','990719690',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(15,'16.9','debit','498255962','924896417',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(16,'72.1','debit','274167270','171515321',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(17,'54.6','portal','891366153','137526926',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(18,'19.6','debit','467128816','958095109',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(19,'13.1','debit','950422256','899560215',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(20,'17.2','debit','687123768','297912886',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(21,'39.6','debit','277228128','379200482',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(22,'43','debit','911040529','485011227',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(23,'70.2','portal','218648179','545507691',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(24,'60.8','portal','834696971','390328578',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(25,'53.6','portal','805491374','993451617',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(26,'13.9','debit','382312345','263687027',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(27,'84.2','portal','694524993','161894436',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(28,'84.2','debit','987305630','135727496',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(29,'80.8','portal','974115960','672903156',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(30,'50.7','debit','365199911','642920849',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(31,'46.4','portal','421080401','494187741',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(32,'41.7','debit','902481652','472060234',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(33,'63.6','portal','486917113','193397173',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(34,'49.9','debit','895203903','233918360',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(35,'56.4','portal','389171275','718844313',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(36,'91.1','debit','880422945','515013024',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(37,'80.2','portal','350094349','944250676',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(38,'59.5','portal','669953522','948111263',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(39,'13.7','debit','933322188','786044812',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(40,'88','debit','145011178','393654656',0,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(41,'50.9','portal','121553380','316204219',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(42,'96.3','debit','384117238','226205510',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(43,'77.9','debit','303672304','686249446',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(44,'59.6','portal','412410736','351161047',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(45,'79.6','portal','211585146','132702301',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(46,'89.2','debit','477768356','291665912',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(47,'42.4','debit','389680029','595517058',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(48,'36.7','debit','541256756','146292357',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(49,'91.4','debit','594442633','802859072',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(50,'30.9','portal','270822813','831643597',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(51,'57.4','debit','280237060','869349298',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(52,'41','debit','499130538','778272418',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(53,'75.9','portal','104917123','995368064',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(54,'85.6','debit','289691314','986117371',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(55,'65.6','portal','589873247','875489279',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(56,'83.4','debit','888485795','134222449',1,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(57,'83.6','portal','328465931','774469335',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(58,'51.9','portal','346065846','374258038',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(59,'19.3','portal','352223817','618982199',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(60,'15','debit','430753590','116454644',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(61,'26.6','portal','290345047','247383626',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(62,'66.8','portal','571136721','611811130',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(63,'32.1','debit','424072361','514487224',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(64,'74','portal','795773753','744692054',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(65,'26.2','portal','882887902','878072493',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(66,'23.9','debit','790219949','202993633',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(67,'33.6','portal','307799989','736634450',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(68,'60.8','portal','625626823','997694705',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(69,'87.5','debit','729534846','662405276',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(70,'95.4','debit','356113912','525873491',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(71,'83.8','portal','124935273','502542481',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(72,'21.1','debit','158297727','568407122',1,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(73,'63.4','debit','831303662','854635910',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(74,'58.6','debit','472745914','849770731',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(75,'69.6','portal','686165340','753241808',1,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(76,'72.4','debit','414002770','221733607',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(77,'64.2','debit','944804202','191534549',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(78,'71.3','portal','327546278','563698637',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(79,'61.1','portal','905649904','842051847',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(80,'62.7','portal','254637519','630969311',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(81,'37.8','debit','622514535','885810169',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(82,'67.2','portal','437039521','830082760',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(83,'54.5','debit','958490229','677788682',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(84,'84.5','portal','755916741','605033850',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(85,'98.8','debit','454435347','503335441',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(86,'81','portal','793599250','207746686',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(87,'82.5','portal','587843300','620748252',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(88,'38.9','debit','518798699','220240108',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(89,'49.4','portal','416311834','348307305',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(90,'40.1','portal','509596284','191164107',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(91,'57.8','portal','470126876','208941915',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(92,'72.2','debit','450579112','407498931',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(93,'35.9','debit','484420466','755950249',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(94,'70.6','portal','735777502','413219869',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(95,'75.6','debit','217259776','288700207',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(96,'43.5','portal','583672636','485889099',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(97,'56.7','portal','618163709','389230124',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(98,'70.4','portal','181787751','154158474',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(99,'96.3','portal','856921860','153554333',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(100,'39','portal','674358051','132558237',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(101,'67.3','portal','320212847','655977200',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(102,'70.7','debit','602011908','299885641',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(103,'92.8','debit','324180409','541100490',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(104,'39.1','portal','545412950','362150002',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(105,'88.6','debit','305682589','113410256',0,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(106,'20.8','portal','459806853','882588586',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(107,'41.2','debit','852312031','217148017',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(108,'77.3','portal','583298656','948723932',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(109,'66.9','debit','865829487','479163941',1,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(110,'16.8','debit','922736148','677125820',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(111,'35.5','debit','453941299','238026715',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(112,'10.2','portal','394433200','838219019',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(113,'29.3','portal','265178206','421218035',0,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(114,'49.9','portal','753227688','803990356',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(115,'44.4','portal','209196586','311685380',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(116,'86.4','debit','291953065','981840342',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(117,'62.2','debit','537039808','468292437',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(118,'73.5','debit','355069338','337862614',0,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(119,'68.3','portal','413123479','251512024',0,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(120,'86','debit','483324833','534118830',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(121,'26.5','portal','685540790','879336775',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(122,'86.9','portal','986730230','718253366',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(123,'87.5','portal','681482396','133390601',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(124,'83.7','debit','580533435','794886947',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(125,'88.8','portal','871020288','832959173',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(126,'77.1','debit','790151723','594700772',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(127,'73','portal','139919814','700951711',1,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(128,'76.9','debit','582139901','490227482',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(129,'59.3','debit','406564844','163514329',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(130,'93.3','debit','719765084','680507412',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(131,'86.1','debit','345248213','619021644',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(132,'71.6','portal','725988325','220559373',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(133,'93','portal','250962143','459325447',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(134,'92.3','portal','388523695','700990365',1,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(135,'21.3','debit','291790237','391881442',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(136,'58.2','portal','551430692','261809895',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(137,'17.4','debit','195705797','939632378',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(138,'32.4','debit','189416309','112969073',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(139,'43.4','portal','874035486','169405256',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(140,'27.7','debit','987963029','729151686',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(141,'68.1','portal','115861634','220113783',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(142,'98.1','debit','393379030','354565088',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(143,'27.4','portal','129377641','376996747',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(144,'13.3','debit','476526429','798593285',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(145,'91.1','portal','595049843','393907589',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(146,'56.8','debit','678755470','601796407',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(147,'34.5','portal','291659081','722934658',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(148,'93.7','portal','963830027','562218403',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(149,'72.8','portal','645588690','692632104',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(150,'76.6','portal','478812087','197436232',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(151,'33.1','debit','275692240','350958195',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(152,'56','debit','365728499','685419979',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(153,'95.4','debit','966510579','109804505',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(154,'77.9','debit','130767409','466167480',1,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(155,'38.6','debit','594361444','863704349',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(156,'30.4','debit','574316433','215657193',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(157,'47.1','portal','458236709','905645049',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(158,'67','portal','419368755','853669406',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(159,'10','debit','536548838','807694943',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(160,'66.8','debit','267031550','110105631',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(161,'89.2','portal','675952676','187949241',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(162,'73.2','debit','194249655','645691022',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(163,'14.1','debit','178782190','193829744',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(164,'89.9','portal','671548795','406926029',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(165,'50.6','portal','568149833','979410179',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(166,'88.8','portal','488665941','364956279',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(167,'38.8','debit','858964808','441601604',0,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(168,'17.9','portal','118581324','976592288',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(169,'10.8','portal','829182552','603208157',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(170,'99.3','portal','291256135','668181107',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(171,'37','debit','899772981','751353765',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(172,'78.4','portal','562271665','663076103',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(173,'27.2','debit','735639760','864151496',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(174,'83.7','debit','648546948','454245542',1,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(175,'25.6','portal','969870392','569614798',0,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(176,'44.7','debit','838381964','702164650',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(177,'23.6','portal','189846684','911826261',1,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(178,'66','portal','843066145','528732489',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(179,'50.7','debit','182777789','261775678',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(180,'88.8','debit','334106511','237065546',1,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(181,'25.1','debit','855859041','638065541',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(182,'55.6','debit','614576343','703625516',0,3,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(183,'76.1','portal','403423512','487300969',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(184,'11.1','portal','665586786','960580446',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(185,'69','portal','120424597','595045636',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(186,'28.2','portal','860632951','401450742',0,4,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(187,'43.4','debit','582408102','462007597',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(188,'66.2','debit','639705176','593993857',1,9,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(189,'18.8','debit','913428041','675317770',0,1,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(190,'43','debit','800337043','762905348',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(191,'87.2','portal','764319950','913153341',1,8,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(192,'79','debit','657774758','109896870',0,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(193,'90.3','debit','861839046','199798588',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(194,'64.1','portal','220778047','405207979',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(195,'75.2','debit','393832315','597916516',0,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(196,'64.9','portal','986082973','855333113',1,10,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(197,'13.5','portal','305724920','486357750',1,7,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(198,'79.6','debit','462980020','119424891',1,6,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(199,'44.1','portal','338339255','862316884',1,2,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(200,'34.6','debit','736471428','147778845',0,5,NULL,'2024-09-05 09:10:54','2024-09-05 09:10:54');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_100000_create_password_reset_tokens_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_07_29_102639_create_roles_table',1),(5,'2024_07_29_102646_create_pages_table',1),(6,'2024_07_29_102712_create_page_role_table',1),(7,'2024_07_29_134533_create_users_table',1),(8,'2024_07_29_135835_create_files_table',1),(9,'2024_08_11_122627_create_course_categories_table',1),(10,'2024_08_19_113421_create_tasks_table',1),(11,'2024_08_22_070302_create_uploads_table',1),(12,'2024_08_22_092816_create_verification_codes_table',1),(13,'2024_08_22_121137_create_sub_tasks_table',1),(14,'2024_08_27_085752_create_invoices_table',1),(15,'2024_08_29_101235_create_discount_codes_table',1),(16,'2024_08_29_122748_create_user_available_sessions_table',1),(17,'2024_08_29_123548_create_platforms_table',1),(18,'2024_09_01_101257_create_class_courses_table',1),(19,'2024_09_05_085405_create_counseling_types_table',1),(20,'2024_09_05_115020_create_courses_table',1),(21,'2024_09_05_115215_create_course_user_table',1),(22,'2024_09_05_115330_create_carts_table',1),(23,'2024_09_05_115435_create_counsels_table',1),(24,'2024_09_05_115546_create_payments_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `page_role`
--

DROP TABLE IF EXISTS `page_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned NOT NULL,
  `page_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `page_role_role_id_foreign` (`role_id`),
  KEY `page_role_page_id_foreign` (`page_id`),
  CONSTRAINT `page_role_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `page_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page_role`
--

LOCK TABLES `page_role` WRITE;
/*!40000 ALTER TABLE `page_role` DISABLE KEYS */;
INSERT INTO `page_role` VALUES (1,1,1,NULL,NULL),(2,1,2,NULL,NULL),(3,1,3,NULL,NULL),(4,2,4,NULL,NULL),(5,2,5,NULL,NULL),(6,2,6,NULL,NULL),(7,3,7,NULL,NULL),(8,3,8,NULL,NULL),(9,3,9,NULL,NULL);
/*!40000 ALTER TABLE `page_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES (1,'Cleve Rice',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(2,'Dr. Ken Mayer',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(3,'Ericka Christiansen',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(4,'Mrs. Teresa Corkery Sr.',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(5,'Omari Zemlak',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(6,'Rolando Aufderhar',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(7,'Ms. Shanny Cummerata V',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(8,'Harmony Anderson',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(9,'Ms. Eulah Terry',NULL,'2024-09-05 09:10:47','2024-09-05 09:10:47');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `user_id` bigint unsigned DEFAULT NULL,
  `course_id` bigint unsigned DEFAULT NULL,
  `counsel_id` bigint unsigned DEFAULT NULL,
  `class_course_id` bigint unsigned DEFAULT NULL,
  `invoice_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_user_id_foreign` (`user_id`),
  KEY `payments_course_id_foreign` (`course_id`),
  KEY `payments_counsel_id_foreign` (`counsel_id`),
  KEY `payments_class_course_id_foreign` (`class_course_id`),
  KEY `payments_invoice_id_foreign` (`invoice_id`),
  CONSTRAINT `payments_class_course_id_foreign` FOREIGN KEY (`class_course_id`) REFERENCES `class_courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payments_counsel_id_foreign` FOREIGN KEY (`counsel_id`) REFERENCES `counsels` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payments_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'98.2','Corporis quaerat sed in deleniti inventore aperiam. Error inventore maiores voluptas libero nobis sit et sint.','697252422','637845144','portal',0,3,3,NULL,NULL,1,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(2,'12','Et laborum ab qui vel et neque alias mollitia. Quia suscipit inventore magnam esse vel repellendus.','960728963','353432441','portal',0,7,3,NULL,NULL,2,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(3,'95.9','Quas non ut hic libero. Voluptas occaecati assumenda aut est explicabo maiores inventore. Sit hic est suscipit facilis ut possimus officia maxime. Id autem sed dolores aut rerum ipsam labore.','280313141','848974457','debit',0,6,3,NULL,NULL,3,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(4,'83.5','Perferendis iure reprehenderit est mollitia ut nihil. Iste ad voluptatem et eos. Numquam nam velit aperiam quod.','491878320','726586454','debit',1,5,10,NULL,NULL,4,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(5,'18.3','Laborum quod iusto molestiae repellendus ut sint nihil. Quasi delectus quae ut reprehenderit. Aut sint omnis aut mollitia adipisci. Illum cumque quibusdam sed qui.','576372825','201317606','portal',0,10,2,NULL,NULL,5,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(6,'41.7','Ut et tenetur sit quam. Adipisci veritatis rem ipsam sed. Sunt sint ut tenetur exercitationem enim et. Doloribus eveniet voluptatem maxime ex.','947551700','835043276','debit',1,6,3,NULL,NULL,6,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(7,'18.5','Sint omnis est esse nihil itaque labore. Neque tempora quo quod vel fugiat. Quibusdam aut occaecati veniam nihil.','111374354','641838110','portal',1,6,8,NULL,NULL,7,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(8,'78.7','Quisquam sit necessitatibus et vel tenetur. Delectus quae nihil molestias est quia.','556973971','242320484','portal',0,10,6,NULL,NULL,8,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(9,'64.6','Autem voluptatum quisquam beatae. Nam sequi aut deserunt beatae aut expedita. Nobis dolorem earum sit eaque. Iste excepturi et repellat expedita illum.','699250027','259203246','debit',0,6,6,NULL,NULL,9,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(10,'31.7','Veritatis ipsum harum et nostrum reprehenderit voluptatibus ea. Rem sit dolorem maxime et qui reiciendis aut quia. Id iste consequatur labore tenetur. Ut qui occaecati laborum et sunt et.','311230203','432803747','portal',1,3,7,NULL,NULL,10,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(11,'15.8','Ullam architecto aut qui et expedita eos eos. Ipsam quaerat quis cumque sint repellendus et.','548468707','900678603','debit',1,6,6,NULL,NULL,11,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(12,'52.8','Quam ducimus aut et. At velit cumque voluptatem aut debitis. Facilis aut veniam beatae repellat nihil voluptas. Animi quibusdam eligendi voluptas aspernatur.','162788701','995132795','portal',1,4,1,NULL,NULL,12,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(13,'46.3','Debitis ipsum odit quidem repellat ipsam quos. Consequuntur error molestiae molestiae doloremque voluptatem. Quam aut corporis laboriosam necessitatibus.','103986132','808628947','portal',1,2,8,NULL,NULL,13,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(14,'74.3','Tempore dolor tenetur numquam ab. Vero necessitatibus officiis placeat quibusdam qui nam fugiat quae. Consectetur dolor porro dolores architecto.','609040479','795512809','portal',0,9,8,NULL,NULL,14,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(15,'70.2','Repellendus vel enim est eos. Et quasi consequatur tenetur nihil. Ab magni quod eos laboriosam. Qui quas eius temporibus dolorum.','922146237','664435221','portal',1,8,1,NULL,NULL,15,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(16,'79.7','Inventore in iure sit ut. Reprehenderit culpa recusandae numquam ea. Iusto ducimus odit unde autem.','768664005','469821989','portal',0,9,4,NULL,NULL,16,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(17,'13.2','Ea eum id placeat quis. Iure ut odio reprehenderit sint officiis voluptatem. Qui vel est temporibus nihil recusandae labore dignissimos.','184807973','337293445','portal',0,8,1,NULL,NULL,17,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(18,'27.5','Enim veniam est omnis perspiciatis. Ullam asperiores voluptatem rerum tempore porro. Tenetur sit velit nesciunt minima provident velit. Et ut consequatur soluta rerum.','707031050','724529644','portal',0,2,6,NULL,NULL,18,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(19,'96.4','Et molestiae autem quo id natus fugit sit. Eius tempore ullam dignissimos voluptate ipsam qui. Ut et laborum maiores.','254568839','432837179','debit',0,9,2,NULL,NULL,19,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(20,'26.6','Quia aut nostrum aut sit velit a. Laboriosam rerum repellendus modi omnis. Facere repudiandae sunt iusto nisi ea quia aut commodi. Aperiam rerum vel rerum provident.','992640981','843344297','debit',0,1,3,NULL,NULL,20,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(21,'80.4','Sunt doloribus quae tempora at. Nemo voluptatem quia ullam modi omnis. Eaque assumenda harum aspernatur qui et ad. Eveniet repudiandae rerum est quo velit quo suscipit.','435424455','586240185','debit',1,2,1,NULL,NULL,21,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(22,'20.9','Debitis sit voluptatum iusto possimus vel hic voluptate. Dolores ab sit aspernatur. Quo ut repudiandae dolorum cumque. Dolorum impedit magnam eligendi voluptas incidunt quae.','942475488','971669309','portal',0,1,7,NULL,NULL,22,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(23,'15.5','Autem laboriosam nostrum laborum. Sint sed illum repellendus reprehenderit qui. Labore voluptas modi nostrum rem tempore.','931529945','162874595','portal',1,5,7,NULL,NULL,23,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(24,'22.5','Est ut quia esse suscipit impedit ut. Veniam quia porro maxime non quasi totam. Repellat vel blanditiis expedita voluptas. Omnis quis ea deserunt.','520691950','187851808','debit',0,6,10,NULL,NULL,24,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(25,'37.9','Modi animi officia sint sed consequuntur id. Cumque esse sit et dolorum aut qui. Veniam consectetur modi quae ad voluptatem. Ad ea soluta voluptates eveniet et est iste.','980193427','140223151','debit',1,5,4,NULL,NULL,25,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(26,'86.7','Earum sit et saepe distinctio non sit sit. Quibusdam est quisquam soluta non dolores nihil rem. Excepturi voluptatem maxime et et dicta in.','168406393','323279134','portal',0,8,9,NULL,NULL,26,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(27,'51.8','Laborum facere quo id voluptas earum. Sapiente dolor quia aut ducimus. Quia minus mollitia enim voluptas. Recusandae voluptas amet sint ut.','786420603','400708411','debit',1,2,8,NULL,NULL,27,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(28,'93.5','Dolorum voluptatum laudantium qui mollitia. Autem rerum id eos quis rerum consequatur. Nihil quaerat voluptas voluptatum voluptatibus labore. Sit totam hic impedit ut non labore laudantium.','195329472','667028375','debit',0,3,9,NULL,NULL,28,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(29,'90.6','Rerum illum repudiandae voluptatem voluptatem repudiandae velit in. Quas voluptatem provident esse natus autem esse tempora. Non porro aut aut neque illum.','361738780','358777070','debit',0,1,10,NULL,NULL,29,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(30,'92.9','Architecto voluptatem suscipit sit sunt. Quae impedit earum est consectetur. Eum quod alias quo corrupti.','300755783','262454242','debit',0,2,7,NULL,NULL,30,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(31,'71.1','Omnis enim magni consectetur eos. Maxime aperiam totam dolor labore nihil beatae. Nisi enim voluptatem temporibus iusto. Tempore autem qui aut provident dolores dolorem.','289776255','928374998','debit',1,4,10,NULL,NULL,31,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(32,'99.3','Qui aliquam maxime officia ipsa necessitatibus officia beatae. Sunt totam necessitatibus et quo incidunt perferendis. A maiores autem inventore sint.','222668036','320879096','debit',1,8,2,NULL,NULL,32,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(33,'82.2','Culpa ut laboriosam odit quaerat iste. Nesciunt quod quo ex voluptatem. Eligendi consequuntur perspiciatis cumque atque aut velit corporis. Quo quibusdam voluptas impedit.','426983546','291919700','portal',0,4,8,NULL,NULL,33,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(34,'84.9','Quia laboriosam et est voluptates. Voluptatem ut error maxime nulla adipisci harum beatae. Nihil odit doloribus est aliquam id.','647268497','340430792','debit',0,3,10,NULL,NULL,34,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(35,'42.3','Et omnis eos amet recusandae molestias laudantium nemo. Aut sed aut tenetur error. Autem aspernatur dolorem voluptatem voluptas rerum. Quis aut non eum.','231784744','270245679','debit',1,1,9,NULL,NULL,35,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(36,'96.2','Porro animi perspiciatis porro et illum. Quasi ea repudiandae culpa fugiat quod similique. Aut sapiente labore optio asperiores. Neque sequi atque autem ut.','394539068','803272433','portal',0,10,8,NULL,NULL,36,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(37,'89.2','Maiores vitae error blanditiis odit omnis. Id libero fugiat eos corrupti assumenda. Nesciunt maiores voluptatum voluptatem minus eos in distinctio. Ut quam voluptas rerum officia dolorem illo.','399635250','514846306','debit',0,1,9,NULL,NULL,37,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(38,'57.8','Sed animi praesentium non consequatur ab voluptatibus iure. Est consectetur ut non sequi architecto laborum. Quos porro et fuga ex porro nihil ut.','362485727','888420309','debit',0,5,3,NULL,NULL,38,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(39,'33.9','Sit velit ipsum perferendis culpa. Aut eos reiciendis non. Repudiandae iusto repellendus aut et minus et fuga. Cumque exercitationem in quo.','752685460','241003104','debit',0,3,8,NULL,NULL,39,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(40,'89.3','In quis voluptatum odio incidunt tempore architecto. Sit numquam laboriosam itaque. Qui minima nisi voluptatem natus consectetur asperiores.','349699636','117362105','portal',0,7,4,NULL,NULL,40,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(41,'71','Et qui dolore autem veritatis recusandae voluptate voluptate maxime. Maxime consequatur tempora laboriosam ut. Beatae atque repudiandae vel est asperiores tenetur.','796223644','371950270','portal',0,8,8,NULL,NULL,41,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(42,'85.4','Debitis est voluptatem eligendi exercitationem voluptate ut voluptatum. Nihil in et consequatur ullam possimus esse qui. Odit ut dolorem velit quidem.','292577868','970997485','debit',1,2,9,NULL,NULL,42,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(43,'83.3','Id quo et pariatur sed rem repellat rerum. Ea in commodi nisi eius iste quis et. Optio delectus debitis impedit cum dolorum sed. Ratione at quam dolorum distinctio eligendi quasi est omnis.','854041913','245787423','debit',1,8,7,NULL,NULL,43,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(44,'80.9','Ab deleniti dolore dolore ut. Sapiente quod delectus eaque reprehenderit. Ab illo soluta voluptas voluptatem rem quibusdam sed. Est id fugit autem delectus.','268143507','625545447','debit',0,5,5,NULL,NULL,44,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(45,'66.6','Voluptatibus autem vitae non eum repudiandae temporibus. Possimus necessitatibus laboriosam eum velit vero debitis neque. Est architecto consequatur laborum enim cumque.','415780763','847380720','portal',0,2,9,NULL,NULL,45,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(46,'25.8','Aut soluta qui et. Harum quo repellat aut impedit natus esse. Et consectetur placeat cupiditate reiciendis tempora et reiciendis.','643561136','511129038','debit',0,8,1,NULL,NULL,46,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(47,'39.8','Officiis tempore molestias expedita aut earum voluptatem nam. Aut illo eveniet at quisquam. Aperiam perferendis veniam dolorem. Ea consequatur animi non unde maiores aliquam.','201805704','131611395','debit',0,1,2,NULL,NULL,47,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(48,'41.6','Porro magni voluptates dolor aut perspiciatis earum quia. Non hic nihil aut tempore. Ut in provident accusamus sed eius. Culpa sunt optio dolorem.','311014435','631111294','debit',1,1,8,NULL,NULL,48,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(49,'43.5','Beatae minima consectetur ut est. Fugit consequatur accusantium repellat est. Iusto quis voluptas aliquid unde labore officia in.','983956760','890964980','portal',1,5,2,NULL,NULL,49,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(50,'49.2','Molestiae mollitia distinctio nemo. Qui facere consequatur ipsam. Rem perferendis ex ut necessitatibus sit est. Quis dolorem et nihil distinctio ea.','521227836','411235559','portal',0,3,1,NULL,NULL,50,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(51,'18.7','Deserunt dolore tempore aut voluptate esse dolorem quam. Sit modi excepturi aut sequi tempora. Quasi est occaecati et praesentium.','366000410','584533310','debit',1,10,5,NULL,NULL,51,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(52,'21.8','Animi aut autem facere possimus. Magnam quis voluptatem asperiores repellendus sint commodi reprehenderit.','628695110','447662973','portal',0,8,3,NULL,NULL,52,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(53,'96.9','Minima velit explicabo quidem labore. Repellat ad nisi corrupti rerum. Ipsa iste hic mollitia error in reprehenderit est.','668524303','943141490','debit',1,4,7,NULL,NULL,53,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(54,'58.1','Provident deserunt vero deleniti est. Et et et cumque numquam. Placeat illum eaque aut velit enim culpa aut.','264299665','224761792','portal',0,9,8,NULL,NULL,54,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(55,'55.8','Est corporis qui dolores quia. Reiciendis quis illum cum velit qui molestiae vel. Cumque et voluptate dolor.','707587844','268534761','portal',0,8,9,NULL,NULL,55,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(56,'59','Odio ut et sunt libero tenetur possimus laudantium. Natus dolorem et repellat nisi accusantium at. Eaque dolore delectus voluptatem culpa. Numquam consectetur non quas possimus dolorem cum.','924746388','216420117','portal',1,3,8,NULL,NULL,56,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(57,'16.9','Et commodi velit eaque distinctio. Est mollitia dolorem ratione rem eum saepe maxime. Placeat impedit nihil maxime molestiae.','289742078','684383496','portal',1,5,8,NULL,NULL,57,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(58,'50.3','Voluptatem voluptatum rerum totam et voluptatem repellat aut. Impedit sint soluta maiores laboriosam reprehenderit temporibus. Quis nostrum et reprehenderit rerum culpa.','369109513','972913611','debit',0,10,2,NULL,NULL,58,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(59,'81','In ipsam sint veritatis. Id quo repellendus modi vitae laboriosam voluptate mollitia. Et qui est blanditiis fugiat itaque.','585716236','795658435','portal',0,10,4,NULL,NULL,59,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(60,'69.6','Quo deleniti id dignissimos a suscipit. Esse corporis quidem qui eum minima asperiores in. Atque optio nulla a cum vero modi.','569908152','355826596','debit',0,2,2,NULL,NULL,60,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(61,'64','Rerum libero suscipit vero tenetur ipsam dolor eos. Magnam fuga ex dolores maxime voluptatem velit. Soluta magni magni omnis qui recusandae iste.','470744389','942564654','portal',0,9,2,NULL,NULL,61,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(62,'77.7','Nisi maiores quis ut itaque veniam. Numquam et aut velit voluptatem aperiam quia sit. Dolores ex nam enim voluptatem. Repellendus voluptatem provident enim vel sed aspernatur.','118899359','585334455','debit',1,4,1,NULL,NULL,62,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(63,'56.6','Fuga optio ut odit laborum ut. Soluta non nesciunt eos rem sapiente. Delectus minima pariatur qui autem animi.','565285288','815374930','portal',0,3,2,NULL,NULL,63,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(64,'76.9','Animi consequatur facere ex velit voluptatem. Officia eos perferendis dignissimos nesciunt. Tempore illo quo aut. Officiis dolor enim voluptatum laborum.','536132069','573328017','debit',0,6,10,NULL,NULL,64,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(65,'50.7','Quo vero ipsa qui. Earum laborum id hic alias. Molestiae sunt corporis tempore velit. Maxime autem illum ea et quas alias et. Est nostrum et ipsum. Placeat iure quae qui rem eos velit.','206270672','890962380','portal',0,8,8,NULL,NULL,65,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(66,'66.2','Eaque aspernatur molestiae harum rerum. Debitis rerum culpa aut voluptate rerum mollitia sed. Maiores minima quisquam dicta qui quaerat.','888290614','396645753','portal',0,8,2,NULL,NULL,66,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(67,'12.2','Repellendus molestiae numquam cupiditate molestiae et dolorem impedit sint. Beatae unde unde iste eos. Ut ut et ducimus soluta. Perferendis velit corrupti ut ea.','790542370','276361635','portal',0,9,4,NULL,NULL,67,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(68,'88.8','Fuga est quo atque eos. Unde et eaque debitis soluta in quia at. Soluta velit natus voluptatem placeat praesentium. Minus rem aliquam quis id itaque.','921221288','997456483','debit',0,5,4,NULL,NULL,68,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(69,'89.7','Aliquid distinctio praesentium et ullam fugiat enim. Voluptatum et mollitia assumenda ducimus eos et. Iusto quia blanditiis fuga beatae. Quos reprehenderit libero facere vero laborum.','602464784','836904700','portal',0,1,5,NULL,NULL,69,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(70,'52.3','Ipsum perferendis maiores suscipit. Aut tenetur ratione ea molestias illum. Eaque sint optio ipsam corporis non molestiae et. Dolor impedit est aut velit dolorem.','811442635','691064093','debit',1,7,9,NULL,NULL,70,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(71,'38.8','Sint sunt voluptas cumque consequuntur eum ab. Voluptates nam autem veritatis eius quis sint. Repellendus aut est eligendi cum eligendi cum maxime.','667045437','373389485','debit',1,5,5,NULL,NULL,71,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(72,'15.9','Et qui dolores voluptates. Natus et provident aliquid voluptas magni quae nobis. Velit id in aut ad omnis. Delectus molestias earum non quis id.','968401996','826920940','debit',1,9,10,NULL,NULL,72,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(73,'79.5','Ut quos aut repellendus cumque molestiae maiores. Quasi maiores adipisci dolor accusantium et eos necessitatibus odio. Numquam ipsam quia nulla a.','212179253','655183317','portal',1,1,1,NULL,NULL,73,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(74,'95.6','Minus quod suscipit culpa nisi placeat rerum. Voluptatem fugiat nesciunt rem eius. Enim corrupti eos et molestiae voluptatem debitis quia. Nemo minus alias sit modi.','936811020','684127682','portal',0,4,4,NULL,NULL,74,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(75,'98.3','Est doloremque consequatur et esse rerum illo. Id enim nihil labore ducimus. Provident consequatur ipsam corporis laboriosam ut quas animi iusto. Eius id ut sunt qui.','787162063','460854305','debit',1,9,8,NULL,NULL,75,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(76,'95.8','Alias quod et culpa eum sed tempora. Excepturi quos esse velit nisi blanditiis consequatur. Eos pariatur qui error aut rem. Quos quis itaque porro consequuntur. Voluptatum ab aut rerum et rerum.','724150615','421018446','debit',0,1,9,NULL,NULL,76,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(77,'88','Sequi aliquam veniam quos omnis. Fugit aliquam eum et voluptatibus dolores et beatae sint. Impedit ut aliquid ut saepe optio iusto sed iusto.','251186779','706589510','debit',1,7,10,NULL,NULL,77,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(78,'55.6','Non cumque consequuntur recusandae porro inventore culpa sequi. Odio eius doloremque non vel voluptatum ex. Modi quisquam omnis ipsum consectetur consequatur.','555971705','460604317','debit',1,2,9,NULL,NULL,78,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(79,'19.7','Itaque aut quae soluta est accusantium et cumque. Vitae praesentium quas unde libero ea assumenda facere. Eos sapiente impedit dolores officiis nostrum esse qui.','765475886','193240900','debit',1,1,8,NULL,NULL,79,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(80,'41.9','Pariatur dignissimos qui molestiae officia laudantium odio. Qui saepe deleniti fugit perspiciatis omnis expedita qui harum. Odio non quia consequuntur sapiente dolores.','983638319','608912579','portal',0,10,3,NULL,NULL,80,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(81,'97.1','Eum est adipisci saepe. Saepe accusamus et aut repellat sapiente. Nesciunt et nulla et saepe. Vitae consequatur eum officia quia eligendi reiciendis.','488040930','411674739','portal',0,3,9,NULL,NULL,81,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(82,'37.1','Accusamus vero unde quia rem ipsa assumenda tempora eos. Minus rem ut nihil consequatur. Quia tenetur soluta voluptatem beatae error fugit aut.','843915702','939662813','portal',0,4,1,NULL,NULL,82,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(83,'20.6','Nam in voluptatum fugit aspernatur illo. Laudantium non sunt unde delectus aspernatur rerum maiores. Voluptatem optio odit velit pariatur nostrum. Ipsa eveniet voluptatibus cupiditate.','532764979','326588860','portal',1,8,8,NULL,NULL,83,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(84,'85.3','Ipsa qui similique ut soluta velit. Aliquid officiis odio adipisci occaecati rerum qui aut. Dolor sit qui ea maiores sed rerum quo.','257858967','262184640','debit',0,5,1,NULL,NULL,84,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(85,'63.8','Amet quia sit et tempora voluptate. Aut quia eius dignissimos praesentium tenetur at. Est quasi inventore fuga.','303332273','517925692','portal',1,5,10,NULL,NULL,85,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(86,'94.1','Ex rem corrupti recusandae iste earum sunt. Quidem maxime unde quisquam repudiandae enim. Perferendis saepe error molestias. Consectetur vel dolore officia error libero odio.','831749693','413916283','portal',1,10,3,NULL,NULL,86,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(87,'65','Voluptatem iure architecto rerum nesciunt deserunt. Magni sed est reprehenderit porro deleniti eos.','420181211','716879629','portal',0,1,5,NULL,NULL,87,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(88,'93.4','Illo minus commodi dolor consectetur magni sint. Autem et dolorem quis non id. Enim eum adipisci fuga voluptates qui neque quis.','704939465','644514636','debit',0,3,7,NULL,NULL,88,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(89,'68.5','Atque nisi et nesciunt eum officiis amet veniam. Doloremque deserunt nostrum suscipit repellendus veritatis possimus quo. Placeat aliquid excepturi harum et vero.','775892751','766714570','debit',1,6,6,NULL,NULL,89,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(90,'63.5','Quia eum sit saepe repellat dolorum. Accusantium numquam expedita non rerum ipsum qui. Rerum reiciendis voluptas illum eligendi. Hic ex magnam et fugit. Ullam voluptas et eos alias.','104383625','833564989','portal',0,3,10,NULL,NULL,90,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(91,'86.5','Voluptatem quam voluptas voluptate molestiae enim laborum placeat. Esse et quae ab iste occaecati quam soluta. Maxime est deleniti facere.','524544357','204008793','debit',1,10,6,NULL,NULL,91,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(92,'27.5','Blanditiis velit facilis totam quibusdam odit. Nulla harum aut voluptas expedita iure et dolores rerum. Voluptas voluptatem voluptate delectus aut quis. Officiis velit harum eum culpa.','926466468','432459126','debit',0,6,3,NULL,NULL,92,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(93,'59.1','Aut eligendi repudiandae enim rerum aperiam magnam beatae quae. Sed minus aut quia qui aliquid temporibus reprehenderit. Esse possimus aut fuga placeat illo.','682953548','429300660','portal',1,10,6,NULL,NULL,93,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(94,'56.1','Inventore nulla facere saepe qui aut. Dolor odio sit odio error omnis. Quaerat facere consequatur eos rerum.','449184752','394973501','portal',1,8,8,NULL,NULL,94,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(95,'55.6','Sint rerum optio ipsa at. Itaque quisquam assumenda suscipit eos est. Aut accusamus veniam dolorem ut at aut ea. Harum neque dolores provident itaque sunt est iure. Aut earum et rerum id.','677438592','150444267','debit',0,3,7,NULL,NULL,95,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(96,'27.2','Quia assumenda deleniti et impedit sit. Sint hic provident aut numquam nesciunt.','243678184','379288741','portal',1,4,8,NULL,NULL,96,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(97,'38.3','Rem velit nostrum et earum sed sit aliquid et. Quia non dolorum accusantium voluptatem impedit magni nulla ab. Quod sed voluptas aut porro quam est ut consequatur. Ipsa rem dolores temporibus.','494059005','884687697','portal',0,5,8,NULL,NULL,97,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(98,'62.8','Repudiandae nesciunt nulla voluptatem enim accusamus facilis nihil. Excepturi quo aut aut non ut eius. Quia occaecati et delectus facere perspiciatis.','428227316','449069657','debit',0,6,3,NULL,NULL,98,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(99,'99.9','Enim ducimus est quae ut perspiciatis dignissimos rerum. Laboriosam occaecati adipisci aut voluptas voluptatem veritatis natus assumenda. Veritatis minus repellat magni commodi.','532624023','181027385','debit',0,5,5,NULL,NULL,99,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(100,'21.2','Eos voluptatem nihil ullam dolorem modi dignissimos. Porro voluptatibus sit quia tempora. Similique illo maxime dicta magnam eveniet dolore quidem.','390055050','557858053','portal',1,4,8,NULL,NULL,100,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(101,'80.4','Assumenda asperiores aliquam non ut. Eius praesentium laudantium aut expedita molestias et voluptatem. Qui est sint earum. Dicta quis optio amet ab eos illum et.','178243596','369182141','debit',0,5,4,NULL,NULL,101,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(102,'74.6','Voluptatem expedita deserunt id ut reprehenderit qui. Debitis est ut dolorum ut hic velit dolorum. Velit aliquid maiores reiciendis optio explicabo.','362960981','565604785','portal',1,4,9,NULL,NULL,102,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(103,'62.7','Commodi amet ullam placeat neque qui alias. Impedit cumque necessitatibus ex id ea cupiditate. Qui minus occaecati eveniet quisquam et. Aut fuga id nostrum dolorum corrupti eos.','472989144','721587125','debit',0,1,4,NULL,NULL,103,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(104,'22.9','Officiis est aperiam reprehenderit voluptas ut. Repudiandae nostrum ipsum quos. Ut occaecati asperiores voluptatum a distinctio.','231452675','344359918','debit',0,6,10,NULL,NULL,104,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(105,'86.2','Ea eum itaque quo quis. Sunt alias aliquam quibusdam ab nulla dicta explicabo. Ut reprehenderit voluptate velit eveniet non libero. Quia aut debitis quas voluptates id consequatur et.','752172891','919805507','portal',0,8,1,NULL,NULL,105,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(106,'54.7','Voluptatem nulla quae quibusdam aliquam. Repellendus amet modi ea quaerat neque rerum. Et iusto voluptatum nihil.','846447047','979022644','debit',0,1,3,NULL,NULL,106,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(107,'61.1','Voluptatem ut commodi aut velit. Velit culpa atque voluptatum velit maxime dolor. Et amet et iusto excepturi voluptas. Ut unde eum sapiente adipisci qui incidunt voluptates.','760583682','702132342','portal',1,6,1,NULL,NULL,107,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(108,'55.2','Dolor voluptates voluptatibus enim sed voluptatem. Non illo enim tenetur sed. Repellat tempora nesciunt qui voluptatem tenetur. Et perspiciatis itaque et autem aspernatur velit et.','501047495','929677344','debit',0,4,5,NULL,NULL,108,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(109,'89.6','Beatae ipsam est praesentium quas omnis. Accusamus deserunt a deleniti voluptas ut exercitationem. Eos nesciunt sed ducimus non.','109343792','142323346','portal',1,9,1,NULL,NULL,109,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(110,'27.1','Repellendus dicta natus omnis perspiciatis. Ut exercitationem eum impedit culpa consequuntur deserunt qui.','546301749','977763571','portal',0,6,5,NULL,NULL,110,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(111,'30.6','Asperiores molestiae et quidem in. Nesciunt ipsum voluptatibus quidem excepturi. Nemo recusandae repudiandae in non. Velit tenetur cumque voluptatem fugit.','866080275','174303993','portal',0,9,2,NULL,NULL,111,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(112,'31.4','Fuga porro nobis aut nihil. Esse dolores beatae architecto quod assumenda non tenetur. Voluptatem vel autem sint dolor et quae perferendis autem.','802844196','225224832','debit',1,10,7,NULL,NULL,112,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(113,'75.1','Temporibus incidunt excepturi nisi debitis temporibus. Adipisci sequi numquam qui. Sed molestias est magnam deleniti ut adipisci. Nostrum excepturi architecto voluptas ea.','707585287','820915222','debit',0,7,7,NULL,NULL,113,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(114,'32.7','Totam aut facilis voluptatum id. Nesciunt vero tenetur officiis illum dolor velit. Assumenda ex minus eaque eos cum. Nulla et in laboriosam in deleniti.','187414016','819505577','portal',1,6,1,NULL,NULL,114,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(115,'87.6','Tempora et ullam et ut fuga iusto. Ipsum et praesentium non voluptatem sit. Porro libero id nulla nostrum. Vel unde earum quaerat consequatur.','704524795','423373948','portal',1,5,9,NULL,NULL,115,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(116,'29.4','Qui unde tempore consequatur omnis non deserunt. Ut cupiditate accusantium quod. Iusto quo omnis fuga saepe voluptate harum.','231497411','576363383','portal',1,5,10,NULL,NULL,116,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(117,'67.5','Minima eius enim ratione totam quibusdam maxime. Voluptatum reprehenderit omnis repellendus. Incidunt a quae consequuntur quia.','283087629','477028652','portal',0,3,10,NULL,NULL,117,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(118,'24.6','Maiores est fugit aut illo. Officiis reprehenderit molestiae nihil modi quasi tempora. Ratione sint et perferendis labore quia in veritatis. Velit reiciendis vel qui quisquam et.','632155482','918072833','debit',0,7,5,NULL,NULL,118,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(119,'40.3','Nihil cumque unde repellat quisquam asperiores totam autem. Consectetur placeat ad assumenda error distinctio sint. Id dolorum ducimus deleniti et. Voluptatem ad dolores ea voluptas nihil fugiat.','736756757','281482883','debit',0,7,8,NULL,NULL,119,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(120,'97.8','Eum perspiciatis at atque sed nihil. Hic debitis cupiditate quod sint consectetur.','292992940','190749419','portal',0,2,3,NULL,NULL,120,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(121,'62.1','Facilis unde distinctio vero est quisquam dolore quis. Voluptates veritatis similique consequuntur exercitationem dolorem. Sed saepe corporis commodi placeat iste eos vero.','517124126','463330530','portal',0,9,8,NULL,NULL,121,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(122,'78.1','Nesciunt est consequuntur ab facere. Debitis occaecati doloremque consequuntur ut et ab. Hic omnis nulla voluptatem quos rerum. Dolor earum laudantium odio eligendi.','840230436','363518491','portal',1,8,3,NULL,NULL,122,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(123,'42.6','Aut consequatur porro non ea quia culpa. Quaerat neque alias aut voluptates aliquam. Possimus eius veritatis cupiditate modi libero rerum doloremque dolor.','222105199','619357693','portal',1,10,10,NULL,NULL,123,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(124,'68.5','A enim quia natus qui corporis laboriosam iste. Facere temporibus accusantium excepturi error fugit. Mollitia et sed sequi ut mollitia.','935238340','174475062','debit',0,6,6,NULL,NULL,124,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(125,'82.6','Quam autem fugiat eos error. Est cumque maiores et ipsa nostrum.','714864916','648269596','debit',1,6,8,NULL,NULL,125,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(126,'28','Possimus voluptate itaque aut autem est. Deleniti est expedita mollitia sunt sit quas pariatur et. Officia aliquam tenetur a officia quis tempora optio.','370878378','152311651','portal',0,6,7,NULL,NULL,126,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(127,'26','Sunt in officia quaerat. Enim asperiores amet voluptatem vel animi. Aut reprehenderit sunt velit voluptatem odio quis amet. Excepturi vero dolorum ducimus ipsa corporis.','375149862','614461995','portal',1,3,3,NULL,NULL,127,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(128,'41.2','Amet asperiores accusantium soluta dolor ducimus. Vel magni facere voluptatem. Eveniet repudiandae accusantium exercitationem quo sed quisquam. Quo doloremque et repellendus odit nemo aspernatur qui.','159116074','550022344','portal',1,1,5,NULL,NULL,128,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(129,'98.1','Qui consequuntur nemo nulla ab. Animi perspiciatis esse molestiae sed consectetur est. Possimus tempore earum commodi iste.','502273530','189220841','debit',1,10,9,NULL,NULL,129,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(130,'18.5','Aliquam doloribus voluptates possimus. Quis explicabo molestias ullam id. Vitae tenetur est adipisci sit dignissimos repudiandae.','590317883','978930254','portal',1,10,3,NULL,NULL,130,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(131,'82.7','Et rerum et quis vel quo. Autem fugit molestiae rem ipsa earum. Nesciunt in dolores quo tempora veniam.','107705670','220617262','debit',0,10,7,NULL,NULL,131,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(132,'16.4','Ab hic amet molestias in assumenda aperiam. Esse quisquam temporibus molestiae rerum minus illo. Et vero occaecati praesentium sapiente.','239879207','206137569','debit',0,1,5,NULL,NULL,132,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(133,'50.8','Asperiores velit qui neque natus. Ullam qui enim quis vitae iure voluptatem repudiandae. In eligendi eligendi facere eum dolorem qui.','743037826','393338828','debit',1,8,9,NULL,NULL,133,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(134,'36.7','Quis perspiciatis est mollitia officia nisi dolores voluptatem. Ea quia hic id et dolor. Voluptatem deleniti iusto fugit dolores.','716542562','975981653','portal',1,3,4,NULL,NULL,134,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(135,'40.6','Magnam facilis voluptatem at molestiae architecto eligendi. Inventore natus dicta facilis explicabo. Ipsa eligendi tenetur dolores id ducimus. Laboriosam distinctio modi assumenda qui ex.','514868129','622501002','debit',0,10,5,NULL,NULL,135,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(136,'53.7','Ut ad sed corrupti necessitatibus. Qui placeat blanditiis est autem voluptatum et. Voluptates commodi labore voluptas commodi facere ut in sit.','735448056','531391987','debit',0,6,10,NULL,NULL,136,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(137,'22.5','Sit et autem eius asperiores voluptatibus. Qui error quia magni sed ipsa. Et quia impedit omnis provident aliquid. Aspernatur corrupti deserunt eum dolore quia aut.','533754392','754862303','debit',1,5,2,NULL,NULL,137,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(138,'91.4','Distinctio et ut ratione et. Eaque quae ipsa et vero quisquam ab hic maiores. Suscipit aut qui nostrum et. Minima et quasi nihil voluptas fuga suscipit amet.','839234879','602274504','portal',0,10,6,NULL,NULL,138,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(139,'58.6','Eum exercitationem aut assumenda nulla fuga ducimus culpa. Magni dignissimos accusantium maxime et. At nulla commodi soluta aut.','315361447','869950944','debit',1,7,10,NULL,NULL,139,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(140,'45.7','Sed atque distinctio vero deleniti facere totam. Voluptas a tenetur ea maxime. Delectus quo voluptatem quis unde. Et cumque voluptatem ut eaque officia et asperiores.','568143128','310874411','portal',1,10,9,NULL,NULL,140,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(141,'53.4','Consequuntur est et et rerum. Optio consequuntur enim maxime at corporis sunt. Voluptas aut qui culpa quasi.','689993755','241503269','portal',1,7,3,NULL,NULL,141,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(142,'21.6','Sit occaecati eum error sint odit. Nihil qui sint maxime libero eveniet. Dicta dolor voluptas est.','100286036','172532675','debit',1,2,6,NULL,NULL,142,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(143,'22.7','Doloremque doloremque est et similique. Saepe temporibus deleniti necessitatibus ea at repellat sit. Porro dolores sequi quia cum. Quia assumenda aperiam quam fuga atque quidem occaecati est.','779103780','287592838','portal',0,1,10,NULL,NULL,143,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(144,'41.6','Est aperiam non exercitationem. Temporibus quas ipsam et earum minus provident. Voluptatum ratione ducimus est consequatur ea. Harum saepe sed excepturi ab natus.','589385283','351789332','portal',0,2,9,NULL,NULL,144,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(145,'32.7','Eum sed accusantium explicabo unde sapiente similique corporis. In cumque aspernatur accusamus doloribus voluptatem velit autem. Eligendi commodi sit error.','119507500','621029849','portal',1,6,9,NULL,NULL,145,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(146,'53.7','Explicabo explicabo eveniet sit necessitatibus ducimus. Expedita qui inventore veritatis illum aut. Earum nulla maxime in vel iusto ab eaque. Quis id blanditiis perspiciatis iste a.','336815409','105336676','portal',0,4,3,NULL,NULL,146,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(147,'23.5','In suscipit eius adipisci nihil ex voluptatum. Possimus autem dolores est ex vel earum a. Voluptate id sint qui odio velit at. Quo sunt odio quod eum.','914181764','843267600','debit',0,3,6,NULL,NULL,147,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(148,'53.4','Ducimus fugiat voluptates accusamus eos. Nihil quis quaerat exercitationem voluptas ea a earum. Ipsam iure eum repellat magnam dolorem.','701331218','172583769','portal',1,4,10,NULL,NULL,148,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(149,'43.6','Quasi dignissimos aut suscipit aliquam. Odit quis qui vel sunt. Et perspiciatis voluptates porro beatae similique porro facere quas. Facere minus est perspiciatis aliquam.','351597134','906186279','debit',1,4,1,NULL,NULL,149,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(150,'12.9','Non quo sequi praesentium cumque repudiandae. Aperiam nulla sed quidem dolorem et sed. Expedita quia et magni in qui dignissimos et.','913981338','471453823','debit',0,3,9,NULL,NULL,150,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(151,'69.6','Veritatis corporis totam soluta numquam quis. Nulla maxime unde quidem assumenda est voluptas. Voluptatem amet dolor incidunt eligendi. Laboriosam ut aut error quidem voluptatem.','807580570','169879261','portal',1,1,4,NULL,NULL,151,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(152,'74.5','Non ut molestiae alias et autem vel. Cumque ipsum hic quo. Quod sit ex alias. Ducimus officia autem ut consectetur mollitia non.','144260817','450252529','debit',0,9,3,NULL,NULL,152,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(153,'23.8','Molestiae dolorum ipsam voluptatum. Et deleniti animi beatae ut porro rerum. Necessitatibus et sit ut voluptas omnis similique eum.','560589503','715482690','portal',1,6,10,NULL,NULL,153,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(154,'13.2','Mollitia repudiandae voluptatibus dicta repellat. Voluptates voluptatem cupiditate assumenda quaerat. Aut ut magnam odio recusandae eveniet.','219843334','234908457','debit',1,5,1,NULL,NULL,154,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(155,'21.8','Omnis laudantium nihil aperiam quaerat id doloribus aspernatur. Quas aut sunt odit esse repellendus possimus numquam. Id voluptas praesentium aliquam debitis.','948659350','718660653','debit',1,10,5,NULL,NULL,155,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(156,'73','Aperiam assumenda rem autem quo quas. Dolorum natus sint officia nulla. Ratione aut doloremque corrupti omnis asperiores. Esse amet et occaecati et et.','230827310','371030895','debit',0,5,6,NULL,NULL,156,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(157,'85.2','Eaque modi numquam sit est rerum qui. Enim facere libero sint non qui. Dolores recusandae quia id.','402488314','251270197','portal',0,1,3,NULL,NULL,157,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(158,'54','Ducimus ea laboriosam est corrupti beatae error. Beatae officia nisi quisquam commodi saepe dolore repellendus ratione. Ea ratione quo cumque voluptatem necessitatibus.','222401503','206122779','portal',0,2,10,NULL,NULL,158,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(159,'28','Id voluptatem saepe accusantium perferendis rerum dolorem quibusdam. Dolorem rerum ut blanditiis doloribus.','129937259','333011501','debit',0,6,5,NULL,NULL,159,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(160,'97','Deleniti rem dolore ut porro hic. Aut autem deleniti architecto omnis atque consectetur. Fugiat beatae quaerat nemo consequuntur perferendis ab. Vel enim aspernatur animi ipsam nam.','593960598','950372848','portal',0,4,6,NULL,NULL,160,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(161,'87.4','Qui fugit blanditiis ratione sint eligendi. Ipsa in aperiam id velit omnis minima. Qui rerum sunt ut in. Vel a quis alias veniam.','152401556','377782253','portal',1,1,3,NULL,NULL,161,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(162,'35','Quod eveniet quia eum. Laborum ad qui et odit. Autem rem et at sunt quo eveniet. Consequatur vel nobis omnis quia incidunt.','202031494','873346088','portal',1,7,4,NULL,NULL,162,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(163,'29.6','Dolor id impedit tempora dolorum laudantium. Labore assumenda voluptatibus atque iure. Laboriosam nesciunt laboriosam possimus numquam neque natus.','419669765','378415954','portal',0,6,5,NULL,NULL,163,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(164,'32','Ut facilis voluptatem voluptatem dolorum sed sint. Perspiciatis corporis cum nesciunt et dolorum est. Aut nesciunt quasi dolores officia est.','154060683','363819889','debit',1,4,2,NULL,NULL,164,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(165,'99.5','Quos rerum assumenda quia. At et id quas voluptas dolor laboriosam id. Assumenda veritatis illo ut quasi eos iusto. Eum alias dolorum et. In quia molestiae et voluptatem illum deleniti.','128416204','465138852','debit',0,4,5,NULL,NULL,165,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(166,'69.4','Necessitatibus velit et et rerum voluptate ea dolorum. Quidem perspiciatis ipsam dolorem odit illum quidem eligendi. Perferendis repellendus sed ut itaque quas aut.','722558627','741360087','portal',0,6,6,NULL,NULL,166,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(167,'36.2','Veniam consectetur dolore tempora eius aut. Temporibus sequi ipsam nam tenetur. Nesciunt earum magni repellendus asperiores quia.','845145180','197457065','portal',0,9,9,NULL,NULL,167,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(168,'25','Nihil provident quos eligendi vero amet aut. Sunt sint et sit cumque ut repellat. Enim beatae debitis labore dicta omnis dolorem non. Ut debitis non atque. Nihil nostrum vitae suscipit modi.','127609915','313030153','debit',0,4,2,NULL,NULL,168,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(169,'90.8','Omnis autem est nobis veritatis quod. Id quia soluta molestias quia quam necessitatibus quae. Assumenda totam eaque rem libero. Sunt sed dolore earum libero temporibus.','199231044','367478439','debit',1,6,5,NULL,NULL,169,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(170,'41.4','Blanditiis quae impedit provident aspernatur inventore repudiandae. Corrupti deleniti esse quia. Natus numquam qui neque sequi ab perspiciatis doloremque.','341716122','442968455','debit',1,2,1,NULL,NULL,170,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(171,'68.5','Quia ut pariatur ullam omnis. Blanditiis ea minus sint impedit dicta non non ratione. Et a laboriosam ut voluptatem id voluptatum. Ex dicta eaque consequuntur atque eos.','167297367','759245110','debit',0,4,3,NULL,NULL,171,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(172,'62.1','Minima rem sit rerum. Accusantium voluptatem voluptatem eos dolor nisi. Maiores est optio quibusdam sequi consequatur.','496387878','252976883','portal',1,1,10,NULL,NULL,172,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(173,'69','Enim eius est possimus suscipit ut eos a. Optio veritatis labore quia illum eius provident. Nihil dolor delectus itaque magni. Voluptatem dolorem enim voluptatem.','385063534','972695979','portal',1,10,6,NULL,NULL,173,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(174,'93','Dolor ut et laudantium amet non aperiam nobis. Officia ad et beatae voluptatem. Nostrum soluta optio et earum rem illum fugiat ut. Rerum quidem pariatur quam distinctio.','277241458','646048312','portal',1,3,2,NULL,NULL,174,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(175,'86.8','Hic hic aut quod consequatur eum. Aliquam tempore et quisquam et minima et. Perferendis odit fugit id laboriosam corrupti.','752841358','456520464','portal',0,6,6,NULL,NULL,175,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(176,'42.3','Laborum in possimus natus ut magni. Aut dolor perspiciatis reprehenderit aut saepe. Voluptatum impedit ut consequatur repellendus error architecto.','434779704','624199148','portal',0,2,9,NULL,NULL,176,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(177,'31.9','At vel aut perferendis nihil sit sunt. Reiciendis ipsum eaque doloremque. Id autem animi magni repudiandae ratione nobis. Rerum natus et architecto ipsam maxime est dolor maxime.','401686295','823816509','debit',1,1,3,NULL,NULL,177,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(178,'28.9','Cumque voluptas voluptatum pariatur occaecati iusto ut accusantium. Aut recusandae nam ea optio. Ipsam reiciendis omnis incidunt perferendis ut voluptas.','930026863','127997767','debit',1,2,6,NULL,NULL,178,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(179,'71.5','Sunt mollitia atque et voluptatem nisi. Beatae consectetur non autem vel dignissimos deleniti.','207598190','576029562','portal',1,8,6,NULL,NULL,179,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(180,'13.2','Iure recusandae eaque necessitatibus deleniti quam. Aliquam in dolore ab facere suscipit. Ratione quae ut consequatur repellendus tempore ducimus enim. Autem delectus quis qui animi et et voluptas.','268910991','428680116','debit',1,4,5,NULL,NULL,180,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(181,'62.1','Est asperiores libero necessitatibus nihil impedit quia. Consequatur quia et dolorem. Error ut ullam saepe. Accusamus amet esse asperiores officia commodi necessitatibus sit aut.','366168340','930791961','debit',1,2,5,NULL,NULL,181,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(182,'28.3','Fugiat dolores maiores maxime ea nisi maiores. Et quis placeat quae error. Vitae enim est sunt vitae harum dicta in. Fugiat qui veniam dolores modi eaque voluptatem ea.','167070382','345801257','portal',0,3,6,NULL,NULL,182,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(183,'70','Alias tenetur odit laudantium quidem iusto qui aliquid. Enim quae recusandae reiciendis velit aliquam. Et voluptatem praesentium corporis ut eius.','135438785','790188067','debit',1,2,3,NULL,NULL,183,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(184,'46.6','Commodi necessitatibus nostrum et ipsum exercitationem. In velit aut dignissimos porro dolores. Quas id sit iure ad dolorem.','142475389','835006458','debit',1,2,2,NULL,NULL,184,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(185,'22','In quod quia est reprehenderit. Architecto doloribus consequuntur molestiae omnis. Consectetur voluptas quas nemo molestiae voluptatibus fugit. Repellat qui voluptas dicta quo.','721676879','884603436','portal',1,7,1,NULL,NULL,185,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(186,'12.4','Quas placeat suscipit est quasi. Harum quo voluptatum exercitationem est illo. Rerum tempora molestiae quasi sed eum facere ut. Vel esse sit id voluptate.','506919934','820899605','debit',0,4,6,NULL,NULL,186,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(187,'92.2','Voluptatum ab ut rerum fugiat id est. Ut qui et laborum consequuntur sunt excepturi labore. Quia accusamus nemo est mollitia atque et rerum quidem.','724847319','601296050','portal',1,10,10,NULL,NULL,187,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(188,'42.4','Ut iure adipisci totam sunt et sed cum. Omnis beatae non fugit voluptatem eos iure optio. Doloribus sapiente quaerat velit rem nostrum officia. Consequatur porro assumenda aut vel sit placeat eum.','675027328','180176494','portal',1,9,3,NULL,NULL,188,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(189,'68.7','Quasi recusandae eos doloremque perspiciatis. Sed molestiae magnam modi inventore excepturi corporis sapiente. Minima est qui voluptatem ut ut sint sed sed. Cum harum velit officiis sed consectetur.','966336459','118882466','debit',0,1,6,NULL,NULL,189,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(190,'99.4','Cumque rerum recusandae distinctio esse. Iure deserunt ipsam at sit minus repudiandae aperiam. Qui nulla quis debitis incidunt qui accusamus. Quae necessitatibus quis qui non iste enim dolor nobis.','321562840','188267819','portal',1,7,5,NULL,NULL,190,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(191,'19.6','Ut consequatur et officia. Cum aut saepe voluptas aut consequatur in. Id doloremque architecto necessitatibus aliquam autem officia quasi.','530372018','663961551','debit',1,8,10,NULL,NULL,191,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(192,'60.3','Ut molestiae recusandae libero id. Voluptas qui voluptatem eius dicta molestiae aspernatur. Enim temporibus laboriosam aut sapiente dolorum optio.','645314271','741619448','portal',0,10,7,NULL,NULL,192,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(193,'91.5','A ut doloribus aperiam a sapiente. Aliquam neque ratione voluptatem quam sit. Qui aspernatur dicta deserunt quae officiis est eligendi.','827357104','515689013','debit',1,2,4,NULL,NULL,193,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(194,'25.4','Deleniti odit culpa velit. Et optio et consequatur eum consequuntur tempore. Molestias deserunt quia dolor nostrum quia quibusdam. Assumenda dignissimos officia tempore voluptatem expedita ea quia.','561455593','283958804','portal',1,10,9,NULL,NULL,194,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(195,'46.7','Laboriosam facilis at voluptas consequatur debitis. Rem accusamus quam vel maiores. Molestias optio ducimus illum eum officia. Illum reprehenderit reiciendis ipsa et.','546508884','302104366','debit',0,2,8,NULL,NULL,195,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(196,'18.6','Aliquid voluptatem et sapiente dicta qui repudiandae expedita. Atque id eligendi vero ipsa. Unde non neque veniam et repudiandae aut et. Facilis quo non vitae tempore exercitationem.','566523626','995512647','portal',1,10,4,NULL,NULL,196,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(197,'73','Nostrum quia quae cum. Ea aut eos qui iure itaque. Vitae hic totam veritatis laboriosam aut. Numquam id consectetur sequi.','592220376','847161401','debit',1,7,6,NULL,NULL,197,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(198,'60.6','Voluptatem ut exercitationem occaecati amet alias. Iure enim a reiciendis voluptates omnis in. Tempore ipsa voluptas laudantium consectetur nulla provident.','865512086','221055710','debit',1,6,10,NULL,NULL,198,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(199,'33','Velit voluptas tempore saepe ab. Quod dolores error quae officiis expedita. Amet porro voluptate quaerat id quo pariatur tempore.','775608426','214477610','portal',1,2,7,NULL,NULL,199,'2024-09-05 09:10:54','2024-09-05 09:10:54'),(200,'66.2','Voluptatem rerum incidunt sit. Ab non quis neque est rerum esse. Dolor aut rerum harum. Aut ut omnis ab veritatis saepe velit. Quasi laboriosam at ratione officia est autem.','630194496','243237446','debit',0,5,5,NULL,NULL,200,'2024-09-05 09:10:54','2024-09-05 09:10:54');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',3,'API token of Jeremie Rice','3befc3dab3544b3230fd42c11bce3c6c9cb643dd39559d42ca8f972309567d40','[\"*\"]','2024-09-05 09:11:51',NULL,'2024-09-05 09:11:32','2024-09-05 09:11:51');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `platforms`
--

DROP TABLE IF EXISTS `platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `platforms` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `platforms`
--

LOCK TABLES `platforms` WRITE;
/*!40000 ALTER TABLE `platforms` DISABLE KEYS */;
INSERT INTO `platforms` VALUES (1,'platform - 96',1,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(2,'platform - 72',0,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(3,'platform - 3',0,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(4,'platform - 45',0,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(5,'platform - 93',0,'2024-09-05 09:10:47','2024-09-05 09:10:47');
/*!40000 ALTER TABLE `platforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Neal West',8,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(2,'Dr. Leslie Jacobi',2,'2024-09-05 09:10:47','2024-09-05 09:10:47'),(3,'Joshuah White',2,'2024-09-05 09:10:47','2024-09-05 09:10:47');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sub_tasks`
--

DROP TABLE IF EXISTS `sub_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sub_tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `has_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `upload_id` bigint unsigned DEFAULT NULL,
  `task_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sub_tasks_upload_id_foreign` (`upload_id`),
  KEY `sub_tasks_task_id_foreign` (`task_id`),
  CONSTRAINT `sub_tasks_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `tasks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sub_tasks_upload_id_foreign` FOREIGN KEY (`upload_id`) REFERENCES `uploads` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_tasks`
--

LOCK TABLES `sub_tasks` WRITE;
/*!40000 ALTER TABLE `sub_tasks` DISABLE KEYS */;
INSERT INTO `sub_tasks` VALUES (1,'Prof. Braxton Robel Jr.','Sit enim dolores neque ex sed. Doloribus esse quas ab nihil veritatis quas voluptas aperiam. Sit unde cum atque aut. In omnis aut excepturi dicta ad esse.',0,0,NULL,14,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(2,'Emiliano Hauck','Qui qui eveniet repellat dolore quibusdam consectetur. Iste et dolores esse. Ducimus ut consequuntur aut minima occaecati eaque. Distinctio perspiciatis qui explicabo et rerum ut.',0,0,NULL,12,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(3,'Karlee Durgan','In magni molestiae harum quos. Repudiandae sunt eos consequatur similique. Ipsa minima nobis aut corporis ab consequatur.',0,0,NULL,15,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(4,'Rosetta Marks PhD','Molestiae provident quia corrupti optio. Sunt qui debitis minus aut animi. Sit quia iure enim vitae minus. Aut id culpa officiis sit tenetur quia. Itaque minima praesentium rerum totam.',0,0,NULL,7,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(5,'Dr. Monique Morissette','Quidem eum debitis asperiores minus. Unde aut tenetur mollitia qui. Debitis ab est officia iure quam omnis.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(6,'Glen Kozey','Recusandae deserunt quam ab tempore qui. Nostrum in voluptatem placeat aut fuga harum veritatis sit. Debitis eos omnis nostrum illo assumenda.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(7,'Carissa McKenzie','Facere nisi atque debitis ut. Sint architecto eaque et fugit inventore a. Natus soluta sit et nihil. Quibusdam dolor quisquam quia ut voluptatibus.',0,0,NULL,7,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(8,'Prof. Shane Dach','Est quia quo ut quos. Itaque magni quos ut.',0,0,NULL,14,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(9,'Karina Goodwin','Consequatur hic consequatur voluptatum veniam dolores cumque rem. Voluptatem accusamus sit nihil voluptatum. Sit expedita omnis nesciunt rerum ullam delectus sed. Et est labore labore.',0,0,NULL,15,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(10,'Cornelius Morar','Inventore provident consequatur non cupiditate aliquam deleniti atque. Assumenda necessitatibus qui repellat doloremque qui magnam quaerat rerum.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(11,'Christian Heidenreich','Aut doloremque dolores natus deleniti et. Numquam deserunt excepturi at aut provident. Excepturi ut cupiditate ipsa perspiciatis.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(12,'Korey Fadel','Nostrum id accusamus dolore qui perferendis. Qui labore nihil magni natus. Consequatur qui ea molestias quo. Dolor illo sint sapiente iure est saepe explicabo voluptatum.',0,0,NULL,5,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(13,'Miss Ilene Farrell Jr.','Et hic tempore sapiente eos id autem. In magnam et ea vel cupiditate. Expedita hic vel culpa est. Explicabo autem occaecati dicta laboriosam in.',0,0,NULL,9,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(14,'Mona Durgan III','Ut sint consequatur non ipsum. Cum molestiae numquam qui incidunt tempore dolore. Enim et voluptatem sint dolorum repellat nulla. Dicta debitis nisi dicta. Harum ut reprehenderit sed nam.',0,0,NULL,7,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(15,'Dr. Silas Schiller','Eveniet laboriosam molestiae ea perferendis. Possimus omnis eos id alias rerum quia soluta. Quia ut ipsam et hic.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(16,'Nathaniel Barrows','Voluptatem accusantium sint qui reiciendis fugit id voluptatum assumenda. Officia consectetur aut accusamus odit aut. Laboriosam numquam quam nihil. Quasi asperiores sint voluptatem.',0,0,NULL,4,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(17,'Ramiro King DDS','Minus sapiente aut similique maiores sint. Tempore incidunt dolor aut quae dolores voluptatem consequuntur. Sed occaecati quas nostrum in explicabo.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(18,'Grant Lehner','Quo dolor ut aperiam magni eos ipsam. Non ratione eaque nesciunt sint possimus. Sit mollitia placeat quas sit.',0,0,NULL,11,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(19,'Dr. Akeem Gusikowski','Molestias atque delectus nesciunt voluptas. Fugiat architecto minima sequi magni esse. Voluptas ex error impedit qui fugit dicta blanditiis rerum. Aperiam molestias provident ab.',0,0,NULL,4,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(20,'Idell Barton','Quae quisquam adipisci ut totam neque. Ipsa illum qui aspernatur ratione voluptatum quia enim. Dolorem quaerat veniam quia minus dolor modi voluptatem. Iusto expedita eveniet rerum veritatis et aut.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(21,'Linda Brakus','At suscipit nihil non est nihil. Voluptatem dignissimos placeat ducimus ut aut voluptatum vel. Doloribus quod dolorem rem laborum officiis consequatur quia. Repellat magnam ex aut illo.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(22,'Mose Funk','Incidunt iure fuga libero. Voluptatibus ducimus temporibus saepe est maxime. Est praesentium maiores rerum consequatur mollitia.',0,0,NULL,7,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(23,'Mr. Foster Schmeler DDS','Consequatur modi et nihil odio et ab et. Reiciendis quam sequi et provident laboriosam quas. Porro repellat eaque totam eum dignissimos doloremque aut.',0,0,NULL,6,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(24,'Tatum Flatley','Atque eaque vel alias et qui similique. Nobis ea enim sit. Enim maiores excepturi aperiam distinctio esse nobis.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(25,'Peyton Keebler','In ut impedit aspernatur fugit. Sed ad corporis exercitationem praesentium reprehenderit quo. Neque ipsa voluptatem exercitationem et quia consequatur sed quae.',0,0,NULL,7,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(26,'Elvie Morar','Nam reiciendis accusantium et soluta numquam. Illum in id qui omnis et. Ducimus quia nesciunt debitis repellat ratione ea.',0,0,NULL,4,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(27,'Alexzander Willms','Molestiae et consequuntur in alias. Et quia quibusdam accusantium. Incidunt consequatur sequi molestiae excepturi molestiae dolorem libero. Laudantium ut facilis distinctio veritatis.',0,0,NULL,12,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(28,'Ms. Leila Parisian Sr.','Porro minus est est et ut. Culpa non et quia magnam possimus deserunt. Tempora odit alias eum deserunt. Voluptates consequatur delectus enim et recusandae aliquid voluptatem.',0,0,NULL,6,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(29,'Mrs. Kattie Ondricka MD','Sapiente quod in ratione itaque at quis. Atque ea sed quia labore quis iste nesciunt. Ipsam maxime illum voluptate similique.',0,0,NULL,14,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(30,'Rita Predovic','Aut sed et voluptates omnis ipsam dolores quia. Nam officiis iste quaerat totam. Voluptas magni aperiam harum velit nobis. Fugit officiis sint labore vitae laborum deserunt et.',0,0,NULL,6,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(31,'Murl Dibbert V','Praesentium numquam ipsum libero officia ipsam eaque laborum. Sunt accusantium architecto error et. Est corrupti corrupti praesentium doloremque officia et quisquam voluptatem.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(32,'Quinten O\'Conner','Et voluptatem distinctio est culpa vel tempore. Quaerat voluptatibus sit facilis laborum. Aspernatur vitae voluptas harum consectetur quia consequatur et.',0,0,NULL,15,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(33,'Yasmeen King Sr.','Autem consectetur tempore debitis esse sapiente. Cumque et aperiam ut aspernatur sit ullam. Dolores impedit corporis est illo.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(34,'Fatima Leffler','Quo dolorum eius debitis vero facilis mollitia. Illo omnis officiis ut placeat. Autem corporis et voluptatem. Reprehenderit alias ea perferendis nemo aut vel non.',0,0,NULL,11,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(35,'Ms. Corene Nader II','Beatae ut inventore non eligendi necessitatibus corporis fugit. Placeat cum fugit quo officia reiciendis. Maiores laborum ut enim qui.',0,0,NULL,7,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(36,'Dr. Kaley Casper','Id et a repellat eaque quia. Quaerat accusantium ut officiis quos distinctio non error.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(37,'Prof. Weldon Kassulke I','Qui accusamus at est aut aut voluptates similique. Alias harum voluptatem placeat nisi exercitationem maiores molestiae. Minus ut quia quia rerum aliquam. Distinctio impedit ut nemo voluptatum.',0,0,NULL,15,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(38,'Norwood Terry','Voluptas odio ipsum enim ullam nesciunt cumque sed. Iste error dolor autem consequatur ea eius. Laudantium omnis non iste omnis. Alias vitae minus aut vel.',0,0,NULL,9,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(39,'Thomas McLaughlin','Quo at quia laborum. Quaerat quia et hic quibusdam qui qui libero. Et id ullam dolores labore esse consequatur molestiae. Non delectus odio numquam veritatis qui voluptas culpa.',0,0,NULL,8,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(40,'Willard Hegmann MD','Ab in qui consequatur. Quae necessitatibus aut architecto eius provident et. Qui omnis in odit vel ipsum dignissimos.',0,0,NULL,1,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(41,'Prof. Taurean Schmidt III','Amet architecto sed reprehenderit commodi autem quia id. In nam praesentium dolores sapiente voluptatum voluptas. Voluptas hic aliquam quasi.',0,0,NULL,6,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(42,'Casimer Tromp','Debitis quia ea vel blanditiis delectus voluptas. Molestiae nihil culpa aut velit dolor libero. Non maiores sunt totam sequi.',0,0,NULL,9,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(43,'Gregory Sauer','Aut fugit fugit omnis maxime doloribus. Rerum libero est excepturi.',0,0,NULL,5,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(44,'Ashleigh Koss','Quia officiis corporis dolore illum sunt. Dolor error odit aut doloribus atque voluptas quos. Et qui veritatis dolorum architecto.',0,0,NULL,5,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(45,'Dr. Mathew Tillman IV','Iure odit aperiam a facilis molestiae ut ut. Deserunt eum totam aut sed vel. Non earum impedit sunt qui. Veritatis vero rerum et odio asperiores.',0,0,NULL,3,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(46,'Oswald Kling','In qui id doloribus ipsum. Omnis culpa qui consequatur nulla inventore. Veniam sequi omnis cumque aliquid. Rerum alias sed et illum dolor laborum.',0,0,NULL,6,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(47,'Sherwood Huels','Odio sunt alias inventore consequatur voluptas eaque optio. Corrupti quis voluptatem itaque et officia veritatis quasi. Perferendis qui ut et ut architecto perspiciatis doloremque qui.',0,0,NULL,6,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(48,'Jed Hackett','Voluptas ut qui soluta molestiae earum. Et dolorem repellendus id fugit. Soluta ipsa quo ducimus temporibus. Rerum aut rerum consequuntur sapiente minus unde. Nostrum tempora vitae consequatur.',0,0,NULL,12,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(49,'Nina Feest','Animi aliquam maxime recusandae delectus. Autem distinctio modi dignissimos aut pariatur. Et quasi beatae suscipit et reprehenderit sit. Aut accusantium explicabo tempore id laudantium.',0,0,NULL,2,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(50,'Daphne Mosciski','Qui excepturi sapiente aperiam fugit. Explicabo cumque officia nobis qui nihil cupiditate. Sunt expedita cum ut aut minus.',0,0,NULL,2,'2024-09-05 09:10:53','2024-09-05 09:10:53');
/*!40000 ALTER TABLE `sub_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_id` bigint unsigned NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_file_id_foreign` (`file_id`),
  CONSTRAINT `tasks_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Bianka VonRueden',1,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(2,'Demarcus Williamson DDS',1,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(3,'Alia Prohaska',1,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(4,'Dylan Durgan III',3,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(5,'Cory Heller Jr.',4,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(6,'Orion Fahey',4,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(7,'Dr. Rogers Franecki',5,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(8,'Darlene Schulist III',1,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(9,'Rosella Rutherford',1,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(10,'Lolita Keebler',4,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(11,'Mr. Kennedi Ledner Jr.',5,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(12,'Justine Lubowitz Jr.',2,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(13,'Micheal Cassin Sr.',1,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(14,'Mr. Gideon Streich IV',4,0,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(15,'Prof. Alexander Kub II',2,0,'2024-09-05 09:10:53','2024-09-05 09:10:53');
/*!40000 ALTER TABLE `tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uploads`
--

DROP TABLE IF EXISTS `uploads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uploads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int NOT NULL,
  `path` int NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `upload_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uploads_upload_by_foreign` (`upload_by`),
  CONSTRAINT `uploads_upload_by_foreign` FOREIGN KEY (`upload_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uploads`
--

LOCK TABLES `uploads` WRITE;
/*!40000 ALTER TABLE `uploads` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_available_sessions`
--

DROP TABLE IF EXISTS `user_available_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_available_sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_available_sessions`
--

LOCK TABLES `user_available_sessions` WRITE;
/*!40000 ALTER TABLE `user_available_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_available_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `national_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `image` bigint unsigned DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  `role_assigned_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role_expire_date` timestamp NULL DEFAULT NULL,
  `is_trashed` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_phone_number_unique` (`phone_number`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Bo','Tremblay','71976515400','tstiedemann@example.org','317712497',NULL,NULL,'$2y$10$6w8.ABHpzT8TRQBvkTMZ2.7/XI4lcJf.BcYMoBSPUzKhqIuu8Jnzi',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(2,'Tabitha','Hammes','95650191339','deion.ryan@example.net','217244751',NULL,NULL,'$2y$10$34LZX37c8fhvwlyN90zk/OOBgejiYkjGIR1CvCm0m1WIXvWglKjr6',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(3,'Jeremie','Rice','70560426113','crooks.dale@example.org','123836279',NULL,NULL,'$2y$10$2M07fQ4rJ0wx7NPT1fiCvOd00/s9UUVt5sMDtVZ6ntIO6gBnVd7b2',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(4,'Marie','Sipes','43637853393','aleen97@example.org','169761063',NULL,NULL,'$2y$10$ruh7QP9J4XWagY.j3D0i9OZEv2noxAtALLnazC6S1uWZ7Zt0duOOa',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(5,'Edward','Waelchi','58350097121','rau.stephanie@example.org','832552709',NULL,NULL,'$2y$10$3cvBknR71QmvisaTyObeGeIKhVmJX2InfivN3F3bwKP9wyOj.BbY2',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(6,'Moises','Bogisich','93819308829','leuschke.maxwell@example.org','527339193',NULL,NULL,'$2y$10$udF.RL.Iy0Eq0q0f/Jd2o.urq3VocDiHbzPv9q..mJmrxhyfgdYVe',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(7,'Hannah','Fisher','85236224504','egrant@example.com','626503447',NULL,NULL,'$2y$10$sQ5FXsZD.CUKAZX/f.zTGOr4xGnm4agrUPsfAVDUlpXfp8tk/cMDe',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(8,'Bella','Murazik','56933409492','reynolds.emilia@example.org','318914615',NULL,NULL,'$2y$10$qAfPevVwjH2Vpruo/ZXFCuyBkIv1hsoBK8s7xSAix.QMd1wAqA8/.',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(9,'Celestino','Hettinger','11411166487','bpouros@example.org','125727748',NULL,NULL,'$2y$10$GsBunW6zQ7xEGbYYZq9lUuy.ECQBYkVLSg/zcsvVEW4LyBJ/eqIIO',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(10,'Stephon','Harber','42582209101','torrance93@example.com','982286645',NULL,NULL,'$2y$10$8C6X0fz2N9eZBqxGiwPCouMgYMR5VQQXnzQhvDH2A.BFbuqDor7.2',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(11,'Johanna','Hermiston','37688244135','queen.rodriguez@example.com','489548470',NULL,NULL,'$2y$10$6L/MsGewr4aBaT8g3RF66eYAtO4bdVzpvp52oQSazTYS3S5oD5BWW',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(12,'Dedrick','Bins','90497733194','xlang@example.org','482182004',NULL,NULL,'$2y$10$EY1jm81PxqTjQiAJFaYllesluu898t4FpIB4DigmYz3qBqAKgbAKW',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(13,'Keith','Swaniawski','35484138235','cordell.yundt@example.net','363356318',NULL,NULL,'$2y$10$BJL9iukdsGpTCZ8hkWqsbuV3hJEUs/6fp.ygwhVnTqu806NgC3hhy',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(14,'Hortense','Rowe','98996093469','rau.zack@example.com','790211080',NULL,NULL,'$2y$10$Jk/kC35Qjzy4OZlSb9n/4uuWaxJBHQmwSZuEy.kpdDOOUPIQqlwiu',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(15,'Lorna','Ritchie','81957267626','zmorar@example.org','459397290',NULL,NULL,'$2y$10$L4Ag2KBdVIe5.x4MA9bVbePAAhzCp/LjQUjSLi1vPa.MxDSbLA8WW',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(16,'Tomas','Boyer','29857617603','wilma.pfeffer@example.org','939318241',NULL,NULL,'$2y$10$VBriSDo1J3Ud4T3Zb5InLOXKlJThzUfGtk/jVfnDRIUV9Bgq3BCZ2',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(17,'Lou','Mertz','15776136634','johnson.tina@example.com','904843022',NULL,NULL,'$2y$10$G00tcrzzxXTMHCnIu647OuuIHwnuGmDCx9bKUMwZFK71YSe.4Qd0u',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(18,'Arvel','Hagenes','42464279126','mboehm@example.org','404414245',NULL,NULL,'$2y$10$YlvXemhmw.MsG6eOj7D7MeGZ1FfC3oTKC.Nz1IH1SUSIa/KN9wV/K',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(19,'Deshawn','Okuneva','72878118294','thowell@example.net','495304574',NULL,NULL,'$2y$10$j9Uy5mF4qJSSTdZFp/X2YufGqIkQoaOgypw10pxhcPDZa5yw6WfuO',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(20,'Pearl','Jaskolski','74115889349','wpurdy@example.net','128781538',NULL,NULL,'$2y$10$RCDV33N6rGhCWPb.5FLMYOBwYAF49ZdWhmh160190dUN31rT7KQmi',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(21,'Jeremy','Stracke','83404125349','randy.tromp@example.org','895699119',NULL,NULL,'$2y$10$ZNI7bhdjpIh/EZHgyRouJuU7KbT1nJD1vEl5Bzu5QeYpL1v7ZPDre',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(22,'Jermaine','Becker','54284903857','newton.hahn@example.net','795098742',NULL,NULL,'$2y$10$7/blxuCJ7b7NhCOPPa3ESu9SSoI5iWUP8AtT3gg8A5BFZsxAC3.JO',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(23,'Rosemarie','Cormier','43959383300','howell.carmelo@example.net','615382502',NULL,NULL,'$2y$10$anlqbXcf40Y2y6sSnDrA4eCN.5bOQ7M/0Wqxj6Z7mYjCVPFsSbv7G',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(24,'Kassandra','Zieme','99282415118','sterling49@example.net','451330058',NULL,NULL,'$2y$10$aF.Dp9BS6eq7xXBgy2CaFuLrYZSEDbCD0UGTbyCVt34TKZsrbtBFO',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(25,'Jordy','Fahey','78706092028','cicero12@example.net','657787952',NULL,NULL,'$2y$10$mPOom/IKO1WP9jqNuBCv8eoAi8Y7CgLC9wyQig6Kxf9J2kU49IRm.',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(26,'Vidal','Nienow','69023742086','gbrekke@example.org','751666748',NULL,NULL,'$2y$10$V0.EQi/yGyeICb.UznB1.OyfP4xIni5luNT..7LcKKC5ZjuGRBjBq',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(27,'Trinity','Wisoky','66355800105','fisher.pietro@example.net','312536950',NULL,NULL,'$2y$10$/9GSBWsVDHY7DfbBreZ82.BIkUKNwh8bYmJGmlnAfzfvzZqCF.D.O',1,NULL,3,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(28,'Michale','Zboncak','15034868295','koepp.anibal@example.org','677152939',NULL,NULL,'$2y$10$uZpIPthXycOWJyGtZj3UrOOWX3/3vwn5HW0vySHPVgb4JUppdFoAO',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(29,'Darwin','Huels','24612561665','elliot.barton@example.org','351803995',NULL,NULL,'$2y$10$LNCMs1/qw8O1hf.aFPz1D./RIJMuWcRFfoKat8Migo15s4uiSP8eC',1,NULL,1,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(30,'Juana','Braun','19163898158','katharina18@example.net','356538013',NULL,NULL,'$2y$10$fagH6cOMgfqyeJXa6.3eo.HSG5TXAE33uKztNNey059v9cOVjY7Rq',1,NULL,2,'2024-09-05 12:40:49',NULL,0,NULL,'2024-09-05 09:10:49','2024-09-05 09:10:49'),(31,'Nathanial','Jast','71299702437','blanche.conn@example.org','425929777',NULL,NULL,'$2y$10$JoLiD5qG6H3VFQhTA/fyDeJ/2J2NwF74OBnPI94xFXoPlRK8YeFOy',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(32,'Wilton','Moore','18149084380','bogan.norene@example.com','633344437',NULL,NULL,'$2y$10$1jW6m8G3lFwGXaXiM0JCFeTR978.kuUZFcKmL30CsuIRvPCiMZiqW',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(33,'Anne','Beier','37308276124','milford38@example.net','632296062',NULL,NULL,'$2y$10$30/L2hJKnGq8G/8jMOUjaemQhsdyK7XigycLO1qC2oTesItqnhXoG',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(34,'Courtney','Romaguera','76139591405','weber.theo@example.com','149926475',NULL,NULL,'$2y$10$DqsLfsMy3scLkrB2WQV3FuvMNemfNuspXSA0vYBwDznOJT/r8pqm.',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(35,'Yasmine','O\'Keefe','41349906818','hkutch@example.org','885677304',NULL,NULL,'$2y$10$RHpukQAKMdB3vI7W55mGqO1ddYFqP7IK.sucseCd91VFKpZJMdsy6',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(36,'Aniya','Hermann','62483977662','rolfson.wilford@example.net','160285230',NULL,NULL,'$2y$10$6wYq8Sxc3u5QfhQ1ebEJdO.JxjBBH2VgxBdzwCTUngAxBoC0HPsNi',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(37,'Hal','Jones','59484004460','strosin.rodrick@example.net','964483282',NULL,NULL,'$2y$10$64kAwUt66RaTYRhLqio5Wep/lbP41PDaDyGrmHE2kRSekblXt5V3m',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(38,'Patricia','Greenholt','77755640083','terry.kasandra@example.org','787770060',NULL,NULL,'$2y$10$a7j9AK1jPziLTW8vNr.IgOJ.Nl0e8QwHnWh8rkW5Ciu2efoZ5tvA.',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(39,'Luciano','Cruickshank','74724624649','alia.dooley@example.org','139735914',NULL,NULL,'$2y$10$fLtos/ZtIWvkjKDNorU8ceG2Eh/35knvZU3BnSwrYsYxCyuirf0tC',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(40,'Buford','Ratke','63241987024','bethel.dach@example.net','453499819',NULL,NULL,'$2y$10$Y4y1DOqMlApnXUppugNa2.eqnlvGT9lbeP8/dHQcVer9Pxr6Jp3u2',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(41,'Florence','Ratke','95904620414','enrico.mosciski@example.org','561077054',NULL,NULL,'$2y$10$g3GAnaxKvLMl4uKn62JPVO9XTeFcT9UqJbt/1sl7HnE6PWMW65VAW',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(42,'Johnson','Goodwin','86863085101','blick.pierre@example.net','305068410',NULL,NULL,'$2y$10$icIw7k.aEu/hQqxWSNnC2Oka0Jvuk0IS0E7zckES9sVk8iJbcaiRK',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(43,'Rebeca','Beer','22888288034','rebeca.emmerich@example.org','343837913',NULL,NULL,'$2y$10$VD0NnBqM4RLTzzpqkOvMy.Sx7aYKzIdapxU6/soVGvAig6ADeXRGa',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(44,'Fabian','Treutel','81774237092','bret.hettinger@example.com','234668524',NULL,NULL,'$2y$10$DnUN9bnG7dY6eoWDJSWT6.0Riq3Dave28SzsmCgsp2RR3QkIj7vea',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(45,'Tremayne','Mayert','23820831509','aidan.johns@example.net','156519439',NULL,NULL,'$2y$10$3igZOYgQJoLxjJsFQ/i1/.ZIJt.jzL5RvxylCQrAxzJLazzhFdYBG',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(46,'Velma','Greenholt','38341268516','saul96@example.net','334152002',NULL,NULL,'$2y$10$VW0B8mcRKeh1lmgNj1prfOIinsdc7o8rpYJYHkO8v4CFhdWCnMKWa',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(47,'Ashlee','White','63869516569','rlangosh@example.net','968124228',NULL,NULL,'$2y$10$WlAHqY2WortjDX3XIinlMucWC3sGthwJJd1QvrwsV3nJgKDpXJ.F.',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(48,'Jayden','Kuhlman','13107906005','schmeler.lilyan@example.com','287709443',NULL,NULL,'$2y$10$irH5BlLIlDihp2S1nG5I6..h2/5XXJNDxyzLPQr16/PTxi.qHvrYO',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(49,'Kendrick','Sporer','52777328993','kristian.kiehn@example.org','858772600',NULL,NULL,'$2y$10$IwOs6yRPHrncgRSGbzIvI.F5ibwlHFhv6aWX5cv3lPGbojzclmg0i',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(50,'Doyle','Heller','82266817815','kadin42@example.com','777223796',NULL,NULL,'$2y$10$3pc8FegfbLvCA6C8DVS5leUVkQi7QDB8xkeYS9gZ1/FcoViPG1ZVG',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(51,'Clifton','Fisher','81868758972','isabella61@example.net','857414222',NULL,NULL,'$2y$10$v6DwGR7fufN5ffhwa1uuNeCRMf/fdEHB.14IR5RiLfNWzBBIeZo5m',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(52,'Emilie','Spencer','40656689602','angelo10@example.com','707603435',NULL,NULL,'$2y$10$OkH21SdLGj/9m06vSF0r..7rhOEj4z.BAZryQq4Dhj5NVlp8VZy/u',1,NULL,3,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(53,'Rosa','Kuhlman','95929700367','gilda.oconnell@example.net','163055781',NULL,NULL,'$2y$10$cDkC6S.U.2qDtaUhc0/Z0em699DkGmf7EcXNawcbET0eJgG0e1ncO',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(54,'Jayson','Kunde','45030649088','loren93@example.net','623254690',NULL,NULL,'$2y$10$AGIsT4ywkfCop/Mb.5FZF.gT9FSVZ0mVgPjzFtt37aOl07D6ptpie',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(55,'Jammie','Sauer','14278539684','christiansen.ernesto@example.org','705559476',NULL,NULL,'$2y$10$rjtw2Ln11JwEySnvs2Ex3unKo4HfFgIX6XsjLJEJZRSp8vTKoXbca',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(56,'Taylor','Ritchie','87298439622','lesch.abraham@example.com','103410951',NULL,NULL,'$2y$10$tSSBH1bduUd82b9OUKY2yu6axkcP5Jh9oeAIaHc9wKdgk/CCgv1iC',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(57,'Bette','Okuneva','29106358491','yrempel@example.org','678542868',NULL,NULL,'$2y$10$Lw9LAvvbqI/nsWhdV8udL.wltdDMZpx.wbjkKW6CT8GVd6mi3rqtC',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(58,'Ophelia','Reinger','10819810494','leif56@example.net','608101002',NULL,NULL,'$2y$10$9QTTxNS3vVA1TtIb4OhzMuf08V0JxB/1GOFEpdK24Q365fMEroN/q',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(59,'Destiny','Osinski','89979427811','haven78@example.com','918077840',NULL,NULL,'$2y$10$Y86R5O9fanfBjz3FvX0tMu8ceTtCRWThQ4U.w8EToFgNQ6F3mex6K',1,NULL,2,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(60,'Eliezer','Hane','99131829154','verda.bartoletti@example.net','987758419',NULL,NULL,'$2y$10$Bv0RdvaJO4LRO8quOcIg1.P7GtWW3ZIIbyd7HijD6r2CzLXahmuSO',1,NULL,1,'2024-09-05 12:40:51',NULL,0,NULL,'2024-09-05 09:10:51','2024-09-05 09:10:51'),(61,'Rosalee','Dickinson','32952182179','enoch16@example.net','474504782',NULL,NULL,'$2y$10$dgkm2G4LN69uXa1uyHjdleWpQeQvDpoOo7pFumq2ySlG/eDVZg5Iu',1,NULL,3,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(62,'Garrett','Eichmann','78676861236','jenkins.gudrun@example.com','521938492',NULL,NULL,'$2y$10$XXYXluCIuaxhwPGLqdV1rukFb69/JL4qCeRa1NEcRKU.EpHM/Vdc6',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(63,'Jaleel','Parker','27422322009','madie.larson@example.com','122835086',NULL,NULL,'$2y$10$vLTaK/Z16BaUD4YkFtcPfOTEHD7kCqFCrmkk5GvpJe/wXsy5ynJCO',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(64,'Anahi','Shanahan','81075134820','jammie.hirthe@example.com','136231730',NULL,NULL,'$2y$10$j4Q2wrwLk3VpGaC6mNhkY.dK7v8KYR/z1uW2AGOv6C8rZsEw2r2gm',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(65,'Scot','Skiles','92845036901','clegros@example.org','994691465',NULL,NULL,'$2y$10$lfiASjp4NRU1E/Rnv8xPw.71cmG6utCKg3jjDumN3b6KXtOSxgZfm',1,NULL,3,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(66,'Werner','Douglas','88491776199','salvador.weber@example.org','484703114',NULL,NULL,'$2y$10$rhKA2BajnCEmLZLJVO1x8eto9kus/cWuBV.MsB76/kH9ObuteS2GW',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(67,'Verna','Leannon','46851202266','glynch@example.com','504020341',NULL,NULL,'$2y$10$xMJ7hCgBbUoCeBzv0eeNNuXvqUeWH7kjdvMx1jPG/k5QosQuaKbfa',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(68,'Georgette','Greenfelder','84320542817','ondricka.darrion@example.org','356328893',NULL,NULL,'$2y$10$tgr4L2lDnMpkYsxRkW5tp.WkfLyxqZyG7sqRnFS.Rkftkpqc7yB7K',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(69,'Lelah','Harvey','98941831338','alberto91@example.com','925251454',NULL,NULL,'$2y$10$FbGd8L.2XCeTS6dhpNsXfuqW4nGFpXNHoF7.EDkKmD07IGB6XHHCC',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(70,'Rudolph','Ankunding','50729903886','sydnie.wolf@example.com','892872589',NULL,NULL,'$2y$10$C.KySjUW8WEUyp2TYjUJMuDAb5Imr/IVT/DIacgImXb7CWPVbobhu',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(71,'Marlene','Spinka','73644024967','mariam.beahan@example.net','459064214',NULL,NULL,'$2y$10$MzNcYXJBXMsmlblTkuaBgu3261sQrVY9WynRqX0HejN/DjqObtrIC',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(72,'Marianne','Hahn','19399935562','sabina69@example.com','242318393',NULL,NULL,'$2y$10$EawyefgM9jhv2xucUFXKNO4rHs7w5SrvDnkT54qdxMy0Ko42afwE.',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(73,'Rolando','D\'Amore','42623434185','fiona53@example.net','660468986',NULL,NULL,'$2y$10$I4xaq2a1g5s4vCKrchHV1O6gCJmwk2V169KvX.j9ZcK5vUxwOyYM6',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(74,'Lue','Lemke','28798857325','pablo85@example.org','534413390',NULL,NULL,'$2y$10$QOSMFU.rOXA0v.hQmqNQieSZyLLyLhxldbtwGSspw5BWQvxNiHUEO',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(75,'Elva','Reichert','59670986931','hans32@example.com','195155756',NULL,NULL,'$2y$10$ej9DKJp6ZM3g7m.Q09dEzuxNCJ2L79cYfXFyWKMUgh00Lw3BBsE/G',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(76,'Emilio','Feest','29971374820','hammes.hal@example.com','778090321',NULL,NULL,'$2y$10$tt6080mWUPVbzVAUwebZxuK1INjvA8F/LjEodmG2OrDzzjLC/Xqrq',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(77,'Lionel','Feeney','80726565046','assunta93@example.net','335647744',NULL,NULL,'$2y$10$JUJOyipIS1iZMOgiwce/Y.ojugJI9dQv9ntJ5/QrfxDs3w9XJznca',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(78,'Krystal','Koss','77698157064','jblock@example.org','596394921',NULL,NULL,'$2y$10$I4FxHU6lasbm4mqH21z.Hu8N8ff.Tevrlrs7tX98rXprAjKe0rwFm',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(79,'Issac','Reilly','74721316057','kohler.juston@example.org','844796077',NULL,NULL,'$2y$10$0MNwcx59Ozwk/6IJ2SkXZumeXRd40LUgQX3MrzWC/tZuQ/VXujQ52',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(80,'Ashlee','Cartwright','62532273311','reilly.leanna@example.net','583163482',NULL,NULL,'$2y$10$frbWzgps8FuL3JKApTU4iOKC0UphcXaNai3Tt8hzbu9fw2Ta/Xq76',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(81,'Yasmin','Considine','77119314576','jakubowski.lolita@example.com','840363035',NULL,NULL,'$2y$10$Sy58gZRYBWsxKUGTLeJ4JO0uOsbNsly5seSehyGFh9FoOsYONI2AK',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(82,'Margaretta','Welch','44808555703','okey94@example.com','912374333',NULL,NULL,'$2y$10$IchfOZa0xXZYrRBgdkIUF.mnYxJ5tLtWb7yMU0qeWTW0ugZdT4yVS',1,NULL,3,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(83,'Amya','Boyer','39170788187','sandra04@example.org','575794213',NULL,NULL,'$2y$10$kBMkmgVr0eS4j3HuCYv3t.8rM8BoT2GPz64k9X7IimLcetMVXyTlG',1,NULL,3,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(84,'Lenny','Wehner','28138250906','sflatley@example.com','818975824',NULL,NULL,'$2y$10$z14RDSLExYEmj8bGIaFDguoOgfZEp64hRcNYk4egguRPDkSt7/OhW',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(85,'Jameson','Casper','83213965614','leffler.van@example.net','921419347',NULL,NULL,'$2y$10$VguV55Pu/1Zlqe5pAvtfFOxqPCRI4OWbyTBJGwFx1/mcCMO0dBn1C',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(86,'Viola','Beer','64427542667','kirlin.bernice@example.net','746295988',NULL,NULL,'$2y$10$7Bw0jlFNHmPFngy3h8eG3OsvKoZoyMX5OiXijBSU1LCJHzmYI4aJu',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(87,'Bell','Keebler','98747326113','hahn.jamir@example.org','566721916',NULL,NULL,'$2y$10$.nBBys9gtyTWk1lstcr6DOPzevGdJ4EcHmZo4pu3fZKxHHrpZ4igu',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(88,'Shayne','Kling','43942258815','wweber@example.org','989560470',NULL,NULL,'$2y$10$sxG6WGf8k6/QJuRhdJnNLuxlQ5sGqqrO/8QwjtM1wARbDzbvO1NiO',1,NULL,1,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(89,'Stephan','Bechtelar','13375110800','keeling.melyssa@example.com','103959043',NULL,NULL,'$2y$10$yZ4YPTaQZy92tGKsXk8MAuAK/CegSdWWPQYvif4jugWR.LNEBTCSW',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53'),(90,'Santino','Schuster','21825211158','nikolaus.rosendo@example.net','856259478',NULL,NULL,'$2y$10$h8RLiNARKpvrS9DMmWQ8g.QyVJWFqJPmYaRVu1Lj48OvZHNlnScJO',1,NULL,2,'2024-09-05 12:40:53',NULL,0,NULL,'2024-09-05 09:10:53','2024-09-05 09:10:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_codes`
--

DROP TABLE IF EXISTS `verification_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_codes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_expired` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `verification_codes_user_id_foreign` (`user_id`),
  CONSTRAINT `verification_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_codes`
--

LOCK TABLES `verification_codes` WRITE;
/*!40000 ALTER TABLE `verification_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `verification_codes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-05 16:13:53
