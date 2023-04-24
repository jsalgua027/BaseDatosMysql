-- simulacro examen Tema6
/*
1
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
2
(1,25 ptos.) Muestra un listado de todos los artículos vendidos,
 queremos mostrar la descripción del artículo y entre paréntesis la descripción de la categoría a la que pertenecen
 y la fecha de la venta con el formato “march - 2016, 1 (tuesday)”. Haz que se muestren todos los artículos de la misma categoría juntos.

*/

delimiter $$
drop procedure if exists eje2_simu$$
create procedure eje2_simu()
begin 
 -- select  concat(articulos.desart , '(', categorias.descat,date_format(fecventa,'%M-%Y-W'),')') 
  select desart, concat(nomart,' (',descat,')'), date_format(fecventa, '%M - %Y, %d (%W)')
from articulos join categorias on articulos.codcat = categorias.codcat
			 join detalleventa on  articulos.refart= detalleventa.refart 
             join ventas
		      on ventas.codventa = detalleVenta.codventa
order by categorias.descat;

end$$
delimiter ;

call eje2_simu();
/*
3
 (1 pto.) Obtener el precio medio de los artículos de cada promoción
 (muestra la descripción de la promoción) del año 2012. (Se usará en el ejercicio 7).

*/
select avg(catalogospromos.precioartpromo) as precioMedio, promociones.despromo
	from catalogospromos join promociones on catalogospromos.codpromo= promociones.codpromo
    where year(fecinipromo)=2012
 group by promociones.codpromo;

/*
4
 (1,25 ptos.) Prepara una rutina que muestre un listado de artículos,
 su referencia, su nombre y la categoría que no hayan estado en ninguna promoción que haya empezado en este año.

*/
delimiter $$
drop procedure if exists ejer4$$
create procedure ejer4
()
begin
select articulos.refart, articulos.nomart, categorias.nomcat
from articulos join categorias on articulos.codcat = categorias.nomcat
where articulos.refart not in ( select catalogospromos.refart  
							     from catalogospromos join promociones on catalogospromos.codpromo= promociones.codpromo
								 where year(promociones.fecinipromo)= year(curdate()) 
                                    );
 
end $$
delimiter ;

call ejer4();

/*
5.
1,25 ptos.) Queremos asignar una contraseña a nuestros clientes para la APP de la cadena, 
prepara una rutuina que dado un email y un teléfono, nos devueltva la contraseña inicial que estará formada por: la 
inicial del nombre, los números correspondientes a las posiciones 3ª, 4ª Y 5ª del dni y
 el número de caracteres de su nombre completo. Asegúrate que el nombre no lleva espacios a izquierda ni derecha.

*/
delimiter $$
drop function if exists ejer5$$
create function ejer5
( correo char(9),
 telefono char(9)
)
returns  char(7)
begin
return (
		select concat(left(clientes.nomcli,1),
				substring(clientes.mail,3,1),
                substring(clientes.mail,4,1),
                substring(clientes.mail,5,1),
                length(concat(trim(nomcli), trim(ape1cli), ifnull(trim(ape2cli),'')))
        
        )
         from clientes
         	where email = correo and tlfcli = telefono
        );
        
 
end $$
delimiter ;

call ejer5();

/*
6.
 (1,25 ptos.) Sabemos que de nuestros vendedores almacenamos en nomvende su nombre y su primer apellido y su segundo apellido,
 no hay vendedores con nombres ni apellidos compuestos. Obten su contraseña formada por la inicial del nombre, 
 las 3 primeras letras del primer apellido y las 3 primeras letras del segundo apellido

*/
SELECT 
    CONCAT(SUBSTRING(nomvende, 1, 1),
            SUBSTRING(nomvende,
                LOCATE(' ', nomvende) + 1,3),
            SUBSTRING(nomvende,LOCATE(' ', nomvende, LOCATE(' ', nomvende) + 1) + 1,3))
            from vendedores
/*
7.
Queremos saber las promociones que comiencen en el mes actual y
 para las que la media de los precios de los artículos de dichas promociones
 coincidan con alguna de las de un año determinado (utiliza el ejercicio P3. Tendrás que hacer alguna modificación).
*/
delimiter $$
drop procedure if exists eje_7 $$
create procedure eje_7
	(in anyo int)
begin    
	-- call exam_2019_5_2_7(2012);
	select despromo, avg(precioartpromo)
	from catalogospromos join promociones
		on catalogospromos.codpromo = promociones.codpromo
	-- NOTA: quitar where para probar, ya que no hay datos de este año
	where year(fecinipromo)=year(curdate()) and month(fecinipromo)=month(curdate())
	group by promociones.codpromo
	having avg(precioartpromo) in (select avg(precioartpromo)
								   from catalogospromos join promociones
										on catalogospromos.codpromo = promociones.codpromo
								   where year(fecinipromo)=anyo
								   group by promociones.codpromo
								   );
end $$
delimiter ;


/*
8.
 Obtén un listado de artículos (referencia y nombre)
 cuyo precio venta sin promocionar sea el mismo que el que han tenido en alguna promoción.


*/
select refart, nomart
from articulos
where precioventa = any (
						select precioartpromo
						from catalogospromos
						where catalogospromos.refart = articulos.refart
						);
                        
                        