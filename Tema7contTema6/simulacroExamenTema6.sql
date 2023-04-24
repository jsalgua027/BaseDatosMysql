-- simulacro examen Tema6
/*
(1,25 ptos.) Queremos saber el importe de las ventas de artículos a cada uno de nuestros clientes (muestra el nombre). 
Queremos que cada cliente se muestre una sola vez y que aquellos a los que hayamos vendido más se muestren primero.
*/
use ventapromoscompleta;
delimiter $$
drop procedure if exists eje1_simu$$
create procedure eje1_simu()
begin 

select concat_ws(' ', clientes.nomcli, clientes.ape1cli) as nombre,  sum(detalleventa.precioventa) as totalVentas
from clientes join ventas on clientes.codcli = ventas.codcli
			 join detalleventa on ventas.codventa = detalleventa.codventa
group by concat_ws(' ', clientes.nomcli, clientes.ape1cli)
order by sum(detalleventa.precioVenta) desc;

end$$
delimiter ;

call  eje1_simu();

/*
(1,25 ptos.) Muestra un listado de todos los artículos vendidos,
 queremos mostrar la descripción del artículo y entre paréntesis la descripción de la categoría a la que pertenecen
 y la fecha de la venta con el formato “march - 2016, 1 (tuesday)”. Haz que se muestren todos los artículos de la misma categoría juntos.

*/

delimiter $$
drop procedure if exists eje2_simu$$
create procedure eje2_simu()
begin 
 select  concat(articulos.desart as descripcion, '(', categoria.descat, ventas.fecventa,')') 
from articulos join categorias on articulos.codcat = categorias.codcat
			 join ventas on  


end$$
delimiter ;


