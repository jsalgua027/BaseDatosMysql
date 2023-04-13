/*
1. Para la base de datos “empresa_clase” obtener, dado el código de un empleado, la contraseña de
acceso formada por:
i. Inicial del nombre + 10 caracteres.
ii. Tres primeras letras del primer apellido + 5 caracteres.
iii. Tres primeras letras del segundo apellido (o “LMN” en caso de no tener 2o
apellido) + 5 caracteres.
iv. El último dígito del dni (sin la letra).

2. Para la base de datos “BDAlmacen” obtener por separado el nombre, el primer apellido y el
segundo apellido de los proveedores.
3. Obtener un procedimiento que obtenga el salario de los empleados incrementado en un 5%. El
formato de salida del salario incrementado debe ser con dos decimales.
4. Prepara una función que determine si un valor que se pasa como parámetro es una fecha correcta o
no.
5. Para la base de datos “Empresa_clase” prepara un procedimiento que devuelva la edad de un
empleado.
6. Para la base de datos “EMPRESA_CLASE” obtener el día que termina el periodo de prueba de un
empleado, dado su código de empleado. El periodo de prueba será de 3 meses.
7. Nuestro sistema MS Sql Server tiene como primer día de la semana el domingo. Cámbialo al
lunes. Obtén el nombre del primer día de la semana del sistema.
8. Obtener el nombre completo de los empleados y la fecha de nacimiento con los siguientes
formatos:
a. “05/03/1978”
b. 5/3/1978
c. 5/3/78
d. 05-03-78
e. 05 Mar 1978
9. Obtener como resultado de la fecha de nacimiento el formato: “5 de marzo de 1978”
10. Añade una columna en la tabla empleados para el nombre de usuario y otra para la contraseña de
acceso de los mismos.
11. Los empleados solo pueden acceder al salario de ellos mismos, no al de sus compañeros. Prepara
un procedimiento que devuelva el salario del usuario actual. Tendrás que comprobar que el usuario
conectado coincida con el usuario de la tabla empleados.
12. Utiliza lo que hicimos en el apartado 1 de esta actividad para almacenar los valores de la clave de
los empleados.
13. Igual que el apartado anterior, pero ahora los valores de la contraseña se almacenarán cifrados.
Utiliza la función de cifrado de MySQL.

*/


/*
1. Para la base de datos “empresa_clase” obtener, dado el código de un empleado, la contraseña de
  acceso formada por:
i. Inicial del nombre + 10 caracteres. (11)
ii. Tres primeras letras del primer apellido + 5 caracteres. (8)
iii. Tres primeras letras del segundo apellido 
(o “LMN” en caso de no tener 2oapellido) + 5 caracteres.(8)
iv. El último dígito del dni (sin la letra).(1)

la contraseña tiene un char de (28)
*/

delimiter $$
drop function if exists ejer1_r7 $$
create function ejer1_r7
(
 codigo int 
)
returns varchar(20)
deterministic
begin 
return (

select concat(
	char((AscII(left(empleados.nomem,1))+10)),
    char(AscII(left(empleados.ape1em,3))+5),
    char(AscII(left(empleados.ape1em,2))+5),
    char(AscII(left(empleados.ape1em,1))+5),
    char(ifnull((AscII(left(empleados.ape2em,3))+5),'LMN')),
	char(ifnull((AscII(left(empleados.ape2em,2))+5),'LMN')),
	char(ifnull((AscII(left(empleados.ape2em,1))+5),'LMN')),
    char(AscII(right(empleados.dniem,1))) 
    )
from empleados
where empleados.numem= codigo
);
end $$
delimiter ;


select ejer1_r7(120);

/*
2. Para la base de datos “BDAlmacen” obtener por separado el nombre, el primer apellido y el
segundo apellido de los proveedores.

*/


