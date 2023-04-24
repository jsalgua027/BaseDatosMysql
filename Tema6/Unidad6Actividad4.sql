/*
26.Borrar de la tabla EMPLEADOS a los empleados cuyo salario (sin incluir la comisión) supere al salario medio de los empleados de su departamento.
27.Disminuir en la tabla EMPLEADOS un 5% el salario de los empleados que superan el 50% del salario máximo de su departamento.
40. Para la base de datos de turismo rural, queremos obtener las casas disponibles para una zona y un rango de fecha dados.
*/

-- 26.Borrar de la tabla EMPLEADOS a los empleados cuyo salario (sin incluir la comisión) supere al salario medio de los empleados de su departamento.


select avg(salarem) from empleados;

delete 
from empleados
where salarem  > all (select avg(salarem)
                  from empleados
                   );
                   
                   
/*
* EJER 26 
drop procedure if exists proc_ejer_6_4_26;
delimiter $$

create procedure proc_ejer_6_4_26()
begin
	-- call proc_ejer_6_4_26();
    -- el ejercicio pide que los borremos, pero, para verlo vamos a hacer una selección:
	/*select numem
	from empleados 
    where salarem >= (select avg(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
	
    -- HAGAMOS AHORA EL BORRADO COMO PIDE EL EJERCICIO
    delete from empleados 
    where empleados.salarem >= (select avg(e.salarem)
					  from empleados as e
/*                      where e.numde = empleados.numde);
end $$ 
delimiter ;


*/                   
                   
                   
-- 27.Disminuir en la tabla EMPLEADOS un 5% el salario de los empleados que superan el 50% del salario máximo de su departamento.

update  empleados
set salarem = salarem -(salarem*0.05)
where salarem > all (select* from empleados 
						where salarem > (max(salarem))/2);
                        
-- 40. Para la base de datos de turismo rural, queremos obtener las casas disponibles para una zona y un rango de fecha dados.

use  gbdturrural2015;

delimiter $$
drop procedure if exists ejercicio40 $$
create procedure ejercicio40
(
in nzona int,
in fechaI date,
in fechaF date
)
deterministic
begin 
/*select distinct casa.codcasa , casas.nomcasa, casa.codzona
	reservas.feciniestancia, reservas.numdiasestancia
    from casas
    join reservas on casas.codcasa= reservas.codcasa
    where casas.codzona= codzona
     and adddate(casa,feciniestancia, interval reservas.numdiasestancia days)not between and fechaI and fechaF;*/
  select codcasa 
  from casas 
  where codcasa not in (select codcasa
							from reservas 
                            where fecanulacion is null and (date_add( feciniestancia, interval reservas.numdiasestancia day )
                            not between fechaI and fechaF or (feciniestancia between fechaI and fechaF))
						     and casas.codzona = nzona 
                             );


end $$
delimiter ;
-- hay que anular la reserva para hacer la comprobacion
call ejercicio40(1,'2012/3/22','2012/3/30');



