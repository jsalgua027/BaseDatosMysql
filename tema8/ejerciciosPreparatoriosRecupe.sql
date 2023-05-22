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
		  if new.numdepto <> (select departamentos.numde from departamentos join empleados where numem = new.numempdirec )   then 
		signal sqlstate '45000' set message_text = 'el departamento que va a dirigir es distinto';
	end if;
end $$
delimiter ;

insert into dirigir
	(numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values
	(35,2,'2021-12-12','2024-12-12','P');

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