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
                            where fecanulacion is null and (adddate( fechainiestancia, interval reservas.numdiasestancia day )
                            not between fechaI and fechaF or (feciniestancia between fechaI and fechaF))
						     and casas.codzona = nzona 
                             );


end $$
delimiter ;
-- hay que anular la reserva para hacer la comprobacion
call ejercicio40('2012/3/22','2012/3/30',1);