/*
1*Obtener por orden alfabético el nombre y los sueldos de los empleados con más de tres hijos.
2*Obtener la comisión, el departamento y el nombre de los empleados cuyo salario es inferior a 190.000 u.m., clasificados por departamentos en orden creciente y por comisión en orden decreciente dentro de cada departamento.
3*Hallar por orden alfabético los nombres de los deptos cuyo director lo es en funciones y no en propiedad.
4*Obtener un listín telefónico de los empleados del departamento 121 incluyendo el nombre del empleado, número de empleado y extensión telefónica. Ordenar alfabéticamente.
5*Hallar la comisión, nombre y salario de los empleados con más de tres hijos, clasificados por comisión y dentro de comisión por orden alfabético.
6*Hallar por orden de número de empleado, el nombre y salario total (salario más comisión) de los empleados cuyo salario total supere las 300.000 u.m. mensuales. 
7*Obtener los números de los departamentos en los que haya algún empleado cuya comisión supere al 20% de su salario.
8*Hallar por orden alfabético los nombres de los empleados tales que si se les da una gratificación de 100 u.m. por hijo el total de esta gratificación no supere a la décima parte del salario.
9*Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su presupuesto anual por 12. Supongamos que se decide aumentar los presupuestos medios de todos los deptos en un 10% a partir del mes de octubre inclusive. Para los deptos. cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m. Hallar por orden alfabético el nombre de departamento y su presupuesto anual total después del incremento.
10 Suponiendo que en los próximos tres años el coste de vida va a aumentar un 6% anual y que se suben los salarios en la misma proporción. Hallar para los empleados con más de cuatro hijos, su nombre y sueldo anual, actual y para cada uno de los próximos tres años, clasificados por orden alfabético.
11*Hallar por orden de número de empleado, el nombre y salario total (salario más comisión) de los empleados cuyo salario total supera al salario mínimo en 300.000 u.m. mensuales.
12*se desea hacer un regalo de un 1% del salario a los empleados en el día de su onomástica. Hallar por orden alfabético, los nombres y cuantía de los regalos en u.m. para los que celebren su santo el día de San Honorio.
13*Obtener por orden alfabético los nombres y los salarios de los empleados del depto. 111 que tienen comisión, si hay alguno de ellos cuya comisión supere al 15% de su salario.

14*En la fiesta de Reyes se desea organizar un espectáculo para los hijos de los empleados, que se representará en dos días diferentes. El primer día asistirán los empleados cuyo apellido empiece por las letras desde la “A” hasta la “L”, ambas inclusive. El segundo día se darán invitaciones para el resto. A cada empleado se le asignarán tantas invitaciones como hijos tenga y dos más. Además en la fiesta se entregará a cada empleado un obsequio por hijo. Obtener una lista por orden alfabético de los nombres a quienes hay que invitar el primer día de la representación, incluyendo también cuantas invitaciones corresponden a cada nombre y cuantos regalos hay que preparar para él.
15 Hallar los nombres de los empleados que no tienen comisión, clasificados de manera que aparezcan primero aquellos cuyos nombres son más cortos.
16 Hallar cuántos departamentos hay y el presupuesto anual medio de ellos.
17 *Hallar el salario medio de los empleados cuyo salario no supera en más de un 20% al salario mínimo de los empleados que tienen algún hijo y su salario medio por hijo es mayor que 100.000 u.m.
18 Hallar la diferencia entre el salario más alto y el más bajo.
19 Hallar el número medio de hijos por empleado para todos los empleados que no tienen más de dos hijos.
20 Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tengan.
21 Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos.
22 Para los departamentos cuyo salario medio supera al de la empresa, hallar cuantas extensiones telefónicas tienen.
23 Hallar el máximo valor de la suma de los salarios de los departamentos.
24 Hallar por orden alfabético, los nombres de los empleados que son directores en funciones.
25 A los empleados que son directores en funciones se les asignará una gratificación del 5% de su salario. Hallar por orden alfabético, los nombres de estos empleados y la gratificación correspondiente a cada uno.
26 Borrar de la tabla EMPLEADOS a los empleados cuyo salario (sin incluir la comisión) supere al salario medio de los empleados de su departamento.
27 Disminuir en la tabla EMPLEADOS un 5% el salario de los empleados que superan el 50% del salario máximo de su departamento.
28 Crear una vista en la que aparezcan todos los datos de los empleados que cumplen 65 años de edad este año.
29 Seleccionar los nombres de los  departamentos que no dependan de ningún otro.
30 Obtener por orden alfabético los nombres de los empleados cuyo salario igualen o superen al de Claudia Fierro en más de un 50%.
31 Obtener los nombres de los centros, si hay alguno en la C/ Atocha.
32 Obtener el nombre de los empleados cuyo salario supere al salario de cualquiera de los empleados del departamento 121.
33 Obtener los nombres y salarios de los empleados cuyo salario coincide con la comisión de algún otro o la suya propia.
34 Obtener por orden alfabético los nombres de los empleados que trabajan en el mismo departamento que Pilar Gálvez o Dorotea Flor.
35 Obtener por orden alfabético los nombres de los empleados cuyo salario supere en tres veces y media o más al mínimo salario de los empleados del departamento 122.
36 Hallar el salario máximo y mínimo para cada grupo de empleados con igual número de hijos y que tienen al menos uno, y solo si hay más de un empleado en el grupo.
37 Hallar el centro de trabajo (nombre y dirección) de los empleados sin comisión.
38 Hallar cuantos empleados no tienen comisión en un centro dado.
39 Hallar cuantos empleados no tienen comisión por cada centro de trabajo.
40 Para la base de datos de turismo rural, queremos obtener las casas disponibles para una zona y un rango de fecha dados.


*/

-- 1*Obtener por orden alfabético el nombre y los sueldos de los empleados con más de tres hijos.

delimiter $$
drop procedure if exists eje1_4$$
create procedure  eje1_4 ()
begin
select empleados.nomem, empleados.salarem
from empleados
where empleados.numhiem >=3
order by empleados.nomem;

end$$
delimiter ;

call  eje1_4();

-- 2*Obtener la comisión, el departamento y el nombre de los empleados cuyo salario es inferior a 190.000 u.m., clasificados por departamentos en orden creciente y por comisión en orden decreciente dentro de cada departamento.
delimiter $$
drop procedure if exists eje2_4$$
create procedure  eje2_4 ()
begin
select empleados.comisem, empleados.numde, empleados.nomem
from empleados
             join departamentos
             on empleados.numde = departamentos.numde
where	empleados.salarem< 19000
order by  empleados.numde asc, empleados.comisem desc;
end$$
delimiter ;

call eje2_4();

-- 3*Hallar por orden alfabético los nombres de los deptos cuyo director lo es en funciones y no en propiedad.
delimiter $$
drop procedure if exists eje3_4$$
create procedure  eje3_4 ()
begin
select departamentos.nomde
from departamentos join 
	dirigir on departamentos.numde = dirigir.numdepto
where ifnull(dirigir.fecfindir, curdate())>=curdate() and dirigir.tipodir ="F"
order by departamentos.nomde asc;
end$$
delimiter ;

call eje3_4();

-- 4*Obtener un listín telefónico de los empleados del departamento 121 incluyendo el nombre del empleado, número de empleado y extensión telefónica. Ordenar alfabéticamente.

