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



