
/*
TEORIA DEL JOIN

*/
-- averiguar los nombres de empleados que trabajan en la c/atocha
use empresaclase;

SELECT 
    empleados.numem,
    empleados.nomem,
    empleados.numde,
    departamentos.numde,
    departamentos.numce,
    centros.numce
FROM
    centros
        JOIN
    departamentos ON centros.numce = departamentos.numce
        JOIN
    empleados ON departamentos.numde = empleados.numde
WHERE
    centros.dirce LIKE '%atocha%'; -- con el like es que contenga esa palabra aunque haya más
    
    -- obten una lista de centros y  nombres de departamentos (el departamento en el que están)
    
    
    select centros.nomce, centros.numce,departamentos.nomde
    from 
    centros
    join departamentos on centros.numce = departamentos.numce
    order by numce;
    
    -- left
    
     select centros.nomce, centros.numce,departamentos.nomde
    from 
    centros
    left join departamentos on centros.numce = departamentos.numce
    order by numce;
    
    -- right (no hat para los ejemplos del right en la base de datos)
    
     select centros.nomce, centros.numce,departamentos.nomde
    from 
    centros
    right join departamentos on centros.numce = departamentos.numce
    order by numce;
    
    
    -- ejempplo usando un clon -- averiguar los nombres de empleados que trabajan en la c/atocha inlcuir el nombre del director
    
 SELECT 
    centros.nomce,
    departamentos.nomde,
   
    empleados.numem,
    dirigir.numempdirec,
    empleados.nomem,
    e1.nomem
FROM
    centros
        JOIN
    departamentos ON centros.numce = departamentos.numce
        JOIN
    empleados ON departamentos.numde = empleados.numde
        JOIN
    dirigir ON departamentos.numde = dirigir.numdepto
		join empleados as e1 on dirigir.numempdirec= e1.numem -- clono la tablaa empleados para darle otro uso en la misma consulta
    where fecfindir is null
ORDER BY nomce , nomde , empleados.nomem;

    
    
    