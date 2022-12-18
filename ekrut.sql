-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: ekrut
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `costumer_report`
--

DROP TABLE IF EXISTS `costumer_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `costumer_report` (
  `region` enum('Tel-Aviv','Haifa','Kiryat-Ata','Karmiel','Beer-Sheva') DEFAULT NULL,
  `deviceID` varchar(45) DEFAULT NULL,
  `month` varchar(45) DEFAULT NULL,
  `year` varchar(45) DEFAULT NULL,
  `reportID` varchar(45) NOT NULL,
  PRIMARY KEY (`reportID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costumer_report`
--

LOCK TABLES `costumer_report` WRITE;
/*!40000 ALTER TABLE `costumer_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `costumer_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `costumers`
--

DROP TABLE IF EXISTS `costumers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `costumers` (
  `costumerID` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `creditCard` varchar(45) DEFAULT NULL,
  `subscriberID` varchar(45) DEFAULT NULL,
  `status` enum('APPROVED','NOT APPROVED') DEFAULT NULL,
  PRIMARY KEY (`costumerID`),
  KEY `username_costumers_idx` (`username`),
  CONSTRAINT `username_costumers` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costumers`
--

LOCK TABLES `costumers` WRITE;
/*!40000 ALTER TABLE `costumers` DISABLE KEYS */;
/*!40000 ALTER TABLE `costumers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `costumerAdress` varchar(225) NOT NULL,
  `supplyTimedate` varchar(45) DEFAULT NULL,
  `supplyTimehour` varchar(45) DEFAULT NULL,
  `deliveryStatus` enum('NOT APPROVED','APPROVED','DONE') DEFAULT NULL,
  `orderID` int NOT NULL,
  PRIMARY KEY (`costumerAdress`,`orderID`),
  KEY `orderNumber` (`orderID`),
  CONSTRAINT `orderID_delivery` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `deviceID` varchar(45) NOT NULL,
  `threshold` int DEFAULT NULL,
  `region` enum('Tel-Aviv','Haifa','Kiryat-Ata','Karmiel','Beer-Sheva') DEFAULT NULL,
  `deviceName` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employeeID` varchar(225) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `role` enum('CEO','SalesManager','AreaManager','SalesWorker','DeliveryOP','OpWorker') DEFAULT NULL,
  `region` enum('Tel-Aviv','Haifa','Kiryat-Ata','Karmiel','Beer-Sheva') DEFAULT NULL,
  PRIMARY KEY (`employeeID`),
  KEY `username_employee_idx` (`username`),
  CONSTRAINT `username_employee` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_calls`
--

DROP TABLE IF EXISTS `inventory_calls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_calls` (
  `callID` int NOT NULL,
  `status` enum('OPEN','DONE') DEFAULT NULL,
  `deviceID` varchar(45) DEFAULT NULL,
  `description` varchar(555) DEFAULT NULL,
  PRIMARY KEY (`callID`),
  KEY `deviceID_calls_idx` (`deviceID`),
  CONSTRAINT `deviceID_calls` FOREIGN KEY (`deviceID`) REFERENCES `devices` (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_calls`
--

LOCK TABLES `inventory_calls` WRITE;
/*!40000 ALTER TABLE `inventory_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_calls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_report`
--

DROP TABLE IF EXISTS `inventory_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_report` (
  `reportID` int NOT NULL,
  `month` varchar(45) DEFAULT NULL,
  `year` varchar(45) DEFAULT NULL,
  `deviceID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`reportID`),
  KEY `deviceID_ireport_idx` (`deviceID`),
  CONSTRAINT `deviceID_ireport` FOREIGN KEY (`deviceID`) REFERENCES `devices` (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_report`
--

LOCK TABLES `inventory_report` WRITE;
/*!40000 ALTER TABLE `inventory_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `orderID` int NOT NULL,
  `orderStatus` enum('APPROVED','CANCELED') DEFAULT NULL,
  `orderPrice` float DEFAULT NULL,
  `supplyMethod` enum('Delivery','PickUp','Standart') DEFAULT NULL,
  `costumerID` varchar(45) NOT NULL,
  `deviceID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  KEY `costumerID_orders_idx` (`costumerID`),
  KEY `deviceID_orders_idx` (`deviceID`),
  CONSTRAINT `costumerID_orders` FOREIGN KEY (`costumerID`) REFERENCES `costumers` (`costumerID`),
  CONSTRAINT `deviceID_orders` FOREIGN KEY (`deviceID`) REFERENCES `devices` (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_report`
--

DROP TABLE IF EXISTS `orders_report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_report` (
  `month` varchar(45) DEFAULT NULL,
  `year` varchar(45) DEFAULT NULL,
  `deviceID` varchar(45) DEFAULT NULL,
  `numOfTotalOrders` int DEFAULT NULL,
  `mostWantedProduct` varchar(225) DEFAULT NULL,
  `reportID` int NOT NULL,
  PRIMARY KEY (`reportID`),
  KEY `deviceID_ordersRep_idx` (`deviceID`),
  CONSTRAINT `deviceID_ordersRep` FOREIGN KEY (`deviceID`) REFERENCES `devices` (`deviceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_report`
--

LOCK TABLES `orders_report` WRITE;
/*!40000 ALTER TABLE `orders_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_report` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_in_device`
--

DROP TABLE IF EXISTS `product_in_device`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_in_device` (
  `productCode` int NOT NULL,
  `deviceID` varchar(45) NOT NULL,
  `quantity` int DEFAULT NULL,
  `status` enum('AVAILABLE','NOT AVAILABLE') DEFAULT NULL,
  PRIMARY KEY (`productCode`,`deviceID`),
  KEY `deviceID_pid_idx` (`deviceID`),
  CONSTRAINT `deviceID_pid` FOREIGN KEY (`deviceID`) REFERENCES `devices` (`deviceID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productCode_pid` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_in_device`
--

LOCK TABLES `product_in_device` WRITE;
/*!40000 ALTER TABLE `product_in_device` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_in_device` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_in_order`
--

DROP TABLE IF EXISTS `product_in_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_in_order` (
  `orderID` int NOT NULL,
  `productCode` int NOT NULL,
  `quantity` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`orderID`,`productCode`),
  KEY `productCode_pio_idx` (`productCode`),
  CONSTRAINT `orderID_pio` FOREIGN KEY (`orderID`) REFERENCES `orders` (`orderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productCode_pio` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_in_order`
--

LOCK TABLES `product_in_order` WRITE;
/*!40000 ALTER TABLE `product_in_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_in_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `productCode` int NOT NULL,
  `productName` varchar(225) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `imagePath` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `startDate` varchar(45) DEFAULT NULL,
  `endDate` varchar(45) DEFAULT NULL,
  `region` enum('Tel-Aviv','Haifa','Kiryat-Ata','Karmiel','Beer-Sheva') DEFAULT NULL,
  `saleID` varchar(45) NOT NULL,
  `patternID` varchar(225) NOT NULL,
  `startHour` varchar(225) DEFAULT NULL,
  `endHour` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`saleID`),
  KEY `patternID_sales_idx` (`patternID`),
  CONSTRAINT `patternID_sales` FOREIGN KEY (`patternID`) REFERENCES `sales_patterns` (`patternID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales_patterns`
--

DROP TABLE IF EXISTS `sales_patterns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales_patterns` (
  `patternID` varchar(225) NOT NULL,
  `discountPrecent` float DEFAULT NULL,
  PRIMARY KEY (`patternID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales_patterns`
--

LOCK TABLES `sales_patterns` WRITE;
/*!40000 ALTER TABLE `sales_patterns` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales_patterns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phoneNumber` varchar(45) NOT NULL,
  `isLoggedIn` tinyint(1) NOT NULL,
  `id` varchar(45) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2022-12-17 16:55:51
