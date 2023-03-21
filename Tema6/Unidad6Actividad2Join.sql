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
delimiter $$
drop procedure if exists apartado4_2$$
create procedure apartado4_2()
begin
SELECT 
    empleados.extelem, centros.nomce
FROM
    empleados
        JOIN
    departamentos ON empleados.numde = departamentos.numde  
        JOIN
    centros ON   departamentos.numce = centros.numce
WHERE
    empleados.nomem = 'Juan'
        AND empleados.ape1em = 'Lopez';
  end$$
  delimiter ;
  
  call apartado4_2();
    
-- 5.Obtener el nombre completo y en una sola columna de los empleados del departamento “Personal” y “Finanzas”.    
 delimiter $$
 drop procedure if exists apartado5_2$$
 create procedure apartado5_2()
 begin
 select concat(empleados.nomem,' ', empleados.ape1em, ' ', ifnull(empleados.ape2em, '')) as nombreCompleto , departamentos.nomde
 from empleados
 join 
	departamentos on empleados.numde = departamentos.numde
 where departamentos.nomde= 'Personal' or departamentos.nomde= 'Finanzas';
 
 end$$
 delimiter ;

call apartado5_2();

-- 6.Obtener el nombre del director actual del departamento “Personal”.
delimiter $$
drop procedure if exists apartado6_2$$
create procedure apartado6_2()
begin
select concat_ws(' ', empleados.nomem, empleados.ape1em, ifnull(empleados.ape2em,' ')) as NombreCompleto
/*
from empleados
join 
departamentos on empleados.numde= departamentos.numde
join 
dirigir on departamentos.numde = dirigir.numdepto
*/
FROM empleados 
	join 
	  dirigir on empleados.numem = dirigir.numempdirec
	join
	 departamentos on dirigir.numdepto = departamentos.numde
where departamentos.nomde = 'Personal' and dirigir.fecinidir<= curdate() and (dirigir.fecfindir is null or dirigir.fecfindir >= curdate());
end$$
delimiter ;

call apartado6_2();

-- version eva ejercicio 6 

SELECT empleados.nomem, dirigir.fecinidir, dirigir.fecfindir
FROM empleados join dirigir 
	on empleados.numem = dirigir.numempdirec
		join departamentos on dirigir.numdepto = departamentos.numde
WHERE departamentos.nomde = 'Personal' and 
	fecinidir <= curdate() and
	(fecfindir is null or fecfindir >= curdate());
    

-- 7.Obtener el nombre de los departamentos y el presupuesto que están ubicados en la “SEDE CENTRAL”.

delimiter $$
drop procedure if exists apartado7_2$$
create procedure apartado7_2()
begin
	select departamentos.nomde as NombreDepartamento, departamentos.presude
	from departamentos
	 join centros on departamentos.numce = centros.numce
	 where trim(centros.nomce)= 'SEDE CENTRAL';
 end$$
 delimiter $$;

call apartado7_2();

/* EJERCICIO 7 VERSIÓN - CUALQUIER DEPARTAMENTO */
DROP PROCEDURE IF EXISTS ejer_5_2_7_v2;
DELIMITER $$
CREATE PROCEDURE ejer_5_2_7_v2(centro varchar(60))
BEGIN
	SELECT departamentos.nomde, departamentos.presude
    FROM departamentos join centros on departamentos.numce = centros.numce
    WHERE lower(trim(centros.nomce)) = lower(trim(centro)); 
END $$
DELIMITER ;

-- 8.Obtener el nombre de los centros de trabajo cuyo presupuesto esté entre 100000 € y 150000 €.
delimiter $$
drop procedure if exists apartado8_2$$
create procedure apartado8_2()
begin
	select centros.nomce
	  from centros
	   join 
	   departamentos on centros.numce= departamentos.numce
	where departamentos.presude between 100000 and 150000;
end$$ 
delimiter ;
 
 call apartado8_2();
 
 -- version eva con modificaciones
 DELIMITER $$
 DROP PROCEDURE IF EXISTS ejer_5_2_8;
CREATE PROCEDURE ejer_5_2_8
	(valorini decimal(9,2), valorfin decimal(9,2))
	-- call ejer_5_2_8(100000, 150000)
BEGIN
	SELECT centros.nomce, sum(departamentos.presude)/count(*),
		avg(departamentos.presude)
	FROM centros join departamentos 
		on centros.numce= departamentos.numce
	where departamentos.nomde like 'd%'
	GROUP BY centros.nomce
	
	having sum(departamentos.presude) between 300000 and 500000;
END $$

DELIMITER ;

-- 9.Obtener las extensiones telefónicas del departamento “Finanzas”. No deben salir extensiones repetidas

delimiter $$
drop procedure if exists apartado9_2$$
create procedure apartado9_2()
begin
	select distinct empleados.extelem
    from empleados
		join departamentos on empleados.numde = departamentos.numde
	where departamentos.nomde= trim('Finanzas');
end$$
delimiter ;

call apartado9_2();
-- version de eva solo con select sin estar en un procedimiento**************
-- pero si quisieramos obtener el numero de 
-- extensiones telefónicas de un depto:
-- no entra
SELECT count(distinct empleados.extelem)
FROM empleados join departamentos 
		on empleados.numde= departamentos.numde
WHERE departamentos.nomde = 'Proceso de datos';

-- Si quisiéramos obtener el numero de extensiones 
-- telefónicas que usa cada depto:
SELECT nomde, count(distinct empleados.extelem)
FROM empleados join departamentos 
		on empleados.numde= departamentos.numde
GROUP BY nomde;

SELECT nomde, empleados.extelem
FROM empleados join departamentos 
		on empleados.numde= departamentos.numde
order BY nomde;



