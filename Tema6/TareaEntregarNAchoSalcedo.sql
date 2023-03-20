-- Nacho Salcedo Guarde
/*
. Prepara una rutina que, dado el número de un departamento, devuelva el presupuesto del mismo.
2. Prepara una rutina que, dado el número de un empleado, nos devuelva la fecha de ingreso en la empresa y el nombre de su director/a.
3. Prepara una rutina que nos muestre el nombre de todos los empleados y el nombre del último departamento que ha dirigido (si es que  ha dirigido alguno)

*/

-- 1 
delimiter $$
drop function if exists apartado1 $$
create function apartado1
(
 numeroDep int

)
returns int
deterministic
begin
declare resultado decimal(10,2);

set resultado =(select presude
from departamentos
where numde = numeroDep

);
return resultado;


end$$
delimiter ;

select apartado1(100);


--  2. Prepara una rutina que, dado el número de un empleado, nos devuelva la fecha de ingreso en la empresa y el numero de su director/a.


delimiter $$
drop procedure if exists apartado2 $$
create procedure apartado2
(
 in numeroEmple int,
 out fechaIngreso date,
 out numeroDirector int
)
begin

set fechaIngreso = (select empleados.fecinem
from empleados 
where empleados.numem= numeroEmple

);
set numeroDirector =( select dirigir.numempdire
/*
from dirigir
join empleados on empleados.numde = dirigir.numdepto
where empleados.numem= numeroEmple
*/
from departamentos
join empleados on  empleados.numde = departamentos.nomde
);

end$$
delimiter ;

 call  apartado2(110, @fechaIngreso, @numeroDir);
 select @fechaIngreso, @numeroDir;
 
-- 3. Prepara una rutina que nos muestre el nombre de todos los empleados y el nombre del último departamento que ha dirigido (si es que  ha dirigido alguno)

delimiter $$
drop procedure if exists apartado3 $$
create procedure apartado3
()
begin
select empleados.nomem as nombre , departamentos.nomde as nombreDepartamento
from 
empleados 
join  
 dirigir on dirigir.numempdirec = empleados.numem
 join 
 departamentos on dirigir.numdepto = empleados.numde;

end$$
delimiter ;

call apartado3();
 