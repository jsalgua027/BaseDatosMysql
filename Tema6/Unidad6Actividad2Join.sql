/*
Para la BD Empresa_clase descargada de la plataforma obtener las siguientes consultas:
1.Genera un script que te sirva de copia de seguridad de la tabla empleados.
2.Obtén de la plataforma un script con los datos de una tabla “empleados_temp”. En esta tabla los datos de los salarios están actualizados. Realiza las operaciones que consideres oportunas para actualizar, en la tabla empleados los salarios de sus empleados por los de la tabla “empleados_temp”.
3.Obtener todos los datos de todos los empleados y el nombre del departamento al que pertenecen.
4.Obtener la extensión telefónica y el nombre del centro de trabajo de “Juan López”.
5.Obtener el nombre completo y en una sola columna de los empleados del departamento “Personal” y “Finanzas”.
6.Obtener el nombre del director actual del departamento “Personal”.
7.Obtener el nombre de los departamentos y el presupuesto que están ubicados en la “SEDE CENTRAL”.
8.Obtener el nombre de los centros de trabajo cuyo presupuesto esté entre 100000 € y 150000 €.
9.Obtener las extensiones telefónicas del departamento “Finanzas”. No deben salir extensiones repetidas.
10.Obtener el nombre completo y en una sola columna de todos los directores que ha tenido el departamento cualquiera.
11.Como el apartado 2, pero, ahora, generalízalo para el empleado que queramos en cada caso.
12.Como el apartado 3 pero generalízalo para que podamos buscar los empleados de un solo departamento.
13.Como el apartado 4. pero generalízalo para buscar el director del departamento que queramos en cada caso.
14.Como el apartado 5 pero generalízalo para buscar por el centro que queramos.
15.Como el apartado 6 pero generalizado para poder buscar el rango que deseemos.
16.Como el apartado 7 pero generalizado para poder buscar las extensiones del departamento que queramos.



*/


/*
2.Obtén de la plataforma un script con los datos de una tabla “empleados_temp”. 
En esta tabla los datos de los salarios están actualizados. 
Realiza las operaciones que consideres oportunas para actualizar,
 en la tabla empleados los salarios de sus empleados por los de la tabla “empleados_temp”.
*/

-- 3.Obtener todos los datos de todos los empleados y el nombre del departamento al que pertenecen
select
	empleados.nomem,
    empleados.ape1em,
    empleados.extelem,
    departamentos.nomde
    
    from empleados
    join departamentos on departamentos.numde= empleados.numde;
    
    
-- 4.Obtener la extensión telefónica y el nombre del centro de trabajo de “Juan López”.

select
	empleados.extelem,
    centros.nomce
    from empleados
    join departamentos on departamentos.numde= empleados.numde
    join centros on centros.numce= departamentos.numce
    
    where empleados.nomem = 'Juan' and empleados.ape1em= 'Lopez';