CREATE DATABASE  IF NOT EXISTS `full-stack-ecommerce-tech` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `full-stack-ecommerce-tech`;
-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: full-stack-ecommerce-tech
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (27,'sfdsf','Brazil','Acre','fsfsf','19111'),(28,'afasa','Canada','Alberta','afasa','afasa'),(29,'','','','',''),(30,'','','','',''),(31,'','','','',''),(32,'','','','',''),(33,'','','','',''),(34,'JOHANNESBURG','South Africa','Gauteng','6300 TSUTSUMANI STREET EXT9','2090'),(35,'JOHANNESBURG','South Africa','Eastern Cape','6300 TSUTSUMANI STREET EXT9','2090'),(36,'JOHANNESBURG','South Africa','Kwa Zulu-Natal','6300 TSUTSUMANI STREET EXT9','2090'),(37,'JOHANNESBURG','South Africa','Kwa Zulu-Natal','6300 TSUTSUMANI STREET EXT9','2090');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (14,'afasa','afasa','afasa@test.com'),(15,'Athenkosi','Jonase','athenkosijonase7@gmail.com'),(16,'Lwazi','kayizana','athenkosijonase7@gmail.com'),(17,'Lwazi','kayizana','athenkosijonase7@gmail.com'),(18,'Athenkosi','Jonase','athenkosijonase7@gmail.com'),(19,'Athenkosi','Jonase','218253737@edu.vut.ac.za'),(20,'Athenkosi','Jonase','218253737@edu.vut.ac.za'),(21,'Athenkosi','Jonase','218253737@edu.vut.ac.za'),(22,'Athenkosi','Jonase','218253737@edu.vut.ac.za');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(19,2) DEFAULT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `K_order_id` (`order_id`),
  KEY `FK_product_id` (`product_id`),
  CONSTRAINT `FK_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (3,'assets/images/products/Headphones/001.png',1,18.99,14,26),(4,'assets/images/products/Headphones/001.png',1,17.99,14,27),(5,'assets/images/products/Laptops/001.png',3,10999.00,15,NULL),(6,'assets/images/products/Laptops/009.png',3,19999.00,16,NULL),(7,'assets/images/products/Laptops/009.png',3,19999.00,17,NULL),(8,'assets/images/products/Laptops/003.png',3,5499.00,18,NULL),(9,'assets/images/products/Phones/006.png',3,1499.00,19,NULL),(10,'assets/images/products/Headphones/003.png',3,145.00,20,NULL),(11,'assets/images/products/Laptops/001.png',2,10999.00,21,NULL),(12,'assets/images/products/Laptops/001.png',1,10999.00,22,NULL);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_tracking_number` varchar(255) DEFAULT NULL,
  `total_price` decimal(19,2) DEFAULT NULL,
  `total_quantity` int DEFAULT NULL,
  `billing_address_id` bigint DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL,
  `shipping_address_id` bigint DEFAULT NULL,
  `status` varchar(128) DEFAULT NULL,
  `date_created` datetime(6) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_billing_address_id` (`billing_address_id`),
  UNIQUE KEY `UK_shipping_address_id` (`shipping_address_id`),
  KEY `K_customer_id` (`customer_id`),
  CONSTRAINT `FK_billing_address_id` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FK_shipping_address_id` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (14,'e0d63efc-f954-4e27-b889-ecc34fef8afe',36.98,2,27,14,28,NULL,'2022-08-12 05:53:17.774000','2022-08-12 05:53:17.774000'),(15,'bc8c2c3f-54f0-4908-989e-0cd3d0abc0c0',32997.00,3,NULL,15,29,NULL,'2022-08-12 10:28:23.369000','2022-08-12 10:28:23.369000'),(16,'8cd7f0f3-e245-4f7c-98ba-f51e5bef7058',59997.00,3,NULL,16,30,NULL,'2022-08-12 13:31:37.504000','2022-08-12 13:31:37.504000'),(17,'2e95d24b-edb3-495d-b68d-08d17428ca32',59997.00,3,NULL,17,31,NULL,'2022-08-12 13:31:59.917000','2022-08-12 13:31:59.917000'),(18,'f461af22-5789-4e73-8775-b38cc999fa9c',16497.00,3,NULL,18,32,NULL,'2022-08-12 15:17:08.508000','2022-08-12 15:17:08.508000'),(19,'8714ca75-972c-4ddc-ac55-8ecb5f8d1c2a',4497.00,3,NULL,19,33,NULL,'2022-08-13 09:59:09.275000','2022-08-13 09:59:09.275000'),(20,'debc05f0-da6a-4938-8e01-12af157f1ef7',435.00,3,NULL,20,34,NULL,'2022-08-16 10:25:09.055000','2022-08-16 10:25:09.055000'),(21,'180bbb83-b4ed-49f8-8adc-7f55337948c8',21998.00,2,NULL,21,35,NULL,'2022-08-16 10:49:06.562000','2022-08-16 10:49:06.562000'),(22,'ef4a2f1b-3f17-4ed2-b260-0572976f9bf8',10999.00,1,36,22,37,NULL,'2022-08-16 11:53:37.514000','2022-08-16 11:53:37.514000');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `unit_price` decimal(13,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Lenovo Ideal 3 core i7 1165G7 8GB','Upgradeable to windows 11 home. 8GB RAM and 1 TB HDD storage.Intel Core i7. 1165G7 processor',10999.00,'assets/images/products/Laptops/001.png',1),(2,'Lenovo Ideal 3 Core i5 1113G7 8GB','16 inch full HD display',8999.00,'assets/images/products/Laptops/002.png',1),(3,'Asus X415 Celeron Laptop 8GB 256GB','Windows 11 Home. 14 inch HD Display. 8 GB RAM. Intel graphics',5499.00,'assets/images/products/Laptops/003.png',1),(4,'Lenovo Ideapad 3 i3 10110U 4GB','Upgradeable to windows 11 Home. 15-6 inch full HD Display. 4GB RAM and Full HD dispaly',6999.00,'assets/images/products/Laptops/004.png',1),(5,'HP 15 Core i5 1135G7 8GB RAM','Windows 11 Home. 15-6 inch Full HD Display',9999.00,'assets/images/products/Laptops/005.png',1),(6,'Predator Helios 500 Core i9 32GB 1TB SSD','11th Gen Intel Core i9 processor. 120Hz refresh- you can see why Hellos is heralding in the future of gaming',79999.00,'assets/images/products/Laptops/006.png',1),(7,'Lenovo flex 5 Chromeback Core i3 8GB','Google Chrome OS. 13-3 inch Full inch HD Display',14999.00,'assets/images/products/Laptops/007.png',1),(8,'Acer Aspire 5 Core i3 1115GB 8GB 256GB','Upgradeable to windows 11 Home. 14 inch Full HD Display. 8GB RAM and 256GB SSD Storage',10999.00,'assets/images/products/Laptops/007.png',1),(9,'Lenovo Flex 5 Chromebook Core i5','Chrome OS. 13-3 inch Full HD Touch Display. 8GB RAM and 256GB SSD Storage',16999.00,'assets/images/products/Laptops/008.png',1),(10,'Acer Chromebook spin 713 Core i5','Google chrome OS. 13-5 INCH 3.39MA Multi Touch Display',19999.00,'assets/images/products/Laptops/009.png',1),(11,'ASUS X515 Core i5 103G7 8GB RAM','256GB SSD Storage Laptop. Windows 11 Home. 8GB RAM and 256GB SSD Storage',10999.00,'assets/images/products/Laptops/010.png',1),(12,'Acer swift 1 pentlum 4GB Pentium 4GB','14 inch IPS FHD. Intel pentiun Silver N6000 Processor. Windows home upgradeable',6999.00,'assets/images/products/Laptops/011.png',1),(13,'HP Pavilion Gaming Ryzen 5 5600H 8GB','Windows 11 Home. 15-6 inch Full HD. 8GB RAM and 512GB SSD Storage',14999.00,'assets/images/products/Laptops/012.png',1),(14,'Acer spin 1 Pentium N5000 4GB RAM 128GB','Upgradebale to windows 11 Home. Intel HD Graphics. 4GB RAM and 128GB eMMC Storage',10999.00,'assets/images/products/Laptops/013.png',1),(15,'HP Pavilion i5 Core 1155G7 16GB RAM','Windows 11 home. 15-6 inch Full HD Display',16999.00,'assets/images/products/Laptops/014.png',1),(16,'HP Pavilion 14 x360 Core i5 1155G7 8GB RAM','Windows 11 Home. 14 inch Full HD Display. Intel iris Xe Graphics',19999.00,'assets/images/products/Laptops/016.png',1),(17,'Samsung Galaxy A03 Core','8MP CAMERA. 8.5 inch HD V Cut Display',1499.00,'assets/images/products/Phones/001.png',2),(18,'Techno POP 2 X Auro Blue Network Locked','5.5 inch 18:9 FullView. Dual rear camera. 4G LTE',499.00,'assets/images/products/Phones/002.png',2),(19,'Hisense Infinity H50 Zoom Black Pearl LTE VC','4000mAh Battery. 4G. 16 mp Front Camera. RAM:6GB:ROM:128GB',6299.00,'assets/images/products/Phones/003.png',2),(20,'Huawei Y5p Midnight Black','3020Mah Bettery Capacity. 32GB Ram memory. 5.45 inch HUAWEI Fullview Display',1699.00,'assets/images/products/Phones/004.png',2),(21,'OPPO A16s Pearl Blue 4G SS VC','500mAh ai Beautification. Android 11 with GMS + COLOR OS7. 2 years warranty',3649.00,'assets/images/products/Phones/005.png',2),(22,'Samsung Galaxy A03 Core Blue DS LTE','Android 10.0. 8MP Main Camera. 2GB RAM + 32GB ROM',1499.00,'assets/images/products/Phones/006.png',2),(23,'Vivo Y21s Pearl White DS','5000mAh Battery 1BW Fast. 8MP Front Camera. Android OS 11, Function 11.5',4649.00,'assets/images/products/Phones/007.png',2),(24,'Vivo Y33s Mirror Black 128GB 4G','5000mAh Battery 18W Fast Charge. 16MP Front Camera. 2years warranty',4999.00,'assets/images/products/Phones/008.png',2),(25,'Techno Spark 7 Morpeus Blue 64GB','5000mAh Battery Size. 8MP Front Camera. Android 11',2499.00,'assets/images/products/Phones/009.png',2),(26,'Vivo y21s Midnight Blue 128GB SS 4G','5000mAh Battery 18W Fast. 8MP Front Camera. Android OS 11. Funtouch 11.5',4649.00,'assets/images/products/Phones/010.png',2),(27,'Huawei nova 8i Moonlight Silver + powerb','4300MaH Battery Capacity. 4g. 16MP Front Camera. Android Q',6949.00,'assets/images/products/Phones/011.png',2),(28,'Hisense E60 Black Dual Sim VS','5150MaH Battery Capacity. 8MP Front Camera. Andiod 11. 2 years warranty',2699.00,'assets/images/products/Phones/012.png',2),(29,'Earbud Earphones H5 - White','6 months limited warranty. Hassle Free Exchange & return for 30 days',83.00,'assets/images/products/Headphones/001.png',3),(30,'Skullcandy jib In-Ear Earphones','12 months warranty. Stock will arrive after two weeks. No delivary',99.00,'assets/images/products/Headphones/002.png',3),(31,'Wireless In-Ear Earphones','Suitable for iOS & Android with charging Case. 6 month limited warranty',145.00,'assets/images/products/Headphones/003.png',3),(32,'Personalised Name Wireless Earbuds','Free delivary for customers around Johannesburg. Gift for a friend. 12 Month limited warranty',499.00,'assets/images/products/Headphones/004.png',3),(33,'JBL Tune 110 In Ear Wired Headphone','Are you a jogger? then this is for you. limited stock available',199.00,'assets/images/products/Headphones/005.png',3),(34,'True Shake Series True Wireless Earphones','Bounce True Shake Series True Wireless Earphones give 3 to 4 hours of playback time',239.00,'assets/images/products/Headphones/006.png',3),(35,'Quality Waterproof Wireless F95 Sport Earpod','Hassle-free Exchange & return within 30 days. 6 month warranty',285.00,'assets/images/products/Headphones/007.png',3),(36,'Volkano Headphones with Mic Falcon Series White','Hassle-free Exchange & Return within 30 days. 12 month limited warranty',149.00,'assets/images/products/Headphones/008.png',3),(37,'Earphones Compile with iPhone','Hassle-free Exchange & return within 30 days. 6 month limited warranty',74.00,'assets/images/products/Headphones/009.png',3),(38,'JBL Wave 200TWS True Wireless Bluetooth In-Ear','Powerful JBL deep base sound & all the freedom of true wireless for up to 20 hours with the JBL Wave',1199.00,'assets/images/products/Headphones/010.png',3),(39,'Volkano Impulse Bluetooth Haedphones White','Volkano Impulse Bluetooth Haedphones White packs a number of features in its sleek design',349.00,'assets/images/products/Headphones/011.png',3),(40,'Bounce Clef 2.0 Series True Wireless Earphones pads White','Bounce Clef 2.0 Series True Wireless Earphones pads White offers a wireless listening experience and deliver an excellent sound',239.00,'assets/images/products/Headphones/012.png',3),(41,'SUPA FLY Wireless Earbuds Black','Hassle-free Exchange & return within 30 days. 6 month limited warranty. Can be unlocked with fingerprints',199.00,'assets/images/products/Headphones/013.png',3),(42,'Compitable with iPhone Airpods Pro','Hassle-free Exchange & return within 30 days. 6 month limited warranty. Suitable for Android and iPhone Pro',219.00,'assets/images/products/Headphones/014.png',3),(43,'Sennheiser Momentum M3 In-Ear Wireless Earphones','A new dimension in wearble sound. Uncompromised sound performance. State of the art technology',5999.00,'assets/images/products/Headphones/015.png',3),(44,'Audio-Technica Bluetooth Sports Headphones(Rose Gold)','These wireless bluetooth sport earphones Sports earphones in Rose Gold let you fuel your workout with clear, powerful music',2700.00,'assets/images/products/Headphones/016.png',3);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
INSERT INTO `product_category` VALUES (1,'Laptops'),(2,'Phones'),(3,'Headphones');
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-17 10:21:34
