-- MySQL dump 10.13  Distrib 8.0.12, for osx10.13 (x86_64)
--
-- Host: localhost    Database: elevage
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Animal`
--

DROP TABLE IF EXISTS `Animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Animal` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `espece` varchar(40) NOT NULL,
  `sexe` char(1) DEFAULT NULL,
  `date_naissance` datetime NOT NULL,
  `nom` varchar(30) DEFAULT NULL,
  `commentaires` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Animal`
--

LOCK TABLES `Animal` WRITE;
/*!40000 ALTER TABLE `Animal` DISABLE KEYS */;
INSERT INTO `Animal` VALUES (1,'chien','F','2008-02-20 15:45:00','Canaille',NULL),(2,'chien','F','2009-05-26 08:54:00','Cali',NULL),(3,'chien','F','2007-04-24 12:54:00','Rouquine',NULL),(4,'chien','F','2009-05-26 08:56:00','Fila',NULL),(5,'chien','F','2008-02-20 15:47:00','Anya',NULL),(6,'chien','F','2009-05-26 08:50:00','Louya',NULL),(7,'chien','F','2008-03-10 13:45:00','Welva',NULL),(8,'chien','F','2007-04-24 12:59:00','Zira',NULL),(9,'chien','F','2009-05-26 09:02:00','Java',NULL),(10,'chien','M','2007-04-24 12:45:00','Balou',NULL),(11,'chien','M','2008-03-10 13:43:00','Pataud',NULL),(12,'chien','M','2007-04-24 12:42:00','Bouli',NULL),(13,'chien','M','2009-03-05 13:54:00','Zoulou',NULL),(14,'chien','M','2007-04-12 05:23:00','Cartouche',NULL),(15,'chien','M','2006-05-14 15:50:00','Zambo',NULL),(16,'chien','M','2006-05-14 15:48:00','Samba',NULL),(17,'chien','M','2008-03-10 13:40:00','Moka',NULL),(18,'chien','M','2006-05-14 15:40:00','Pilou',NULL),(19,'chat','M','2009-05-14 06:30:00','Fiero',NULL),(20,'chat','M','2007-03-12 12:05:00','Zonko',NULL),(21,'chat','M','2008-02-20 15:45:00','Filou',NULL),(22,'chat','M','2007-03-12 12:07:00','Farceur',NULL),(23,'chat','M','2006-05-19 16:17:00','Caribou',NULL),(24,'chat','M','2008-04-20 03:22:00','Capou',NULL),(25,'chat','M','2006-05-19 16:56:00','Raccou','Pas de queue depuis la naissance');
/*!40000 ALTER TABLE `Animal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Personne`
--

DROP TABLE IF EXISTS `Personne`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Personne` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(40) NOT NULL,
  `prenom` char(40) NOT NULL,
  `date_naissance` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personne`
--

LOCK TABLES `Personne` WRITE;
/*!40000 ALTER TABLE `Personne` DISABLE KEYS */;
/*!40000 ALTER TABLE `Personne` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-20 12:41:45
