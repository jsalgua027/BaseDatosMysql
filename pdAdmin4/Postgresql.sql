-- Borramos las reglas
drop rule if exists jerarquiaTotal on enunciados;
drop rule if exists controlOraciones on oraciones;
drop rule if exists controlFrases on frases;

-- Borramos las tablas
drop table if exists oraciones;
drop table if exists frases;
drop table if exists enunciados;

-- Creamos las tablas
create table enunciados
	(codenunciado int, 
	 texto varchar);

create table oraciones
	(codoracion int, 
	 verbo varchar
	)inherits (enunciados);

create table frases
	(codfrase int, 
	 observaciones varchar
	)inherits (enunciados);
 
 -- Creamos las reglas
create rule jerarquiaTotal as
	on insert to enunciados
	do instead nothing;
	
create rule controlOraciones as
	on insert to oraciones
	where exists 
	(select * 
	 from frases 
	 where frases.codenunciado  = new.codenunciado)

	do instead nothing;
	
create rule controlFrases as
	on insert to frases
	where exists 
	(select * 
	 from oraciones 
	 where oraciones.codenunciado  = new.codenunciado)
	do instead nothing;

-- Insertamos los datos
insert into enunciados
	(codenunciado, texto)
values
	(1, 'Prueba1'),
	(2, 'Prueba2'),
	(3, 'Prueba3');
	
insert into oraciones
	(codenunciado, texto, codoracion, verbo)
values
	(1, 'Me compré una bicicleta', 1, 'comprar'),
	(2, 'Mañana nos vamos de campamento', 2, 'ir');

insert into frases
	(codenunciado, texto, codfrase, observaciones)
values
	(2, 'Mañana nos vamos de campamento', 1, 'ir'),
	(3, '¡Por dios!', 2, 'Exclamación');

-- Comprobamos que funcionan las reglas
select * from enunciados;
select * from oraciones;
select * from frases;