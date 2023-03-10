use empresaclase;
/*
Para la BD Empresa_clase descargada de la plataforma obtener las siguientes consultas:
1.Obtener todos los datos de todos los empleados.
2.Obtener la extensión telefónica de “Juan López”.
3.Obtener el nombre completo de los empleados que tienen más de un hijo.
4.Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.
5.Obtener el nombre completo y en una sola columna de los empleados sin comisión.
6.Obtener la dirección del centro de trabajo “Sede Central”.
7.Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
8.Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
9.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
10.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).


*/

-- ejemplos

select numem, ape1em, ape2em, nomem
from empleados
where numde=110 or numde= 120
order by  ape1em desc ,  ape2em desc,  nomem desc; -- desc orden descendente; por defecto es asc--> ascendente



select numem, numem as NumEmpleado , ape1em, ape2em, nomem,
concat(ape1em, ape2em, nomem),
concat(ape1em, ape2em, nomem) as nombreCompleto1,
concat(ape1em,' ',ape2em,' ',nomem)as nombreCompleto2,
concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto3,
concat_ws(' ',ape1em,ape2em,nomem)as nombreCompleto_ws
from empleados
where numde=110 or numde= 120
order by  ape1em desc ,  ape2em desc,  nomem desc; 


-- 1.Obtener todos los datos de todos los empleados.
select * 
from empleados;

-- 2.Obtener la extensión telefónica de “Juan López”.
select extelem
from empleados
where nomem= 'Juan' and ape1em= 'Lopez';


-- 3.Obtener el nombre completo de los empleados que tienen más de un hijo.
select nomem , ape1em, ape2em, numhiem as numeroHijos
from empleados
-- where ifnull(numhiem,0) < 1;
where numhiem>1;


-- 4.Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.

select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, numhiem as numeroHijos
from empleados
where numhiem between 1 and 3; -- es más eficiente
-- where numhiem>0 and numhiem<4; otra opcion
-- where ifnull(numhiem,0) not between 1 and 3; -- nos quedamos con todos los que el numhiem esté fuera del rango (1,3)
-- where ifnull(numhiem,0) <1 or numhiem >3;

-- 5.Obtener el nombre completo y en una sola columna de los empleados sin comisión.
select concat_ws(' ',ape1em,ape2em,nomem)as nombreCompleto
from empleados
where ifnull(comisem,0) = 0;

-- 6.Obtener la dirección del centro de trabajo “Sede Central”.
select dirce
from centros
-- where nomce=' Sede Central';
-- El anterior no obtiene resultados porque los nombres
-- de centro tienen espacios en blanco
-- para quitar los espacios usamos ltrim y rtrim:
-- where rtrim(ltrim(centros.nomce)) = 'Sede Central';
where lower(trim(nomce)) = 'sede central';

-- 7.Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
select nomde, presude
from deptos
where presude>6000;

-- 8.Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.

select nomde, presude
from deptos
where presude>=6000;

-- 9.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombmuestraExtensionreCompleto, fecinem
from empleados
where curdate()-fecinem>1;
-- where fecinem <= date_sub(curdate(), interval 1 year);
-- where fecinem <= subdate(curdate(), interval 1 year);
-- where fecinem <= adddate(curdate(), interval -1 year);
-- where fecinem <= date_add(curdate(), interval -1 year);

-- 10.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, fecinem
from empleados
where (curdate()-fecinem>0) and (curdate()-fecinem<3) ;
-- where fecinem >= '2018/2/14' and fecinem <= '2021/2/14';
-- where fecinem between '2018/2/14' and '2021/2/14';
-- where fecinem between date_sub(curdate(), interval 3 year) and date_sub(curdate(), interval 1 year);



/*

EJEMPLO DE PROCEDIMIENTO

select extelem
from empleados
where nomem= 'Juan' and ape1em= 'Lopez';

*/
-- EJERCICIO 2 EN UN PROCEDIMIENTO
delimiter $$
drop procedure if exists muestraExtension $$
create procedure muestraExtension 
	(nombre varchar(60),
    ape1 varchar(60)
    )
	begin
    select extelem
from empleados
where nomem= nombre and ape1em= ape1;
    
    end $$
delimiter ;

call muestraExtension('Juan', 'Lopez');

