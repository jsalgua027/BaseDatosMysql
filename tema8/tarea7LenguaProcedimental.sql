/*
con empresa clase

1.Crea un procedimiento que devuelva el año actual
2.Crea una función que devuelva el año actual.
3.Crea un procedimiento que muestre las tres primeras letras de una cadena pasada como parámetro en mayúsculas.
4.Crea un procedimiento que devuelva una cadena formada por dos cadenas, pasadas como parámetros, concatenadas y en mayúsculas.
5.Crea una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.
6.Crea una función que devuelva 1 ó 0 en función de si un número es o no divisible por otro.
7.Crea una función que devuelva el día de la semana (lunes, martes, …) en función de un número de entrada (1: lunes, 2:martes, …).
8.Crea una función que devuelva el mayor de tres números que pasamos como parámetros.
9.Crea una función que diga si una palabra, que pasamos como parámetros, es palíndroma.
10.Crea un procedimiento  que muestre la suma de los primeros n números enteros, siendo n un parámetro de entrada.
11.Prepara un procedimiento que muestre la suma de los términos 1/n con n entre 1 y m (1/2 + 1/3 + ¼ +…), siendo m un parámetro de entrada.
12.Crea una función que determine si un número es primo o no (devolverá 0 ó 1).
13.Crea una función que calcule la suma de los primeros m números primos empezando por el 1. Utiliza la función del apartado anterior.
14.Crea un procedimiento que almacene en una tabla (primos (id, numero)) los primeros números primos comprendidos entre 1 y m (m es parámetro de entrada).
15. Modifica el procedimiento anterior para que se almacene en un parámetro de salida el número de primos almacenados.

*/

-- 1.Crea un procedimiento que devuelva el año actual
 delimiter $$
 drop procedure if exists anioActual$$
 create procedure anioActual( out actual int )
  no sql
 begin 
  set actual =  year(current_date);
  end $$
  delimiter $$;
  
  call  anioActual(@anio);
  select @anio;
  
-- 2.Crea una función que devuelva el año actual.
delimiter $$
drop function if exists actualAnio$$
create function actualAnio ()
returns  int
deterministic
	begin 
    return  year(current_date());
    end$$
delimiter $$;

select actualAnio ()
  
-- 3.Crea un procedimiento que muestre las tres primeras letras de una cadena pasada como parámetro en mayúsculas.
delimiter $$
drop procedure if exists primerasLetras$$
create procedure primerasLetras 
( in cadena varchar(30))
no sql
begin
 select  upper(left(cadena,3));
end$$
delimiter ;


call primerasLetras ('pericodelospalotes')

-- 4.Crea un procedimiento que devuelva una cadena formada por dos cadenas, pasadas como parámetros, concatenadas y en mayúsculas.

delimiter $$
drop procedure if exists cadena$$
create procedure cadena 
( in cadena1 varchar(30), in cadena2 varchar(30), out cadena3 varchar(100))
no sql
begin
 -- set cadena3= concat(upper(left(cadena1,3)),upper(left(cadena2,3));
 set cadena3 = upper(concat(cadena1,cadena2));
end$$
delimiter ;

call cadena ( 'hola','pedro',@a);
select @a;

-- 5.Crea una función que devuelva el valor de la hipotenusa de un triángulo a partir de los valores de sus lados.

delimiter $$
drop function if exists hipotenusa$$
create function hipotenusa 
(
 lado1 int, lado2 int
)
returns decimal(10,2)
deterministic
begin
return sqrt(pow(lado1,2)+ pow(lado2,2));
end$$
delimiter ;

select hipotenusa (2,2);

-- 6.Crea una función que devuelva 1 ó 0 en función de si un número es o no divisible por otro.