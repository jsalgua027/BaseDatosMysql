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
   
   
   
   
   /*
   
   UNION
   
   */
        -- usamos la base de datos    gestionProyectoss    tiene que tener el mismo numero de columnas y de valor (char,int,decimal)-->mismo dominio  
        
	select numcli, concat_ws(' ', nomcli, ape1cli, ape2cli), email
		from clientes
        union -- union distinct para que no salgan repetidos, union all para que salgan todos
        select numcli, concat_ws(' ', nomem, ape1em, ape2em), dniem
		from empleados;
        
        
        /*
        
        view
        creo tablas fijas ; no temporales con los datos que quiero para trabajar con ellos
        */
        drop view if exists invitados;
        create view invitados
			(numInvitado, nombreInvitado, emailInvitado)
            as
        select numcli, concat_ws(' ', nomcli, ape1cli, ape2cli), email
		from clientes
        union -- union distinct para que no salgan repetidos, union all para que salgan todos
        select numcli, concat_ws(' ', nomem, ape1em, ape2em), dniem
		from empleados;
        
        
        /*
        EJERCICIO PROPUESTO PARA BASE DE DATOS PROMOCIONES
		preparar una vista que se llamara catalogoproductos que tenga la referecnia el artículo, código  y nombre categoría,  
		nombre del artículo , el precio base y el precio de venta hoy
                
        */
        drop view if exists CATALOGOPRODUCTOS;
        create view  CATALOGOPRODUCTOS
         (referenciaArt, codigoCat, nombreCat, nombreArticulo, precioBase, precioVentaHoy)-- , precioPromo)
         as
         select articulos.refart, articulos.codcat,categorias.nomcat, articulos.nomart, articulos.preciobase, articulos.precioventa
         from articulos join categorias on articulos.codcat = categorias.codcat;
         /*
         union 
         select ifnull( catalogospromos.precioartpromo ,'no esta en promocion')
         from promociones;
         */
         
         select * 
         from  CATALOGOPRODUCTOS;
         
        /*
        para la bd empresaclase
        prepara una vista que se llamará LISTINTELEFONICO 	en la qye cada usuario podrá consultar
        la extensión telefonica de los empleados de su departamento.. (pista)--> necesitamos usar una funcion de mysql user()
			el que crea la vista es el use definer
           el sql security hay que ponerlo en invoker para que se actualice los datos
                      
        */
        
        drop view if exists LISTINTELEFONICO;
        create view  LISTINTELEFONICO 
         ( nombreEmple, nombreDep, extension)
         as
         select  empleados.nomem, departamentos.nomde, empleados.extelem
         from empleados join departamentos on empleados.numde= departamentos.numde
          
         where empleados.nomem = substring(user(),'@',-1)
	     SQL SECURITY INVOKER;
         
         
         
        
        