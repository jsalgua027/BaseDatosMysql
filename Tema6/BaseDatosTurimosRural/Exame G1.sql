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

/*
p3
Prepara un procedimiento que, dado un código de característica,
 muestre el código de casa, nombre,  
 población y tipo de casa (nombre del tipo) de las casas que tienen esa característica.
 Queremos mostrar los datos por poblaciones y, dentro de una población, las más caras (precio base) primero. 

*/
delimiter $$
drop procedure if exists ejer3_simuExaG1 $$
create procedure  ejer3_simuExaG1 
	(
   in codigoCaract int 
    
    )
begin 
select casas.codcasa, casas.nomcasa,casas.poblacion, tiposcasa.nomtipo
from casas join tiposcasa on casas.codtipocasa = tiposcasa.numtipo
		join caracteristicasdecasas on  casas.codcasa = caracteristicasdecasas.codcasa
where caracteristicasdecasas.codcaracter = codigoCaract
group by  casas.poblacion, casas.preciobase;


end $$
delimiter ;
    
call  ejer3_simuExaG1 (1);

/*
p4
Prepara un procedimiento que, dado un código de zona,
 muestre el listado de las casas de esa zona. Se mostrará en el listado el nombre de la casa y la población.
*/
 delimiter $$
 drop procedure if exists ejer4_simuExaG1 $$
 create procedure ejer4_simuExaG1 
 (
 in codigo int 
 )
 
 begin
 select casas.nomcasa, casas.poblacion
 from casas join zonas on casas.codzona = zonas.numzona
 where zonas.numzona= codigo;
 
 end $$
 delimiter ;

call  ejer4_simuExaG1 (1);

/*
p6

Prepara un procedimiento que, dado el código de una reserva,
 devuelva el número de teléfono del cliente que ha hecho dicha reserva y su nombre completo (todo junto).

*/


delimiter $$
drop procedure if exists ejer6_simuExaG1 $$
create procedure  ejer6_simuExaG1 
	(
	in codigo int,
    out telefono char(13),
    out nombreCompleto varchar(60)
	)
    /*
    mi solucion
begin
	select clientes.tlf_contacto, concat_ws(' ', clientes.nomcli, clientes.ape1cli, ifnull(clientes.ape2cli, 'no tiene')) into telefono ,nombreCompleto
    from reservas join clientes on reservas.codcliente = clientes.codcli
    where reservas.codreserva= codigo;
 */
 begin
	select clientes.tlf_contacto into telefono
    from reservas join clientes on reservas.codcliente = clientes.codcli
    where reservas.codreserva = reserva;
end $$
delimiter ;

call  ejer6_simuExaG1 (1,@telefono, @nombre);
select @telefono, @nombre;


call  ejer6_simuExaG1 (1,@telefono);
select concat('El teléfono del cliente es: ',ifnull(@telefono,'el cliente no tiene teléfono')) as consulta;