/*
EJEMPLO DE FUNCION; DEVULVE UN VALOR , FUNCIONES SOLO DEVUELVEN UN VALOR

*/

delimiter $$
drop function if exists devuelveExtension $$
create function devuelveExtension 
	(nombre varchar(60),
    ape1 varchar(60)
    )
    returns char(3) 
    deterministic
	begin
    declare extension char(3); -- declaro la variable 
  /*  -- devuelvo todo en la variable extension 
     select extelem into extension
            from empleados
             where nomem= nombre and ape1em= ape1 ;
    */          
    SET extension =( select extelem
                    from empleados
                    where nomem= nombre and ape1em= ape1 
                   );
		return extension;
    
 /* 
 OTRA FORMA DE HACERLO SIN DECLARAR LAS VARIABLES
 return ( select extelem
            from empleados
              where nomem= nombre and ape1em= ape1 
              );
  */  
 
  
  
    end $$
delimiter ;

select devuelveExtension('Juan', 'Lopez');
set @miExtension = devuelveExtension('Juan', 'Lopez');
select @miExtension;

/*
PARA QUE DEVUELVA MAS DE UN VALOR SE USA UN PROCEDIMIENTO
SI SOLO DEVUELVE UN VALOR SE REALIZA UNA FUNCION

*/
delimiter $$
drop procedure if exists DevExtensionProce $$
create procedure DevExtensionProce
	( in nombre varchar(60),
      in ape1 varchar(60),
      out extension char(3)
    )
	begin
    set extension =(select extelem
                    from empleados
                 where nomem= nombre and ape1em= ape1);
                 
/*
select extelem into extension
            from empleados
             where nomem= nombre and ape1em= ape1 ;

*/
    
    end $$
delimiter ;
-- @miextension  es un parametro de salida usamos el @ y el nombre de la variable que queramos
call DevExtensionProce('Juan', 'Lopez', @miextension);

select @miextension;

/*
prepra una rutina (Procedimiento o funcion) 
que muestre---> procedimiento
que devuleva (Funcion o procedimiento)
1 valor = funcion
+ de una valor = procedimiento
*/


/*

11.Prepara un procedimiento almacenado que ejecute la consulta del apartado 1 y otro que ejecute la del apartado 5.
12.Prepara un procedimiento almacenado que ejecute la consulta del apartado 2
 de forma que nos sirva para averiguar la extensión del empleado que deseemos en cada caso.
13.Prepara un procedimiento almacenado que ejecute la consulta del apartado 3 y
 otro para la del apartado 4 de forma que nos sirva para averiguar el nombre de aquellos que tengan el número de hijos que deseemos en cada caso.
14.Prepara un procedimiento almacenado que, dado el nombre de un centro de trabajo, nos devuelva su dirección.
15.Prepara un procedimiento almacenado que ejecute la consulta del apartado 7 de forma que nos sirva para averiguar,
 dada una cantidad, el nombre de los departamentos que tienen un presupuesto superior a dicha cantidad.
16.Prepara un procedimiento almacenado que ejecute la consulta del apartado 8 de forma que nos sirva para averiguar,
 dada una cantidad, el nombre de los departamentos que tienen un presupuesto igual o superior a dicha cantidad.
17.Prepara un procedimiento almacenado que ejecute la consulta del apartado 9 de forma que nos sirva para averiguar, 
dada una fecha, el nombre completo y en una sola columna de los empleados que llevan trabajando con nosotros desde esa fecha.

*/

-- 11.Prepara un procedimiento almacenado que ejecute la consulta del apartado 1 y otro que ejecute la del apartado 5.
delimiter $$
drop procedure if  exists apartado1 $$
create procedure apartado1()
  begin
  select *
  from empleados;
  
end $$
delimiter ;

call apartado1();

/*
select concat_ws(' ',ape1em,ape2em,nomem)as nombreCompleto
from empleados
where ifnull(comisem,0) = 0;

*/

delimiter $$
drop procedure if exists apartado5 $$
create procedure apartado5
(comision decimal(4,2))
begin
select concat_ws(' ',ape1em,ape2em,nomem)as nombreCompleto
from empleados
where ifnull(comisem,0) = comision;
end $$
delimiter ;

