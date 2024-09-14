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
-- Table structure for table `counsels`
--

DROP TABLE IF EXISTS `counsels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `counsels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
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
INSERT INTO `course_categories` VALUES (1,'Colby Koch',NULL,NULL,1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Marley Rohan DDS',NULL,1,1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Malika Roberts',NULL,1,1,'2024-08-22 08:57:38','2024-08-22 08:57:38');
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_user`
--

LOCK TABLES `course_user` WRITE;
/*!40000 ALTER TABLE `course_user` DISABLE KEYS */;
INSERT INTO `course_user` VALUES (1,1,1,0,NULL,NULL),(2,1,2,0,NULL,NULL),(3,2,3,0,NULL,NULL),(4,2,4,0,NULL,NULL),(5,3,5,0,NULL,NULL),(6,3,6,0,NULL,NULL);
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
  `platform` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `capacity` int NOT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` bigint unsigned DEFAULT NULL,
  `demo` bigint unsigned DEFAULT NULL,
  `course_category_id` bigint unsigned NOT NULL,
  `status` tinyint NOT NULL DEFAULT '3',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_slug_unique` (`slug`),
  KEY `courses_course_category_id_foreign` (`course_category_id`),
  CONSTRAINT `courses_course_category_id_foreign` FOREIGN KEY (`course_category_id`) REFERENCES `course_categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'Prof. Sheridan Pouros','Est totam sint et aspernatur quia rerum. Aperiam quod quo iste nobis voluptas. Vel quo architecto molestiae et rerum. Harum natus quia mollitia consequatur similique excepturi sunt.','voluptas-dolor-nostrum-et-nesciunt','Weldon Morissette','Luther Bins',16,'704',NULL,NULL,2,2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Era Jones','Quia ex qui tempora repellendus debitis voluptatum eos. Aut facilis et asperiores aut. Eos animi nostrum rerum ut at minus.','asperiores-eaque-aut-quae-maxime','Roscoe Turcotte','Dustin Schmitt',200,'644',NULL,NULL,3,3,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Javon Parker DVM','Nam dolorem velit exercitationem iste labore sunt. Error culpa ducimus odit voluptas quos perspiciatis. Quam ut possimus minima est.','asperiores-asperiores-quibusdam-rerum-ratione-in','Krystal Schumm','Vance Sporer',191,'335',NULL,NULL,1,2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(4,'Jennifer Robel','Quod quibusdam sint dicta minima. Sapiente voluptas sint est autem earum accusamus maxime. Animi deserunt cumque molestiae praesentium ullam.','voluptatum-et-provident-error-id-dolorum-nihil','Rozella Stehr','Vilma Kreiger',198,'784',NULL,NULL,2,0,'2024-08-22 08:57:38','2024-08-22 08:57:38');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
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
  `type` tinyint(1) NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `files_user_id_foreign` (`user_id`),
  CONSTRAINT `files_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (1,'Prof. Enrico Jenkins',1,'1',1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Kylee Feeney',0,'0',5,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Bernadette Fay',1,'1',6,'2024-08-22 08:57:38','2024-08-22 08:57:38');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_100000_create_password_reset_tokens_table',1),(2,'2019_08_19_000000_create_failed_jobs_table',1),(3,'2019_12_14_000001_create_personal_access_tokens_table',1),(4,'2024_07_29_102639_create_roles_table',1),(5,'2024_07_29_102646_create_pages_table',1),(6,'2024_07_29_102712_create_page_role_table',1),(7,'2024_07_29_134533_create_users_table',1),(8,'2024_07_29_135835_create_files_table',1),(9,'2024_08_11_122627_create_course_categories_table',1),(10,'2024_08_12_123532_create_courses_table',1),(11,'2024_08_13_180459_create_course_user_table',1),(12,'2024_08_19_113421_create_tasks_table',1),(13,'2024_08_19_173729_create_payments_table',1),(14,'2024_08_22_070302_create_uploads_table',1),(15,'2024_08_22_071957_create_counsels_table',1),(16,'2024_08_22_092816_create_verification_codes_table',1),(17,'2024_08_22_121137_create_sub_tasks_table',1);
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
INSERT INTO `pages` VALUES (1,'Selmer Mertz',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Akeem Hegmann',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Patience Gibson',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(4,'Savannah Williamson',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(5,'Morris Barton',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(6,'Monte Wolff I',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(7,'Ms. Zella Lockman I',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(8,'Ali McLaughlin',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(9,'Oral Smith I',NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38');
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
  `user_id` bigint unsigned DEFAULT NULL,
  `course_id` bigint unsigned DEFAULT NULL,
  `file_id` bigint unsigned DEFAULT NULL,
  `price` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_user_id_foreign` (`user_id`),
  KEY `payments_course_id_foreign` (`course_id`),
  KEY `payments_file_id_foreign` (`file_id`),
  CONSTRAINT `payments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payments_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,3,2,NULL,'33.6','Commodi iste non voluptas vel sint. Veritatis ut in sed. Sed eos exercitationem recusandae ab.','377641407','530904930','portal',0,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,1,2,NULL,'11.2','Sed aut odit ea magni repudiandae. Nam sunt fugiat quia sed veritatis et omnis. Fuga recusandae aut doloremque libero sed dolor iste. Voluptatem consectetur et cupiditate sapiente et repudiandae.','921451085','868441363','portal',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(3,2,3,NULL,'28.3','Est consequatur id autem deserunt perspiciatis. Perspiciatis voluptas libero eligendi.','629718693','701079054','debit',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(4,3,3,NULL,'81.5','Laudantium dolor amet sunt. Accusantium explicabo voluptates ut a voluptatem. Rerum ducimus ipsam molestiae perspiciatis.','654995704','562127639','debit',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(5,1,3,NULL,'48.7','Consectetur et quam tenetur. Veniam distinctio est repellat fugiat iste occaecati tempora. Delectus tempore reiciendis iusto autem eligendi vel. Quasi aperiam iste voluptate.','926881160','272654947','debit',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(6,1,3,NULL,'24.2','Pariatur et dolorum aliquid aut voluptatum esse. Unde adipisci soluta officia aut quos. Itaque nihil laboriosam cum exercitationem eum.','601497957','985572519','portal',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(7,3,1,NULL,'70.7','Soluta sit quo sequi ea ut. Impedit quidem a fugit ea. Vel quasi deserunt exercitationem dolorem suscipit cum ut. Ut magnam quia dolores omnis nulla cumque earum.','221434022','945483633','portal',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(8,2,2,NULL,'29.6','Et quidem molestiae numquam. Quod est quibusdam laboriosam ea. Iste ut dolorem est et saepe nisi. Optio voluptas sequi aspernatur.','335075430','262028282','debit',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(9,2,2,NULL,'66.9','A quis sapiente ut dicta. Earum non quam culpa delectus quia. Quisquam quia in quaerat autem.','171710092','949610044','debit',0,'2024-08-22 08:57:39','2024-08-22 08:57:39'),(10,1,2,NULL,'94.9','At quos dolor ipsa in ad praesentium. Est neque expedita expedita blanditiis. Sunt quidem molestias voluptates vitae. Ipsam sed distinctio dicta consequatur.','732358774','549478324','portal',0,'2024-08-22 08:57:39','2024-08-22 08:57:39');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
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
INSERT INTO `roles` VALUES (1,'Nova Maggio',5,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Avis Ruecker',8,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Vincenzo Walter',9,'2024-08-22 08:57:38','2024-08-22 08:57:38');
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sub_tasks`
--

