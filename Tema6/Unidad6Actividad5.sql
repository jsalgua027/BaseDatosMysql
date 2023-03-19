/*
******************************** NOTA1 ****************************************
PARA SABER QUE FUNCIÓN USAR EN CADA CASO, UTILIZA EL MANUAL DE REFERENCIA DE MySQL SERVER. BUSCA EN FUNCIONES .

PRINCIPALES FUNCIONES DE CADENA:

ASCII, CHAR, CHARINDEX, LEFT, LEN LOWER, LTRIM, NCHAR, PATINDEX, QUOTENAME, REPLACE, REPLICATE, REVERSE, SPACE, STR, STUB, SUBSTRIN, UNICODE, UPPER.

PRINCIPALES FUNCIONES DE FECHA Y HORA:

DATEADD, DATEDIFF, DATENAME, DATEPART, DAY, MONTH, YEAR, GETDATE, GETUTCDATE.
  
PRINCIPALES FUNCIONES MATEMÁTICAS:

ABS, EXP, SQRT, SQUARE, RADIANS, POWER, ROUND, RAND, SIGN, FLOOR, CEILING

******************************** NOTA2 ****************************************
RECUERDA ==> COMO VER EL VALOR DE UN PARÁMETRO DE SALIDA DE UN PROCEDIMIENTO DESPUÉS DE SU EJECUCIÓN:

Supongamos que el procedimiento P1 tiene dos parámetros x1 (entero de entrada) 7 x2 (char(10) de salida). Para poder ver el resultado de x2 después de su ejecución podemos hacer lo siguiente:

CALL P1 (2, @micadena );

SELECT @micadena;
-- o también:
SELECT CONCAT('EL RESULTADO ES: ', @micadena);

**************************** FIN NOTAS ****************************************

Para BD_Almacen, hacer los siguientes ejercicios utilizando procedimientos almacenados y la función que consideres más adecuada:

TODOS LOS EJERCICIOS DEBEN HACERSE UTILIZANDO FUNCIONES ESCALARES DE MYSQL

1.Obtener todos los productos que comiencen por una letra determinada.
2.Se ha diseñado un sistema para que los proveedores puedan acceder a ciertos datos, 
la contraseña que se les da es el teléfono de la empresa al revés. 
Se pide elaborar un procedimiento almacenado que dado un proveedor obtenga su contraseña y la muestre en los resultados.
3.Obtener el mes previsto de entrega para los pedidos que no se han recibido aún y para una categoría determinada.
4.Obtener un listado con todos los productos, ordenados por categoría, en el que se muestre solo las tres primeras letras de la categoría.
5.Obtener el cuadrado y el cubo de los precios de los productos.
6.Devuelve la fecha del mes actual.
7.Para los pedidos entregados el mismo mes que el actual, obtener cuantos días hace que se entregaron.
8.En el nombre de los productos, sustituir “tarta” por “pastel”.
9.Obtener la población del código postal (los primeros dos caracteres se refieren a la provincia y los tres últimos a la población).
10.Obtén el número de productos de cada categoría, haz que el nombre de la categoría se muestre en mayúsculas.
11.Obtén un listado de productos por categoría y dentro de cada categoría del nombre de producto más corto al más largo.
12.Asegúrate de que los nombres de los productos no tengan espacios en blanco al principio o al final de dicho nombre.
13.Lo mismo que en el ejercicio 2, pero ahora, además, sustituye el 4 y 5 número del resultado por las 2 últimas letras del nombre de la empresa.
14.Obtén el 10 por ciento del precio de los productos redondeados a dos decimales.
15.Muestra un listado de productos en que aparezca el nombre del producto y el código de producto y el de categoría repetidos (por ejemplo para la tarta de azucar se mostrará “623623”).
*/

-- 1.Obtener todos los productos que comiencen por una letra determinada.
delimiter $$
drop procedure if exists ejercicio1 $$
create procedure ejercicio1
(
	letra char
)
begin
select  descripcion
from productos
where descripcion like concat(letra, '%');
end $$
delimiter ;


call ejercicio1('C');

/*
2.Se ha diseñado un sistema para que los proveedores puedan acceder a ciertos datos, 
la contraseña que se les da es el teléfono de la empresa al revés. 
Se pide elaborar un procedimiento almacenado que dado un proveedor obtenga su contraseña y la muestre en los resultados.

*/
delimiter $$
drop procedure if exists ejercicio2 $$
create procedure ejercicio2
(
  codigoProveedor int
	)
    
begin
 select  reverse(cast(telefono as char)) 
 from proveedores
 where codigoProveedor = codproveedor;
end $$
delimiter ;


call ejercicio2(1);

-- 3.Obtener el mes previsto de entrega para los pedidos que no se han recibido aún y para una categoría determinada.
delimiter $$
drop procedure if exists ejercicio3 $$
create procedure ejercicio3
(
codigoCategoria int
)
begin 
select month(fecentrega)
from pedidos
join
productos on productos.codproducto = pedidos.codproducto
join 
categorias on productos.codcategoria = categorias.codcategoria
where categorias.codcategoria= codigoCategoria or pedidos.fecentrega>date('1996-04-04');
end$$
delimiter ;

call ejercicio3(1);


-- 4.Obtener un listado con todos los productos, ordenados por categoría, en el que se muestre solo las tres primeras letras de la categoría.
select left(categorias.Nomcategoria,3) , productos.descripcion
from productos
join 
categorias on productos.codcategoria = categorias.codcategoria
order by categorias.codcategoria;