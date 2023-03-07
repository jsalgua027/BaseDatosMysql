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
where numhiem>1;

-- 4.Obtener el nombre completo y en una sola columna de los empleados que tienen entre 1 y 3 hijos.

select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, numhiem as numeroHijos
from empleados
where numhiem>0 and numhiem<4;

-- 5.Obtener el nombre completo y en una sola columna de los empleados sin comisión.
select concat_ws(' ',ape1em,ape2em,nomem)as nombreCompleto
from empleados
where comisem=0;

-- 6.Obtener la dirección del centro de trabajo “Sede Central”.
select dirce
from centros
where nomce=' Sede Central';

-- 7.Obtener el nombre de los departamentos que tienen más de 6000 € de presupuesto.
select nomde, presude
from deptos
where presude>6000;

-- 8.Obtener el nombre de los departamentos que tienen de presupuesto 6000 € o más.

select nomde, presude
from deptos
where presude>=6000;

-- 9.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa más de 1 año. (Añade filas nuevas para poder comprobar que tu consulta funciona).
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, fecinem
from empleados
where curdate()-fecinem>1;

-- 10.Obtener el nombre completo y en una sola columna de los empleados que llevan trabajando en nuestra empresa entre 1 y tres años. (Añade filas nuevas para poder comprobar que tu consulta funciona).
select concat(ape1em,' ',ifnull(ape2em,''),' ',nomem)as nombreCompleto, fecinem
from empleados
where (curdate()-fecinem>0) and (curdate()-fecinem<3) ;



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
create procedure apartado1
  (tabla varchar(60))
  begin
  select *
  from tabla;
  
end $$
delimiter ;

call apartado1(empleados)
