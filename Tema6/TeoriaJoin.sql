
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