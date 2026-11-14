-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: shop
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
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (103,'Светлана','Сидорова','svetlana.s@email.com','','2024-02-01','2026-03-16 16:18:23'),(107,'Елена','Морозова','elena.m@email.com','+7-495-567-89-01','2024-04-01','2026-03-16 16:18:23'),(110,'Николай','Николаев','n.nikolaev@email.com','+7-495-789-01-23','2024-05-15','2026-03-16 16:18:23');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1003,103,'P005','2024-02-10',1,'delivered'),(1008,107,'P003','2024-03-15',3,'delivered'),(1011,110,'P010','2024-04-10',1,'delivered'),(1014,103,'P006','2024-04-20',1,'shipped'),(1017,107,'P002','2024-05-07',2,'delivered'),(1020,110,'P009','2024-05-15',1,'delivered');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('P001','Ноутбук Dell XPS 13','Электроника','124990.5',15),('P002','Мышь Logitech MX Master 3','Электроника','8990.0',42),('P003','Коврик для мыши большой','Аксессуары','890.0',105),('P004','Монитор Samsung 27\" 4K\"','Электроника','45990.0',8),('P005','Внешний SSD 1TB','Хранение данных','12490.0',23),('P006','USB-C Hub 6-в-1','Аксессуары','3990.0',37),('P007','Клавиатура механическая','Электроника','7990.0',12),('P008','Подставка для ноутбука','Аксессуары','2490.0',56),('P009','Наушники Sony WH-1000XM4','Электроника','28990.0',5),('P010','Wi-Fi роутер TP-Link','Сетевое оборудование','6990.0',19);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-14 10:18:37
