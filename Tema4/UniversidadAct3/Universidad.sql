drop database if exists UNIVERSIDAD;
create database if not exists UNIVERSIDAD;
use UNIVERSIDAD;
CREATE TABLE IF NOT EXISTS ASIGNATURAS (
    numAsigna varchar(30)  NOT NULL,
    nomAsigna VARCHAR(60),
    curso INT UNSIGNED,
    CONSTRAINT PK_ASIGNATURAS PRIMARY KEY (numAsigna)
);

CREATE TABLE IF NOT EXISTS DEPTOS (
    numDepto VARCHAR(30) NOT NULL,
    presupuesto DECIMAL(8 , 2 ) NOT NULL,
    nomDepto VARCHAR(60),
    ubicacion VARCHAR(60),
    CONSTRAINT PK_DEPTOS PRIMARY KEY (numDepto)
);
CREATE TABLE IF NOT EXISTS PROFESORES (
    numDepto VARCHAR(30) NOT NULL,
    numProf VARCHAR(30) NOT NULL,
    despacho VARCHAR(30) NOT NULL,
    fecNacim DATETIME NULL,
    fecIngreso DATETIME NOT NULL,
    sueldo DECIMAL(6 , 2 ) NOT NULL,
    nomProfe VARCHAR(60) NOT NULL,
    idJefe VARCHAR(30) NULL,
    CONSTRAINT PK_PROFESORES PRIMARY KEY (numProf),
    CONSTRAINT FK_PROFESORES_DEPTOS FOREIGN KEY (numDepto)
        REFERENCES DEPTOS (numDepto)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_PROFESORES_JEFES FOREIGN KEY (idJefe)
        REFERENCES PROFESORES (numProf)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

create table if not exists IMPARTEN
(
   numAsigna varchar(30)  NOT NULL,
	 numProf VARCHAR(30) NOT NULL,
     anio_acad datetime null,
     grupo varchar(30) null,
     
     constraint PK_IMPARTEN primary key (numAsigna, numProf),
     constraint FK_IMPARTEN_ASIGNATURAS foreign key(numAsigna)
		references ASIGNATURAS (numAsigna)
        on delete no action on update cascade ,
        constraint FK_IMPARTEN_PROFESORES foreign key(numProf)
		references PROFESORES (numProf)
        on delete no action on update cascade 

);

/*Actividad 2.1: Modifica ahora el nombre de la restricción asociada a la relación “JEFES”, llámale
“cf_jefes”*/
alter table PROFESORES
rename column idjefe to cf_jefes;