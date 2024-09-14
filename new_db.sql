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
INSERT INTO `course_categories` VALUES (1,'Dr. Theron Abshire',NULL,NULL,1,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Daija Deckow DVM',NULL,1,1,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Amelia Waters',NULL,1,1,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `courses` VALUES (1,'Dock Cummerata','Necessitatibus ut nemo unde laboriosam delectus. Sit numquam provident atque et dolorum rem. Ducimus facere impedit voluptatibus aut ullam provident.','rem-eum-voluptate-fugiat-qui-sit-saepe-ea-non','Maxine Harvey','Maudie Lang',127,'221',NULL,NULL,1,0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Liam Tremblay','Tempore aut dignissimos consequatur dicta magni aut voluptatem. Et voluptatem labore enim ipsam. Quia ullam voluptates at consequatur necessitatibus. Debitis ipsa aut omnis amet tempore occaecati.','sunt-voluptate-maxime-nihil-esse','Izaiah Willms','Elmira Lebsack',80,'211',NULL,NULL,3,3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Paula Morissette','Iste numquam dolor qui at optio. Sunt repellendus temporibus magnam officia. Est est quia dolores sit id.','aut-asperiores-eum-omnis-quas','Prof. Amaya Stehr PhD','Dr. Rogelio Mann',195,'401',NULL,NULL,1,3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(4,'Brooke Jakubowski V','Debitis error suscipit velit impedit cumque ut ab. Numquam placeat aut a illum deserunt amet. Nesciunt rerum laborum atque qui.','porro-dolores-voluptas-saepe-est-non-qui-tempore','Robb Christiansen','Mr. Darius Medhurst Jr.',117,'216',NULL,NULL,1,3,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `files` VALUES (1,'Esmeralda Luettgen PhD',1,'1',4,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Christop Fahey',0,'0',3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Georgianna Borer',0,'0',2,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `pages` VALUES (1,'Alex Grady',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Solon Wilderman',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Esteban Gulgowski',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(4,'Mrs. Pascale Wiza',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(5,'Finn Morissette',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(6,'Rolando Nader',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(7,'Bettye Weimann DDS',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(8,'Olen Gibson',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(9,'Aurelio Haley DVM',NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `payments` VALUES (1,1,2,NULL,'15.4','In ut omnis voluptatem eaque incidunt. Ratione minima est est eius laboriosam. Unde qui exercitationem corporis perferendis eos molestiae sit sequi. Impedit ipsum est quia numquam enim.','934353128','952678554','debit',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,2,1,NULL,'74.5','Corporis mollitia fugiat officiis doloremque cupiditate. Ipsa ab eligendi vel alias laudantium accusamus. Quia ad sint odio quas ullam nisi. Sint qui corporis quia nobis est in.','806646945','262029142','portal',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,1,3,NULL,'99.7','Aliquid commodi dolorem facilis voluptas neque et eius ex. Similique cumque architecto iste quod est esse. Quos est voluptates est ut officia quo dolores.','415575001','840609238','portal',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(4,3,3,NULL,'73.6','Dolore architecto et impedit pariatur nemo quidem. Quas saepe dolores quidem corrupti perferendis quos. Expedita occaecati ullam vitae esse. Qui harum accusantium molestiae qui enim vero.','513446881','410584957','portal',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(5,1,3,NULL,'65.8','Dolores consequatur est vero aut vel. Corrupti voluptatibus dicta eligendi exercitationem. Sunt accusantium rerum quos placeat nesciunt nobis.','213682378','648005439','portal',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(6,1,3,NULL,'86.6','Alias laborum voluptas sunt quo excepturi. Ad vero minima magni adipisci quis accusantium. Molestiae quia et id hic.','476176110','486957465','portal',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(7,3,3,NULL,'30.2','Dolorem consequatur adipisci fugit ad. Officiis quae non numquam recusandae. Et vero possimus quasi et. Qui hic in eos minus eveniet nulla quis illo.','946988794','157687579','debit',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(8,2,3,NULL,'94.2','Eos modi voluptatem quas commodi dolores quo inventore. Veritatis iste nostrum dignissimos provident velit sit dolor voluptates. Eos qui exercitationem hic aut distinctio. Dolorem et fugiat sint.','155925116','276257916','debit',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(9,1,3,NULL,'70.7','Vel labore mollitia accusantium vel atque sequi. Voluptas sunt dolor vero et dolor veritatis. Amet quas et harum aut ea.','935806021','644187207','debit',0,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(10,1,3,NULL,'75.2','Illum vitae voluptatum dolor nisi saepe. Sit iusto odio qui molestiae nostrum molestiae. Est est ut voluptatem.','914969353','620471557','debit',0,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (1,'App\\Models\\User',1,'API token of Ronaldo Nader','2d02a122c620f5bb5218de9b8dee75e83f9a48deaef0d13a0de10cb2aaf7775a','[\"*\"]',NULL,NULL,'2024-08-26 08:22:14','2024-08-26 08:22:14'),(2,'App\\Models\\User',1,'API token of Ronaldo Nader','5ad554c77848e076abdf8d1df8b1ee8e7aa71a8f160bccbb8fdcbeb6b62d7d7b','[\"*\"]',NULL,NULL,'2024-08-26 08:23:52','2024-08-26 08:23:52');
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
INSERT INTO `roles` VALUES (1,'Maya Wolff',8,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Miss Tressie Halvorson DVM',4,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Dr. Moriah Beatty DVM',4,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `sub_tasks` VALUES (1,'Henry Considine','Sit adipisci qui sed at sed sed tempore. Repudiandae consectetur consequuntur rem rerum aperiam voluptates. Autem laboriosam minima voluptates. Occaecati perspiciatis sed exercitationem iste vel.',0,0,NULL,3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Ervin Green','Natus maiores aliquam quam aut eos minima. Consequatur qui dolor nostrum. Numquam voluptates dolores sapiente dolorum qui.',0,0,NULL,6,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Aida Herman','Excepturi explicabo qui numquam voluptatum excepturi. Eos facere est dignissimos fugiat eum. Qui sit dolor quisquam aperiam in esse ab. Molestias quia ea consequatur accusantium optio natus repellat.',0,0,NULL,5,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(4,'Jazmyn Macejkovic','Sit enim excepturi officia. Magni deleniti aut et itaque distinctio vitae qui. Nihil facilis sint animi debitis accusamus aut dolorum.',0,0,NULL,8,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(5,'Rey Fritsch','Perferendis ducimus et sit nihil. Rem possimus in fugiat numquam aut repudiandae rerum laudantium. Debitis soluta nisi non explicabo. Excepturi aut aut et delectus eligendi similique.',0,0,NULL,6,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(6,'Mrs. Katelyn Lehner','Impedit qui sit quia corrupti. A sapiente quam dolore quasi quisquam optio. Voluptatum quae provident corrupti iusto repellat nihil tempore.',0,0,NULL,5,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(7,'Murphy Jacobs IV','Atque quisquam deleniti labore delectus totam error ut saepe. Adipisci harum est omnis.',0,0,NULL,1,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(8,'Haley Turcotte','Occaecati ut fugiat incidunt sint. Et dicta sint et non quos in eum. Et placeat veniam aliquid voluptates voluptas quam. Cumque iure eos repellendus tenetur molestias quia.',0,0,NULL,9,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(9,'Lelia Langosh','Repellendus beatae minus reprehenderit error et. Sed iusto nesciunt est deleniti dolorum tenetur officiis est. Repellendus animi est aliquid natus ut fugiat. Enim omnis ut ab eos sed.',0,0,NULL,4,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(10,'Ms. Aimee Koch','Non qui dolores dolor. Omnis quis vero ipsum. Itaque ab magnam aspernatur delectus hic illo.',0,0,NULL,9,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(11,'Miss Libby Koepp IV','Aspernatur aspernatur deleniti nihil porro qui inventore. Qui quia sed placeat omnis quas vitae non et. Non facilis qui non magni iste assumenda accusantium ipsum.',0,0,NULL,8,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(12,'Rhea Nienow','Sequi nihil sequi qui deleniti vitae id totam error. Sint cum enim autem consequatur ea deleniti. Quod voluptatem quaerat officia aliquam. Iure ipsam molestias et omnis in. Dicta accusantium qui qui.',0,0,NULL,3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(13,'Jake Hayes','Sunt autem consequatur provident. Eos enim et laborum expedita cumque. Unde et quo perferendis sunt dolor. Debitis molestiae necessitatibus quia qui quas voluptas. Mollitia quos est et.',0,0,NULL,7,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(14,'Mara Hackett','Est architecto illum voluptatem occaecati voluptate beatae. Dolores ea et tenetur id quasi accusamus. Eos voluptas blanditiis nemo quos nam. Harum dolorem qui velit.',0,0,NULL,5,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(15,'Dr. Tad Buckridge I','Reiciendis ipsum ad quo enim. At ratione odit vero deleniti. Rerum sequi eos rerum accusamus suscipit.',0,0,NULL,9,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(16,'Retha Vandervort','Et exercitationem ut dolorum consequuntur qui quasi autem et. Sed aliquam et est officia delectus non in. Inventore quaerat impedit repudiandae sit.',0,0,NULL,7,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(17,'Aliyah Schimmel','Dolor autem iure qui optio. Sed qui nam et dolore molestiae nam. Blanditiis culpa sed consequatur optio. Excepturi reiciendis id assumenda et provident ut modi molestias.',0,0,NULL,2,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(18,'Mr. Bertram Will','Nobis distinctio sequi perferendis distinctio quis ut nihil deleniti. Velit et ex est repudiandae nisi. Consectetur iure voluptatibus vero expedita.',0,0,NULL,5,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(19,'Ellie Reichel','Ratione qui quam qui ut et eum. Et itaque tempore cumque cupiditate corporis sit officiis placeat. Et ut dolorem laborum beatae. Vel eaque est voluptas. Quasi culpa dolores ut rem rerum et.',0,0,NULL,6,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(20,'Jerod Welch III','Qui ea modi voluptas qui eos sed soluta perspiciatis. Dolore reprehenderit enim eos nam nisi explicabo adipisci deleniti. Dolores quo voluptas iure rerum. Et eos et omnis eum quia quia est.',0,0,NULL,6,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(21,'Axel Abshire','Necessitatibus officia dolorem omnis odit. Eaque eum nihil fugit qui. Illo maxime autem itaque ex qui provident eum molestiae.',0,0,NULL,5,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(22,'Mr. Carmelo Nitzsche','Eaque autem ut mollitia ipsa. Voluptas deserunt velit quia qui at et necessitatibus. Quod assumenda facilis in dolores ut harum iste sunt.',0,0,NULL,6,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(23,'Sylvia Gerhold I','Est excepturi consequatur possimus. Et sit reprehenderit excepturi et. Quibusdam consequatur rerum et a ducimus unde tenetur.',0,0,NULL,8,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(24,'Mr. Wilbert Runte','Occaecati commodi in facilis error non. Quas in nobis voluptate ut reprehenderit recusandae nam. Id eum et quis voluptatem est porro cupiditate repellat.',0,0,NULL,7,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(25,'Miss Sydni Glover DDS','Quia et vitae itaque officia rerum beatae. Quae et tenetur qui qui occaecati sed. Harum architecto et facilis consequatur sunt blanditiis quia sit.',0,0,NULL,3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(26,'Ena Mann','Quia ut id corporis ipsam dolores rerum culpa. Eum fuga explicabo et ab blanditiis aut deserunt. Non natus sit odio ab nam.',0,0,NULL,1,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(27,'Jovan Schuppe','Nostrum libero aliquam quisquam at. Eos dolorum sit consectetur. Voluptatem dolores ullam dolores sint praesentium earum fugit.',0,0,NULL,4,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `tasks` VALUES (1,'Rosie Denesik',2,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(2,'Dr. Chanel Buckridge II',2,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Amelia Heller',1,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(4,'Randal Terry',2,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(5,'Giovanna Sauer',3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(6,'Prof. Kendra Franecki',2,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(7,'Miss Pearline Runolfsdottir Jr.',3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(8,'Prof. Adelbert Moore II',3,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(9,'Mr. Cicero Cummings',3,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
INSERT INTO `users` VALUES (1,'Ronaldo','Nader','71839842451','luettgen.clinton@example.net','238719143',NULL,'$2y$10$HmDvekwQCM8yQik.5Q3fvuaEZgyLZTlCSdnGVBDTPw7CuBDm/hw96',1,NULL,2,'2024-08-26 11:51:02',NULL,NULL,'2024-08-26 08:21:02','2024-08-26 08:23:39'),(2,'Chadrick','Deckow','71105814140','hsteuber@example.org','473230423',NULL,'$2y$10$.CBRXKk8aH0/mpIbUrcdZOnxzZOO65LUmIJ1dCr4rInVut1LYpuYK',1,NULL,3,'2024-08-26 11:51:02',NULL,NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(3,'Issac','Kunze','44615345781','qondricka@example.net','842508731',NULL,'$2y$10$PFcEuBgsXiBFjN4uOH2p7.x8bKs11Y3eDAJPJih48L.KzAi9Z7mVu',1,NULL,2,'2024-08-26 11:51:02',NULL,NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(4,'Elna','Wyman','67678122330','krajcik.kris@example.org','150532360',NULL,'$2y$10$qplOuXtJe2wK5sYfGhUSA.DZgvOeetOEF.CAm1iyZPt28H2D79Lg.',1,NULL,3,'2024-08-26 11:51:02',NULL,NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(5,'Delpha','Auer','35409922737','thettinger@example.net','141570247',NULL,'$2y$10$goR4ulWNQBHTicmnCRV8RuOEm07yG5o41Go8/LtoLhJalyUdtrlmq',1,NULL,2,'2024-08-26 11:51:02',NULL,NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02'),(6,'Christa','Kihn','56006535317','drowe@example.com','825963470',NULL,'$2y$10$4Ws7WJpsZYOp8KNKBI5bjOF1nwP/9uAYDYBmW6k.fNkkMJBJjg5ym',1,NULL,1,'2024-08-26 11:51:02',NULL,NULL,'2024-08-26 08:21:02','2024-08-26 08:21:02');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_codes`
--

LOCK TABLES `verification_codes` WRITE;
/*!40000 ALTER TABLE `verification_codes` DISABLE KEYS */;
INSERT INTO `verification_codes` VALUES (1,1,'26997',1,'2024-08-26 08:21:57','2024-08-26 08:22:14'),(2,1,'15412',1,'2024-08-26 08:22:26','2024-08-26 08:22:58');
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

-- Dump completed on 2024-08-26 15:32:14
