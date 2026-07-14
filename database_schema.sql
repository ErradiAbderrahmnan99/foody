/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.16-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: foody
-- ------------------------------------------------------
-- Server version	10.11.16-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addons`
--

DROP TABLE IF EXISTS `addons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `files` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`files`)),
  `item_id` varchar(255) NOT NULL,
  `license_code` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addons`
--

LOCK TABLES `addons` WRITE;
/*!40000 ALTER TABLE `addons` DISABLE KEYS */;
/*!40000 ALTER TABLE `addons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `label` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `apartment` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `addresses_user_id_foreign` (`user_id`),
  CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES
(1,1,'Home','Dhaka Bangladesh','680, Mirpur 10','23.8069','90.3687',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(2,1,'Work','Dhaka Bangladesh','889, Mirpur 1','23.7956','90.3537',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(3,2,'Home','Dhaka Bangladesh','493, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(4,2,'Work','Dhaka Bangladesh','224, Gulshan 2','23.7948','90.4143',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(5,3,'Home','Dhaka Bangladesh','986, Gulshan 2','23.7948','90.4143',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(6,3,'Work','Dhaka Bangladesh','792, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(7,4,'Home','Dhaka Bangladesh','252, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(8,4,'Work','Dhaka Bangladesh','622, Mirpur 1','23.7956','90.3537',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(9,5,'Home','Dhaka Bangladesh','611, Gulshan 2','23.7948','90.4143',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(10,5,'Work','Dhaka Bangladesh','889, Gulshan 1','23.7821','90.4161',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(11,6,'Home','Dhaka Bangladesh','938, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(12,6,'Work','Dhaka Bangladesh','239, Mirpur 1','23.7956','90.3537',NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(13,7,'Home','Dhaka Bangladesh','606, Gulshan 2','23.7948','90.4143',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(14,7,'Work','Dhaka Bangladesh','792, Gulshan 1','23.7821','90.4161',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(15,8,'Home','Dhaka Bangladesh','933, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(16,8,'Work','Dhaka Bangladesh','227, Mirpur 1','23.7956','90.3537',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(17,9,'Home','Dhaka Bangladesh','665, Gulshan 2','23.7948','90.4143',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(18,9,'Work','Dhaka Bangladesh','485, Gulshan 1','23.7821','90.4161',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(19,10,'Home','Dhaka Bangladesh','407, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(20,10,'Work','Dhaka Bangladesh','757, Mirpur 1','23.7956','90.3537',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(21,11,'Home','Dhaka Bangladesh','410, Mirpur 2','23.7873','90.3514',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(22,11,'Work','Dhaka Bangladesh','631, Mirpur 1','23.7956','90.3537',NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `branches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES
(1,'Mirpur-1','mirpur@inilabs.xyz','+536464646464','23.8042375','90.3525979','Mirpur-1','Dhaka','1216','House : 25, Road No: 2, Block A, Mirpur-1, Dhaka 1216',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:35:44'),
(2,'Gulshan-1','gulshan@inilabs.xyz','+1243535366','23.7948597','90.4083123','Gulshan-1','Dhaka','1212','1st floor, Adam Building, House: 41 Road: 52, Dhaka 1212',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-02 02:16:40');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `is_cryptocurrency` tinyint(3) unsigned NOT NULL,
  `exchange_rate` decimal(19,2) DEFAULT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) unsigned DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES
(1,'Dirham','DH','MAD',10,1.00,NULL,NULL,NULL,NULL,NULL,NULL),
(2,'Dollars','$','USD',10,1.00,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_access`
--

DROP TABLE IF EXISTS `default_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `default_access` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `default_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_access`
--

LOCK TABLES `default_access` WRITE;
/*!40000 ALTER TABLE `default_access` DISABLE KEYS */;
INSERT INTO `default_access` VALUES
(1,'branch_id',1,1,'2026-06-02 02:18:57','2026-06-02 02:18:57'),
(2,'branch_id',11,1,'2026-06-02 02:23:57','2026-06-02 02:23:57'),
(3,'branch_id',6,1,'2026-06-02 02:25:35','2026-06-02 02:25:35');
/*!40000 ALTER TABLE `default_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dining_tables`
--

DROP TABLE IF EXISTS `dining_tables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dining_tables` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `size` int(11) DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dining_tables_slug_unique` (`slug`),
  KEY `dining_tables_branch_id_foreign` (`branch_id`),
  CONSTRAINT `dining_tables_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dining_tables`
--

LOCK TABLES `dining_tables` WRITE;
/*!40000 ALTER TABLE `dining_tables` DISABLE KEYS */;
INSERT INTO `dining_tables` VALUES
(1,'Table 1','table-1',6,'storage/qr_codes/Owt8NuAlN5.svg',1,5,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(2,'Table 2','table-2',8,'storage/qr_codes/ZGuOqGYj44.svg',1,5,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(3,'Table 1','table-2-1',10,'storage/qr_codes/NA28LDNG9o.svg',2,5,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(4,'Table 2','table-2-2',6,'storage/qr_codes/7pjXLza79R.svg',2,5,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01');
/*!40000 ALTER TABLE `dining_tables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
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
-- Table structure for table `gateway_options`
--

DROP TABLE IF EXISTS `gateway_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `gateway_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_id` bigint(20) NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `option` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` tinyint(4) NOT NULL,
  `activities` longtext DEFAULT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gateway_options`
--

LOCK TABLES `gateway_options` WRITE;
/*!40000 ALTER TABLE `gateway_options` DISABLE KEYS */;
INSERT INTO `gateway_options` VALUES
(1,3,'App\\Models\\PaymentGateway','paypal_app_id','sb-qzxs18789565@business.example.com',5,'\"\"',NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:20'),
(2,3,'App\\Models\\PaymentGateway','paypal_client_id','AbcV-BG5b30hjofcp2dj41GB1OYXE8_9-egRlV8z4R7vHiA-1mgL3Fvj3pkrOJyq0dC_vHNRAh_tp74p',5,'\"\"',NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:20'),
(3,3,'App\\Models\\PaymentGateway','paypal_client_secret','EP6r5hEtBc6icJeEseZIiOJqSRnFvqNLI7yxjplzITaObh-t-516gGJ_EysXisLtEavaIMcjrG9aYprz',5,'\"\"',NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:20'),
(5,3,'App\\Models\\PaymentGateway','paypal_status','5',10,'{\"5\":\"enable\",\"10\":\"disable\"}',NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:20');
/*!40000 ALTER TABLE `gateway_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_addons`
--

DROP TABLE IF EXISTS `item_addons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_addons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `addon_item_id` bigint(20) unsigned NOT NULL,
  `addon_item_variation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`addon_item_variation`)),
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_addons_item_id_foreign` (`item_id`),
  KEY `item_addons_addon_item_id_foreign` (`addon_item_id`),
  CONSTRAINT `item_addons_addon_item_id_foreign` FOREIGN KEY (`addon_item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `item_addons_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_addons`
--

LOCK TABLES `item_addons` WRITE;
/*!40000 ALTER TABLE `item_addons` DISABLE KEYS */;
INSERT INTO `item_addons` VALUES
(1,1,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(2,1,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(3,2,48,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(4,2,49,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(5,2,46,'{\"1\":82}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(6,3,48,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(7,3,49,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(8,3,52,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(9,4,48,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(10,4,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(11,5,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(12,5,51,'{\"1\":84}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(13,6,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(14,6,48,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(15,7,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(16,7,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(17,8,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(18,8,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(19,9,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(20,9,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(21,10,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(22,10,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(23,11,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(24,11,48,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(25,12,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(26,12,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(27,13,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(28,13,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(29,14,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(30,14,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(31,15,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(32,15,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(33,16,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(34,16,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(35,17,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(36,17,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(37,18,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(38,18,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(39,19,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(40,19,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(41,20,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(42,20,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(43,21,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(44,21,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(45,22,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(46,22,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(47,23,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(48,23,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(49,24,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(50,24,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(51,25,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(52,25,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(53,26,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(54,26,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(55,27,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(56,27,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(57,28,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(58,28,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(59,29,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(60,29,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(61,30,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(62,30,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(63,31,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(64,31,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(65,32,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(66,32,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(67,33,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(68,33,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(69,34,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(70,34,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(71,35,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(72,35,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(73,36,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(74,36,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(75,37,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(76,37,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(77,38,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(78,38,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(79,39,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(80,39,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(81,40,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(82,40,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(83,41,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(84,41,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(85,42,55,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(86,42,53,'{}',NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01');
/*!40000 ALTER TABLE `item_addons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_attributes`
--

DROP TABLE IF EXISTS `item_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_attributes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attributes`
--

LOCK TABLES `item_attributes` WRITE;
/*!40000 ALTER TABLE `item_attributes` DISABLE KEYS */;
INSERT INTO `item_attributes` VALUES
(1,'Size',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(2,'Quantity Choice',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(3,'Steak Size',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(4,'Steak Temperature',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(5,'Choose a filling',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(6,'Egg Variation',5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43');
/*!40000 ALTER TABLE `item_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_categories`
--

DROP TABLE IF EXISTS `item_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `sort` bigint(20) unsigned NOT NULL DEFAULT 1,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_categories`
--

LOCK TABLES `item_categories` WRITE;
/*!40000 ALTER TABLE `item_categories` DISABLE KEYS */;
INSERT INTO `item_categories` VALUES
(1,'Appetizers','appetizers',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(2,'Flame Grill Burgers','flame-grill-burgers',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(3,'Veggie & Plant Based Burgers','veggie-plant-based-burgers',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(4,'Sandwich from the Grill','sandwich-from-the-grill',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(5,'Hot Chicken Entrees','hot-chicken-entrees',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(6,'Beef Entrees','beef-entrees',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(7,'Seafood Entrees','seafood-entrees',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(8,'House Special Salads','house-special-salads',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(9,'Zoop Soups','zoop-soups',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(10,'Side Orders','side-orders',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(11,'Beverages','beverages',NULL,5,1,NULL,NULL,NULL,NULL,'2026-06-02 02:16:42','2026-06-02 02:16:42');
/*!40000 ALTER TABLE `item_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_extras`
--

DROP TABLE IF EXISTS `item_extras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_extras` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(19,6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_extras_item_id_foreign` (`item_id`),
  CONSTRAINT `item_extras_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_extras`
--

LOCK TABLES `item_extras` WRITE;
/*!40000 ALTER TABLE `item_extras` DISABLE KEYS */;
INSERT INTO `item_extras` VALUES
(1,6,'Add Tomato',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(2,6,'Add Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(3,6,'Add Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(4,6,'Add Patty',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(5,7,'Add Tomato',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(6,7,'Add Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(7,7,'Add Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(8,8,'Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(9,8,'Bacon',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(10,8,'BBQ Sauce',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(11,9,'Add Tomato',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(12,9,'Add Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(13,9,'Add Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(14,9,'Add Patty',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(15,10,'Add Tomato',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(16,10,'Add Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(17,10,'Add Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(18,10,'Add Patty',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(19,11,'Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(20,11,'Bacon',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(21,11,'BBQ Sauce',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(22,12,'Vegan Cheddar Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(23,12,'Vegan American Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(24,12,'Extra Plant-Based Bacon',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(25,12,'Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(26,13,'Vegan Cheddar Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(27,13,'Vegan American Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(28,13,'Extra Plant-Based Bacon',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(29,13,'Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(30,14,'Vegan Cheddar Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(31,14,'Vegan American Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(32,15,'Vegan Cheddar Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(33,15,'Vegan American Cheese',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(34,15,'Lettuce',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(35,26,'Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(36,26,'Mushrooms',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(37,27,'Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(38,27,'Mushrooms',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(39,28,'Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(40,28,'Mushrooms',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(41,29,'Onion',0.500000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(42,29,'Mushrooms',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(43,31,'Avocado',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(44,31,'Bacon',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(45,31,'Chilli fries',1.000000,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01');
/*!40000 ALTER TABLE `item_extras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_variations`
--

DROP TABLE IF EXISTS `item_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_variations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` bigint(20) unsigned NOT NULL,
  `item_attribute_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(19,6) NOT NULL DEFAULT 0.000000,
  `caution` longtext DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `item_variations_item_id_foreign` (`item_id`),
  KEY `item_variations_item_attribute_id_foreign` (`item_attribute_id`),
  CONSTRAINT `item_variations_item_attribute_id_foreign` FOREIGN KEY (`item_attribute_id`) REFERENCES `item_attributes` (`id`),
  CONSTRAINT `item_variations_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_variations`
--

LOCK TABLES `item_variations` WRITE;
/*!40000 ALTER TABLE `item_variations` DISABLE KEYS */;
INSERT INTO `item_variations` VALUES
(1,1,1,'Regular - 8 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,1,'Big - 12 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(3,2,5,'Chicken',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(4,2,5,'Beef',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(5,3,1,'Regular - 8 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(6,3,1,'Big - 12 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(7,4,1,'Half - 6 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(8,4,1,'Full - 12 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(9,6,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(10,6,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(11,7,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(12,7,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(13,8,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(14,8,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(15,9,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(16,9,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(17,10,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(18,10,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(19,11,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(20,11,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(21,12,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(22,12,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(23,13,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(24,13,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(25,14,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(26,14,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(27,15,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(28,15,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(29,16,1,'Regular - 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(30,16,1,'Large - 10',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(31,17,1,'Regular - 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(32,17,1,'Large - 10',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(33,18,1,'Regular - 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(34,18,1,'Large - 10',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(35,19,1,'Regular - 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(36,19,1,'Large - 10',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(37,20,1,'Regular - 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(38,20,1,'Large - 10',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(39,21,2,'6 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(40,21,2,'8 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(41,21,2,'12 pcs',1.500000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(42,22,2,'6 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(43,22,2,'8 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(44,22,2,'12 pcs',1.500000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(45,23,2,'6 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(46,23,2,'8 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(47,23,2,'12 pcs',1.500000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(48,24,2,'6 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(49,24,2,'8 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(50,24,2,'12 pcs',1.500000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(51,25,2,'6 pcs',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(52,25,2,'8 pcs',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(53,25,2,'12 pcs',1.500000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(54,26,3,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(55,26,3,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(56,26,4,'Rare',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(57,26,4,'Medium',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(58,26,4,'Well',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(59,27,3,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(60,27,3,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(61,27,4,'Rare',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(62,27,4,'Medium',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(63,27,4,'Well',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(64,28,3,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(65,28,3,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(66,28,4,'Rare',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(67,28,4,'Medium',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(68,28,4,'Well',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(69,29,3,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(70,29,3,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(71,29,4,'Rare',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(72,29,4,'Medium',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(73,29,4,'Well',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(74,32,2,'Pack of 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(75,32,2,'Pack of 12',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(76,33,2,'Pack of 6',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(77,33,2,'Pack of 12',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(78,34,6,'No egg',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(79,34,6,'Poached egg',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(80,44,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(81,44,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(82,46,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(83,46,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(84,51,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(85,51,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(86,52,1,'Regular',0.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(87,52,1,'Large',1.000000,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `item_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `item_category_id` bigint(20) unsigned NOT NULL,
  `tax_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `caution` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `price` decimal(19,6) NOT NULL DEFAULT 0.000000,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `item_type` tinyint(4) NOT NULL DEFAULT 5,
  `order` bigint(20) NOT NULL DEFAULT 1,
  `is_featured` tinyint(4) NOT NULL DEFAULT 5,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `items_item_category_id_foreign` (`item_category_id`),
  KEY `items_tax_id_foreign` (`tax_id`),
  CONSTRAINT `items_item_category_id_foreign` FOREIGN KEY (`item_category_id`) REFERENCES `item_categories` (`id`),
  CONSTRAINT `items_tax_id_foreign` FOREIGN KEY (`tax_id`) REFERENCES `taxes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES
(1,1,2,'Chicken Dumplings','chicken-dumplings','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','With a side of fried rice or supreme soy noodles, and steamed chinese greens with oyster sauce',2.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(2,1,2,'Egg Roll','egg-roll','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','Egg roll wrappers filled with a mixture of vegetables and beef or chicken, and fried to a crispy golden brown.',1.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(3,1,2,'Fried Cheese wonton','fried-cheese-wonton','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','Crispy fried cream cheese wontons are filled with cream cheese, lemon and garlic pepper, paprika & fried to golden perfection!',2.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:44','2026-06-02 02:16:44'),
(4,1,2,'Vegetable Dumplings','vegetable-dumplings','LMIV - Allergen - i). Contains milk and products thereof (including lactose).','With a side of fried rice or supreme soy noodles, and steamed chinese greens with oyster sauce',2.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:44','2026-06-02 02:16:44'),
(5,1,2,'Vegetable Roll','vegetable-roll','LMIV - Allergen - i). Contains milk and products thereof (including lactose).','Pastry sheet filled with a mixture of vegetables and fried to a crispy golden brown.',1.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:44','2026-06-02 02:16:44'),
(6,2,1,'American BBQ Double','american-bbq-double','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose4. iii). Wheat.','Two flame-grilled whopper patty, topped with american cheese, fresh slices of tomato and crisp lettuce, and finished with a zesty BBQ sauce and golden crispy onions.',5.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:45','2026-06-02 02:16:45'),
(7,2,1,'American BBQ Single','american-bbq-single','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose4. iii). Wheat.','A flame-grilled whopper patty, topped with American cheese, fresh slices of tomato and crisp lettuce, and finished with a zesty BBQ sauce and golden crispy onions.',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:45','2026-06-02 02:16:45'),
(8,2,2,'Bacon Double Cheeseburger','bacon-double-cheeseburger','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose4. iii). Wheat.','Two signature flame-grilled beef patties topped with smoked bacon and two layers of melted American cheese on a toasted sesame seed bun.',3.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:45','2026-06-02 02:16:45'),
(9,2,1,'Cheeseburger','cheeseburger','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose4. iii). Wheat.','Two layers of melted american cheese on a toasted sesame seed bun.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:46','2026-06-02 02:16:46'),
(10,2,1,'Peppercorn Anger','peppercorn-anger','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose4. iii). Wheat.','Beef flame-grilled to perfection, topped with sizzling strips of Bacon, sweet caramelised onions, fresh rocket and finished with our secret peppercorn mayo sauce. It could only be our gourmet kings.',2.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:46','2026-06-02 02:16:46'),
(11,2,1,'Whopper','whopper','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose4. iii). Wheat.','A flame-grilled beef patty, topped with tomatoes, fresh cut lettuce, mayo, pickles, a swirl of ketchup, and sliced onions on a soft sesame seed bun.',2.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:46','2026-06-02 02:16:46'),
(12,3,2,'Plant Based Bacon','plant-based-bacon','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','A flame-grilled plant-based patty in our classic bun, layered with slices of smooth vegan cheese and strips of vegan bakon, topped with egg-free mayo and ketchup. It\'s big, plant-based flavor.',3.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:47','2026-06-02 02:16:47'),
(13,3,1,'Plant Based Whopper','plant-based-whopper','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','A flame-grilled plant-based burger, topped with tomatoes, fresh cut lettuce, vegan mayo, pickles, a swirl of ketchup, and sliced onions on a soft sesame seed bun.',3.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:47','2026-06-02 02:16:47'),
(14,3,1,'Vegan Hum-burger with Cheese','vegan-hum-burger-with-cheese','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','A crispy vegan patty topped vegan cheese, vegan bakon, iceberg lettuce, vegan mayo and crowned with a toasted sesame seed bun.',2.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:47','2026-06-02 02:16:47'),
(15,3,2,'Vegan Royale','vegan-royale','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','A crispy vegan patty topped with iceberg lettuce, vegan mayo and crowned with a toasted sesame seed bun.',3.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:48','2026-06-02 02:16:48'),
(16,4,1,'BBQ Chicken','bbq-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','Sweet and tangy BBQ Chicken Sandwiches made with juicy slow cooker BBQ chicken and crisp coleslaw on toasted brioche buns.',4.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:48','2026-06-02 02:16:48'),
(17,4,1,'BBQ Pulled Pork','bbq-pulled-pork','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','Sweet and tangy BBQ Pork sandwiches made with juicy slow cooker BBQ pork and crisp coleslaw on toasted brioche buns.',4.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:48','2026-06-02 02:16:48'),
(18,4,2,'Chicken Mushroom','chicken-mushroom','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','Cheese sandwich with a chicken, mushroom and capsicum stuffing, grilled with butter to make it crispy.',3.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:49','2026-06-02 02:16:49'),
(19,4,1,'Plain Grilled Chicken','plain-grilled-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','This grilled chicken sandwich is simple to make with flavorsome marinated chicken, lettuce, tomato, and mayo. Crispy golden pan-fried bread makes it extra special!',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:49','2026-06-02 02:16:49'),
(20,4,1,'Steak Sandwich','steak-sandwich','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','A juicy steak sandwich, piled high with tender slices of steak, tomato, lettuce, caramelized onion, garlic aioli and mustard.',3.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:49','2026-06-02 02:16:49'),
(21,5,1,'Hentai Chicken','hentai-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','Creamy, tomato and herbed chicken with a sprinkle of fiery heat.',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:50','2026-06-02 02:16:50'),
(22,5,1,'Kung Pao Chicken','kung-pao-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','kung pao chicken is a highly addictive stir-fried chicken with the perfect combination of salty, sweet and spicy flavour!',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:50','2026-06-02 02:16:50'),
(23,5,2,'Sesame Chicken','sesame-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','This sesame chicken is crispy chicken pieces tossed in a sweet and savory honey sesame sauce.',3.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:50','2026-06-02 02:16:50'),
(24,5,1,'Sweet & Sour Chicken','sweet-sour-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','Sweet and sour chicken with crispy chicken, pineapple and bell peppers just like your favorite takeout place without the food coloring.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:51','2026-06-02 02:16:51'),
(25,5,1,'Yemete Kudasai Chicken','yemete-kudasai-chicken','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Contains eggs and products thereof. iii). Wheat.','Chicken breasts are simply baked to perfection, topped with fresh mozzarella and juicy, garlicky fresh chopped tomatoes.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:51','2026-06-02 02:16:51'),
(26,6,2,'Beef with Broccoli','beef-with-broccoli','Substances or products causing allergies - i). With nitrite curing salt. ii). With nitrate. iii). With nitrite curing salt and nitrate.','Crisp green broccoli and sweet onions, with beef, glistens with the best-tasting brown sauce.',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:51','2026-06-02 02:16:51'),
(27,6,1,'Beef with Mix Vegetables','beef-with-mix-vegetables','Substances or products causing allergies - i). With nitrite curing salt. ii). With nitrate. iii). With nitrite curing salt and nitrate.','Tender slices of steak with crisp snow peas, carrots, and broccoli, sesame beef stir fry is a quick and nutritious meal, with a pleasantly spicy ginger sesame sauce.',3.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:52','2026-06-02 02:16:52'),
(28,6,1,'Pepper Steak with Onions','pepper-steak-with-onions','Substances or products causing allergies - i). With nitrite curing salt. ii). With nitrate. iii). With nitrite curing salt and nitrate.','Pepper Steak is tender and juicy slices of Steak mixed with peppers and lots of onion in a silky and flavorful sauce.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:52','2026-06-02 02:16:52'),
(29,6,1,'Szechuan Beef','szechuan-beef','Substances or products causing allergies - i). With nitrite curing salt. ii). With nitrate. iii). With nitrite curing salt and nitrate.','Beef enveloped in dynamic spicy sauce made from layers of chilis, garlic, ginger and of course Szechuan peppercorns with just a touch of sweetness.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:52','2026-06-02 02:16:52'),
(30,7,2,'Kung Pao Squid','kung-pao-squid','LMIV - Allergen - i). Contains fish and products thereof. ii). Contains sulphur dioxide and sulphites. iii). Contains soybeans and products thereof. iv). Contains milk and products thereof (including lactose). v). Contains cereals and products thereof containing gluten. vi). wheat. vii). Contains eggs and products thereof. viii). Contains sesame seeds and products thereof.','Kung Pao squid is studded with crunchy roasted peanuts, spicy chilies, and tongue numbing sichuan peppercorns in a slightly sweet and savory sauce.',5.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:53','2026-06-02 02:16:53'),
(31,7,1,'Salmon with Mix Vegetables','salmon-with-mix-vegetables','LMIV - Allergen - i). Contains fish and products thereof. ii). Contains sulphur dioxide and sulphites. iii). Contains soybeans and products thereof. iv). Contains milk and products thereof (including lactose). v). Contains cereals and products thereof containing gluten. vi). wheat. vii). Contains eggs and products thereof. viii). Contains sesame seeds and products thereof.','Tender slices of salmon with crisp snow peas, carrots, and broccoli, salmon stir fry is a quick and nutritious meal, with a pleasantly spicy ginger sesame sauce.',3.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:53','2026-06-02 02:16:53'),
(32,7,1,'Shrimp with Broccoli','shrimp-with-broccoli','LMIV - Allergen - i). Contains crustaceans and products thereof. ii). Contains sesame seeds and products thereof.','Crisp green broccoli and sweet onions, with shrimp, glistens with the best-tasting brown sauce.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:53','2026-06-02 02:16:53'),
(33,7,2,'Szechuan Shrimp','szechuan-shrimp','LMIV - Allergen - i). Contains crustaceans and products thereof. ii). Contains sesame seeds and products thereof.','Spicy, tangy Szechuan sauce packs a ton of strong flavors on top of tender baby shrimp.',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:54','2026-06-02 02:16:54'),
(34,8,1,'Classic Caesar Salad','classic-caesar-salad','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','Classic Caesar Salad recipe is a crisp, crunchy, homemade version tossed with a traditional Caesar salad dressing and garlic croutons.',3.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:54','2026-06-02 02:16:54'),
(35,8,1,'Fresh Tuna Salad','fresh-tuna-salad','LMIV - Allergen - i). Contains fish and products thereof. ii). Contains sulphur dioxide and sulphites. iii). Contains soybeans and products thereof. iv). Contains milk and products thereof (including lactose). v). Contains cereals and products thereof containing gluten. vi). wheat. vii). Contains eggs and products thereof. viii). Contains sesame seeds and products thereof.','Fresh tuna, crisp celery, red onion, radishes, and fresh herbs, tossed in a creamy lemony dressing.',4.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:54','2026-06-02 02:16:54'),
(36,8,2,'Mix Vegetables Salad','mix-vegetables-salad','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','A bow full of cabbage, tomatoes and carrots tossed with a delicious dressing of yogurt, honey, salt and pepper.',2.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:55','2026-06-02 02:16:55'),
(37,8,1,'Poached Pear Salad','poached-pear-salad','LMIV - Allergen - i). Contains nuts and products thereof. ii). Contains milk and products thereof (including lactose). iii). cashews.','Poached pear and goat cheese salad made with mixed greens, poached pears and herbed goat cheese with pear shallot vinaigrette.',3.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:55','2026-06-02 02:16:55'),
(38,8,1,'Roasted Salmon Salad','roasted-salmon-salad','LMIV - Allergen - i). Contains fish and products thereof. ii). Contains sulphur dioxide and sulphites. iii). Contains soybeans and products thereof. iv). Contains milk and products thereof (including lactose). v). Contains cereals and products thereof containing gluten. vi). wheat. vii). Contains eggs and products thereof. viii). Contains sesame seeds and products thereof.','Flaky baked salmon, crisp celery, red onion, radishes, and fresh herbs, tossed in a creamy lemony dressing.',1.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:55','2026-06-02 02:16:55'),
(39,9,2,'Chicken Noodles Soup','chicken-noodles-soup','Substances or products causing allergies - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose). iii). Contains celery and products thereof. iv). Contains eggs and products thereof.','This chicken noodle soup is like a warm hug from the inside out. Loaded with tender chicken, hearty vegetables, and comforting noodles, it\'s the ultimate comfort food on a chilly day.',3.000000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:56','2026-06-02 02:16:56'),
(40,9,1,'Egg Drop Soup','egg-drop-soup','Substances or products causing allergies - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose). iii). Contains celery and products thereof. iv). Contains eggs and products thereof.','Egg Drop Soup is a warm, thickened broth, with rich flavors of chicken and beautiful egg ribbons throughout.',2.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:56','2026-06-02 02:16:56'),
(41,9,1,'Hot & Sour Soup','hot-sour-soup','Substances or products causing allergies - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose). iii). Contains celery and products thereof. iv). Contains eggs and products thereof.','Filled with mushrooms, tofu and silky egg ribbons, hot and sour soup is thickened with corn flour/cornstarch so the broth is beautifully glossy.',2.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:56','2026-06-02 02:16:56'),
(42,9,2,'Wonton Soup','wonton-soup','Substances or products causing allergies - i). Contains cereals and products thereof containing gluten. ii). Contains milk and products thereof (including lactose). iii). Contains celery and products thereof. iv). Contains eggs and products thereof.','Wonton soup is a simple, light, Chinese classic with pork-filled dumplings in seasoned chicken broth. Whether in soup or fried, wontons always add delicious, hearty flavor to any dish!',2.500000,5,10,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:57','2026-06-02 02:16:57'),
(43,10,1,'Baked Potato','baked-potato','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','The outside is brown and crisp, coated in a crust of sea salt.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:57','2026-06-02 02:16:57'),
(44,10,1,'French Fries','french-fries','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','Serve with mayo and green chili sauce.',1.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:57','2026-06-02 02:16:57'),
(45,10,1,'Homemade Mashed Potato','homemade-mashed-potato','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','Made with idaho potatoes, butter, and optional garlic.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:58','2026-06-02 02:16:58'),
(46,10,2,'Onion Rings','onion-rings','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','Serve with mayo and green chili sauce.',1.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:58','2026-06-02 02:16:58'),
(47,10,1,'Potato Pancakes','potato-pancakes','LMIV - Allergen - i). Contains cereals and products thereof containing gluten. ii). Wheat.','Shallow-fried pancakes of grated potato, flour or matzo meal, and a binder such as egg or applesauce.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:58','2026-06-02 02:16:58'),
(48,11,1,'Cappuccino','cappuccino','LMIV - Allergen - i). Contains milk and products thereof (including lactose).','Dark, rich espresso lies in wait under a smoothed and stretched layer of thick milk foam.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:59','2026-06-02 02:16:59'),
(49,11,1,'Chai Latte','chai-latte','LMIV - Allergen - i). Contains milk and products thereof (including lactose).','Black tea infused with cinnamon, clove and other warming spices is combined with steamed milk and topped with foam for the perfect balance of sweet and spicy.',1.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:59','2026-06-02 02:16:59'),
(50,11,2,'Espresso','espresso','','Smooth signature espresso roast with rich flavor and caramel sweetness.',1.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:59','2026-06-02 02:16:59'),
(51,11,1,'Homemade Lemonade','homemade-lemonade','','Perfectly sweet and makes the best refreshing summer drink.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:00','2026-06-02 02:17:00'),
(52,11,1,'Iced Coffee','iced-coffee','LMIV - Allergen - i). Contains milk and products thereof (including lactose).','Cold foam contrasts with dark, smooth cold brew, yielding an inviting aroma with lush infused cold foam.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:00','2026-06-02 02:17:00'),
(53,11,1,'Mojito','mojito','','Mixed drink of mint, lime, sugar, and club soda.',2.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:00','2026-06-02 02:17:00'),
(54,11,1,'Soda (Bottle)','soda-bottle','','0.5 ltr of soda bottle.',1.000000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:00','2026-06-02 02:17:00'),
(55,11,1,'Soda (Can)','soda-can','','0.5 ltr of soda can.',1.500000,5,5,1,5,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `display_mode` tinyint(3) unsigned NOT NULL DEFAULT 5,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES
(1,'English','en',5,5,NULL,NULL,NULL,NULL,'2026-06-03 23:57:29','2026-06-03 23:57:29'),
(2,'Arabic','ar',10,5,NULL,NULL,NULL,NULL,'2026-06-03 23:57:29','2026-06-03 23:57:29'),
(3,'French','fr',5,5,NULL,NULL,NULL,NULL,'2026-06-03 23:57:29','2026-06-03 23:57:29');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `uuid` char(36) DEFAULT NULL,
  `collection_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `mime_type` varchar(255) DEFAULT NULL,
  `disk` varchar(255) NOT NULL,
  `conversions_disk` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `manipulations` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`manipulations`)),
  `custom_properties` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`custom_properties`)),
  `generated_conversions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`generated_conversions`)),
  `responsive_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`responsive_images`)),
  `order_column` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `media_uuid_unique` (`uuid`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `media_order_column_index` (`order_column`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES
(1,'App\\Models\\NotificationSetting',37,'a2fae6d5-d5c4-4c3a-b8a5-c3fc9b8ba0a1','notification-file','service-account-file','service-account-file.json','application/json','public','public',2381,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(2,'App\\Models\\PaymentGateway',1,'f4ff9bd5-bfb7-4ecd-9fe3-2349fbc63b83','payment-gateway','cash-on-delivery','cash-on-delivery.png','image/png','public','public',3437,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(3,'App\\Models\\PaymentGateway',2,'143af68c-dbf0-4ee9-9223-37059557f898','payment-gateway','credit','credit.png','image/png','public','public',3885,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(4,'App\\Models\\PaymentGateway',3,'882b24b0-b1be-4b7b-89bf-618faa7fd827','payment-gateway','paypal','paypal.png','image/png','public','public',3809,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(6,'App\\Models\\PaymentGateway',5,'319bdbb0-a4e5-4a60-bff8-92afd0f84fda','payment-gateway','flutterwave','flutterwave.png','image/png','public','public',5191,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(7,'App\\Models\\PaymentGateway',6,'07269735-e6a1-4944-aacd-a2d5bac43207','payment-gateway','paystack','paystack.png','image/png','public','public',4195,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(8,'App\\Models\\PaymentGateway',7,'85d263e2-a123-442e-b585-38542250fe07','payment-gateway','sslcommerz','sslcommerz.png','image/png','public','public',4546,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(9,'App\\Models\\PaymentGateway',8,'901ce26c-d32d-443c-b299-ea94a1798679','payment-gateway','mollie','mollie.png','image/png','public','public',8116,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(10,'App\\Models\\PaymentGateway',9,'22f9e517-4334-4e80-a51f-cca0b4573a4f','payment-gateway','senangpay','senangpay.png','image/png','public','public',6541,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(11,'App\\Models\\PaymentGateway',10,'93111b30-da04-44fb-a295-f41e4bc5089a','payment-gateway','bkash','bkash.png','image/png','public','public',5282,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(12,'App\\Models\\PaymentGateway',11,'69f519a1-8407-4f7f-a3f7-4abaa715637c','payment-gateway','paytm','paytm.png','image/png','public','public',3285,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(13,'App\\Models\\PaymentGateway',12,'67de401f-358e-4781-b657-3508a773d138','payment-gateway','razorpay','razorpay.png','image/png','public','public',4847,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(14,'App\\Models\\PaymentGateway',13,'5995769a-9740-4e18-87db-001ca4bc2bbd','payment-gateway','mercadopago','mercadopago.png','image/png','public','public',11423,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(15,'App\\Models\\PaymentGateway',14,'cc914890-c112-4d41-abef-4920c98c150b','payment-gateway','cashfree','cashfree.png','image/png','public','public',4940,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(16,'App\\Models\\PaymentGateway',15,'eb33b493-757e-4818-943d-cd9952b8e17a','payment-gateway','payfast','payfast.png','image/png','public','public',2173,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(17,'App\\Models\\PaymentGateway',16,'2d8e64cb-b3c8-47d9-94a8-ed6821ad5a8c','payment-gateway','skrill','skrill.png','image/png','public','public',7074,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(18,'App\\Models\\PaymentGateway',17,'bb93796b-41cf-4a93-81c1-8c4f876f13eb','payment-gateway','phonepe','phonepe.png','image/png','public','public',4417,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(19,'App\\Models\\PaymentGateway',18,'380cc6ce-4cc1-483c-93b2-29fbca663377','payment-gateway','telr','telr.png','image/png','public','public',7594,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(20,'App\\Models\\PaymentGateway',19,'92cc262e-39eb-44a6-8323-bfd7259db33f','payment-gateway','iyzico','iyzico.png','image/png','public','public',7652,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(21,'App\\Models\\PaymentGateway',20,'e6b4f433-a881-46f0-b21a-ce62f26203f7','payment-gateway','pesapal','pesapal.png','image/png','public','public',9373,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(22,'App\\Models\\PaymentGateway',21,'0de61ed6-8321-40ed-856e-2dbe7543aa1c','payment-gateway','midtrans','midtrans.png','image/png','public','public',5877,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(23,'App\\Models\\PaymentGateway',22,'6c5c0f2a-6abe-4b36-90dc-6e9887ea54cb','payment-gateway','myfatoorah','myfatoorah.png','image/png','public','public',5411,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(24,'App\\Models\\PaymentGateway',23,'4b32ee93-2fa6-41b1-a200-030e37ac2520','payment-gateway','easypaisa','easypaisa.png','image/png','public','public',11255,'[]','[]','[]','[]',1,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(25,'App\\Models\\Language',1,'3c4ecbba-fb25-408e-81c8-2ac962965367','language','english','english.png','image/png','public','public',1149,'[]','[]','[]','[]',1,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(26,'App\\Models\\Language',2,'98ff69e2-414f-4e7f-bf24-6e49d7217c07','language','bangla','bangla.png','image/png','public','public',1309,'[]','[]','[]','[]',1,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(27,'App\\Models\\Language',3,'d0233729-91af-4cde-8c14-afce3e01c52f','language','german','german.png','image/png','public','public',1835,'[]','[]','[]','[]',1,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(28,'App\\Models\\Language',4,'0be5f76f-14f4-4570-a697-7b7138083fad','language','arabic','arabic.png','image/png','public','public',4388,'[]','[]','[]','[]',1,'2026-06-02 02:16:40','2026-06-02 02:16:40'),
(29,'App\\Models\\ItemCategory',1,'e70c24b8-042a-4ec8-9ae9-994d0de61028','item-category','appetizers','appetizers.png','image/png','public','public',29630,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(30,'App\\Models\\ItemCategory',2,'62ec4e66-d532-41a0-8b9d-c00c5409f39e','item-category','flame_grill_burgers','flame_grill_burgers.png','image/png','public','public',28882,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:41','2026-06-02 02:16:42'),
(31,'App\\Models\\ItemCategory',3,'37bd72e8-8e35-49d0-acf0-9e422965ef76','item-category','veggie_&_plant_based_burgers','veggie_&_plant_based_burgers.png','image/png','public','public',24706,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(32,'App\\Models\\ItemCategory',4,'2dd56861-87d7-4137-8b9f-9884fec025f1','item-category','sandwich_from_the_grill','sandwich_from_the_grill.png','image/png','public','public',29519,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(33,'App\\Models\\ItemCategory',5,'f2abf6dd-cb99-4c9a-b27d-a24f91e5bbe3','item-category','hot_chicken_entrees','hot_chicken_entrees.png','image/png','public','public',24748,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(34,'App\\Models\\ItemCategory',6,'3cb3b4c2-484b-4121-a15a-d29a98760725','item-category','beef_entrees','beef_entrees.png','image/png','public','public',23558,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(35,'App\\Models\\ItemCategory',7,'d3bf24cc-918e-4835-b83a-acf7cad03cba','item-category','seafood_entrees','seafood_entrees.png','image/png','public','public',29835,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(36,'App\\Models\\ItemCategory',8,'5e7166bc-82b7-4f4b-baf5-d0e008fe02b2','item-category','house_special_salads','house_special_salads.png','image/png','public','public',28797,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(37,'App\\Models\\ItemCategory',9,'5f027447-222c-411a-bf33-2c168b6de4cb','item-category','zoop_soups','zoop_soups.png','image/png','public','public',17785,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(38,'App\\Models\\ItemCategory',10,'819f7fe9-28e6-403d-a961-d7ae7455f7f5','item-category','side_orders','side_orders.png','image/png','public','public',18072,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:42','2026-06-02 02:16:42'),
(39,'App\\Models\\ItemCategory',11,'9f08cc78-84a2-4c70-aa21-1c38da2f3c30','item-category','beverages','beverages.png','image/png','public','public',15312,'[]','[]','{\"thumb\":true,\"cover\":true}','[]',1,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(40,'App\\Models\\Item',1,'01d0609b-015d-48bb-9581-350ffa31d4ab','item','chicken_dumplings','chicken_dumplings.png','image/png','public','public',97901,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:43','2026-06-02 02:16:43'),
(41,'App\\Models\\Item',2,'9165a27b-c8a8-44cc-9e6b-0f142bc0d616','item','egg_roll','egg_roll.png','image/png','public','public',100373,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:43','2026-06-02 02:16:44'),
(42,'App\\Models\\Item',3,'a72dd213-2bd7-4995-bfb2-354e9726138d','item','fried_cheese_wonton','fried_cheese_wonton.png','image/png','public','public',109816,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:44','2026-06-02 02:16:44'),
(43,'App\\Models\\Item',4,'21f335dc-ee25-443f-92ba-9b5056dab2a1','item','vegetable_dumplings','vegetable_dumplings.png','image/png','public','public',105347,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:44','2026-06-02 02:16:44'),
(44,'App\\Models\\Item',5,'bcfcbea6-c722-480a-b7da-177349434c4f','item','vegetable_roll','vegetable_roll.png','image/png','public','public',109340,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:44','2026-06-02 02:16:45'),
(45,'App\\Models\\Item',6,'11ba48d8-cdb4-423f-bf73-6d78ec7254c7','item','american_bbq_double','american_bbq_double.png','image/png','public','public',78824,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:45','2026-06-02 02:16:45'),
(46,'App\\Models\\Item',7,'4200ba82-9a92-4eaf-87ac-ab8f314c29e2','item','american_bbq_single','american_bbq_single.png','image/png','public','public',107196,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:45','2026-06-02 02:16:45'),
(47,'App\\Models\\Item',8,'9d9644e7-5db4-4629-8954-85bff1bddac8','item','bacon_double_cheeseburger','bacon_double_cheeseburger.png','image/png','public','public',95580,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:45','2026-06-02 02:16:46'),
(48,'App\\Models\\Item',9,'ffb5b5bb-ddb6-49fc-bab9-4fcdc3138610','item','cheeseburger','cheeseburger.png','image/png','public','public',69645,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:46','2026-06-02 02:16:46'),
(49,'App\\Models\\Item',10,'bb1b1029-6315-40b5-9f4e-6086271afb3d','item','peppercorn_anger','peppercorn_anger.png','image/png','public','public',89388,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:46','2026-06-02 02:16:46'),
(50,'App\\Models\\Item',11,'43776c38-337c-4e54-af1f-827773bc66e8','item','whopper','whopper.png','image/png','public','public',100345,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:46','2026-06-02 02:16:47'),
(51,'App\\Models\\Item',12,'44ea2a18-3423-4a0f-8d3d-86844b0e5f5e','item','plant_based_bacon','plant_based_bacon.png','image/png','public','public',80808,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:47','2026-06-02 02:16:47'),
(52,'App\\Models\\Item',13,'9938c456-df61-4522-a0ea-28743728260c','item','plant_based_whopper','plant_based_whopper.png','image/png','public','public',88038,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:47','2026-06-02 02:16:47'),
(53,'App\\Models\\Item',14,'05a3e8ef-8463-4caf-a2df-636917578601','item','vegan_hum-burger_with_cheese','vegan_hum-burger_with_cheese.png','image/png','public','public',76043,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:47','2026-06-02 02:16:48'),
(54,'App\\Models\\Item',15,'403ac708-eaf0-4873-ae38-291fece86095','item','vegan_royale','vegan_royale.png','image/png','public','public',109393,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:48','2026-06-02 02:16:48'),
(55,'App\\Models\\Item',16,'0696c955-e437-4713-8d5c-cf4e447d63be','item','bbq_chicken','bbq_chicken.png','image/png','public','public',97124,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:48','2026-06-02 02:16:48'),
(56,'App\\Models\\Item',17,'fcb9ab18-7505-48af-aaaf-947393a1fa06','item','bbq_pulled_pork','bbq_pulled_pork.png','image/png','public','public',91451,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:48','2026-06-02 02:16:49'),
(57,'App\\Models\\Item',18,'1286a121-f9ba-45da-b195-8345ba85a28a','item','chicken_mushroom','chicken_mushroom.png','image/png','public','public',96996,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:49','2026-06-02 02:16:49'),
(58,'App\\Models\\Item',19,'7cfa3621-7476-4e2a-a274-b5ef99dc8064','item','plain_grilled_chicken','plain_grilled_chicken.png','image/png','public','public',92307,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:49','2026-06-02 02:16:49'),
(59,'App\\Models\\Item',20,'79cc5a3c-d065-4023-8154-42a8102bea10','item','steak_sandwich','steak_sandwich.png','image/png','public','public',93925,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:49','2026-06-02 02:16:50'),
(60,'App\\Models\\Item',21,'63e9d74f-244a-4abe-aaa2-3fc0a9a1aa34','item','hentai_chicken','hentai_chicken.png','image/png','public','public',82155,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:50','2026-06-02 02:16:50'),
(61,'App\\Models\\Item',22,'1c107938-e1fd-4f49-8bcc-838310898b5b','item','kung_pao_chicken','kung_pao_chicken.png','image/png','public','public',97655,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:50','2026-06-02 02:16:50'),
(62,'App\\Models\\Item',23,'c12820d6-eb97-437a-80c8-e4f9fa79d597','item','sesame_chicken','sesame_chicken.png','image/png','public','public',120571,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:50','2026-06-02 02:16:51'),
(63,'App\\Models\\Item',24,'3976fa24-a0cc-4dda-9044-8495fb0ebf59','item','sweet_&_sour_chicken','sweet_&_sour_chicken.png','image/png','public','public',104392,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:51','2026-06-02 02:16:51'),
(64,'App\\Models\\Item',25,'48c1165a-f669-4883-82b6-8e12b5b35ec4','item','yemete_kudasai_chicken','yemete_kudasai_chicken.png','image/png','public','public',98997,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:51','2026-06-02 02:16:51'),
(65,'App\\Models\\Item',26,'100c300c-5f3a-4264-afe6-11a0ea0dac1a','item','beef_with_broccoli','beef_with_broccoli.png','image/png','public','public',112742,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:51','2026-06-02 02:16:52'),
(66,'App\\Models\\Item',27,'db713f5b-ad7c-46b9-8a21-2cc4b1a4e830','item','beef_with_mix_vegetables','beef_with_mix_vegetables.png','image/png','public','public',89887,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:52','2026-06-02 02:16:52'),
(67,'App\\Models\\Item',28,'05cb272b-c265-4b97-962e-e6959e3b97ed','item','pepper_steak_with_onions','pepper_steak_with_onions.png','image/png','public','public',81014,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:52','2026-06-02 02:16:52'),
(68,'App\\Models\\Item',29,'30dad55d-5a09-4ce3-b492-4b1f7e6840a8','item','szechuan_beef','szechuan_beef.png','image/png','public','public',109760,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:52','2026-06-02 02:16:53'),
(69,'App\\Models\\Item',30,'2a7072fd-934e-48bf-bd3c-35e3883c6efc','item','kung_pao_squid','kung_pao_squid.png','image/png','public','public',99998,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:53','2026-06-02 02:16:53'),
(70,'App\\Models\\Item',31,'d363db53-507b-40ee-af69-72324ef8f9a5','item','salmon_with_mix_vegetables','salmon_with_mix_vegetables.png','image/png','public','public',97727,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:53','2026-06-02 02:16:53'),
(71,'App\\Models\\Item',32,'5fa87dc6-9969-4f1b-bc6e-5c6d094f5f89','item','shrimp_with_broccoli','shrimp_with_broccoli.png','image/png','public','public',110522,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:53','2026-06-02 02:16:54'),
(72,'App\\Models\\Item',33,'066993b6-9eb7-4ab7-8ad0-a45e9c5f8b3b','item','szechuan_shrimp','szechuan_shrimp.png','image/png','public','public',124668,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:54','2026-06-02 02:16:54'),
(73,'App\\Models\\Item',34,'f24d3088-e80b-4f2d-a33b-0031be3054d4','item','classic_caesar_salad','classic_caesar_salad.png','image/png','public','public',115547,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:54','2026-06-02 02:16:54'),
(74,'App\\Models\\Item',35,'13974507-0ac8-48f0-875b-6610d02d6f65','item','fresh_tuna_salad','fresh_tuna_salad.png','image/png','public','public',110902,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:54','2026-06-02 02:16:55'),
(75,'App\\Models\\Item',36,'2c63cdc7-66b1-454f-bb98-bc79dca44a1d','item','mix_vegetables_salad','mix_vegetables_salad.png','image/png','public','public',117819,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:55','2026-06-02 02:16:55'),
(76,'App\\Models\\Item',37,'6b9dba4c-afdb-472e-a02a-a75f3d26a48a','item','poached_pear_salad','poached_pear_salad.png','image/png','public','public',117182,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:55','2026-06-02 02:16:55'),
(77,'App\\Models\\Item',38,'25cefc35-92cd-4699-a10c-d6eff7bd59e9','item','roasted_salmon_salad','roasted_salmon_salad.png','image/png','public','public',118430,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:55','2026-06-02 02:16:56'),
(78,'App\\Models\\Item',39,'0f3e50ed-fd32-4b4f-b8f7-6ea4d6a4a3f7','item','chicken_noodles_soup','chicken_noodles_soup.png','image/png','public','public',108069,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:56','2026-06-02 02:16:56'),
(79,'App\\Models\\Item',40,'f9c26354-4781-44c7-b42b-9d68f10e4a27','item','egg_drop_soup','egg_drop_soup.png','image/png','public','public',118301,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:56','2026-06-02 02:16:56'),
(80,'App\\Models\\Item',41,'309062be-0351-4382-9db3-c4b61bad442b','item','hot_&_sour_soup','hot_&_sour_soup.png','image/png','public','public',91236,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:56','2026-06-02 02:16:57'),
(81,'App\\Models\\Item',42,'2057639a-b1bc-4db4-ad81-36beb60f6214','item','wonton_soup','wonton_soup.png','image/png','public','public',109978,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:57','2026-06-02 02:16:57'),
(82,'App\\Models\\Item',43,'0e43929a-78fd-49ab-a019-80a7cddd5c9e','item','baked_potato','baked_potato.png','image/png','public','public',107742,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:57','2026-06-02 02:16:57'),
(83,'App\\Models\\Item',44,'e13f1563-ec2b-4c19-bbd5-c3d82f60ef3f','item','french_fries','french_fries.png','image/png','public','public',79941,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:57','2026-06-02 02:16:58'),
(84,'App\\Models\\Item',45,'8ed90d50-e2ed-483d-9bba-d5dcf30ba600','item','homemade_mashed_potato','homemade_mashed_potato.png','image/png','public','public',95674,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:58','2026-06-02 02:16:58'),
(85,'App\\Models\\Item',46,'17c937c0-50bf-433f-8d01-4396e12dafb8','item','onion_rings','onion_rings.png','image/png','public','public',91961,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:58','2026-06-02 02:16:58'),
(86,'App\\Models\\Item',47,'39a713fd-b069-4207-a728-aff2470e3948','item','potato_pancakes','potato_pancakes.png','image/png','public','public',76936,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:58','2026-06-02 02:16:59'),
(87,'App\\Models\\Item',48,'72a9b596-ec6d-4bab-b7c8-9fb856aeff5d','item','cappuccino','cappuccino.png','image/png','public','public',105928,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:59','2026-06-02 02:16:59'),
(88,'App\\Models\\Item',49,'c37dc1b9-ac2e-42d8-933c-bc9e41ee5f2f','item','chai_latte','chai_latte.png','image/png','public','public',81611,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:59','2026-06-02 02:16:59'),
(89,'App\\Models\\Item',50,'21aea731-4bfb-4b1e-a7a3-ea9ddddd33e3','item','espresso','espresso.png','image/png','public','public',89214,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:16:59','2026-06-02 02:17:00'),
(90,'App\\Models\\Item',51,'21145a4f-6aac-48a3-9710-9ac717188117','item','homemade_lemonade','homemade_lemonade.png','image/png','public','public',81333,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:17:00','2026-06-02 02:17:00'),
(91,'App\\Models\\Item',53,'dc0325d6-7676-4a54-b40b-f0ea02a225aa','item','mojito','mojito.png','image/png','public','public',77900,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:17:00','2026-06-02 02:17:00'),
(92,'App\\Models\\Item',54,'3a77e1d0-8d6a-4ec3-bc10-5864cc42dd0c','item','soda_(bottle)','soda_(bottle).png','image/png','public','public',94450,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:17:00','2026-06-02 02:17:01'),
(93,'App\\Models\\Item',55,'8f3cab0a-f8f8-40f2-8d0a-0908e50148da','item','soda_(can)','soda_(can).png','image/png','public','public',97672,'[]','[]','{\"thumb\":true,\"cover\":true,\"preview\":true}','[]',1,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(94,'App\\Models\\Offer',1,'2252502c-8a28-4561-b1d8-b571d2f82bae','offer','savory_and_satisfying','savory_and_satisfying.png','image/png','public','public',49995,'[]','[]','{\"cover\":true}','[]',1,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(95,'App\\Models\\Offer',2,'07390952-c4b8-4350-aadd-b70efc45e987','offer','uplifting_anytime','uplifting_anytime.png','image/png','public','public',50993,'[]','[]','{\"cover\":true}','[]',1,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(96,'App\\Models\\Language',1,'a2387e4b-7ad0-4d26-928a-175e75bdff7e','language','english','english.png','image/png','public','public',1149,'[]','[]','[]','[]',2,'2026-06-03 23:57:29','2026-06-03 23:57:29'),
(97,'App\\Models\\Language',2,'30efacfe-75a3-46da-b702-67310b969ebd','language','arabic','arabic.png','image/png','public','public',4388,'[]','[]','[]','[]',2,'2026-06-03 23:57:29','2026-06-03 23:57:29'),
(98,'App\\Models\\PaymentGateway',1,'2c25679c-c359-4395-b3e3-7adedeae5e4d','payment-gateway','cash-on-delivery','cash-on-delivery.png','image/png','public','public',3437,'[]','[]','[]','[]',2,'2026-06-04 00:01:19','2026-06-04 00:01:19'),
(99,'App\\Models\\PaymentGateway',2,'402762cc-e01f-45e6-b026-cd0b4136714a','payment-gateway','credit','credit.png','image/png','public','public',3885,'[]','[]','[]','[]',2,'2026-06-04 00:01:19','2026-06-04 00:01:19'),
(100,'App\\Models\\PaymentGateway',3,'853bccae-8cd3-4a6c-b6dc-a686c79193e5','payment-gateway','paypal','paypal.png','image/png','public','public',3809,'[]','[]','[]','[]',2,'2026-06-04 00:01:19','2026-06-04 00:01:19');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_sections`
--

DROP TABLE IF EXISTS `menu_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_sections`
--

LOCK TABLES `menu_sections` WRITE;
/*!40000 ALTER TABLE `menu_sections` DISABLE KEYS */;
INSERT INTO `menu_sections` VALUES
(1,'Header Section',NULL,NULL,NULL,NULL,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(2,'Footer Section',NULL,NULL,NULL,NULL,'2026-06-02 02:16:38','2026-06-02 02:16:38');
/*!40000 ALTER TABLE `menu_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_templates`
--

DROP TABLE IF EXISTS `menu_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_templates`
--

LOCK TABLES `menu_templates` WRITE;
/*!40000 ALTER TABLE `menu_templates` DISABLE KEYS */;
INSERT INTO `menu_templates` VALUES
(1,'Contact Us',NULL,NULL,NULL,NULL,'2026-06-02 02:16:38','2026-06-02 02:16:38');
/*!40000 ALTER TABLE `menu_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `language` varchar(255) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL,
  `parent` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 1,
  `priority` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES
(1,'Dashboard','dashboard','dashboard','lab lab-dashboard',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(2,'Items','items','items','lab lab-items',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(3,'Dining Tables','dining_tables','dining-tables','lab lab-dining-table',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(4,'Pos & Orders','pos_and_orders','#','lab lab-pos',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(5,'POS','pos','pos','lab lab-pos',1,4,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(6,'POS Orders','pos_orders','pos-orders','lab lab-pos-orders',1,4,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(7,'Table Orders','table_orders','table-orders','lab lab-reserve-line',1,4,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(8,'K.D.S','k_d_s','kitchen-display-system','lab lab-kds',1,4,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(10,'Promo','promo','#','lab ',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(11,'Offers','offers','offers','lab lab-offers',1,10,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(12,'Users','users','#','lab ',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(13,'Administrators','administrators','administrators','lab lab-administrators',1,12,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(14,'Customers','customers','customers','lab lab-customers',1,12,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(15,'Employees','employees','employees','lab lab-employee',1,12,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(16,'Waiters','waiters','waiters','lab lab-waiter',1,12,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(17,'Chef','chefs','chefs','lab lab-chef',1,12,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(20,'Reports','reports','#','lab ',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(21,'Sales Report','sales_report','sales-report','lab lab-sales-report',1,20,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(22,'Items Report','items_report','items-report','lab lab-items-report',1,20,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(23,'Credit Balance Report','credit_balance_report','credit-balance-report','lab lab-credit-balance-report',1,20,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(24,'Setup','setup','#','lab ',1,0,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(25,'Settings','settings','settings','lab lab-settings',1,24,1,100,'2026-06-02 02:16:38','2026-06-02 02:16:38');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_histories`
--

DROP TABLE IF EXISTS `message_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `text` longtext DEFAULT NULL,
  `is_read` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_histories_message_id_foreign` (`message_id`),
  KEY `message_histories_user_id_foreign` (`user_id`),
  CONSTRAINT `message_histories_message_id_foreign` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`),
  CONSTRAINT `message_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_histories`
--

LOCK TABLES `message_histories` WRITE;
/*!40000 ALTER TABLE `message_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `message_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_user_id_foreign` (`user_id`),
  CONSTRAINT `messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_resets_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2020_09_10_080029_create_menus_table',1),
(6,'2022_05_01_142407_create_permission_tables',1),
(7,'2022_05_24_204620_create_settings_table',1),
(8,'2022_05_25_124629_create_currencies_table',1),
(9,'2022_06_26_055545_create_default_access_table',1),
(10,'2022_08_10_143500_create_media_table',1),
(11,'2022_10_31_015126_create_pesapals_table',1),
(12,'2022_11_17_110125_create_branches_table',1),
(13,'2022_11_17_110157_create_languages_table',1),
(14,'2022_11_17_110300_create_addresses_table',1),
(15,'2022_11_17_110428_create_item_categories_table',1),
(16,'2022_11_17_110455_create_offers_table',1),
(17,'2022_11_17_110459_create_taxes_table',1),
(18,'2022_11_17_110514_create_items_table',1),
(19,'2022_11_17_110541_create_item_attributes_table',1),
(20,'2022_11_17_110621_create_item_variations_table',1),
(21,'2022_11_17_110650_create_item_extras_table',1),
(22,'2022_11_17_110810_create_orders_table',1),
(23,'2022_11_17_110832_create_order_items_table',1),
(24,'2022_11_17_111737_create_offer_items_table',1),
(25,'2022_11_17_113842_create_menu_sections_table',1),
(26,'2022_11_17_114040_create_menu_templates_table',1),
(27,'2022_11_17_114144_create_analytics_table',1),
(28,'2022_11_17_114516_create_analytics_sections_table',1),
(29,'2022_11_17_114835_create_payment_gateways_table',1),
(30,'2022_11_17_115136_create_sms_gateways_table',1),
(31,'2022_11_17_115341_create_gateway_options_table',1),
(32,'2022_11_17_115716_create_addons_table',1),
(33,'2022_11_17_120130_create_notifications_table',1),
(34,'2022_11_17_120408_create_messages_table',1),
(35,'2022_11_17_120624_create_message_histories_table',1),
(36,'2022_11_17_120626_create_pages_table',1),
(37,'2022_11_17_120627_create_item_addons_table',1),
(38,'2022_11_23_125038_create_push_notifications_table',1),
(39,'2023_01_09_111734_create_time_slots_table',1),
(40,'2023_02_20_180253_create_order_addresses_table',1),
(41,'2023_03_06_154954_create_otps_table',1),
(42,'2023_03_23_143747_create_transactions_table',1),
(43,'2023_03_23_170303_create_capture_payment_notifications_table',1),
(44,'2023_03_27_140107_create_notification_alerts_table',1),
(45,'2023_07_19_135307_add_soft_delete_column_to_users_table',1),
(46,'2023_07_20_095727_add_total_tax_to_orders_table',1),
(47,'2023_07_20_095843_add_tax_to_order_items_table',1),
(48,'2023_09_05_133748_create_dining_tables_table',1),
(49,'2023_11_18_154743_add_dining_table_id_to_order_table',1),
(50,'2024_01_22_172712_add_display_mode_to_languages_table',1),
(51,'2024_03_07_095727_add_sort_to_item_categories_table',1),
(52,'2024_10_28_000000_add_pos_payment_method_and_note_to_orders_table',1),
(53,'2025_02_09_000000_add_pos_received_amount_to_orders_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES
(1,'App\\Models\\User',1),
(2,'App\\Models\\User',2),
(2,'App\\Models\\User',3),
(3,'App\\Models\\User',10),
(4,'App\\Models\\User',11),
(5,'App\\Models\\User',4),
(5,'App\\Models\\User',5),
(6,'App\\Models\\User',6),
(6,'App\\Models\\User',7),
(7,'App\\Models\\User',8),
(7,'App\\Models\\User',9);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offer_items`
--

DROP TABLE IF EXISTS `offer_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `offer_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) unsigned NOT NULL,
  `item_id` bigint(20) unsigned NOT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `offer_items_offer_id_foreign` (`offer_id`),
  CONSTRAINT `offer_items_offer_id_foreign` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offer_items`
--

LOCK TABLES `offer_items` WRITE;
/*!40000 ALTER TABLE `offer_items` DISABLE KEYS */;
INSERT INTO `offer_items` VALUES
(1,1,6,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(2,1,7,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(3,1,8,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(4,2,26,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(5,2,27,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(6,2,28,NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01');
/*!40000 ALTER TABLE `offer_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `amount` decimal(19,6) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES
(1,'Savory and Satisfying','savory-and-satisfying',5.000000,5,'2026-06-02 03:17:01','2027-06-02 03:17:01',NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01'),
(2,'Uplifting Anytime','uplifting-anytime',7.000000,5,'2026-06-02 03:17:01','2027-06-02 03:17:01',NULL,NULL,NULL,NULL,'2026-06-02 02:17:01','2026-06-02 02:17:01');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_addresses`
--

DROP TABLE IF EXISTS `order_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `label` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `apartment` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_addresses_order_id_foreign` (`order_id`),
  KEY `order_addresses_user_id_foreign` (`user_id`),
  CONSTRAINT `order_addresses_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_addresses`
--

LOCK TABLES `order_addresses` WRITE;
/*!40000 ALTER TABLE `order_addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `item_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `discount` decimal(19,6) NOT NULL,
  `tax_name` varchar(255) DEFAULT NULL,
  `tax_rate` decimal(19,6) DEFAULT NULL,
  `tax_type` tinyint(4) DEFAULT NULL,
  `tax_amount` decimal(19,6) DEFAULT NULL,
  `price` decimal(19,6) NOT NULL,
  `item_variations` longtext DEFAULT NULL,
  `item_extras` longtext DEFAULT NULL,
  `item_variation_total` decimal(19,6) DEFAULT 0.000000,
  `item_extra_total` decimal(19,6) DEFAULT 0.000000,
  `total_price` decimal(19,6) DEFAULT 0.000000,
  `instruction` text DEFAULT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_branch_id_foreign` (`branch_id`),
  KEY `order_items_item_id_foreign` (`item_id`),
  CONSTRAINT `order_items_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `order_items_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES
(29,9,1,2,1,0.000000,'VAT',5.000000,10,0.075000,1.500000,'[{\"id\":3,\"item_id\":2,\"item_attribute_id\":\"5\",\"variation_name\":\"Choose a filling\",\"name\":\"Chicken\"}]','[]',0.000000,0.000000,1.500000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(30,10,1,7,1,0.000000,'No-VAT',0.000000,10,0.000000,3.800000,'[{\"id\":11,\"item_id\":7,\"item_attribute_id\":\"1\",\"variation_name\":\"Size\",\"name\":\"Regular\"}]','[]',0.000000,0.000000,3.800000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(37,17,1,1,1,0.000000,'VAT',5.000000,10,0.500000,10.000000,'[]','[]',0.000000,0.000000,10.000000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(38,18,1,1,1,0.000000,'VAT',5.000000,10,0.125000,2.500000,'[{\"id\":1,\"item_id\":1,\"item_attribute_id\":\"1\",\"variation_name\":\"Size\",\"name\":\"Regular - 8 pcs\"}]','[]',0.000000,0.000000,2.500000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(39,19,1,7,1,0.000000,'No-VAT',0.000000,10,0.000000,3.800000,'[{\"id\":11,\"item_id\":7,\"item_attribute_id\":\"1\",\"variation_name\":\"Size\",\"name\":\"Regular\"}]','[]',0.000000,0.000000,3.800000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(40,19,1,14,1,0.000000,'No-VAT',0.000000,10,0.000000,2.500000,'[{\"id\":25,\"item_id\":14,\"item_attribute_id\":\"1\",\"variation_name\":\"Size\",\"name\":\"Regular\"}]','[]',0.000000,0.000000,2.500000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(41,20,1,4,1,0.000000,'VAT',5.000000,10,0.125000,2.500000,'[{\"id\":7,\"item_id\":4,\"item_attribute_id\":\"1\",\"variation_name\":\"Size\",\"name\":\"Half - 6 pcs\"}]','[]',0.000000,0.000000,2.500000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(42,21,1,2,1,0.000000,'VAT',5.000000,10,0.075000,1.500000,'[{\"id\":3,\"item_id\":2,\"item_attribute_id\":\"5\",\"variation_name\":\"Choose a filling\",\"name\":\"Chicken\"}]','[]',0.000000,0.000000,1.500000,'',NULL,NULL,NULL,NULL,NULL,NULL),
(43,22,1,1,1,0.000000,'VAT',5.000000,10,0.125000,2.500000,'[{\"id\":1,\"item_id\":1,\"item_attribute_id\":\"1\",\"variation_name\":\"Size\",\"name\":\"Regular - 8 pcs\"}]','[]',0.000000,0.000000,2.500000,'',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_serial_no` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `subtotal` decimal(19,6) NOT NULL,
  `discount` decimal(19,6) DEFAULT 0.000000,
  `delivery_charge` decimal(19,6) DEFAULT 0.000000,
  `total_tax` decimal(19,6) DEFAULT NULL,
  `total` decimal(19,6) NOT NULL,
  `order_type` tinyint(4) NOT NULL DEFAULT 5,
  `order_datetime` timestamp NOT NULL DEFAULT '2026-06-02 02:06:38',
  `delivery_time` varchar(255) DEFAULT NULL,
  `preparation_time` int(11) NOT NULL DEFAULT 0,
  `is_advance_order` tinyint(4) NOT NULL DEFAULT 5,
  `payment_method` bigint(20) NOT NULL DEFAULT 1,
  `pos_payment_method` tinyint(4) DEFAULT NULL,
  `pos_received_amount` decimal(19,6) DEFAULT 0.000000,
  `pos_payment_note` varchar(200) DEFAULT NULL,
  `payment_status` tinyint(4) NOT NULL DEFAULT 10,
  `status` tinyint(4) NOT NULL,
  `dining_table_id` bigint(20) unsigned DEFAULT NULL,
  `delivery_boy_id` bigint(20) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  KEY `orders_branch_id_foreign` (`branch_id`),
  CONSTRAINT `orders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(9,'0406269','568778',2,1,1.500000,0.000000,0.000000,0.075000,1.500000,20,'2026-06-04 00:29:48','01:29 - 01:59',30,10,1,NULL,0.000000,NULL,10,13,2,NULL,NULL,'5',NULL,NULL,NULL,NULL,'2026-06-04 00:29:48','2026-06-04 00:34:04'),
(10,'04062610','203131',2,1,3.800000,0.000000,0.000000,0.000000,3.800000,10,'2026-06-04 00:31:49','01:31 - 02:01',30,10,1,1,200.000000,NULL,5,8,NULL,NULL,NULL,'15',NULL,NULL,NULL,NULL,'2026-06-04 00:31:49','2026-06-04 01:38:12'),
(17,'04062617',NULL,1,1,10.000000,0.000000,0.000000,0.500000,10.000000,4,'2026-06-04 01:55:38','02:55 - 03:25',30,1,1,NULL,0.000000,NULL,10,1,1,NULL,NULL,'1',NULL,NULL,NULL,NULL,'2026-06-04 01:55:38','2026-06-04 01:55:38'),
(18,'04062618',NULL,2,1,2.500000,0.000000,0.000000,0.125000,2.500000,20,'2026-06-04 01:56:10','02:56 - 03:26',30,10,1,NULL,0.000000,NULL,10,4,2,NULL,NULL,'5',NULL,NULL,NULL,NULL,'2026-06-04 01:56:10','2026-06-10 00:50:47'),
(19,'10062619','204931',2,1,6.300000,0.000000,0.000000,0.000000,6.300000,20,'2026-06-10 00:50:18','01:50 - 02:20',30,10,1,1,666.000000,NULL,5,4,1,NULL,NULL,'15',NULL,NULL,NULL,NULL,'2026-06-10 00:50:18','2026-06-10 00:50:18'),
(20,'10062620','210555',2,1,2.500000,0.000000,0.000000,0.125000,2.500000,20,'2026-06-10 01:11:56','02:11 - 02:41',30,10,1,1,999.000000,NULL,5,4,1,NULL,NULL,'15',NULL,NULL,NULL,NULL,'2026-06-10 01:11:56','2026-06-10 01:11:56'),
(21,'10062621',NULL,2,1,1.500000,0.000000,0.000000,0.075000,1.500000,20,'2026-06-10 01:21:00','02:21 - 02:51',30,10,1,NULL,0.000000,NULL,10,1,1,NULL,NULL,'5',NULL,NULL,NULL,NULL,'2026-06-10 01:21:00','2026-06-10 01:21:01'),
(22,'10062622',NULL,2,1,2.500000,0.000000,0.000000,0.125000,2.500000,20,'2026-06-10 01:28:12','02:28 - 02:58',30,10,1,NULL,0.000000,NULL,10,4,1,NULL,NULL,'5',NULL,NULL,NULL,NULL,'2026-06-10 01:28:12','2026-06-10 01:29:38');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pages`
--

DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `menu_section_id` bigint(20) unsigned NOT NULL,
  `template_id` bigint(20) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pages_menu_section_id_foreign` (`menu_section_id`),
  CONSTRAINT `pages_menu_section_id_foreign` FOREIGN KEY (`menu_section_id`) REFERENCES `menu_sections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pages`
--

LOCK TABLES `pages` WRITE;
/*!40000 ALTER TABLE `pages` DISABLE KEYS */;
INSERT INTO `pages` VALUES
(1,'Cookies Policy','cookies-policy','This Cookies Policy explains how Foody (“us”, “we” or “our”) collects, uses, stores, shares and uses cookies on its website. We provide information on how cookies and similar technologies work, their purpose, use, and duration, how We process and store them, and how you can control them. You can also find all the necessary information regarding your rights on the use of Cookies on this website and how you can exercise them.\n\nCOOKIES AND SIMILAR TECHNOLOGIES\n\nCookies are small files of data that are stored on a user’s device by the browser when visiting a website or application. Cookies are used for various reasons and can be very useful in many cases. They can be necessary for the proper functionality of the website and efficient page navigation, or they can be used to customize and enhance the user’s experience by remembering language preferences, login credentials, and many more. They can also be used to provide anonymous statistical data about the usage of the website or targeted advertisements to the visitor.\n\nSome sites might also use other similar technologies like web beacons, clear GIFs, page tags, and web bugs to understand how people are using them and to target advertising to them. They usually take the form of a small, transparent image that is embedded in a web page or email. They work with cookies and capture data like your IP address, when you viewed the page or email, what device you were using and where you were.\n\nTYPES OF COOKIES\n\nCookies can be classified as First-party Cookies and Third-Party cookies.\n\nFirst-party Cookies refer to cookies that are set by a data controller (or any of its processors) operating the website visited by the user, as defined by the URL that is usually displayed in the browser address bar.\n\nThird-party Cookies are set by data controllers that do not operate the website currently visited by the user. For example, if a user visits a website and another entity sets a cookie on the user’s device, through that website, this would be a third-party cookie. For these types of cookies, we have no control over them.\n\n\nCOOKIES CATEGORIES\n\nCookies are usually categorized into one of the following categories, depending on their purpose:\n\nNecessary cookies help make a website usable by enabling basic functions like page navigation and access to secure areas of the website. The website cannot function properly without these cookies and for these cookies, consent is not required.\n\nPreference or Functionality cookies enable a website to remember information about the user’s choice in the past that changes the way the website behaves or looks, like the preferred language or the region.\n\nStatistics or Performance cookies help website owners to understand how visitors use and interact with their website by collecting and reporting information anonymously, such as which pages are visited most frequently, or which links are clicked on.\n\nMarketing cookies, also known as Advertising or Targeting cookies, are used to track visitors\' online activity across websites. The intention is to display ads that are relevant and engaging for the individual user or limit the times an ad is displayed and thereby are more valuable for publishers and third-party advertisers.\n\n\n\nHOW LONG DO COOKIES LAST?\n\nDepending on the duration that a cookie is stored on the user’s device, cookies can be classified as Session or Persistent.\nSession cookies are temporary cookies and are automatically deleted when the user closes his browser, while Persistent cookies are cookies that remain for a specific amount of time (their expiration date can vary from minutes to days or even years).\n\n\nHOW TO CONTROL COOKIES ON THIS WEBSITE\n\nFoody will only set cookies after you have provided your consent to the use of cookies through the cookies banner upon your visit to our website. For Necessary cookies, we do not need your consent.\n\nYou have the right to withdraw your consent or change your preferences regarding the use of cookies at any time. You can do this by accessing our Cookies banner through the “Cookie Settings” button.\n\n\n\nYOUR RIGHTS\n\nIf you have a concern about the way we are collecting or using cookies, you should raise your concern with us in the first instance or directly to the office of the Commissioner for the Protection of Private Data. ',2,0,5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 01:15:54'),
(2,'About Us','about-us','Who We Are iNiLabs is the maker of GoSchool Education ERP, iTest Online Exam, FoodExpress Multi Vendor eCommerce, QuickPass Visitor Management and many other exclusive Web and Mobile Applications. Our existence depends on making ERPs and SaaS products that help to scale your business.Our Goal We create Innovative Tools to Empower Small Businesses Around the World Our main focus is to deliver high quality and scalable custom PHP applications using Latest Web and Mobile Technologies. We mostly focus our psychic coding abilities, latest development trends and best practices.Origin Story iNiLabs initially began its journey back in 2014. After gathering enough experience, we launched our company in August 2016 as a small web development startup with a renewed confidence and larger vision. We worked our way through many challenges and established ourselves as a Software Development company. iNiLabs now has many amazing products including GoSchool Education ERP, iTest Online Exam, FoodExpress Multi Vendor eCommerce, QuickPass Visitor Management and many other exclusive Web and Mobile Applications ERP and many more. We have 100, 000+ users and businesses using our solutions.',2,0,5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(3,'Contact Us','contact-us','Every day, more than 1000 guests visit Foody restaurants around the city. And they do so because our restaurants are known for serving high-quality, great-tasting, and affordable food. Our commitment to premium ingredients, signature recipes, and friendly dining experiences is what has defined our brand for more than 5 successful years.',2,1,5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 01:15:54');
/*!40000 ALTER TABLE `pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_gateways`
--

DROP TABLE IF EXISTS `payment_gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_gateways` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `misc` longtext DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_gateways`
--

LOCK TABLES `payment_gateways` WRITE;
/*!40000 ALTER TABLE `payment_gateways` DISABLE KEYS */;
INSERT INTO `payment_gateways` VALUES
(1,'Cash On Delivery','cash-on-delivery','null',5,NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:19'),
(2,'Credit','credit','null',5,NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:19'),
(3,'Paypal','paypal','null',5,NULL,NULL,NULL,NULL,'2026-06-04 00:01:19','2026-06-04 00:01:20');
/*!40000 ALTER TABLE `payment_gateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `name` varchar(125) NOT NULL,
  `guard_name` varchar(125) NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `parent` bigint(20) unsigned DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES
(1,'Dashboard','dashboard','sanctum','dashboard',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(2,'Items','items','sanctum','items',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(3,'Items Create','items_create','sanctum','items/create',2,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(4,'Items Edit','items_edit','sanctum','items/edit',2,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(5,'Items Delete','items_delete','sanctum','items/delete',2,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(6,'Items Show','items_show','sanctum','items/show',2,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(7,'Dining Tables','dining-tables','sanctum','dining-tables',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(8,'Dining Tables Create','dining_tables_create','sanctum','dining-table/create',7,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(9,'Dining Tables Edit','dining_tables_edit','sanctum','dining-table/edit',7,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(10,'Dining Tables Delete','dining_tables_delete','sanctum','dining-tables/delete',7,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(11,'Dining Tables Show','dining_tables_show','sanctum','dining-tables/show',7,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(12,'POS','pos','sanctum','pos',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(13,'POS Orders','pos-orders','sanctum','pos-orders',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(14,'Table Orders','table-orders','sanctum','table-orders',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(15,'K.D.S','kitchen-display-system','sanctum','kitchen-display-system',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(16,'O.S.S','order-status-screen','sanctum','order-status-screen',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(17,'Offers','offers','sanctum','offers',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(18,'Offers Create','offers_create','sanctum','offers/create',17,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(19,'Offers Edit','offers_edit','sanctum','offers/edit',17,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(20,'Offers Delete','offers_delete','sanctum','offers/delete',17,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(21,'Offers Show','offers_show','sanctum','offers/show',17,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(22,'Administrators','administrators','sanctum','administrators',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(23,'Administrators Create','administrators_create','sanctum','administrators/create',22,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(24,'Administrators Edit','administrators_edit','sanctum','administrators/edit',22,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(25,'Administrators Delete','administrators_delete','sanctum','administrators/delete',22,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(26,'Administrators Show','administrators_show','sanctum','administrators/show',22,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(27,'Delivery Boys','delivery-boys','sanctum','delivery-boys',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(28,'Delivery Boys Create','delivery-boys_create','sanctum','delivery-boys/create',27,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(29,'Delivery Boys Edit','delivery-boys_edit','sanctum','delivery-boys/edit',27,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(30,'Delivery Boys Delete','delivery-boys_delete','sanctum','delivery-boys/delete',27,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(31,'Delivery Boys Show','delivery-boys_show','sanctum','delivery-boys/show',27,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(32,'Customers','customers','sanctum','customers',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(33,'Customers Create','customers_create','sanctum','customers/create',32,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(34,'Customers Edit','customers_edit','sanctum','customers/edit',32,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(35,'Customers Delete','customers_delete','sanctum','customers/delete',32,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(36,'Customers Show','customers_show','sanctum','customers/show',32,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(37,'Employees','employees','sanctum','employees',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(38,'Employees Create','employees_create','sanctum','employees/create',37,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(39,'Employees Edit','employees_edit','sanctum','employees/edit',37,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(40,'Employees Delete','employees_delete','sanctum','employees/delete',37,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(41,'Employees Show','employees_show','sanctum','employees/show',37,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(42,'Waiters','waiters','sanctum','waiters',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(43,'Waiters Create','waiters_create','sanctum','waiters/create',42,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(44,'Waiters Edit','waiters_edit','sanctum','waiters/edit',42,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(45,'Waiters Delete','waiters_delete','sanctum','waiters/delete',42,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(46,'Waiters Show','waiters_show','sanctum','waiters/show',42,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(47,'Chefs','chefs','sanctum','chefs',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(48,'Chefs Create','chefs_create','sanctum','chefs/create',47,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(49,'Chefs Edit','chefs_edit','sanctum','chefs/edit',47,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(50,'Chefs Delete','chefs_delete','sanctum','chefs/delete',47,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(51,'Chefs Show','chefs_show','sanctum','chefs/show',47,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(53,'Sales Report','sales-report','sanctum','sales-report',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(54,'Items Report','items-report','sanctum','items-report',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(55,'Credit Balance Report','credit-balance-report','sanctum','credit-balance-report',0,'2026-06-02 02:16:38','2026-06-02 02:16:38'),
(56,'Settings','settings','sanctum','settings',0,'2026-06-02 02:16:38','2026-06-02 02:16:38');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES
(5,'App\\Models\\User',1,'auth_token','36213eab353c3b1af0e18d2dbbfcdb02e57cfb6e2030d7b4c9de344a73a68468','[\"*\"]','2026-06-10 16:43:41',NULL,'2026-06-04 00:26:47','2026-06-10 16:43:41'),
(8,'App\\Models\\User',1,'auth_token','3c8215ff35a8c98975e80caf564a362e9655119ea4ff115896be27ca94d869c9','[\"*\"]','2026-06-10 16:56:11',NULL,'2026-06-10 00:41:10','2026-06-10 16:56:11');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pesapals`
--

DROP TABLE IF EXISTS `pesapals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pesapals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone_number` bigint(20) unsigned DEFAULT NULL,
  `billing_address_line_1` varchar(255) DEFAULT NULL,
  `billing_address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `email` text DEFAULT NULL,
  `amount` text NOT NULL,
  `currency` varchar(255) NOT NULL,
  `language` varchar(255) DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `merchant_reference` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` text DEFAULT NULL,
  `tracking_id` text DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pesapals`
--

LOCK TABLES `pesapals` WRITE;
/*!40000 ALTER TABLE `pesapals` DISABLE KEYS */;
/*!40000 ALTER TABLE `pesapals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES
(1,1),
(1,4),
(1,5),
(1,6),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1),
(7,1),
(7,5),
(8,1),
(9,1),
(10,1),
(11,1),
(12,1),
(12,5),
(12,6),
(13,1),
(13,5),
(13,6),
(14,1),
(14,5),
(15,1),
(15,4),
(15,5),
(16,1),
(16,4),
(16,5),
(17,1),
(18,1),
(19,1),
(20,1),
(21,1),
(22,1),
(23,1),
(24,1),
(25,1),
(26,1),
(27,1),
(27,5),
(28,1),
(28,5),
(29,1),
(29,5),
(30,1),
(30,5),
(31,1),
(31,5),
(32,1),
(32,5),
(33,1),
(33,5),
(34,1),
(34,5),
(35,1),
(35,5),
(36,1),
(36,5),
(37,1),
(37,5),
(38,1),
(38,5),
(39,1),
(39,5),
(40,1),
(40,5),
(41,1),
(41,5),
(42,1),
(42,5),
(43,1),
(43,5),
(44,1),
(44,5),
(45,1),
(45,5),
(46,1),
(46,5),
(47,1),
(47,5),
(48,1),
(48,5),
(49,1),
(49,5),
(50,1),
(50,5),
(51,1),
(51,5),
(52,1),
(52,5),
(53,1),
(53,5),
(54,1),
(55,1),
(56,1);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'Admin','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38'),
(2,'Customer','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38'),
(3,'Waiter','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38'),
(4,'Chef','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38'),
(5,'Branch Manager','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38'),
(6,'POS Operator','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38'),
(7,'Stuff','sanctum','2026-06-02 02:16:38','2026-06-02 02:16:38');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `group` varchar(255) DEFAULT NULL,
  `key` varchar(255) NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`payload`)),
  `settingable_type` varchar(255) DEFAULT NULL,
  `settingable_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `settings_settingable_type_settingable_id_index` (`settingable_type`,`settingable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
(1,'company','company_name','{\"$value\":\"Foody - QrCode Restaurant Menu Maker and Contactless Menu Ordering system\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(2,'company','company_email','{\"$value\":\"info@foody.xyz\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(3,'company','company_phone','{\"$value\":\"+13333846282\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(4,'company','company_website','{\"$value\":\"https:\\/\\/foody.xyz\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(5,'company','company_city','{\"$value\":\"Mirpur 1\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(6,'company','company_state','{\"$value\":\"Dhaka\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(7,'company','company_country_code','{\"$value\":\"MAR\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(8,'company','company_zip_code','{\"$value\":\"1216\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(9,'company','company_address','{\"$value\":\"House : 25, Road No: 2, Block A, Mirpur-1, Dhaka 1216\",\"$cast\":null}',NULL,NULL,'2026-06-10 00:46:52','2026-06-10 00:46:52'),
(10,'site','site_date_format','{\"$value\":\"d-m-Y\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(11,'site','site_time_format','{\"$value\":\"h:i A\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(12,'site','site_default_timezone','{\"$value\":\"Africa\\/Casablanca\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(13,'site','site_default_branch','{\"$value\":1,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(14,'site','site_default_currency','{\"$value\":1,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(15,'site','site_default_currency_symbol','{\"$value\":\"DH\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(16,'site','site_currency_position','{\"$value\":10,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(17,'site','site_digit_after_decimal_point','{\"$value\":\"2\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(18,'site','site_email_verification','{\"$value\":5,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(19,'site','site_phone_verification','{\"$value\":10,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(20,'site','site_default_language','{\"$value\":3,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(21,'site','site_google_map_key','{\"$value\":\"Fake-map-key\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(22,'site','site_copyright','{\"$value\":\"\\u00a9 Foody 2026, All Rights Reserved\",\"$cast\":null}',NULL,NULL,'2026-06-04 02:00:20','2026-06-04 02:00:20'),
(23,'site','site_language_switch','{\"$value\":5,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(24,'site','site_app_debug','{\"$value\":10,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(25,'site','site_auto_update','{\"$value\":10,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(26,'site','site_online_payment_gateway','{\"$value\":5,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(27,'site','site_default_sms_gateway','{\"$value\":0,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(28,'site','site_food_preparation_time','{\"$value\":\"30\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(29,'notification','notification_fcm_public_vapid_key','{\"$value\":\"BB_1q5RVeHAFd69HDCkeQA62vFohxS_YEA4gVT45JfKeF7-P9UJ3GEypSRb5seCIYb6fI7E2dlXvj0sqbNIXieo\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(30,'notification','notification_fcm_api_key','{\"$value\":\"AIzaSyBLVngaS_tDeMogfNmVEfqQ1u_HyqXMqc4\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(31,'notification','notification_fcm_auth_domain','{\"$value\":\"foody.apps.com\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(32,'notification','notification_fcm_project_id','{\"$value\":\"foody\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(33,'notification','notification_fcm_storage_bucket','{\"$value\":\"foody.appspot.com\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(34,'notification','notification_fcm_messaging_sender_id','{\"$value\":\"1068326850326\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(35,'notification','notification_fcm_app_id','{\"$value\":\"1:1068326850326:web:fb724f0c9ae7f487ee4a37\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(36,'notification','notification_fcm_measurement_id','{\"$value\":\"G-8SFLD2GVEV\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(37,'notification','notification_fcm_json_file','{\"$value\":\"\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:39','2026-06-02 02:16:39'),
(38,'mail','mail_mailer','{\"$value\":\"smtp\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(39,'mail','mail_host','{\"$value\":\"mail.inilabs.dev\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(40,'mail','mail_port','{\"$value\":\"465\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(41,'mail','mail_username','{\"$value\":\"inilabsd@inilabs.dev\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(42,'mail','mail_password','{\"$value\":\"rb-XO$3~dc4q\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(43,'mail','mail_encryption','{\"$value\":\"ssl\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(44,'mail','mail_from_name','{\"$value\":\"Foody - Inilabs Food Manager\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(45,'mail','mail_from_email','{\"$value\":\"inilabsd@inilabs.dev\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(46,'order_setup','order_setup_food_preparation_time','{\"$value\":\"30\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(47,'order_setup','order_setup_schedule_order_slot_duration','{\"$value\":\"30\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(48,'order_setup','order_setup_takeaway','{\"$value\":5,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(49,'order_setup','order_setup_delivery','{\"$value\":5,\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(50,'order_setup','order_setup_free_delivery_kilometer','{\"$value\":\"2\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(51,'order_setup','order_setup_basic_delivery_charge','{\"$value\":\"1\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(52,'order_setup','order_setup_charge_per_kilo','{\"$value\":\"1\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(53,'otp','otp_type','{\"$value\":\"5\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(54,'otp','otp_digit_limit','{\"$value\":\"4\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(55,'otp','otp_expire_time','{\"$value\":\"10\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(56,'theme','theme_logo','{\"$value\":\"\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(57,'theme','theme_favicon_logo','{\"$value\":\"\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(58,'theme','theme_footer_logo','{\"$value\":\"\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(59,'license','license_key','{\"$value\":\"b6d68vy2-m7g5-20r0-5275-h103w73453q120\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(60,'social_media','social_media_facebook','{\"$value\":\"https:\\/\\/www.facebook.com\\/inilabs\\/\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(61,'social_media','social_media_youtube','{\"$value\":\"https:\\/\\/www.youtube.com\\/@inilabs3830\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(62,'social_media','social_media_instagram','{\"$value\":\"https:\\/\\/www.instagram.com\\/inilabsn\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(63,'social_media','social_media_twitter','{\"$value\":\"https:\\/\\/twitter.com\\/inilabsn?lang=en\",\"$cast\":null}',NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `tax_rate` decimal(19,6) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES
(1,'TVA','TVA-0%',0.000000,10,5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(2,'TVA','TVA-12%',12.000000,10,5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41'),
(3,'TVA','TVA-20%',20.000000,10,5,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-02 02:16:41');
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `time_slots`
--

DROP TABLE IF EXISTS `time_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `time_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `opening_time` varchar(255) NOT NULL,
  `closing_time` varchar(255) NOT NULL,
  `day` tinyint(4) NOT NULL,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `time_slots`
--

LOCK TABLES `time_slots` WRITE;
/*!40000 ALTER TABLE `time_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `time_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sign` varchar(255) NOT NULL DEFAULT '+',
  `order_id` bigint(20) unsigned NOT NULL,
  `transaction_no` varchar(255) NOT NULL,
  `amount` decimal(19,6) NOT NULL DEFAULT 0.000000,
  `payment_method` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'payment',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `device_token` varchar(255) DEFAULT NULL,
  `web_token` varchar(255) DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT 0,
  `country_code` varchar(255) DEFAULT NULL,
  `is_guest` tinyint(3) unsigned NOT NULL DEFAULT 10,
  `status` tinyint(3) unsigned NOT NULL DEFAULT 5 COMMENT '5=Active, 10=Inactive',
  `balance` decimal(19,6) NOT NULL DEFAULT 0.000000,
  `creator_type` varchar(255) DEFAULT NULL,
  `creator_id` bigint(20) DEFAULT NULL,
  `editor_type` varchar(255) DEFAULT NULL,
  `editor_id` bigint(20) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'John Doe','admin@example.com','1254875855','admin','2026-06-02 02:16:40','$2y$10$meoevmjSEMOBqKUr94JRKOanOYf8ngWqpye1E0UZ0eTC4.AMi.5eG',NULL,NULL,0,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:12:53',NULL),
(2,'Walking Customer','walkingcustomer@example.com','1254444555','default-customer','2026-06-02 02:16:40','$2y$10$Jffl7Y.aKYcvbHosXBFbGuHH.gBT0lWuCIAO15k/vw4nsok8dhGwu',NULL,NULL,0,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:12:53',NULL),
(3,'Will Smith','customer@example.com','1253333444','will-smith','2026-06-02 02:16:40','$2y$10$gAa0PFL5nrj5gU.wTyA6/e3QfVGpwLJl6JSYANnz/4EVbnJtKjipe',NULL,NULL,0,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:12:53',NULL),
(4,'Kiron Khan','branchmanager@example.com','1275333453','kiron-khan1313','2026-06-02 02:16:40','$2y$10$iOO7y4IHNx6XR9z2WAVRauBFnRNuN1RP0rCO.D0jARGoQmGte8fEK',NULL,NULL,1,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:12:53',NULL),
(5,'Shohag Ali','shohag@example.com','1257654433','shohag-ali3324','2026-06-02 02:16:40','$2y$10$vSn9T3PS7lNtT4Hs3MseP.Sm0ixhtTXAa6dXApV1bVzklWa4duPLG',NULL,NULL,2,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:12:53',NULL),
(6,'Farha Israt ','posoperator@example.com','156873641','farha-istat343','2026-06-02 02:16:40','$2y$10$KqlvHAa7F5f7UN77PYA.Ze95FwAL34WOUSEL5xtdedjvqf0OG9wqK',NULL,NULL,1,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:40','2026-06-04 00:12:53',NULL),
(7,'Sahataz Afnan','sahataz@example.com','1249955570','sahataz-afnan232','2026-06-02 02:16:40','$2y$10$MfzRWarVyMxxYaD1lQGiyehDUWIzJOPnkh81K5QWx/wzVtR/3jMAa',NULL,NULL,2,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 00:12:53',NULL),
(8,'Rohim Miya','stuff@example.com','1222224443','rohim-miya768','2026-06-02 02:16:41','$2y$10$LdlDNkxUvBuoHMObgLoUJ.as9Lp5EOGXrygiCJR4GCTKbWUy0Gllm',NULL,NULL,1,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 00:12:53',NULL),
(9,'Kala Chan','kala@example.com','1238426043','kala-chan890','2026-06-02 02:16:41','$2y$10$wDp6sLoU0/E6WahKdow1F.jnldqPnEgWzmhPcDEIJGWuJatj9KuHO',NULL,NULL,2,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 00:12:53',NULL),
(10,'Sakib Duronto','waiter@example.com','1275333452','sakib-duronto','2026-06-02 02:16:41','$2y$10$LTZc72a10FxpTCXwd8U7nu3xL6VeoW.UI9kCJmkJy..ljiAYmDTbe',NULL,NULL,1,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 00:12:53',NULL),
(11,'Maruf Khan','chef@example.com','1275323453','maruf-khan','2026-06-02 02:16:41','$2y$10$BzhGUZUFAR73MBDR7w1EIeqE53rbuNLdgHdSSgTvxFrijo.f/16NS',NULL,NULL,1,'+212',10,5,0.000000,NULL,NULL,NULL,NULL,NULL,'2026-06-02 02:16:41','2026-06-04 00:12:53',NULL);
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

-- Dump completed on 2026-06-10 12:56:59
