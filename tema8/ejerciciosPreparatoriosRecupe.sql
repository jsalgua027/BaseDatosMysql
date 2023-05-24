-- ejer 1
-- no admite proveedores nuevos de valencia
delimiter $$
drop trigger if exists comprar$$
create trigger comprar
	before insert on proveedores
for each row
begin
		if new.ciudad='valencia' then 
		signal sqlstate '45000' set message_text = 'No admite proveedores de esa ciudad';
	end if;
end $$
delimiter ;


insert into proveedores
(codproveedor, nomempresa, nomcontacto,direccion, ciudad, codpostal , telefono)
values ( 27,'','' ,'' ,'valencia', '12345','123456789');

-- triger, un pedido que no pueda tener una fecha del pedido menor a hoy

delimiter $$
drop trigger if exists pedidos$$
create trigger pedidos
	before insert on pedidos 
for each row
begin
		if new.fecpedido < curdate() then 
		signal sqlstate '45000' set message_text = 'No admite pedidos de dias anteriores al actual';
	end if;
end $$
delimiter ;

insert into pedidos
(codpedido, fecpedido, fecentrega,codproducto,cantidad)
values(45,'2023-02-25 00:00:00','2023-02-26 00:00:00', 1,10 );

insert into pedidos
(codpedido, fecpedido, fecentrega,codproducto,cantidad)
values(45,'2023-05-22 00:00:00','2023-05-26 00:00:00', 1,10 );


-- evento de que cada dia de halowing todos los precios estan a la mitad

delimiter $$
drop event actualizacionPrecios$$
create event actualizacionPrecios
on schedule
	 every 1 year
    starts '2023-10-31 00:00:00'
do
	begin
		update  productos
        set preciounidad= preciounidad/2;
			
    end $$
    
delimiter ;

-- evento que actulice los productos que sean bebidas
delimiter $$
drop event actualizacionPreciosBebidas$$
create event actualizacionPreciosBebidas
on schedule
	 every 1 year
    starts '2023-10-31 00:00:00'
do
	begin
		update  productos
        set preciounidad= preciounidad/2
		-- 	where codcategoria= 2; sabiendo el codigo de categoria
        where codcategorias= (select categorias.codcategoria from categorias where Nomcategoria= 'Bebidas');
    end $$
    
delimiter ;


/*
USA EMPRESACLASE
1.Comprueba que no podamos contratar a empleados que no tengan 16 años.
2.Comprueba que el departamento de las personas que ejercen la dirección de los departamentos pertenezcan a dicho departamento.
3.Añade lo que consideres oportuno para que las comprobaciones anteriores se hagan también cuando se modifiquen la fecha de nacimiento de un empleado o al director/a de un departamento.
4.Añade una columna numempleados en la tabla departamentos. En ella vamos a almacenar el número de empleados de cada departamento.
5.Prepara un procecdimiento que para cada departamento calcule el número de empleados y guarde dicho valor en la columna creada en el apartado 4.
6.Prepara lo que consideres necesario para que cada trimestre se compruebe y actualice, en caso de ser necesario, el número de empleados de cada departamento.
7.Asegúrate de que cuando eliminemos a un empleado, se actualice el número de empleados del departamento al que pertenece dicho empleado.
*/  
  
-- 1.Comprueba que no podamos contratar a empleados que no tengan 16 años.	
delimiter $$
drop trigger if exists eje1$$
create trigger eje1
	before insert on empleados
for each row
begin
		if  -- date_add(new.fecnaem, interval 16 year)>curdate() otra forma date_add()  es si el (la fecha(campo), intevarl (cantidad) tiempo(year))
        (new.fecnaem)- year(curdate())<16 then 
		signal sqlstate '45000' set message_text = 'No se admite personal menor de 16 años';
	end if;
end $$
delimiter ;
insert into empleados
	(numem, numde, extelem, fecnaem, fecinem,salarem,
	 comisem, numhiem,nomem,ape1em,ape2em,dniem, userem, passem)
values
	(1207, 110, '342','2021-12-12', curdate(), 1000,10,
	0,'María', 'del Campo', 'Flores','10000001a','maria','1234')

-- NO SALE 2.Comprueba que el departamento de las personas que ejercen la dirección de los departamentos pertenezcan a dicho departamento.

delimiter $$
drop trigger if exists eje2$$
create trigger eje2
	before insert on dirigir
for each row
begin
		  if new.numdepto <> (select departamentos.numde from departamentos join empleados on departamentos.numde= empleados.numde where numem = new.numempdirec )   then 
		signal sqlstate '45000' set message_text = 'el departamento que va a dirigir es distinto';
	end if;
end $$
delimiter ;

insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values
	(42,2,'2021-12-12','2024-12-12','P');

