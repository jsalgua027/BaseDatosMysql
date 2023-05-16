/*Para la base de datos empresaclase haz los siguientes ejercicios:

1.Comprueba que no podamos contratar a empleados que no tengan 16 años.
2.Comprueba que el departamento de las personas que ejercen la dirección de los departamentos pertenezcan a dicho departamento.
3.Añade lo que consideres oportuno para que las comprobaciones anteriores se hagan también cuando se modifiquen la fecha de nacimiento de un empleado o al director/a de un departamento.
4.Añade una columna numempleados en la tabla departamentos. En ella vamos a almacenar el número de empleados de cada departamento.
5.Prepara un procecdimiento que para cada departamento calcule el número de empleados y guarde dicho valor en la columna creada en el apartado 4.
6.Prepara lo que consideres necesario para que cada trimestre se compruebe y actualice, en caso de ser necesario, el número de empleados de cada departamento.
7.Asegúrate de que cuando eliminemos a un empleado, se actualice el número de empleados del departamento al que pertenece dicho empleado.

Para la base de datos gestionTests haz los siguientes ejercicios:

8.El profesorado también puede matricularse en nuestro centro pero no de las materias que imparte. Para ello tendrás que hacer lo sigjuiente:
	a.Añade el campo dni en la tabla de alumnado.
	b.Añade la tabla profesorado (codprof, nomprof, ape1prof, ape2prof, dniprof).
	c.Añade una clave foránea en materias ⇒ codprof references a profesorado (codprof).
	d.Introduce datos en las tablas y campos creados para hacer pruebas.
9.Comprueba que un profesor no se matricule de las materias que imparte.
before insert on matriculas
si el dni del alumno = dni profesor que imparte la materia de la matricula entonces
	provocar error
10.La fecha de publicación de un test no puede ser anterior a la de creación.
11.El alumnado no podrá hacer más de una vez un test (ya existe el registro de dicho test para el alumno/a) si dicho test no es repetible (tests.repetible = 0|false).

Crea/Utiliza la base de datos gestionPromo y para dicha base de datos:

1.El precio de un artículo en promoción nunca debe ser mayor o igual al precio habitual de venta (el de la tabla artículos).


Crea/Utiliza la base de datos BDALMACEN y para dicha base de datos:

1.Hemos detectado que hay usuarios que consiguen que el precio del pedido sea negativo,
 con lo cual no se hace un cobro del cliente sino un pago,
 por esta razón hemos decidido comprobar el precio del pedido y 
 hacer que siempre sea un valor positivo.
 
2.Cuando vendemos un producto:
Comprobar si tenemos suficiente stock para ello, si no es así, mostraremos un mensaje de no disponibilidad.
Si tenemos suficiente stock, se hará la venta y se disminuirá de forma automática el stock de dicho producto.

3.Queremos que, cuando queden menos de 5 unidades almacenadas  en nuestro almacén, se realice un pedido automático a nuestro proveedor.
4.Añade una columna de tipo bit para indicar los empleados jubilados y otra con la fecha de jubilación.
5.Cuando un empleado se jubila, si es director de algún departamento, debe aparecer un mensaje que recuerde que debemos buscar un nuevo director para ese departamento.
6.Prepara un evento que, cada trimestre, compruebe si hay algún departamento sin director actual, en cuyo caso mostraremos un mensaje con todos los departamentos sin director.
7.Crea un evento que, al comienzo de cada año, compruebe los empleados jubilados hace diez años o más y los elimine de la base de datos (haz una copia antes de ejecutar este apartado). Deberá eliminar, también, los registros de la tabla dirigir asociados a estos empleados.
8.Crea un evento anual que incremente en un 2,5% el salario de los empleados no jubilados. Este evento se creará deshabilitado.

/*
/**/

use  empresaclase;

-- 1.Comprueba que no podamos contratar a empleados que no tengan 16 años.
delimiter $$
drop trigger if exists compruebaedad $$
create trigger compruebaedad
	before insert on empleados