delimiter $$
drop procedure if exists eje4_4$$
create procedure  eje4_4 ()
begin
select concat_ws(' ', empleados.nomem, empleados.ape1em) as nombre, empleados.numem as numero, empleados.extelem as extension
from empleados
where empleados.numde=121
order by empleados.nomem asc;
end$$
delimiter ;

call eje4_4();


-- 5*Hallar la comisión, nombre y salario de los empleados con más de tres hijos, clasificados por comisión y dentro de comisión por orden alfabético.

delimiter $$
drop procedure if exists eje5_4$$
create procedure  eje5_4 ()
begin
select concat_ws(' ', empleados.nomem, empleados.ape1em) as nombre, empleados.salarem
from empleados
where empleados.numhiem>3
-- group by empleados.comisem
order by empleados.comisem asc, empleados.nomem asc;
end$$
delimiter ;

call eje5_4();

-- 6*Hallar por orden de número de empleado, el nombre y salario total (salario más comisión) de los empleados cuyo salario total supere las 300.000 u.m. mensuales.


delimiter $$
drop procedure if exists eje6_4$$
create procedure  eje6_4 ()
begin
select concat_ws(' ', empleados.nomem, empleados.ape1em) as nombre,   empleados.salarem + ifnull(empleados.comisem,0) as sueldo
from empleados
where  empleados.salarem + ifnull(empleados.comisem,0) >10000  -- pon esa cantidad porque no hay nadie mayor de 300000
order by empleados.numem asc;
end$$
delimiter ;

call eje6_4();

-- 7*Obtener los números de los departamentos en los que haya algún empleado cuya comisión supere al 20% de su salario.
delimiter $$
drop procedure if exists eje7_4$$
create procedure  eje7_4 ()
begin
select distinct numde
from empleados
		
where empleados.comisem > empleados.salarem*0.20; 
end$$
delimiter ;

call eje7_4();

-- 8*Hallar por orden alfabético los nombres de los empleados tales que si se les da una gratificación de 100 u.m. por hijo el total de esta gratificación no supere a la décima parte del salario.

delimiter $$
drop procedure if exists eje8_4$$
create procedure  eje8_4 ()
begin
select empleados.numem , empleados.ape1em, empleados.numhiem
from empleados
where numhiem >0 and numhiem*100 <= salarem/10
order by empleados.numem , empleados.ape1em, empleados.numhiem asc;
end$$
delimiter ;

call eje8_4();
/*
9*Llamaremos presupuesto medio mensual de un depto. al resultado de dividir su presupuesto anual por 12.
 Supongamos que se decide aumentar los presupuestos medios de todos los deptos en un 10% a partir del mes de octubre inclusive.
 Para los deptos. cuyo presupuesto mensual anterior a octubre es de más de 500.000 u.m.
 Hallar por orden alfabético el nombre de departamento y su presupuesto anual total después del incremento.

*/

delimiter $$
drop procedure if exists eje9_4$$
create procedure  eje9_4 ()
begin
select departamentos.nomde,
/*
departamentos.presude as Anual,
    departamentos.presude/12 as Mensual,
    departamentos.presude/12*9 as hastaSep,
     departamentos.presude/12*3 as Oct_Dic,
       departamentos.presude/12*3*1.1 as IncrementoOct_dic
*/
	(departamentos.presude/12*9) +( departamentos.presude/12*3*1.1) as total
from departamentos
where departamentos.presude/12*9> 500000
order by departamentos.nomde;   
end$$
delimiter ;

call eje9_4();

-- *************************************************TODOS RESUELTOS POR EVA***************************************
/* 1 */
drop procedure if exists proc_ejer_6_4_1;
delimiter $$

create procedure proc_ejer_6_4_1()
begin
	-- call proc_ejer_6_4_1();
	select  concat_ws(' ', ape1em, ape2em, nomem) as nombre, empleados.salarem
	from empleados
	where numhiem >3
	order by nombre;
	
end $$
delimiter ;
/*
-- versión generalizada:
drop procedure if exists proc_ejer_6_4_1_v2;
delimiter $$

create procedure proc_ejer_6_4_1_v2
	(numeroHijos int)
begin
	-- call proc_ejer_6_4_1_v2(3);
	select  concat_ws(' ', ape1em, ape2em, nomem) as nombre, empleados.salarem
	from empleados
	where numhiem >numeroHijos
	order by nombre;
	
end $$
delimiter ;

*/

/* 2 */
drop procedure if exists proc_ejer_6_4_2;
delimiter $$

create procedure proc_ejer_6_4_2()
begin
	-- call proc_ejer_6_4_2();
	select departamentos.nomde, empleados.comisem,
		empleados.salarem
	from empleados join departamentos
		on departamentos.numde = empleados.numde
	where empleados.salarem <190000
	order by empleados.nomde asc, empleados.comisem desc;
	
end $$
delimiter ;
/* 2 modificación
para los empleados sin comisión que se muestre el
texto "SIN COMISIÓN"
Y para el tope de salario que elijamos
*/
drop procedure if exists proc_ejer_6_4_2_mod;
delimiter $$