-- 3.Añade lo que consideres oportuno para que las comprobaciones anteriores se hagan también cuando se modifiquen la fecha de nacimiento de un empleado o al director/a de un departamento.
-- A
delimiter $$
drop trigger if exists eje3a$$
create trigger eje3a
	before update on empleados
for each row
begin
		if  old.fecnaem <> new.fecnaem and   date_add(new.fecnaem, interval 16 year)>curdate()-- otra forma date_add()  es si el (la fecha(campo), intevarl (cantidad) tiempo(year))
         then  -- (new.fecnaem)- year(curdate())<16
		signal sqlstate '45000' set message_text = 'No se admite personal menor de 16 años';
	end if;
end $$
delimiter ;
-- lo probamos:
update empleados
set extelem = '567'
where numem = 999;

update empleados
set fecnaem = '2008-1-1'
where numem = 999;

delimiter $$
drop trigger if exists eje3b$$
create trigger eje3b
	before update on dirigir
for each row
begin
		  if old.numdepto<>new.numdepto and (select departamentos.numde from departamentos join empleados where numem = new.numempdirec ) <>new.numdepto   then 
		signal sqlstate '45000' set message_text = 'el departamento que va a dirigir es distinto';
	end if;
end $$
delimiter ;

-- lo probamos:
update dirigir
set	fecfindir = curdate()
where numempdirec = 150 
	and numdepto = 121 and fecinidir = '2003-08-03';

update dirigir
set	numdepto = 111
where numempdirec = 150 
	and numdepto = 121 and fecinidir = '2003-08-03';
    
/*
4.Añade una columna numempleados en la tabla departamentos.
 En ella vamos a almacenar el número de empleados de cada departamento.
*/

alter table departamentos
add column numempleados int not null default 0;

/*
5.Prepara un procecdimiento que para cada departamento calcule el número de empleados
 y guarde dicho valor en la columna creada en el apartado 4.

*/

delimiter $$
drop procedure if exists sumaEmple$$
create procedure sumaEmple()
begin
	update departamentos
		set nuempleados = (select count(*) from empledos where empledos.numde= departamentos.numde);
end$$
delimiter ;

/*
6.Prepara lo que consideres necesario para que cada trimestre se compruebe y actualice,
 en caso de ser necesario, el número de empleados de cada departamento.

*/
delimiter $$
drop event if exists contar$$
create event contar
on schedule
	 every 1 quarter
    starts '2023-06-01'
do
	begin
		call sumaEmple();
    end $$
    
delimiter ;

/*
7.Asegúrate de que cuando eliminemos a un empleado, 
se actualice el número de empleados del departamento al que pertenece dicho empleado.

*/
delimiter $$
drop trigger if exists eje7$$
create trigger eje7
	before delete  on empleados
for each row
begin
		update departamentos
    set numempleados = (select count(*) from empleados where numde = old.numde)
    where numde = old.numde;
         
end $$
delimiter ;

-- base de datos gestiona test

/*
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

*/
/*
delimiter $$
drop trigger if exists eje9$$
create trigger eje9
before insert on  matriculas
for each row
begin
	if  () then
    signal sqlstate '45000' set message_text = 'el profesor no puede matricularse en las misma materias que imparte';
	end if;
    
end $$
delimiter ;


insert into profesorado
(codprof, nomprof, ape1prof, ape2prof, dniprof)
values
( 1, 'nacho', 'sal', 'gua','123456789');

insert into alumnos
(numexped, nomalum, ape1alum, ape2alum, fecnacim, observaciones, calle, poblacion, codpostal, email, telefono, nomuser, dnialum)
values
(2525,'nacho', 'sal', 'gua', '1981-02-15', 'prueba', 'calle','madrid', '12345', '12345@789789', '956651262','12345678', '123456789');

insert into materias
(codmateria, nommateria,cursomateria, codprof)
values
(55, 'preuba','1234', '123456789');
/*

/*

Utiliza la base de datos BDALMACEN

1.Hemos detectado que hay usuarios que consiguen que el precio del pedido sea negativo,
 con lo cual no se hace un cobro del cliente sino un pago, por esta razón hemos decidido comprobar el precio del pedido
 y hacer que siempre sea un valor positivo.
2.Cuando vendemos un producto:
  a.Comprobar si tenemos suficiente stock para ello, si no es así, mostraremos un mensaje de no disponibilidad.
b.Si tenemos suficiente stock, se hará la venta y se disminuirá de forma automática el stock de dicho producto.
3.Queremos que, cuando queden menos de 5 unidades almacenadas  en nuestro almacén, se realice un pedido automático a nuestro proveedor.

4.Añade una columna de tipo bit para indicar los empleados jubilados y otra con la fecha de jubilación.
5.Cuando un empleado se jubila, si es director de algún departamento, debe aparecer un mensaje que recuerde que debemos buscar un nuevo director para ese departamento.
6.Prepara un evento que, cada trimestre, compruebe si hay algún departamento sin director actual, en cuyo caso mostraremos un mensaje con todos los departamentos sin director.
7.Crea un evento que, al comienzo de cada año, compruebe los empleados jubilados hace diez años o más y los elimine de la base de datos (haz una copia antes de ejecutar este apartado). Deberá eliminar, también, los registros de la tabla dirigir asociados a estos empleados.
8.Crea un evento anual que incremente en un 2,5% el salario de los empleados no jubilados. Este evento se creará deshabilitado.


*/


