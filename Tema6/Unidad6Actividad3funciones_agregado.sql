/*
Para la BD EMPRESA_CLASE descargada de la plataforma obtener las siguientes consultas:

1.Prepara un procedimiento almacenado que obtenga el salario máximo de la empresa.
2.Prepara un procedimiento almacenado que obtenga el salario mínimo de la empresa.
3.Prepara un procedimiento almacenado que obtenga el salario medio de la empresa.
4.Prepara 1 procedimiento almacenado que obtenga el salario máximo, mínimo y medio del departamento “Organización”.
5.Prepara un procedimiento almacenado que obtenga lo mismo que el del apartado anterior pero de forma que podamos cambiar el departamento para el que se obtiene dichos resultados.
6.Prepara un procedimiento almacenado que obtenga lo que se paga en salarios para un departamento en cuestión.
7.Prepara un procedimiento almacenado nos dé el presupuesto total de la empresa.
8.Prepara un procedimiento almacenado que obtenga el salario máximo, mínimo y medio para cada departamento.
9.Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que hay en la empresa.
10.Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza un departamento.
11.Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza cada departamento.


*/

-- 1.Prepara un procedimiento almacenado que obtenga el salario máximo de la empresa.

delimiter $$
drop procedure if exists salarioMaximo $$
create procedure salarioMaximo()
begin
select max(salarem) as salario_Maximo
from empleados;
end $$
delimiter ;

select  salarem 
from empleados;

call salarioMaximo();
-- 2.Prepara un procedimiento almacenado que obtenga el salario mínimo de la empresa.

delimiter $$
drop procedure if exists salarioMinimo $$
create procedure salarioMinimo()
begin
select min(salarem) as salario_Minimo
from empleados;
end $$
delimiter ;

select  salarem 
from empleados;

call salarioMinimo();

-- 3.Prepara un procedimiento almacenado que obtenga el salario medio de la empresa.
delimiter $$
drop procedure if exists salarioMedio $$
create procedure salarioMedio()
begin
select avg(salarem) as salario_Minimo
from empleados;
end $$
delimiter ;

select  salarem 
from empleados;

call salarioMedio();

/*
-- 4.Prepara 1 procedimiento almacenado que obtenga el salario máximo, mínimo y medio del departamento “Organización”.
*/
delimiter $$
drop procedure if exists salariosDeparta1 $$
create procedure salariosDeparta1
(

 out salarioMaximo decimal(7,2),
 out salarioMinimo decimal(7,2),
 out salarioMedio decimal(7,2)
)
begin
set salarioMaximo = (select max(salarem) as salario_Maximo
from empleados
where nomde= 'Organizacion'
);

set salarioMinimo = (select min(salarem) as salario_Maximo
from empleados
where nomde= 'Organizacion'
);

set salarioMedio = (select avg(salarem) as salario_Minimo
from empleados
where nomde= 'Organizacion'
);

end $$
delimiter ;

select nomde, nomde from departamentos;

call salariosDeparta(@salarioMax, @salarioMin,@salarioMedio);
select @salarioMax, @salarioMin,@salarioMedio;

/*
5.Prepara un procedimiento almacenado que obtenga lo mismo que el del apartado anterior
 pero de forma que podamos cambiar el departamento para el que se obtiene dichos resultados.

*/


delimiter $$
drop procedure if exists salariosDeparta $$
create procedure salariosDeparta
(
 in nombreDepar varchar(60),
 out salarioMaximo decimal(7,2),
 out salarioMinimo decimal(7,2),
 out salarioMedio decimal(7,2)
)
begin
set salarioMaximo = (select max(salarem) as salario_Maximo
from empleados
where nomde= nombreDepar
);

set salarioMinimo = (select min(salarem) as salario_Maximo
from empleados
where nomde= nombreDepar
);

set salarioMedio = (select avg(salarem) as salario_Minimo
from empleados
where nomde= nombreDepar
);

end $$
delimiter ;

select nomde, nomde from departamentos;

call salariosDeparta('Organizacion',@salarioMax, @salarioMin,@salarioMedio);
select @salarioMax, @salarioMin,@salarioMedio;


-- 6.Prepara un procedimiento almacenado que obtenga lo que se paga en salarios para un departamento en cuestión.
-- Uso funcion porque solo devuelve un valor
delimiter $$
drop function if exists totalSalarios $$
create function  totalSalarios
(  
 numeroDepar int
)
returns decimal(15,2)
 deterministic
 begin
 declare salaTotal decimal(15,2);
 
 set salaTotal = (  
					select sum(ifnull(salarem,0))
                    from empleados
                    where numde = numeroDepar
					);
 return salaTotal;
 
 end$$
 delimiter ;
 
 select * from empleados
 where numde = 112;
 
 
select salarem
from empleados
where numde = 112;

select totalSalarios(112);
set @total = ifnull(totalSalarios(112),0);
select @total; 

-- 7.Prepara un procedimiento almacenado nos dé el presupuesto total de la empresa.
delimiter $$
drop function if exists presuTotal $$
create function presuTotal()
returns decimal(15,2)
 deterministic
 begin
 declare total decimal(15,2);
  set total = (
				select sum(presude)
				from departamentos
               );
 return total;
 end$$
 delimiter ;
 
 select presude
 from departamentos;
 
 select presuTotal();
 
 
 -- 8.Prepara un procedimiento almacenado que obtenga el salario máximo, mínimo y medio para cada departamento.
 
/*

 igual que el cinco
*/ 

-- 9.Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que hay en la empresa.
delimiter $$
drop   procedure if exists telefonos$$ 
create procedure telefonos()
begin
select count(distinct extelem) as numeros_telefono
from empleados;
end$$
delimiter ;

select count(extelem)
from empleados;

call telefonos();

 -- 10.Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza un departamento.
delimiter $$
drop   procedure if exists telefonosDepar$$ 
create procedure telefonosDepar(
					numeroDepartamento int
				)
begin
select count(distinct extelem) as numeros_telefono
from empleados
where numde= numeroDepartamento;
end$$
delimiter ;

select extelem
from empleados
where numde = 112;

call telefonosDepar(112);

-- 11.Prepara un procedimiento almacenado que obtenga el número de extensiones de teléfono diferentes que utiliza cada departamento.
delimiter $$
drop   procedure if exists telefonosCadaDepar$$ 
create procedure telefonosCadaDepar()
	
			
begin
select  numde as numeroDepartamento, count(distinct extelem) as numeros_telefono
from empleados;

end$$
delimiter ;

call telefonosCadaDepar();