create procedure proc_ejer_6_4_2_mod(sueldotope decimal(7,2))
begin
	-- call proc_ejer_6_4_2(190000);
	select departamentos.nomde, ifnull(empleados.comisem, 'SIN COMISIÓN'),
		empleados.salarem
	from empleados join departamentos
		on departamentos.numde = empleados.numde
	where empleados.salarem <sueldotope
	order by empleados.nomde asc, empleados.comisem desc;
	
end $$
delimiter ;

/* 3 */
drop procedure if exists proc_ejer_6_4_3;
delimiter $$

create procedure proc_ejer_6_4_3()
begin
	-- call proc_ejer_6_4_3();
	select departamentos.nomde
	from departamentos join dirigir
		on departamentos.numde = dirigir.numdepto
	where ifnull(dirigir.fecfindir, curdate()) >=curdate()
		and dirigir.tipodir = 'F'
	order by departamentos.nomde asc;
	
end $$
delimiter ;

/* generalización:
drop procedure if exists proc_ejer_6_4_3_v2;
delimiter $$

create procedure proc_ejer_6_4_3_v2
	(tipoDireccion char(1))
begin
	-- call proc_ejer_6_4_3_v2('F');
	select departamentos.nomde
	from departamentos join dirigir
		on departamentos.numde = dirigir.numdepto
	where ifnull(dirigir.fecfindir, curdate()) >=curdate()
		and dirigir.tipodir = tipoDireccion
	order by departamentos.nomde asc;
	
end $$
delimiter ;
*/
/* 4 */
drop procedure if exists proc_ejer_6_4_4;
delimiter $$

create procedure proc_ejer_6_4_4()
begin
	-- call proc_ejer_6_4_4();
	select concat_ws(' ', ape1em, ape2em, nomem) as nombre, numem as 'número de empleado', 
		extelem as extensión
	from empleados
	where numde = 121
    order by nombre asc; -- la opción asc es la opción por defecto, por lo que no es necesario escribirla
    -- order by 1 asc;
    -- order by concat_ws(' ', ape1em, ape2em, nomem) asc;
    -- order by ape1em asc, ape2em asc, nomem asc;
	
end $$
delimiter ;

/* Versión generalizada:
drop procedure if exists proc_ejer_6_4_4_v2;
delimiter $$

create procedure proc_ejer_6_4_4_v2
	(depto int)
begin
	-- call proc_ejer_6_4_4(121);
	select concat_ws(' ', ape1em, ape2em, nomem) as nombre, numem as 'número de empleado', 
		extelem as extensión
	from empleados
	where numde = depto
    order by nombre asc; -- la opción asc es la opción por defecto, por lo que no es necesario escribirla
    -- order by 1 asc;
    -- order by concat_ws(' ', ape1em, ape2em, nomem) asc;
    -- order by ape1em asc, ape2em asc, nomem asc;
	
end $$
delimiter ;
*/
/* 5 */

drop procedure if exists proc_ejer_6_4_5;
delimiter $$

create procedure proc_ejer_6_4_5()
begin
	-- call proc_ejer_6_4_5();
	select comisem as comision, concat_ws(' ', ape1em, ape2em, nomem) as nombre, numem as 'número de empleado', 
		salarem as salario
	from empleados
	where numhiem > 3
    order by comision asc, nombre asc; 
    -- order by 1 asc,2 asc;
    -- order by comisem asc, concat_ws(' ', ape1em, ape2em, nomem) asc;
    -- order by comisem asc, ape1em asc, ape2em asc, nomem asc;
end $$
delimiter ;
-- la generalización se haría como el ejercicio 2.

/* 6 
mostrar ordenados por el número de empleado 
el nombre y el salario total de los empleados 
(salario más comisión)
de aquellos cuyo salario total sea mayor que 300000 u.m.
*/
drop procedure if exists proc_ejer_6_4_6;
delimiter $$

create procedure proc_ejer_6_4_6()
begin
	-- call proc_ejer_6_4_6();
	select numem,
		concat_ws(' ', nomem, ape1em, ape2em) as nombre,
		salarem + ifnull(comisem,0) as sueldo
	from empleados 
	where salarem + ifnull(comisem,0) >1000
	order by numem;
	
end $$
delimiter ;

/* 7.
*Obtener los números de los departamentos en los que 
haya algún empleado cuya comisión
supere al 20% de su salario.
*/
drop procedure if exists proc_ejer_6_4_7;
delimiter $$

create procedure proc_ejer_6_4_7()
begin
	-- call proc_ejer_6_4_7();
	select distinct numde
	from empleados 
	where ifnull(comisem,0) >0.20*salarem;
	
end $$
delimiter ;

/*8. Hallar por orden alfabético los nombres 
de los empleados tales que si se les da una 
gratificación de 100 u.m. por hijo el total 
de esta gratificación no supere a la décima 
parte del salario
*/
drop procedure if exists proc_ejer_6_4_8;
delimiter $$

create procedure proc_ejer_6_4_8()
begin
	-- call proc_ejer_6_4_8();
	select ape1em, ape2em, nomem, numhiem
	from empleados
	where numhiem > 0 and numhiem*100 <= salarem/10
	order by ape1em, ape2em, nomem;
	