for each row
begin
	-- if date_sub(curdate(), interval 16 year) < new.fecnaem then
    if date_add(new.fecnaem, interval 16 year) > curdate() then
    
		signal sqlstate '45000' set message_text = 'no se cumple la edad';
	end if;
end $$
delimiter ;
-- lo probamos:
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem,salarem,
	 comisem, numhiem,nomem,ape1em,ape2em,dniem, userem, passem)
values
	(1201, 110, '342','2010/12/12', curdate(), 1000,10,
	0,'María', 'del Campo', 'Flores','10000001a','maria','1234');

-- 2.Comprueba que el departamento de las personas que ejercen la dirección de los departamentos pertenezcan a dicho departamento.

delimiter $$
drop trigger if exists compruebadeptodir $$
create trigger compruebadeptodir
	before insert on dirigir
for each row
begin
	declare mensaje varchar(100);
	if (select numde from departamentos where numem = new.numempdirec) <> new.numdepto then
	begin
		set mensaje = concat('El empleado no pertenece al departamento ', new.numdepto); -- en algunas versiones de mysql de error usar concat directamente en la sentencia signal
		signal sqlstate '45000' set message_text = mensaje;
	end;
    end if;
end $$
delimiter ;
-- lo probamos:

/*
insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values
--	(....);
*/
-- 3.Añade lo que consideres oportuno para que las comprobaciones anteriores se hagan también cuando se modifiquen la fecha de nacimiento de un empleado o al director/a de un departamento.
-- sobre ejer1
delimiter $$
drop trigger if exists modficofecha $$
create trigger  modficofecha
  before update on empleados
 for each row
begin 
	if date_add(new.fecnaem, interval 16 year) > curdate() and old.fecnaem <> new.fecnaem then
	begin 
		signal sqlstate '45000' set message_text = 'no se cumple la edad';
    end;
	end if;
 
end$$
delimiter ;

-- lo probamos:
update empleados
set extelem = '567'
where numem = 999;

update empleados
set fecnaem = '2007/1/1'
where numem = 999;		

-- sobre ejer2

delimiter $$
drop trigger if exists modficoDire $$
create trigger  modficoDire
 before update on dirigir
for each row
begin
	declare mensaje varchar(100);
	if  old.numdepto <> new.numdepto and (select numde from departamentos where numem = new.numempdirec) <> new.numdepto then
	begin
		set mensaje = concat('El empleado no pertenece al departamento ', new.numdepto); -- en algunas versiones de mysql de error usar concat directamente en la sentencia signal
		signal sqlstate '45000' set message_text = mensaje;
	end;
    end if;
end $$
delimiter ;

-- lo probamos:
update dirigir
set	fecfindir = curdate()
where numempdirec = 150 
	and numdepto = 121 and fecinidir = '2003/08/03';

update dirigir
set	numdepto = 111
where numempdirec = 150 
	and numdepto = 121 and fecinidir = '2003/08/03';

-- 4.Añade una columna numempleados en la tabla departamentos. En ella vamos a almacenar el número de empleados de cada departamento.
alter table departamentos
	add column numempleados int not null default 0;

-- 5.Prepara un procecdimiento que para cada departamento calcule el número de empleados y guarde dicho valor en la columna creada en el apartado 4.
delimiter $$
drop procedure if exists sumaEmpleados $$
create procedure sumaEmpleados()
 begin
	update departamentos
		set numempleados = (select count(*) from empleados where empleados.numde = departamentos.numde);
end $$
delimiter ;

/*
 6.Prepara lo que consideres necesario para que cada trimestre se compruebe y
 actualice, en caso de ser necesario, el número de empleados de cada departamento.
*/
delimiter $$
create event actualizaNumeroEmpleados
on schedule
	every 1 quarter
    starts '2022/6/1'
do
	begin
		call sumaEmpleados();
    end $$
    
delimiter ;

-- 7.Asegúrate de que cuando eliminemos a un empleado, se actualice el número de empleados del departamento al que pertenece dicho empleado.
delimiter $$
drop procedure if exists borradoEmpleados$$
create procedure borradoEmpleados(
    numeroEmpleado int
    )
begin 
	delete empleados 
		set numempledos = (select rest())