-- tema 7 teoria ---
-- quiero buscar el numero de empleados de cada depto, 
-- pero no me interesa los dptos de menos de tres miembros
/*
select  numde ,count(*) -- (5)
from empleados -- (1)
where count(*) >=3 -- (2)
group by numde; -- (3)       ORDEN DE EJECUCION Y DA ERROR POR EL WHEREE
*/
-- correcto
select  numde ,count(*) -- (5)
from empleados -- (1)
-- where count(*) >=3 -- (2)
group by numde -- (3)       ORDEN DE EJECUCION
having count(*) >=3; -- (4)
 
 /*
 buscar el numero de empleados de cada depto con salario mayor a  1500
 pero no me interesan los deptos de menos de tres miembros
 */
 
 select  numde ,count(*) as numEmple-- (5)
from empleados -- (1)
where salarem > 1500 -- (2)
group by numde -- (3)       ORDEN DE EJECUCION
having count(*) >=3 -- (4)
-- order by count(*) desc; -- (6) 
 -- order by 2 desc; -- (6)aqui le indicamos que ordene por el count del selec que es el segundo
 order by numEmple desc; -- (6)
 
 
 