end $$
delimiter ;

drop procedure if exists proc_ejer_6_4_9;
delimiter $$

create procedure proc_ejer_6_4_9()
begin
	-- call proc_ejer_6_4_9();
	select nomde, 
		-- presude as anual, 
		-- presude/12 as mensual,
		-- presude/12*9 as 'hasta sept',
		-- presude/12*3 'de oct a dic',
		-- presude/12*3*1.1 'increm de oct a dic',
		(presude/12*9) + (presude/12*3*1.1) as total
	from departamentos
	where presude/12*9 >50000
	order by nomde;

/*
-- para modificar los datos realmente
-- tendríamos que hacer un update:

UPDATE departamentos
set presude = round((presude/12*9) + (presude/12*3*1.1),
					2)
where presude/12*9 >50000;
*/	
end $$
delimiter ;

/* EJER 10 */
drop procedure if exists proc_ejer_6_4_10;
delimiter $$

create procedure  proc_ejer_6_4_10()
begin
	-- call proc_ejer_6_4_10();
	select  concat_ws(' ', ape1em, ape2em, nomem) as nombre, empleados.salarem as 'salario actual',
		empleados.salarem*1.06 as 'salario prox año', empleados.salarem*1.06*1.06 as 'salario en 2 años',
		empleados.salarem*1.06*1.06*1.06 as 'salario en 3 años'
	from empleados
	where numhiem >4
	order by nombre;
end $$
delimiter ;
-- versión generalizada: podríamos incluir un parámetro para decidir para que número de hijos mínimo hacerlo
-- y otro parámetro para el porcentaje de incremento del salario

/* EJER 11 */
drop procedure if exists proc_ejer_6_4_11;
delimiter $$

create procedure  proc_ejer_6_4_11()
begin
	-- call proc_ejer_6_4_11();
	select  numem as 'numero empleado', concat_ws(' ', ape1em, ape2em, nomem) as nombre, 
		salarem + ifnull(comisiem,0) as 'salario total'
	from empleados
	where salarem + ifnull(comisiem,0) > 300+(select min(salarem)
											from empleados)
	order by numem; -- esto no sería necesario ya que es la PK y por defecto se ordena por la PK.
/* nota.- En el enunciado dice que supere en 300.000 unidades monetarias, pero esto en la unidad actual (euro)
   no tiene sentido.
   Por tanto, vamos a hacerlo para los que superen en 300 unidades monetarias (euros) al salario mínimo
*/
end $$
delimiter ;
-- versión generalizada: podríamos incluir un parámetro para decidir para que número de hijos mínimo hacerlo
-- y otro parámetro para el porcentaje de incremento del salario

/* 12
listado de regalo honomástica (día de San Honorio */
drop procedure if exists proc_ejer_6_4_12;
delimiter $$

create procedure proc_ejer_6_4_12()
begin
	-- call proc_ejer_6_4_12();
	-- call proc_ejer_6_4_12();
	select nomem, salarem*0.01 as gratificacion 
	from empleados
	where nomem rlike 'Honori[ao]$'
	order by nomem;

end $$
delimiter ;

/* 12 - generalización
listado de regalo cualquier honomástica */
drop procedure if exists proc_ejer_6_4_12_v2;
delimiter $$

create procedure proc_ejer_6_4_12_v2
	(nombre varchar(30))
begin
	-- call proc_ejer_6_4_12_v2('honori[ao]$');
	-- call proc_ejer_6_4_12_v2('honoria');
    -- call proc_ejer_6_4_12_v2('honorio');
    -- call proc_ejer_6_4_12_v2('Ana');
    -- cualquier otro....
    
	select nomem, salarem*0.01 as gratificacion 
	from empleados
	where nomem rlike nombre
	order by nomem;
end $$
delimiter ;
/* EJER 13 */
drop procedure if exists proc_ejer_6_4_13;
delimiter $$

create procedure proc_ejer_6_4_13()
begin
	-- call proc_ejer_6_4_13();
	select concat_ws(' ', ape1em, ape2em, nomem) as nombre, empleados.salarem
	from empleados
	where numde = 111 and
		exists (select *
				from empleados
                where numde = 111 and comisem > 0.15*salarem)
	order by nomem;
end $$
delimiter ;
-- la generalización podría ser para un departamento dado y para un porcentaje dado...

/* EJER 14 */
drop procedure if exists proc_ejer_6_4_14;
delimiter $$
create procedure proc_ejer_6_4_14
	(in letraini char(1),
	 in letrafin char(1)
    )
begin
 -- call proc_ejer_6_4_14('a','l');
 -- call proc_ejer_6_4_14('m','z');
 -- call proc_ejer_6_4_14('c','f');
 
	declare expresion char(6) default '';
    -- tenemos que formar expresiones regulares de la siguiente forma ==> '^[a-l]', '^[m-z]', '^[c-f]',....
    set expresion = concat('^[',letraini,'-',letrafin,']');
    
    select concat_ws(' ', ape1em, ape2em, nomem) as empleado, 
		numhiem+2 as invitaciones, numhiem as regalos_reyes
    from empleados
    -- where numhiem >0 and ape1em regexp expresion
    -- where numhiem >0 and ape1em regexp concat('^[',letraini,'-',letrafin,']')
    -- where numhiem >0 and regexp_rlike(ape1em , concat('^[',letraini,'-',letrafin,']'))
    where numhiem >0 and regexp_rlike(ape1em , expresion)
    order by ape1em;
