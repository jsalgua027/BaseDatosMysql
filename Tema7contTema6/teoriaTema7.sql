-- tema 7 teoria ---
-- quiero buscar el numero de empleados de cada depto, 
-- pero no me interesa los dptos de menos de tres miembros
/*
select  numde ,count(*) -- (5)
from empleados -- (1)
where count(*) >=3 -- (2)
group by numde; -- (3)       ORDEN DE EJECUCION Y DA ERROR POR EL WHEREE
*/
-- correcto
select  numde ,count(*) -- (5)
from empleados -- (1)
-- where count(*) >=3 -- (2)
group by numde -- (3)       ORDEN DE EJECUCION
having count(*) >=3; -- (4)
 
 /*
 buscar el numero de empleados de cada depto con salario mayor a  1500
 pero no me interesan los deptos de menos de tres miembros
 */
 
 select  numde ,count(*) as numEmple-- (5)
from empleados -- (1)
where salarem > 1500 -- (2)
group by numde -- (3)       ORDEN DE EJECUCION
having count(*) >=3 -- (4)
-- order by count(*) desc; -- (6) 
 -- order by 2 desc; -- (6)aqui le indicamos que ordene por el count del selec que es el segundo
 order by numEmple desc; -- (6)
 
 
 -- teoria de subselect
 -- todo lo que va entre paranteris en un subselect
  set @ depto=  (select numde
				from empleados
				where nuem =120);
                
  /*
  TEORIA DEL SUBSELECT
  
  insert into empledos
	(num, numde, noem , ape1em ....)
value 
	(1999, @depto,'pepe', 'del campo')
                
-- otra forma de hacerlo con el subselect
insert into empledos
	(num, numde, noem , ape1em ....)
value 
	(1999, (select numde
				from empleados
				where nuem =120),'pepe', 'del campo')
    
    -- creo una tabla y inserto todos los centros de la tabla centros usando un subselect
    
create table centros_new
	(numce int primary key,
    nomce varchar(60)
    );
   insert into centros_new
   (numce, nomce)
   (select numce, nomce
    from centros
   );
    
    -- al empleado 280 le hemos asignado el departamento del 120
  update empleados
  set numde = (select numde
				from empleados
                where nuem=120)
	where numem =280;
	
  */              

                
     /*
     TEORIA CUANTIFICADORES
     
       expresion o columna  operador (< > = ....) SOME/ANY   (conjunto de datos)
												  ALL
												  IN
       */           
 -- BUSCAR LOS EMPLEADOS QUE GANAN MAS QUE  DEL DEPARTAMENTO 110
	
    select numem, nomem, salarem
    from empleados
    where salarem > ALL (select salarem 
						from empleados
                        where numde= 110);
                        
	-- BUSCAR EMPLEADOS QUE GANAN LO MISMO QUE ALGUNOS(SOME/ANY) DE LOS DEPARTAMENTO 100
    
   select numem, nomem, salarem
    from empleados
    where salarem > SOME (select salarem 
						from empleados
                        where numde= 110);          
                        
-- o tambien 
   select numem, nomem, salarem
    from empleados
    where salarem  in (select salarem 
						from empleados)
                        
                        and numde <> 100;                        
                        
   -- busca empleados que ganen diferente  a los del depto 110                     
                        