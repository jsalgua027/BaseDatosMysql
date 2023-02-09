/*
ESQUEMA RELACIONAL:
centros(pk[numce], nomce, dirce)
deptos(pk[numce*, numde],.... [deptodepen, centrodepen]*)
empleados(pk[numem], ...., [numce, numde]*)
dirigir(pk[numem*, [numce,numde]*, fecinidir], fecfindir)

*/
DROP DATABASE IF exists empresaClaseAct1;
CREATE DATABASE if not exists empresaClaseAct1;
USE empresaClaseAct1;
/* CREAMOS LAS TABLAS ==> EL ORDEN ES IMPORTANTE (INTEGRIDAD REFERENCIAL) */
create table if not exists centros
    (numce int,
     nomce varchar(60) not null,
     dirce varchar(120),
    constraint pk_centros primary key (numce)
    );
create table if not exists deptos
    (numde int,
     numce int,
     nomde varchar(60) not null,
     presude decimal (10,2),
    constraint pk_deptos primary key (numde, numce),
    constraint fk_deptos_centros foreign key (numce)
        references centros(numce) 
            on delete no action on update cascade
    );
create table if not exists empleados
    (numem int,
     numde int,
     numce int,
     extelem char(3) null,
     fecnaem date null,
     fecinem date not null,
     salarem decimal (7,2),
     comisem decimal (4,2),
     numhiem tinyint unsigned,
     nomem varchar(20) not null,
     ape1em varchar(20) not null,
     ape2em varchar(20) null,
    constraint pk_empleados primary key (numem),
    constraint fk_empleados_deptos foreign key (numde, numce)
        references deptos (numde, numce)
            on delete no action on update cascade
    );
create table if not exists dirigir
    (numemdir int, -- wejfskjfsjkdf
     numde int,
     numce int,
     fecinidir date,
     fecfindir date null,
    constraint pk_dirigir primary key (numemdir, numde, numce, fecinidir),
    constraint fk_dirigir_empleados foreign key (numemdir)
        references empleados (numem) on delete no action on update cascade,
    constraint fk_dirigir_deptos foreign key (numde, numce)
        references deptos (numde, numce) on delete no action on update cascade
    );

/*  DESPUES DE EJECUTAR DESCUBRIMOS QUE NOS FALTA REPRESENTAR
    LA RELACIÓN DEP (deptos a deptos) */

    ALTER TABLE deptos
        add column deptodepen int,
        add column centrodepen int,
        add constraint fk_deptos_deptos_NEW foreign key (deptodepen, centrodepen)
            references deptos (numde, numce)
                on delete no action on update cascade;
	
/* HACER EL DIAGRAMA DESDE LA VENTANA PRINCIPAL DE WORKBENCH
    DATA - MODELING - CREATE EER MODEL FROM EXISTING DATABASE */

/* INSERCIÓN DE DATOS CON HOJA ADJUNTA ==> EL ORDEN EN EL QUE
              INSERTEMOS LOS DATOS ES IMPORTANTE (POR FOREIGN KEY) */
/*
INSERT INTO centros
    (numce, nomce, dirce)
VALUES
    (10, 'SEDE CENTRAL', 'C/ ALCALÁ 820, MADRID'),
    (20, 'RELACIÓN CON CLIENTES', 'C/ ATOCHA 405, MADRID');
*/
/* AL INSERTAR LOS DATOS EN DEPTOS DESCUBRIMOS QUE FALTA ALGO:
    1.- deptodepen y centrodepen deberían aceptar nulos
    2.- hemos olvidado el tipo de director ==>
        debería ir en la tabla dirigir
*/
/*ALTER TABLE deptos
    change column deptodepen deptodepen int null,
    change column centrodepen centrodepen int null;
*/
/*ALTER TABLE dirigir
    add column tipodir char(1);
*/
/*INSERT INTO deptos
    (numde, numce, nomde, presude, deptodepen, centrodepen)
VALUES
    (100, 10,'DIRECCIÓN GENERAL',12000,NULL,NULL),
    (110, 20, 'DIRECCIÓN COMERCIAL', 15000, 100,10),
    (111,20,'SECTOR INDUSTRIAL',11000,110,20);
*/
insert into empleados
(numem,numde,extelem,fecnaem,fecinem,salarem,comisem,numhiem,nomem,ape1em,ape2em)
VALUES
(110,121,350,'1965-04-30','1985-03-15',1000,null,2,'PEPA','PEREZ',null ),
(120,112,840,'1970-09-10','1995-10-01',1200,50,3,'JUAN', 'LOPEZ', null),
(130,112,810,'1958-03-30','1988-03-01',987,NULL,1,'ANA','GARCIA', NULL),
(150,121,340,'1972-01-15','2001-01-15',856,NULL,0, 'JULIA','VARGAS',NULL),
(160,111,740,'1969-03-18','2002-03-18', 998,NULL,4,'PEPA', 'CANALES',NULL),
(180,110,505,'1971-02-11','1998-02-11',1967,NULL,5,'JUANA','RODRIGUEZ','PEREZ'),
(190,121,350,'1969-01-22','1997-01-22',1174,NULL,0,'LUISA','GOMEZ',null),
(210,100,200,'1964-02-24','1986-02-24',3000,NULL,3,'CESAR','PONS',NULL),
(240,111,760,'1959-03-01','1987-03-01',2145,10,1,'MARIO','LASA',NULL);

select * from empleados;

INSERT INTO centros
    (numce, nomce, dirce)
VALUES
    (10, 'SEDE CENTRAL', 'C/ ALCALÁ 820, MADRID'),
    (20, 'RELACIÓN CON CLIENTES', 'C/ ATOCHA 405, MADRID');
    
    INSERT INTO deptos
    (numde, numce, nomde, presude, deptodepen, centrodepen)
VALUES
    (100, 10,'DIRECCIÓN GENERAL',129000,NULL,NULL),
    (110, 20, 'DIRECCIÓN COMERCIAL', 15000, 100,10),
    (111,20,'SECTOR INDUSTRIAL',90000,110,20),
    (112,20,'SECTOR SERVICIOS',175000,110,20),
    (120,10,'ORGANIZACION',50000,100,10),
    (121,10,'PERSONAL',74000,120,10),
    (122,10,'PROCESO DE DATOS',68000,120,10),
    (130,10,'FINANZAS',85000,100,10);
    
    select * from deptos;