end $$
delimiter ;

/* EJER 15 */

drop procedure if exists proc_ejer_6_4_15;
delimiter $$

create procedure proc_ejer_6_4_15()
begin
	-- call proc_ejer_6_4_15();
	select count(*) as numero_deptos, sum(presude) as presupuesto
	from departamentos;
	
end $$
delimiter ;

/*16. Hallar cuántos departamentos hay y el presupuesto 
anual medio de ellos.
*/
/* si nos pidieran solo el número de deptos */
drop function if exists funcion_ejer_6_4_16;
delimiter $$

create function funcion_ejer_6_4_16()
returns int
begin
	-- select funcion_ejer_6_4_16();
	declare numdeptos int;
	set numdeptos = 
					(select count(*)
					from departamentos);

	return numdeptos;

	/* return (select count(*)
			   from departamentos);
	*/

end $$
delimiter ;

/* con un procedimiento */
drop procedure if exists proc_ejer_6_4_16;
delimiter $$

create procedure proc_ejer_6_4_16(out numdeptos int)
begin
	/* call proc_ejer_6_4_16(@numerodeptos);
		select @numerodeptos;
	*/
	
	set numdeptos = 
					(select count(*)
					from departamentos);

end $$
delimiter ;
/* tal y como es el enunciado: */
drop procedure if exists proc_ejer_6_4_16_real;
delimiter $$

create procedure proc_ejer_6_4_16_real
	(out numdeptos int, out mediapresu decimal(10,2))
begin
	/* call proc_ejer_6_4_16_real(@numerodeptos, @presupuesto);
		select 'num deptos: ',@numerodeptos, 'presupuesto medio: ', @presupuesto;
		select concat('num deptos: ',@numerodeptos, ' presupuesto medio: ', @presupuesto);
	*/
	select count(*), sum(presude) into numdeptos, mediapresu
	from departamentos;

end $$
delimiter ;

/* EJER 17 */

/*
*Hallar el salario medio de los empleados cuyo salario no supera en más de un 20% al salario
mínimo de los empleados que tienen algún hijo y su salario medio por hijo es mayor que
100.000
*/
drop procedure if exists proc_ejer_6_4_17;
delimiter $$

create procedure proc_ejer_6_4_17
	()
begin
	--  call proc_ejer_6_4_17();
	
	select avg(salarem)
	from empleados
    where salarem <= all (select 1.20*min(salarem)
							from empleados
                            where numhiem>0
                            group by numhiem
                            having avg(salarem) > 100);

end $$
delimiter ;
/* EJER 18 */
drop procedure if exists proc_ejer_6_4_18;
delimiter $$

create procedure proc_ejer_6_4_18()
begin
	/* call proc_ejer_6_4_18();
	*/
	
	select max(salarem) - min(salarem) as diferencia
	from empleados;
end $$
delimiter ;

/* EJER 19 */
drop procedure if exists proc_ejer_6_4_19;
delimiter $$

create procedure proc_ejer_6_4_19()
begin
	/* call proc_ejer_6_4_19();
	*/
	
	select round(avg(numhiem)/count(*), 2)
    from empleados
	where numhiem <= 2;
end $$
delimiter ;

/* ejercicio 20 */
/* con un procedimiento */
drop procedure if exists proc_ejer_6_4_20;
delimiter $$

create procedure proc_ejer_6_4_20()
begin
	/* call proc_ejer_6_4_20();
	*/
	
	select ifnull(comisem, 'sin comisión'), 
		   avg(salarem) as salario_medio, count(*)
	from empleados
	group by ifnull(comisem, 'sin comisión')
	having count(*) > 1;
end $$
delimiter ;

/* ejercicio 21 */
/* con un procedimiento */
drop procedure if exists proc_ejer_6_4_21;
delimiter $$

create procedure proc_ejer_6_4_21()
begin
	/* call proc_ejer_6_4_21();
	*/	
	select extelem, count(*) as numero_usuarios,  
		   avg(salarem) as salario_medio
	from empleados
	group by extelem;

	/* igual pero ahora solo me interesa obtener
	   las extensiones que son utilizadas por entre
	   1 y 3 personas
	*/
	select extelem, count(*) as numero_usuarios,  
		   avg(salarem) as salario_medio
	from empleados
	group by extelem
	having count(*) between 1 and 3;

end $$
delimiter ;

/* numero medio de usuarios que utilizan las extensiones
   telefónicas
*/
drop procedure if exists proc_ejer_6_4_21_B;
delimiter $$

create procedure proc_ejer_6_4_21_B()
begin
	/* call proc_ejer_6_4_21_B();
	*/

	select avg(e.numero_usuarios)
	from (
	select extelem, count(*) as numero_usuarios,  
		   avg(salarem) as salario_medio
	from empleados
	group by extelem) as e;

