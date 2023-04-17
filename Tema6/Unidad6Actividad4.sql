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
begin 



end $$
delimiter ;