LOCK TABLES `sub_tasks` WRITE;
/*!40000 ALTER TABLE `sub_tasks` DISABLE KEYS */;
INSERT INTO `sub_tasks` VALUES (1,'Dr. Delphia Bernhard','Et deserunt autem maxime. Eos ut pariatur eius nihil iure. Dolorum vel at qui. Nam nulla assumenda ad mollitia earum. Aut quia enim sit. Voluptate error numquam eos et. Quis ea esse sunt odio.',0,0,NULL,2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Mrs. Maci Leffler DDS','Enim unde sit nam odio et. Sed similique autem vero. Dolorem praesentium omnis a aut eveniet laborum sunt. Incidunt rerum maiores possimus aliquam.',0,0,NULL,4,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Gerda Gutkowski','Harum necessitatibus dolorem sed eos magni. Eum voluptas ipsam quasi in. Exercitationem ad quo ut ut ratione libero veniam. Aut sed sunt incidunt.',0,0,NULL,4,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(4,'Elroy Gutmann','Amet est expedita reiciendis quis voluptatem ea. Nostrum ut nihil a. Voluptas fugiat et molestiae nam esse.',0,0,NULL,7,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(5,'Schuyler Glover','Suscipit enim aut ipsum minima. Dolores et quia architecto non neque. Id recusandae aut consequuntur.',0,0,NULL,2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(6,'Mrs. Phyllis Klocko','Accusantium natus illo quasi eligendi aut non earum. Libero molestias dicta repudiandae sed aliquam aut doloribus. Dolorem in omnis rerum ut.',0,0,NULL,1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(7,'Prof. Beau Murphy II','Quas est consequuntur ut temporibus inventore facere quod. Voluptates dolorem ut aliquid dolorem aut. Accusantium culpa omnis corporis natus nihil in id.',0,0,NULL,9,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(8,'Delbert Towne','Et alias soluta ut sit repudiandae. Cumque aut aut adipisci. Est minima ab minus reiciendis aut aspernatur perferendis.',0,0,NULL,5,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(9,'Mr. Torrey Hammes Jr.','Excepturi eligendi architecto voluptas cum totam ut cupiditate. Qui ea molestias ipsum. A ipsum non accusantium. Ex corrupti dolor dicta est quos id ut qui.',0,0,NULL,7,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(10,'Prof. Abigail Hickle','Fugit nam quod repellat sit. Sequi modi vero ducimus molestias sit aut. Enim voluptatem ut quidem alias illum vel aut.',0,0,NULL,2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(11,'Kara Schultz','Qui in aperiam tempore et quam. Placeat sunt ex voluptates at. Quidem id sit asperiores est harum quasi harum. Consequuntur voluptatum odio est culpa. Sunt quia recusandae quas porro laudantium.',0,0,NULL,9,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(12,'Mr. Shawn Glover MD','Fugiat est nihil voluptates vel. Blanditiis delectus et ad modi qui. Itaque rerum voluptas ipsam. Qui quidem dignissimos dolorem et.',0,0,NULL,7,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(13,'Prof. Justice Sporer','Aut adipisci fugit est quidem. Maiores quia ullam ducimus dolor. Rerum quod voluptates natus et. Vel aperiam aut ut facere itaque autem quidem. Eveniet minus consequuntur placeat voluptatem.',0,0,NULL,9,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(14,'Prof. August Marquardt IV','Voluptatibus ut sit aut et. Eos omnis sequi quam pariatur. Repudiandae labore corrupti laborum aut quia aliquam dolor. Sed tempora cum et vel sit aliquam.',0,0,NULL,5,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(15,'Hailey Shields IV','Quo totam dignissimos a vitae. Sed temporibus hic vel quod temporibus ex. Nisi consectetur impedit excepturi est.',0,0,NULL,3,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(16,'Dorothy Rice','Quaerat culpa quam voluptatem est voluptate ut aperiam. Debitis itaque ut repellat sit qui repudiandae beatae. Magni quia autem ipsum animi animi rerum dolorem.',0,0,NULL,3,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(17,'Cade Ernser','Est consequatur et distinctio aspernatur nulla alias et. Sunt architecto aspernatur repellat officia praesentium omnis voluptatum doloribus.',0,0,NULL,7,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(18,'Leta Green','Incidunt assumenda vel nostrum. Eaque et ut id sit inventore quis qui aut. Aspernatur nihil iste natus quae animi et.',0,0,NULL,2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(19,'Deanna Leffler DVM','Inventore autem quod cumque omnis. Qui qui ipsa cumque ex nihil. Minima distinctio aut molestiae sapiente qui sed. Laborum ipsa hic exercitationem voluptates qui.',0,0,NULL,1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(20,'Keara Mohr','Doloremque veritatis occaecati quasi soluta reprehenderit. Magni corporis beatae repellendus incidunt. Aut sint molestiae voluptatem ipsum non.',0,0,NULL,7,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(21,'Stephen Steuber MD','Dicta perferendis ab aliquam. Rem ipsum quia explicabo beatae sit.',0,0,NULL,6,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(22,'Desiree Heaney','Consequatur neque magnam ea unde ut est. Repellendus aliquid reprehenderit voluptatem occaecati molestiae sit maxime. Tempore ut rerum sit quaerat et.',0,0,NULL,5,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(23,'Cade Romaguera Jr.','Quia et voluptates nostrum molestias suscipit non reprehenderit. Fuga quis vel autem sint sapiente. Eveniet nostrum quos aut. Eaque cum tenetur minima non voluptatem voluptas.',0,0,NULL,8,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(24,'Vida Balistreri','Rerum sapiente error maxime nesciunt sit. Ut accusamus consequatur eum odio tempora sequi. Similique facilis quisquam iste.',0,0,NULL,5,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(25,'Prof. Darrin Nicolas','Quia et voluptatum mollitia non corrupti libero dolor. Voluptas velit distinctio inventore assumenda. Dolorum reprehenderit in voluptatum optio vitae. Sequi rem explicabo voluptatum rem aliquam.',0,0,NULL,1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(26,'Issac Fay','Possimus temporibus distinctio aut non rerum aut. Provident amet at nostrum quis. Itaque ut rerum ut omnis.',0,0,NULL,9,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(27,'Troy O\'Reilly','Tenetur cum illum perferendis. Aspernatur consectetur sit ratione numquam consectetur. Id veniam ut tempora et saepe.',0,0,NULL,1,'2024-08-22 08:57:38','2024-08-22 08:57:38');
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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tasks_file_id_foreign` (`file_id`),
  CONSTRAINT `tasks_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tasks`
--

LOCK TABLES `tasks` WRITE;
/*!40000 ALTER TABLE `tasks` DISABLE KEYS */;
INSERT INTO `tasks` VALUES (1,'Miss Tianna Jones',1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Mireya Bruen IV',1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Laurel Renner',3,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(4,'Ova Wiza',1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(5,'Dr. Columbus Murphy Sr.',3,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(6,'Eda Schmeler',1,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(7,'Dr. Merritt Nader DDS',3,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(8,'Santina Zulauf',2,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(9,'Davon Lockman MD',2,'2024-08-22 08:57:38','2024-08-22 08:57:38');
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
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `image` bigint unsigned DEFAULT NULL,
  `role_id` bigint unsigned DEFAULT NULL,
  `role_assigned_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role_expire_date` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_phone_number_unique` (`phone_number`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Thurman','Leuschke','423.686.1810','rowe.danyka@example.org','670397556',NULL,'$2y$10$gEnk1yrFTQT3AFiGlaoq0uK8QutSbFgIZI7BPZJCQ3QpySzjJ1bP2',1,NULL,3,'2024-08-22 12:27:38',NULL,NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(2,'Carmela','Reilly','+1.480.947.2495','lynch.liliana@example.org','952838793',NULL,'$2y$10$Sz0sSvmhbq0j9/V2vKqGIe4bqLTDOSRoyVmH0yapIojP51Z1Dom.e',1,NULL,2,'2024-08-22 12:27:38',NULL,NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(3,'Sunny','Von','240-215-4392','braeden43@example.net','912911041',NULL,'$2y$10$kWnHTbbfj9TZDl6SX.59/eOVQXwE/4Z/U.NK7OdcSQZ5rlbnCiX16',1,NULL,1,'2024-08-22 12:27:38',NULL,NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(4,'Cassandra','Gaylord','+1 (820) 412-1394','oconnell.salvador@example.org','865282537',NULL,'$2y$10$YcFZb/PelIakqv6c.dVFVePqtTC7HlhwijtYuWF/J6xESogZrK.cS',1,NULL,1,'2024-08-22 12:27:38',NULL,NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(5,'Maximo','Armstrong','+1-425-921-8474','bernardo.stark@example.com','659797603',NULL,'$2y$10$C8R3DPScbnfDEbYRpgOVvubwAh1r40dnG96T/aqBL4tZZzPbA7Kwy',1,NULL,1,'2024-08-22 12:27:38',NULL,NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38'),(6,'Lavada','Berge','765.519.4471','kelvin.pollich@example.com','901028387',NULL,'$2y$10$4SMrXu6GWSj8.1db5QDKXe4Lm3T2OgtiIyQRSaNJEPBeapqyJb9je',1,NULL,3,'2024-08-22 12:27:38',NULL,NULL,'2024-08-22 08:57:38','2024-08-22 08:57:38');
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

-- Dump completed on 2024-08-22 16:00:43
