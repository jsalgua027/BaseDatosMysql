/*drop database if exists BDCLASES; para que borre la base de datos*/
/*Creamos la base de datos; 
(if not exist: creamos si no existe, asi no da error si ya esta creada)*/
create database if not exists BDCLASES; 
use BDCLASES;

/*creamos las tablas*/

/*
int numero entero (este es el int4)
int2 un byte-->tinyint
int4 normal
int8
decimal (posiciones totales,posiciones decimales)
unsigned--> para quitarle el signo
null o not null-->para que pueda o no ser nulo
default--> para darle un valor por defecto
char()--> cadena de caracteres con longitud fija
varchar()--> cadena de caracteres con longitud variable 
dateTime--> hora
*/
create table if not exists deptos 
(
codDepto int unsigned not null,
nomDepto varchar(30),
constraint pk_deptos primary key (codDepto)
);

CREATE TABLE IF NOT EXISTS profesorado (
    codDepto INT UNSIGNED NOT NULL,
    codProf INT UNSIGNED NOT NULL,
    nomProf VARCHAR(30) NOT NULL,
    ape1Prof VARCHAR(30) NOT NULL,
    ape2Prof VARCHAR(30) NULL,
    fecIncorporacion DATE NULL,
    codPostal CHAR(5) NULL,
    telefono CHAR(9) NULL,
    CONSTRAINT pk_profesorado PRIMARY KEY (codDepto , codProf),
    CONSTRAINT fk_profesorado_deptos FOREIGN KEY (codDepto)
        REFERENCES deptos (codDepto) -- references -->hago referencia a la tabla  donde la foranea es primaria
        ON DELETE NO ACTION ON UPDATE CASCADE
);
/*
on delete--> cuando borras un dato que hace con los datos relacionados(no action --> no hagas nada)
on update--> cuando actualizas un dato que haces con los relacionados(cascade --> para que lo haga en todos lados)
*/
create table if not exists asignaturas
(
codAsig int unsigned not null,
nomAsig varchar(30) not null,
curso varchar(30) not null,
constraint pk_asignaturas  primary key(codAsig)


);

CREATE TABLE IF NOT EXISTS impartir (
    codAsig INT UNSIGNED NOT NULL,
    codDepto INT UNSIGNED NOT NULL,
    codProf INT UNSIGNED NOT NULL,
    observaciones VARCHAR(100),
    constraint pk_impartir primary key(codAsig, codDepto,codProf),
    CONSTRAINT fk_impartir_asignaturas FOREIGN KEY (codAsig)
        REFERENCES asignaturas (codAsig)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_impartir_profesorado FOREIGN KEY (codDepto , codProf)
        REFERENCES profesorado (codDepto , codProf)
        ON DELETE NO ACTION ON UPDATE CASCADE
);


