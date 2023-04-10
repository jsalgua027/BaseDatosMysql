/*
p1
Prepara una consulta que muestre, 
de la forma más eficientemente posible, 
todos los datos de las casas con capacidad de entre 4 y 6 personas de la provincia de Sevilla. 
*/

delimiter $$
drop procedure if exists ejer1_simuExaG1 $$
create procedure ejer1_simuExaG1 ()
begin
select *
from casas
where (maxpersonas between 4 and 6) and provincia = 'Sevilla' ;


end $$
delimiter ;


call ejer1_simuExaG1 ();


/*
p2
Prepara una consulta que muestre las 
reservas que se han anulado este año y 
el importe de la devolución (si se ha producido). 
Nos interesa mostrar el código de la reserva 
y el nombre y apellidos del cliente (en una sola columna). 
Ten en cuenta que no todas las reservas anuladas han provocado devolución 
y que solo existirá la fila en devoluciones para aquellas reservas con devolución.
*/
delimiter $$
drop procedure if exists ejer2_simuExaG1 $$
create procedure ejer2_simuExaG1 ()
begin

select  reservas.codreserva, concat_ws(' ', nomcli, ape1cli, ifnull(ape2cli,'No tiene')) as NombreCompleto,
		ifnull(importedevol, 'No tuvo anulación ') as ImporteDevolucion
from reservas join clientes on reservas.codcliente = clientes.codcli 
      join devoluciones on reservas.codreserva = devoluciones.codreserva
where year(reservas.fecanulacion)= year(curdate());

end $$
delimiter ;

call ejer2_simuExaG1 ();



