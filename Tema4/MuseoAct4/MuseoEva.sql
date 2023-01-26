drop database if exists BDMUSEOEVA;
CREATE DATABASE if not exists BDMUSEOEVA;
USE BDMUSEOEVA;
/* CREAMOS LAS TABLAS ==> EL ORDEN ES IMPORTANTE (INTEGRIDAD REFERENCIAL) */
/************************************/

create table if not exists artistas
    (codartista int unsigned, -- int(4)
     nomartista varchar(60),
     biografia text,
	 edad tinyint unsigned, -- int(1)
	 fecnacim date,
    constraint pk_artistas primary key (codartista)
    );
create table if not exists tipobras
    (codtipobra int unsigned,
     destipobra varchar(20),
    constraint pk_tipobras primary key (codtipobra)
    );
create table if not exists estilos
    (codestilo int unsigned,
     nomestilo varchar(20),
     desestilo varchar(250),
    constraint pk_estilos primary key (codestilo)
    );

create table if not exists salas
    (codsala int unsigned,
     nomsala varchar(20),
    constraint pk_salas primary key (codsala)
    );

create table if not exists obras
    (codobra int unsigned,
     nomobra varchar(20),
     desobra varchar(100),
     feccreacion date null,
     fecadquisicion date null,
     valoracion decimal (12,2) unsigned,
     codestilo int unsigned,
     codtipobra int unsigned,
     codubicacion int unsigned, -- sala en la que está
    constraint pk_obras primary key (codobra),
    constraint fk_obras_tipobras foreign key (codtipobra)
        references tipobras(codtipobra) 
        on delete no action on update cascade,
    constraint fk_obras_estilos  foreign key (codestilo)
        references estilos(codestilo) 
        on delete no action on update cascade,
    constraint fk_obras_salas foreign key (codubicacion)
        references salas(codsala) 
        on delete no action on update cascade
    );
alter table obras add column codartista int unsigned,
	add constraint fk_obras_artistas foreign key (codartista)
		references artistas(codartista) 
        on delete no action on update cascade;
create table if not exists empleados
    (codemple int unsigned,
     nomemle varchar(20),
     ape1emple varchar(20),
     ape2emple varchar(20) null,
     fecincorp date,
	 tlfempleado char(12),
     numsegsoc char(15),
    constraint pk_empleados primary key (codemple)
    );
create table if not exists seguridad
    (codsegur int unsigned,
     codemple int unsigned,
	 codsala int unsigned,
     observaciones varchar(200),
    constraint pk_seguridad primary key (codsegur),
    constraint fk_seguridad_empleados foreign key (codemple)
        references empleados (codemple) on delete no action on update cascade,
	constraint fk_seguridad_salas foreign key (codsala)
        references salas (codsala) on delete no action on update cascade
    );
create table if not exists restauradores
    (codrestaurador int unsigned,
     codemple int unsigned,
     especialidad varchar(60),
    constraint pk_restauradores primary key (codrestaurador),
    constraint fk_restauradores_empleados foreign key (codemple)
        references empleados (codemple) on delete no action on update cascade
    );
drop table if exists restauraciones;
create table if not exists restauraciones
    (codrestaurador int unsigned,
     codobra int unsigned,
     fecinirestauracion date,
     fecfinrestauracion date null,
	 observaciones text,
    constraint pk_restauraciones primary key 
		(codrestaurador,codobra, fecinirestauracion),
    constraint fk_restestilosestilosauraciones_restauradores foreign key (codrestaurador)
        references restauradores (codrestaurador) on delete no action on update cascade,
    constraint fk_restauraciones_obras foreign key (codobra)
        references obras (codobra) on delete no action on update cascade
    
    );
    
    /*
    crear tabla turnos que se concatena con salas y seguridad en la tabla detalle turno
    detalle turno es la antigua relacion vigilan 
    
    */
    alter table seguridad
    drop column codsala,
    drop constraint  fk_seguridad_salas;
    
    create table turnos
    (
    codTurno int unsigned,
    tipoTurno varchar(6),
    constraint pk_turnos primary key (codTurno)
    
    );
    
CREATE TABLE IF NOT EXISTS detalleturno (
    codsala INT UNSIGNED,
    codTurno int unsigned,
    codsegur INT UNSIGNED,
    fechaIniturno date,
    fechaFinturno date,
    CONSTRAINT PK_seguridad PRIMARY KEY (codsala , codsegur, codTurno, fechaIniturno),
    CONSTRAINT FK_seguridad_salas FOREIGN KEY (codsala)
        REFERENCES salas(codsala)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_seguridad_seguridad FOREIGN KEY (codsegur)
        REFERENCES seguridad(codsegur)
        ON DELETE NO ACTION ON UPDATE CASCADE,
         CONSTRAINT FK_seguridad_turnos FOREIGN KEY (codTurno)
        REFERENCES turnos(codTurno)
        ON DELETE NO ACTION ON UPDATE CASCADE
);





/*
1.- Se ha decidido añadir un campo (jubilacion) en la tabla empleados de forma que cuando un
empleado se jubile, en lugar de borrar los datos de dicho empleado, se mantendrá en nuestra base de
datos pero se almacenará en el nuevo campo la fecha de jubilación.
*/
alter table empleados
add fecjubilacion date null;

/*
5.- Por cuestiones de organización, se ha decidido crear una tabla nueva “obrasmasbuscadas” para
almacenar datos sobre obras que el museo desea adquirir. Nos interesa guardar el nombre y el autor.
*/
create table if not exists obrasmasbuscadas
(
nomObraMas varchar(30),
nomAutorMas varchar(30),
constraint PK_obrasmasbuscadas primary key (nomObraMas)
);
/*
alter table restauradores
drop foreign key fk_restauradores_empleados,
add constraint fk_restauradores_empleados foreign key (codemple)
references empleados (codemple)
on delete no action on update cascade;
*/
/*
alter table obras
add column nomObraMas varchar(30);
alter table obras
add constraint fk_obras_obrasmasbuscadas foreign key (nomObrasMas)
references obrasmasbuscadas  (nomObrasMas)
on delete no action on update cascade;
*/

/*
6.- Debemos añadir a la tabla anterior el estilo, tipo de obra y el valor estimado de compra. Incluir
las restricciones que consideres necesarias.
*/

/*
7.- Elimina las restricciones de la tabla anterior.
*/

/*
8.- Elimina la tabla anterior.
*/
CREATE TABLE IF NOT EXISTS departamentos (
    codDepto INT UNSIGNED,
    nomDept VARCHAR(30),
    CONSTRAINT pk_departamentos PRIMARY KEY (codDepto)
);

alter table empleados 
add column  codDepto INT UNSIGNED,
add constraint fk_empleados_departamentos foreign key(codDepto)
references departamentos (codDepto)
on delete no action on update cascade;