end $$
delimiter ;
/* EJER 22 */
drop procedure if exists proc_ejer_6_4_22;
delimiter $$

create procedure proc_ejer_6_4_22()
begin
	/* call proc_ejer_6_4_22();
	*/
SELECT empleados.numde, departamentos.nomde, 
	count(DISTINCT empleados.extelem)
FROM empleados JOIN departamentos 
	on departamentos.numde=empleados.numde
GROUP BY empleados.numde
HAVING avg(empelados.salarem)>
					(SELECT avg(salarem) 
					 FROM empleados)
ORDER BY 1;
end $$
delimiter ;

/* EJER 23 */
drop procedure if exists proc_ejer_6_4_23;
delimiter $$

create procedure proc_ejer_6_4_23()
begin
	-- call proc_ejer_6_4_23();
	select numde, sum(salarem)
	from empleados
	group by numde
	having sum(salarem) >= all (select sum(salarem)
								from empleados
								group by numde);
end $$
delimiter ;

/* EJER 24 */
drop procedure if exists proc_ejer_6_4_24;
delimiter $$

create procedure proc_ejer_6_4_24()
begin
	-- call proc_ejer_6_4_24();
	-- Aunque no lo pide el ejercicio, vamos añadir el nombre del departamento que dirige
    -- estamos seleccionando a los directores actuales
    select nomde as departamento, concat_ws(' ', ape1em, ape2em, nomem) as 'director/a'
	from empleados join dirigir
		on empleados.numem = dirigir.numempdirec
			join departamentos
				on dirigir.numdepto = departamentos.numde
	where tipodir= 'F' and ifnull(fecfindir,curdate())>= curdate();
end $$
delimiter ;

/* EJER 25 */
drop procedure if exists proc_ejer_6_4_25;
delimiter $$

create procedure proc_ejer_6_4_25()
begin
	-- call proc_ejer_6_4_25();
	select concat_ws(' ', ape1em, ape2em, nomem) as 'director/a', 
		salarem*0.05 as gratificacion, nomde as departamento
	from empleados join dirigir
		on empleados.numem = dirigir.numempdirec
			join departamentos
				on dirigir.numdepto = departamentos.numde
	where tipodir= 'F' and ifnull(fecfindir,curdate())>= curdate()
    order by 1;
end $$
delimiter ;

/* EJER 26 */
drop procedure if exists proc_ejer_6_4_26;
delimiter $$

