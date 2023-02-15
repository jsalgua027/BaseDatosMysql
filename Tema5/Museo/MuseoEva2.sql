drop database if exists BDMUSEOEVA2;
CREATE DATABASE if not exists BDMUSEOEVA2;
USE BDMUSEOEVA2;
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

alter table restauradores
drop foreign key fk_restauradores_empleados,
add constraint fk_restauradores_empleado foreign key (codemple)
references empleados (codemple)
on delete no action on update cascade;

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
/*** CAMBIOS EN FOREIGN KEY  ****/

/* A. Queremos que si se elimina un empleado, 
	  se elimine el 
	  restaurador/vigilante relacionado
*/
/*
alter table restauradores
	drop foreign key fk_restaurador_emple,
	drop foreign key fk_restauradores_emple,
	add constraint fk_restauradores_empleados 
		foreign key (codemple) references empleados (codemple) 
			on delete cascade on update cascade;

alter table seguridad
	drop foreign key fk_restauradores_seguridad,
	add constraint fk_restauradores_seguridad 
		foreign key (codemple) references empleados (codemple) 
			on delete cascade on update cascade;


/* B. No vamos a permitir que se modifique 
	el código de estilo
	  de una obra, en todo caso se le asignará el valor nulo
*/


/*
alter table obras
 	 -- drop foreign key fk_obras_estilos_new,
	drop foreign key fk_obras_estilos,
	add constraint fk_obras_estilos foreign key (codestilo)
		references estilos(codestilo)
		on delete no action
		on update SET NULL;

/* C. Vamos a permitir que se eliminen artistas, en este caso
	  las obras se quedarán sin autor
*/
/*
alter table obras
	drop foreign key fk_obras_artistas,
	add constraint fk_obras_artistas foreign key (codartista)
		references artistas(codartista)
			on delete set null on update cascade;

/* D. Vamos a permitir que se eliminen artistas, en este caso
	  las obras se quedarán sin autor, pero, una vez que demos
	de alta una obra, el código de artista no podrá cambiar
*/
/*
alter table obras
	drop foreign key fk_obras_artistas,
	add constraint fk_obras_artistas foreign key (codartista)
		references artistas(codartista)
			on delete set null on update no action;
     */
     
    /*
   
    */ 
    delete  from  artistas
    where codartista=0;
    ;
    insert INTO artistas
    values
    (codartista,nomartista,biografia,edad,fecnacim),
    (1,'VICENT BAN GOH','......',32,'1925-02-03'),
    (2,'EVA GONZALES','......',33,'1926-02-03'),
      (3,'RAFAEL MENGS','......',40,'1892-02-03'),
       (4,'PABLO RUIZ PICASSO','......',23,'1927-02-03'),
        (5,'SALVADOR DALI','......',25,'1985-02-03'),
         (6,'JOAN MIRO','......',42,'1932-02-03');
     
    
     select * from artistas;
     
      insert into tipobras
     value
     (codtipobra,destipobra),
     (1,'PINTURA'),
     (2,'ESCULTURA');
     
     INSERT INTO estilos
     value
     (codestilo,nomestilo,desestilo),
     (1,'ABSTRACTO', '.......'),
      (2,'REALISMO', '.......'),
       (3,'SURREALISMO', '.......'),
        (4,'IMPRESIONISMO', '.......'),
         (5,'BARROCO', '.......'),
          (6,'POP', '.......'),
           (7,'EXPRESIONISMO', '.......'),
            (8,'DETALLISMO', '.......'),
             (9,'NEOCLASICISMO', '.......');
     
     delete from salas
     where codsala>0;
     
     insert INTO salas
     value
     (codsala,nomsala),
     (1,'primera sala'),
      (2,'segunda sala'),
      (3,'tercera sala'),
       (4,'cuarta sala'),
      (5,'quinta sala'),
       (6,'almacen 1'),
	  (7,'almacen 2'),
	 (8,'des_restauración 1'),
	  (9,'des_restauración 2');
      
      
      delete from obras
      where codobra>0;
      
     insert into obras
     value
     (codobra,nomobra,desobra,feccreacion,fecadquisicion, valoracion,codestilo,codtipobra,codubicacion,codartista),
     (1,'LA MASIA','.....',null,null,700000,8,1,1,6),
     (2,'CABEZA FUMADOR','......',NULL,NULL,400000,3,1,1,6),
     (3,'LA PERSISTENCIA', '....',NULL,NULL,0,3,1,2,5),
     (4,'TRITÓN ALADO','....',NULL,NULL,0,3,2,3,5),
     (5,'ANGEL SURREALISTA', '......',NULL,NULL,0,3,2,3,5),
     (6,'LA SOMBRERERA', '....',NULL,NULL,0,4,1,2,2),
     (7,'GRANJA EN RABAIS', '....',NULL,NULL,0,4,1,1,2),
     (8,'TE POR LA TARDE', '....',NULL,NULL,0,4,1,5,2),
      (9,'EL TRIUNFO AURORA', '....',NULL,NULL,0,9,1,4,3);
      
      insert INTO departamentos
      values
      (codDepto,nomDept),
      (1,'ADMINISTRACION'),
	  (2,'GERENCIA'),
		(3,'SEGURIDAD'),
            (4,'LIMPIEZA'); 
            
            
      delete from empleados
      where codemple=0;
      
       delete from empleados
      where codemple>100;
     select * from empleados;
    insert into empleados
    value
    (codemple,nomemle,ape1emple,ape2emple,fecincorp,tlfempleado,numsegsoc,fecjubilacion,codDepto),
    (110,'PEPA','PEREZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (120,'JUAN','LOPEZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (130,'ANA','GARCIA', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (150,'JULIA','VARGAS', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (160,'PEPA','CANALES', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (180,'JUANA','RODRIGUEZ', 'PEREZ','2023-02-15','95222222','12345','2040-02-01',1),
    (190,'LUISA','GOMEZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (210,'CESAR','PONS', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (240,'MARIO','LASA', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (250,'LUCIANO','TEROL', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (260,'JULIO','PEREZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (270,'AUREO','AGIRRE', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (280,'MARCO','PEREZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (285,'JULIANA','VEIGA', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (290,'PILAR','GALVEZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (310,'LAVINIA','SANZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (320,'ADRIANA','SALBA', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (330,'ANTONIO','LOPEZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (350,'OCTAVIO','GARCIA', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (360,'DOROTEA','FLOR', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (370,'OTILIA','POLO', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (380,'GLORIA','GUIL', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (390,'AUGUSTO','GARCIA', NULL,'2023-02-15','95222222','12345','2040-02-01',1),
    (400,'CORNELIO','SANZ', NULL,'2023-02-15','95222222','12345','2040-02-01',1);
    
    
    delete from seguridad
    where codsegur>0;
     delete from seguridad
    where codsegur=0;
    
    INSERT INTO seguridad
    values
    (codsegur, codemple, observaciones),
    
   
			(1,	110,1),
			(2	,120,1),	
			(3,	130,2),	
			(4,	150,1),	
			(5	,160,3),	
			(6,	180,4),	
			(7,190,5),	
			(8,210,6),	
			(9,240,6),	
			(10,250,5),	
			(11,260,6),	
			(12,270,7),	
			(13,280,5),	
			(14,285,8),
			(15,290,9),	
			(16,310,2),
			(17,320,2),	
			(18,330,4),
			(19,350,5),	
			(20,360,7),
			(21,370,7),	
			(22,380,8),	
			(23,390,8),	
			(24,400,8);
				
                
                
insert into restauradores
values 
(codrestaurador,codemple, especialidad),
(1,400, 'SALVADOR DALI'),
(2,390, 'EXPRESIONISTAS');

                