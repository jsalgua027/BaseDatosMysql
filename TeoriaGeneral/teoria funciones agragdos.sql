-- quiero saber cuantos empleados hay 

select count(*), count(numem) , count(distinct numde)   -- cuenta celdas
from empleados;

-- cuanto cuestra al mes pagar la suma de los salarios

select sum(salarem)
from empleados;

--  salario maximo
select max(salarem)
from empleados;
-- salario minimo 
select min(salarem)
from empleados;

--  salario media
select avg(salarem)
from empleados;

-- todos juntos
select count(*) as numerosEmpleados, sum(empleados.salarem) as totalSalario,
max(salarem) as Maximo,  min(salarem) as minimo, avg(salarem) as media
from empleados;

-- grupos  por departamentos

select  empleados.numde as numeroDepartamento,  count(*) as numerosEmpleados, sum(empleados.salarem) as totalSalario,
max(salarem) as Maximo,  min(salarem) as minimo, avg(salarem) as media
from empleados
group by numde;

-- una funcion que devuleva el numero de extensiones telefonicas que utiliza un departamento
delimiter $$
drop function if exists extesiones $$
create function extensiones(
numdepto int
)
returns int
deterministic
begin
declare extensiones int;
 set extensiones = (select count(distinct extelem) as numeroDeExtension
from empleados 
where numde = numdepto);
return extensiones;
end$$
delimiter ;

select  nomde ,extensiones(numde)
from departamentos
order by nomde;

