/*
Para la base de datos empresa_clase:
1.Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tengan, 
pero solo nos interesan aquellos grupos de comisión en los que haya más de un empleado.
2.Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos.
 Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados.

	Para la base de datos de las promociones:
3.Prepara un procedimiento que, dado un código de promoción obtenga un listado con el nombre de las categorías que tienen al menos dos productos incluidos en dicha promoción.
4.Prepara un procedimiento que, dado un precio, obtenga un listado con el nombre de las categorías en las que el precio  medio de sus productos supera a dicho precio.
5.Prepara un procedimiento que muestre el importe total de las ventas por meses de un año dado.
6.Como el ejercicio anterior, pero ahora solo nos interesa mostrar aquellos meses en los que se ha superado a la media del año.


*/
-- Para la base de datos empresa_clase:

/*
1.Hallar el salario medio para cada grupo de empleados con igual comisión y para los que no la tengan, 
pero solo nos interesan aquellos grupos de comisión en los que haya más de un empleado.
*/
select avg(empleados.salarem)
from empleados
where empleados.comisem= empleados.comisem or empleados.comisem=0
group by empleados.comisem
having  count(*)>1;

/*
2.Para cada extensión telefónica, hallar cuantos empleados la usan y el salario medio de éstos.
 Solo nos interesan aquellos grupos en los que hay entre 1 y 3 empleados.
*/
select count(empleados.nomem) as numeroEmpleados, avg(empleados.salarem) as salarioMedio
from empleados
group by empleados.extelem
having count(*) between 1 and 3;

	-- Para la base de datos de las promociones:
/*
3.Prepara un procedimiento que, 
dado un código de promoción obtenga un listado con el nombre de las categorías que tienen al menos dos productos incluidos en dicha promoción.

*/
delimiter $$
drop procedure if exists eje3_7$$
create procedure eje3_7
( codigo int)
begin
select categorias.nomcat
from categorias join articulos on categorias.codcat= articulos.codcat
				join catalogospromos on articulos.refart = catalogospromos.refart
                join promociones on catalogospromos.codpromo = promociones.codpromo
group by promociones.codpromo
having count(*)>2;
end$$
delimiter ;

call eje3_7(1);

/*
4.Prepara un procedimiento que, dado un precio, obtenga un listado con el nombre de las categorías
 en las que el precio  medio de sus productos supera a dicho precio.

*/

delimiter $$
drop procedure if exists eje4_7$$
create procedure eje4_7
( precio decimal(5,2))
begin
select categorias.nomcat as nombreCategoria
from categorias join articulos on categorias.codcat = articulos.codcat
group by categorias.codcat
having avg(articulos.preciobase)< precio;
end$$
delimiter ;

call eje4_7(2.50);

/*
5.Prepara un procedimiento que muestre el importe total de las ventas por meses de un año dado.
*/

delimiter $$
drop procedure if exists eje5_7$$
create procedure eje5_7
( anio date)
begin
select sum(detalleventa.precioventa) 
from detalleventa join ventas on detalleventa.codventa = ventas.codventa
where year(ventas.fecventa)= year(anio)
group by month(ventas.fecventa);

end$$
delimiter ;

call eje5_7();