create procedure proc_ejer_6_4_26()
begin
	-- call proc_ejer_6_4_26();
    -- el ejercicio pide que los borremos, pero, para verlo vamos a hacer una selección:
	/*select numem
	from empleados 
    where salarem >= (select avg(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
	*/
    -- HAGAMOS AHORA EL BORRADO COMO PIDE EL EJERCICIO
    delete from empleados 
    where salarem >= (select avg(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);

start transaction;
create temporary table if not exists temp
select numde, avg(empleados.salarem) as media
from empleados
group by numde;

delete from empleados
where empleados.salarem > (select media 
						   from temp
                           where empleados.numde = temp.numde);

drop temporary table  if exists temp;
commit;
end $$
delimiter ;

end $$
delimiter ;

/* EJER 27 */
drop procedure if exists proc_ejer_6_4_27;
delimiter $$

create procedure proc_ejer_6_4_27()
begin
	-- call proc_ejer_6_4_27();
    -- el ejercicio pide que actualicemos, pero, para verlo vamos a hacer una selección:
	/*select numem
	from empleados 
    where salarem > 0.50*(select max(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
	*/
    -- HAGAMOS AHORA LA ACTUALIZACIÓN COMO PIDE EL EJERCICIO versiones anteriores de mySQL
/*    update empleados 
    set salarem = salarem*0.95
    where salarem > 0.50*(select max(salarem)
					  from empleados as e
                      where e.numde = empleados.numde);
*/

-- en nuevas versiones, por cuestiones de bloqueo transaccional en operaciones update/delete/insert no se puede hacer como aparece anteriormente. Solución:






/* ejer 28 */

-- select nomem, year(curdate()), year(fecnaem), 
-- 	year(curdate()) -year(fecnaem) , datediff(curdate(), fecnaem)
create view jubilados
as 
select *
from empleados
-- los que cumplen 65 años en el año actual
-- where year(curdate()) -year(fecnaem) = 65

-- los que ya tienen cumplidos los 65 a fecha de hoy
where date_add(fecnaem, interval 65 year) <= curdate();

-- los que ya tienen cumplidos los 65 a fecha de hoy y los han
-- cumplido este año
-- where date_add(fecnaem, interval 65 year) <= curdate()
-- 	and year(curdate()) = year(date_add(fecnaem, interval 65 year))

-- en lugar de date_add, podríamos usar también date_sub:
-- where date_sub(curdate(), interval 65 year) >= fecnaem
select * from  jubilados;

/* EJER 29 */
drop procedure if exists proc_ejer_6_4_29;
delimiter $$

create procedure proc_ejer_6_4_29()
begin
	/* call proc_ejer_6_4_29();
	*/
	select nomde
    from departamentos 
    where depende is null;
end $$
delimiter ;

/* EJER 30 */
drop procedure if exists proc_ejer_6_4_30;
delimiter $$

create procedure proc_ejer_6_4_30(in nombre varchar(92))
begin
	/* call proc_ejer_6_4_30('Claudia Fierro');
	*/
SELECT concat(ape1em, ' ', 
	ifnull(ape2em,''),', ', nomem) as nombre
FROM empleados
WHERE salarem >= (SELECT salarem *1.5
				  FROM empleados
				  WHERE concat(nomem, ' ', ape1em, 
							   ifnull(concat(' ', ape2em),'')
							   ) = nombre
				)
ORDER BY 1;
end $$
delimiter ;


SELECT numhiem , count(*), max(salarem) as salar_maximo, 
	min(salarem) as salar_minimo
FROM empleados
WHERE numhiem > 0
GROUP BY numhiem
HAVING count(*) >1
ORDER BY 1;

/* ejer 31 */
drop procedure if exists proc_ejer_6_4_31;
delimiter $$

create procedure proc_ejer_6_4_31()
begin
	/* call proc_ejer_6_4_31();
	*/
	select nomce
	from centros 
	-- where exists (select * from centros where dirce like '%C.  atocha%');
    where exists (select * from centros where dirce rlike '(C.|C/|Calle)*atocha');
end $$
delimiter ;
-- la generalización podría ser incluir un parámetro para que pudieramos buscar cualquier calle
/* ejer 32 */

SELECT concat(ape1em , ' ' , ifnull(ape2em,'') , ', ' , nomem) as nombre
FROM empleados
WHERE salarem> all(SELECT salarem
				   FROM empleados
				   WHERE numde = 121);

-- o también:
SELECT concat(ape1em , ' ' , ifnull(ape2em,'') , ', ' , nomem) as nombre
FROM empleados
WHERE salarem> (SELECT max(salarem)
				FROM empleados
				WHERE numde = 121);

/* ejer 33 */
SELECT nomem, ape1em, ape2em, salarem, comisem
FROM empleados
-- wHERE salarem in (SELECT comisem FROM empleados);
-- WHERE salarem = any(SELECT comisem FROM empleados);
-- WHERE salarem = some(SELECT comisem FROM empleados);
WHERE not salarem <> all (SELECT ifnull(comisem,0) FROM empleados);
/* ejer 33 al reves*/
SELECT nomem, ape1em, ape2em, salarem, comisem
FROM empleados
-- wHERE salarem not in (SELECT ifnull(comisem,0) FROM empleados);
WHERE salarem <> all (SELECT ifnull(comisem,0) FROM empleados);

SELECT comisem FROM empleados;
-- WHERE salarem = some(SELECT comisem FROM empleados);


/* EJER 34 */

SELECT CONCAT(ape1em , ' ' , iFnull(ape2em,'') , ', ' , nomem) AS NOMBRE
FROM empleados
WHERE numde IN (SELECT numde
			   FROM empleados
			   WHERE (ape1em = 'GALVEZ' AND nomem = 'PILAR')
					 OR (ape1em = 'FLOR' AND nomem = 'DOROTEA'))
ORDER BY 1;

-- O TAMBIÉN:

SELECT CONCAT(ape1em , ifnull(concat(' ',ape2em),'') , ', ' , nomem) AS NOMBRE
FROM empleados
WHERE numde =(SELECT numde
			  FROM empleados
			  WHERE ape1em = 'GALVEZ' AND nomem = 'PILAR')
	OR numde = (SELECT numde
			    FROM empleados
				WHERE ape1em = 'FLOR' AND nomem = 'DOROTEA')
ORDER BY 1;




/* ejer 35 */

SELECT nomem
FROM empleados
WHERE salarem >= (SELECT min(salarem)*3.5
				  FROM empleados
				  WHERE numde =122)
ORDER BY nomem;

/* ejer 36 */

SELECT numhiem, count(*), max(salarem) as salario_max, min(salarem) as salario_min
FROM empleados
where numhiem >=1
group by numhiem
having count(*) > 1;


/* ejerccio 40 ==> buscar casa disponibles en un rango dado y para una zona.
DROP PROCEDURE IF EXISTS casasDisponibles ;
delimiter $$
CREATE PROCEDURE casasDisponibles (IN fechaInicio DATE, IN fechaFin DATE, IN codigoZona INT)
BEGIN
  SELECT codcasa, nomcasa
  FROM casas
  WHERE codcasa NOT IN (
						SELECT codcasa 
						FROM reservas 
						WHERE fecanulacion is null 
							and ((feciniestancia BETWEEN fechaInicio AND fechaFin) 
								OR (date_add(feciniestancia, interval numdiasestancia day) BETWEEN fechaInicio AND fechaFin)
								)
                        ) 
	AND codzona = codigoZona;
END $$
delimiter ;

-- probad estos casos:
call casasDisponibles ('2012/3/22', '2012/3/30', 1);

call casasDisponibles ('2012/3/18', '2012/3/22', 1);

call casasDisponibles ('2012/3/21', '2012/3/23', 1);

call casasDisponibles ('2012/3/18', '2012/3/30', 1);

