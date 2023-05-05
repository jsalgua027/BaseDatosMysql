-- create database pruebaConexion;
DROP TABLE IF EXISTS `persona`;

CREATE TABLE `persona` (
  `pk` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `fecha_nac` datetime DEFAULT NULL,
  PRIMARY KEY (`pk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

END 
DELIMITER ;