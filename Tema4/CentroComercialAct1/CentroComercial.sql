drop database if exists centrocomercial;
create database if	not exists CENTROCOMERCIAL;
use CENTROCOMERCIAL;

CREATE TABLE IF NOT EXISTS EMPLEADOS (
    numEmpleado VARCHAR(30) NOT NULL,
    extelefon VARCHAR(4) NULL,
    fecNacim DATETIME NULL,
    fecIngreso DATETIME NULL,
    salario DECIMAL(6 , 2 ) unsigned NOT NULL,
    comision DECIMAL(4 , 2 )  unsigned not null,
    numHijos INT NULL,
    nomemp VARCHAR(60) NOT NULL,
    CONSTRAINT PK_EMPLEADOS PRIMARY KEY (numEmpleado)
);


CREATE TABLE IF NOT EXISTS CENTROS (
    numCentro VARCHAR(30) NOT NULL,
    nomCentro VARCHAR(60) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    CONSTRAINT PK_CENTROS PRIMARY KEY (numCentro)
);

CREATE TABLE IF NOT EXISTS DEPTOS (
    numCentro VARCHAR(30) NOT NULL,
    numDepto VARCHAR(30) NOT NULL,
    presupuesto DECIMAL(10 , 2 ) NULL,
    nomDepto VARCHAR(30) NOT NULL,
    depende VARCHAR(30) NULL,
    CONSTRAINT PK_DEPTOS PRIMARY KEY (numCentro , numDepto),
    CONSTRAINT FK_DEPTOS_CENTROS FOREIGN KEY (numCentro)
        REFERENCES CENTROS (numCentro)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DEPTOS_DEPENDE FOREIGN KEY (depende)
        REFERENCES DEPTOS ( numCentro, numDepto)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