call apartado5(0);
/*
12.Prepara un procedimiento almacenado que ejecute la consulta del apartado 2
 de forma que nos sirva para averiguar la extensión del empleado que deseemos en cada caso
select extelem
from empleados
where nomem= 'Juan' and ape1em= 'Lopez';
*/
delimiter $$
drop procedure if exists apartado2 $$
create procedure apartado2
(nombre varchar(60), apellido varchar(60))
begin
select extelem
from empleados
where nomem=nombre and ape1em= apellido;
end $$
delimiter ;

call apartado2('Juan','Lopez');

/*
13.Prepara un procedimiento almacenado que ejecute la consulta del apartado 3 y
 otro para la del apartado 4 de forma que nos sirva para averiguar el nombre de aquellos que tengan el número de hijos que deseemos en cada caso.
 
 -- 3.Obtener el nombre completo de los empleados que tienen más de un hijo.
select nomem , ape1em, ape2em, numhiem as numeroHijos
from empleados
-- where ifnull(numhiem,0) < 1;
where numhiem>1;

-- 4.Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.

select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, numhiem as numeroHijos
from empleados
where numhiem between 1 and 3; -- es más eficiente
-- where numhiem>0 and numhiem<4; otra opcion
-- where ifnull(numhiem,0) not between 1 and 3; -- nos quedamos con todos los que el numhiem esté fuera del rango (1,3)
-- where ifnull(numhiem,0) <1 or numhiem >3;
 
 
*/
delimiter $$
drop procedure if exists apartado3 $$
create procedure apartado3
( numeroHijos tinyint )
begin
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, numhiem as numeroHijos
from empleados
where numhiem > numeroHijos;
end $$
delimiter ;

call apartado3(1);

delimiter $$
drop procedure if exists apartado4 $$
create procedure apartado4
( numeroHijos tinyint )
begin
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, numhiem as numeroHijos
from empleados
where numhiem = numeroHijos;
end $$
delimiter ;

call apartado4(3);

-- 14.Prepara un procedimiento almacenado que, dado el nombre de un centro de trabajo, nos devuelva su dirección.

delimiter $$
drop procedure if exists apartado6 $$
create procedure apartado6
( nombreCentro varchar(60))
begin
select dirce
from centros
where lower(trim(nomce)) = nombreCentro;
end $$
delimiter ;

call apartado6('Sede central')

/*
15.Prepara un procedimiento almacenado que ejecute la consulta del apartado 7 de forma que nos sirva para averiguar,
 dada una cantidad, el nombre de los departamentos que tienen un presupuesto superior a dicha cantidad.
  -- 7.Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
     select nomde, presude
      where presude<>6000;

*/

delimiter $$
drop procedure if exists apartado7 $$
create procedure apartado7
(presupuesto decimal(10,2))
begin
select nomde
from deptos
where presude > presupuesto;
end $$
delimiter ;

call apartado7(6000);

/*
16.Prepara un procedimiento almacenado que ejecute la consulta del apartado 8 de forma que nos sirva para averiguar,
 dada una cantidad, el nombre de los departamentos que tienen un presupuesto igual o superior a dicha cantidad.
	-- 8.Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.
	select nomde, presude
	from deptos
	where presude>=6000;

*/


delimiter $$
drop procedure if exists apartado8 $$
create procedure apartado8
(presupuesto decimal(10,2))
begin
select nomde
from deptos
where presude >= presupuesto;
end $$
delimiter ;

call apartado8(6000);


/*
17.Prepara un procedimiento almacenado que ejecute la consulta del apartado 9 de forma que nos sirva para averiguar, 
dada una fecha, el nombre completo y en una sola columna de los empleados que llevan trabajando con nosotros desde esa fecha.
	-- 9.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
	select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, fecinem
	from empleados
	where curdate()-fecinem>1;
	-- where fecinem <= date_sub(curdate(), interval 1 year);
	-- where fecinem <= subdate(curdate(), interval 1 year);
	-- where fecinem <= adddate(curdate(), interval -1 year);
	-- where fecinem <= date_add(curdate(), interval -1 year);

*/

delimiter $$
drop procedure if exists apartado9 $$
create procedure apartado9
(fecha date)
begin
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, fecinem as fechaIngreso
from empleados
where fecinem> fecha;
end $$
delimiter ;

select *  from empleados;

call apartado9('2000-01-01');