/*
1.Hemos detectado que hay usuarios que consiguen que el precio del pedido sea negativo,
 con lo cual no se hace un cobro del cliente sino un pago, por esta razón hemos decidido comprobar el precio del pedido
 y hacer que siempre sea un valor positivo.
*/


delimiter $$
drop trigger if exists eje1Almacen$$
create trigger eje1Almacen
	 before insert  on pedidos
for each row
begin
		if ( select preciounidad from productos  where codproducto = pedidos.codproducto) <0 then 
          update productos
          set new.preciounidad = abs(old.preciounidad);
          signal sqlstate '01000' set message_text = 'ojo con el valor del producto';
	end if;
end $$
delimiter ;




/*
2.Cuando vendemos un producto:
  a.Comprobar si tenemos suficiente stock para ello, si no es así, mostraremos un mensaje de no disponibilidad.
b.Si tenemos suficiente stock, se hará la venta y se disminuirá de forma automática el stock de dicho producto.

*/

delimiter $$
drop trigger if exists eje2Almacen$$
create trigger eje2Almacen
	 before update on productos
for each row
begin
		  if (pedidos.cantidad > (select stock from productos join pedidos on productos.codproducto= pedidos.codproducto  where codproducto= pedidos.codproducto))then
          
          signal sqlstate '45000' set message_text = 'no hay stock suficiente';
          else 
          update productos
          set new.stock = old.stock-pedidos.cantidad;
          
	end if;
end $$
delimiter ;

-- 3.Queremos que, cuando queden menos de 5 unidades almacenadas  en nuestro almacén, se realice un pedido automático a nuestro proveedor.
delimiter $$
drop trigger if exists eje3Almacen$$
create trigger eje3Almacen
	 after insert on pedidos
for each row
begin
		  if (select productos.stock from productos join pedidos on productos.codproducto = pedidos.codproducto where productos.codproducto= pedidos.codproducto )<5 then
          update productos
          set stock = stock+5;
          signal sqlstate '01000' set message_text = 'Hay menos de cinco hacemos pedido';
          
          
          
	end if;
end $$
delimiter ;

-- 4.Añade una columna de tipo bit para indicar los empleados jubilados y otra con la fecha de jubilación.

alter table empleados
add column jubilado bit,
add column fechaJubi date;

-- 5.Cuando un empleado se jubila, si es director de algún departamento, debe aparecer un mensaje que recuerde que debemos buscar un nuevo director para ese departamento.

delimiter $$
drop trigger if exists eje3Empresa$$
create trigger eje3Empresa
	 before update on empleados
for each row
begin
		  if ((empleados.fechaJubi= curdate())and empleados.numem in (select dirigir.numempdirec from dirigir join empleados on dirigir.numempdirec = empleados.numem)) then
          signal sqlstate '01000' set message_text = 'Necesitamos nuevo director';
          
          
          
	end if;
end $$
delimiter ;


-- 6.Prepara un evento que, cada trimestre, compruebe si hay algún departamento sin director actual, en cuyo caso mostraremos un mensaje con todos los departamentos sin director.
delimiter $$
drop procedure if exists  direcDepar$$
create procedure direcDepar()
begin
	declare deparSin int; 
    set deparSin = (select count(*)from dirigir where numdepto= null);
		if deparsin > 0 then   signal sqlstate '01000' set message_text = 'Hay departamentos sin direccion';
        end if;
end$$
delimiter ;

insert into dirigir
(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values
( 1, 1206, '2008-01-03', null, 'P')

delimiter $$
drop event if exists  direcD$$
create event direcD
on schedule
every 1 quarter
do
begin 
call direcDepar();
end $$
delimiter ;

-- 7.Crea un evento que, al comienzo de cada año, compruebe los empleados jubilados hace diez años o más y los elimine de la base de datos (haz una copia antes de ejecutar este apartado). Deberá eliminar, también, los registros de la tabla dirigir asociados a estos empleados.

delimiter $$
drop procedure if exists  jubilado$$
create procedure jubilado()
begin
	if (select * from empleados where fechaJubi> date_add(curdate(), interval 10 year))then 
    delete from empleados;
    end if;
end$$
delimiter ;

delimiter $$
drop event if exists  ju$$
create event ju
on schedule
every 1 year
starts '2024-01-01'
do
begin 
call jubilado();
end $$
delimiter ;
