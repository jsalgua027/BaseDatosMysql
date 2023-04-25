CREATE DATABASE  IF NOT EXISTS `cadcafeterias` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cadcafeterias`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: cadcafeterias
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `cafeterias`
--

DROP TABLE IF EXISTS `cafeterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cafeterias` (
  `codcafet` int NOT NULL DEFAULT '0',
  `nomcafet` varchar(40) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `poblacion` varchar(40) DEFAULT NULL,
  `codpostal` char(5) DEFAULT NULL,
  `tlfcontacto` char(9) DEFAULT NULL,
  `razonsocial` char(12) DEFAULT NULL,
  PRIMARY KEY (`codcafet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cafeterias`
--

LOCK TABLES `cafeterias` WRITE;
/*!40000 ALTER TABLE `cafeterias` DISABLE KEYS */;
INSERT INTO `cafeterias` VALUES (1,'LOS SUEÑOS','PLAZA LOS SUEÑOS','ESTEPONA','29680','951000000','ZWQ123456'),(2,'PA PICA','PLAZA EL VIENTO','ESTEPONA','29680','678111111','');
/*!40000 ALTER TABLE `cafeterias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comandas`
--

DROP TABLE IF EXISTS `comandas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comandas` (
  `codcomanda` int NOT NULL DEFAULT '0',
  `fechacomanda` date DEFAULT NULL,
  `codemp` int DEFAULT NULL,
  `codcafet` int DEFAULT NULL,
  `codturno` int DEFAULT NULL,
  `codservi` int DEFAULT NULL,
  `importe` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`codcomanda`),
  KEY `fk_comandas_personal` (`codemp`,`codcafet`),
  KEY `fk_comandas_turnos` (`codturno`),
  KEY `fk_comandas_servicios` (`codservi`),
  CONSTRAINT `fk_comandas_personal` FOREIGN KEY (`codemp`, `codcafet`) REFERENCES `personal` (`codemp`, `codcafet`),
  CONSTRAINT `fk_comandas_servicios` FOREIGN KEY (`codservi`) REFERENCES `servicios` (`codservi`),
  CONSTRAINT `fk_comandas_turnos` FOREIGN KEY (`codturno`) REFERENCES `turnos` (`codturno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comandas`
--

LOCK TABLES `comandas` WRITE;
/*!40000 ALTER TABLE `comandas` DISABLE KEYS */;
INSERT INTO `comandas` VALUES (1,'2020-02-12',1,1,1,2,12.00),(2,'2020-02-12',2,1,1,1,9.00),(3,'2020-02-13',1,2,1,3,25.00),(4,'2020-02-14',2,2,2,1,35.00),(5,'2020-02-14',2,2,2,1,29.00);
/*!40000 ALTER TABLE `comandas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal`
--

DROP TABLE IF EXISTS `personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal` (
  `codemp` int NOT NULL DEFAULT '0',
  `codcafet` int NOT NULL DEFAULT '0',
  `nomemp` varchar(20) DEFAULT NULL,
  `ape1emp` varchar(20) DEFAULT NULL,
  `ape2emp` varchar(20) DEFAULT NULL,
  `diremp` varchar(100) DEFAULT NULL,
  `tlfcontacto` char(9) DEFAULT NULL,
  `numsegsocial` char(20) DEFAULT NULL,
  `sueldo_por_dias` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`codemp`,`codcafet`),
  KEY `fk_empleados_cafeterias` (`codcafet`),
  CONSTRAINT `fk_empleados_cafeterias` FOREIGN KEY (`codcafet`) REFERENCES `cafeterias` (`codcafet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal`
--

LOCK TABLES `personal` WRITE;
/*!40000 ALTER TABLE `personal` DISABLE KEYS */;
INSERT INTO `personal` VALUES (1,1,'PEPE','GARCÍA','','','','',75.00),(1,2,'JUAN','SÁNCHEZ','','','','',80.00),(2,1,'MARÍA','LÓPEZ','','','','',75.00),(2,2,'LUISA','TORRES','','','','',80.00),(3,1,'JORGE','CAMPOS','','','','',80.00),(4,1,'JAIME','SÁNCHEZ','','','','',80.00),(5,1,'CARMEN','FLORES','','','','',80.00),(6,1,'MARÍA','PIEDRA','','','','',80.00),(7,1,'JOSE Mª','COBOS','','','','',80.00),(8,1,'Mª JOSÉ','LÓPEZ','','','','',80.00),(9,1,'VICENTE','SARDÁ','','','','',90.00),(10,1,'MIGUEL','PÉREZ','','','','',90.00),(11,1,'ELENA','SÁNCHEZ','','','','',90.00),(12,1,'LUCÍA','SÁNCHEZ','','','','',90.00);
/*!40000 ALTER TABLE `personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servicios` (
  `codservi` int NOT NULL DEFAULT '0',
  `descripcion` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`codservi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'BARRA'),(2,'TERRAZA'),(3,'MESAS INTERIOR'),(4,'COCINA');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socios` (
  `codsocio` int NOT NULL DEFAULT '0',
  `codcafet` int DEFAULT NULL,
  `nomsocio` varchar(20) DEFAULT NULL,
  `ape1socio` varchar(20) DEFAULT NULL,
  `ape2socio` varchar(20) DEFAULT NULL,
  `dirpostal` varchar(100) DEFAULT NULL,
  `poblacion` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `tlfcontacto` char(9) DEFAULT NULL,
  PRIMARY KEY (`codsocio`),
  KEY `fk_socios_cafeterias` (`codcafet`),
  CONSTRAINT `fk_socios_cafeterias` FOREIGN KEY (`codcafet`) REFERENCES `cafeterias` (`codcafet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (1,1,'María',NULL,NULL,NULL,NULL,NULL,NULL),(2,1,'Juan','',NULL,NULL,NULL,NULL,NULL),(3,2,'Miguel',NULL,NULL,NULL,NULL,NULL,NULL),(4,2,'Sofía',NULL,NULL,NULL,NULL,NULL,NULL),(5,1,'Elsa',NULL,NULL,NULL,NULL,NULL,NULL),(6,1,'Álvaro',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos`
--

DROP TABLE IF EXISTS `turnos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turnos` (
  `codturno` int NOT NULL DEFAULT '0',
  `descripcion` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`codturno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos`
--

LOCK TABLES `turnos` WRITE;
/*!40000 ALTER TABLE `turnos` DISABLE KEYS */;
INSERT INTO `turnos` VALUES (1,'MAÑANA'),(2,'TARDE'),(3,'NOCHE');
/*!40000 ALTER TABLE `turnos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turnos_emple`
--

DROP TABLE IF EXISTS `turnos_emple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turnos_emple` (
  `codemp` int NOT NULL DEFAULT '0',
  `codcafet` int NOT NULL DEFAULT '0',
  `dia_desde` date NOT NULL DEFAULT '0000-00-00',
  `dia_hasta` date DEFAULT NULL,
  `codservi` int DEFAULT NULL,
  `codturno` int DEFAULT NULL,
  PRIMARY KEY (`codemp`,`codcafet`,`dia_desde`),
  KEY `fk_turnos_emple_servicios` (`codservi`),
  KEY `fk_turnos_emple_turnos` (`codturno`),
  CONSTRAINT `fk_turnos_emple_personal` FOREIGN KEY (`codemp`, `codcafet`) REFERENCES `personal` (`codemp`, `codcafet`),
  CONSTRAINT `fk_turnos_emple_servicios` FOREIGN KEY (`codservi`) REFERENCES `servicios` (`codservi`),
  CONSTRAINT `fk_turnos_emple_turnos` FOREIGN KEY (`codturno`) REFERENCES `turnos` (`codturno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turnos_emple`
--

LOCK TABLES `turnos_emple` WRITE;
/*!40000 ALTER TABLE `turnos_emple` DISABLE KEYS */;
INSERT INTO `turnos_emple` VALUES (1,1,'2013-11-25','2013-12-01',1,1),(2,1,'2013-11-25','2013-12-01',2,1),(3,1,'2013-11-25','2013-12-01',3,1),(4,1,'2013-11-25','2013-12-01',4,1),(5,1,'2013-11-25','2013-12-01',1,2),(6,1,'2013-11-25','2013-12-01',2,2),(7,1,'2013-11-25','2013-12-01',3,2),(8,1,'2013-11-25','2013-12-01',4,2),(9,1,'2013-11-25','2013-12-01',2,1),(10,1,'2013-11-25','2013-12-01',3,1),(11,1,'2013-11-25','2013-12-01',4,1),(12,1,'2013-11-25','2013-12-01',2,2);
/*!40000 ALTER TABLE `turnos_emple` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-24  0:26:06