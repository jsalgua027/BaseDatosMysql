-- Nacho Salcedo Guarde
-- ejer1


delimiter $$
drop trigger if exists compruebaPreguntasNueva$$
create trigger compruebaPreguntasNueva
	before insert on preguntas
for each row
begin
	if (numpreg <> new.numpreg)  and new.numpreg in (select preguntas.codtest from preguntas where codtest = new.codtest)
	  then
		signal sqlstate '45000' set message_text = 'No se pueden repetir Preguntas';
	end if;
end $$
delimiter ;

delimiter $$
drop trigger if exists compruebaPreguntasExiste$$
create trigger compruebaPreguntasExiste
	before update on preguntas
for each row
begin
	if (numpreg = new.numpreg)  
	  then
		signal sqlstate '45000' set message_text = 'No se pueden modififcar pregunta Existente';
	end if;
end $$
delimiter ;




-- ejer2

delimiter $$
drop procedure if exists sumaNotas $$
create procedure sumaNotas()
 begin
	update matriculas
		set notas = (select count(nota)+1 from matriculas 
        join materias on matriculas.codmateria= materias.codmateria 
        join tests on materias.codmateria = tests.codmateria
        where count(codtest)>10);
end $$
delimiter ;


delimiter $$
create event actualizaNotas
on schedule
	every 10 year
    starts '2023/6/20'
do
	begin
		call sumaNotas();
    end $$
    
delimiter ;


-- eje3
delimiter $$
drop trigger if exists controlNotas$$
create trigger controlNotas
	before update on matriculas
for each row
begin
	if (new.nota> 10)
	  then
      set nota= 10;
		signal sqlstate '45000' set message_text = 'No se pueden superar el 10 en las notas';
	end if;
end $$
delimiter ;

-- eje4

delimiter $$
drop trigger if exists datosAlumno$$
create trigger datosAlumno
  before insert on  alumnos
  for each row
  begin 
   declare nuevoUsuario char(8);
   declare nuevoEmail  varchar(60);
   declare nuevoTelefono char(12);
	if ( select alumnos.nomuser from alumnos where alumnos.nomuser regexp '[^0-9]+[a-z]+6[0-9][\\=-\\_\\?-\\!]') then 
          signal sqlstate '45000' set message_text = 'El nombre de usuario no es correcto';
	
        
        if ( select alumnos.email from alumnos where alumnos.email regexp '[@][$\\.a-z]+3') then 
          signal sqlstate '45000' set message_text = 'El correo electronico es incorrecto';
	
    
    if ( select alumnos.telefono from alumnos where alumnos.telefono regexp '[^6|7|9][ ][0-9]+3[ ][0-9]+3[ ][0-9]+3') then 
          signal sqlstate '45000' set message_text = 'El teléfono es incorrecto';
	end if;
    end if;
    end if;
        begin 
        insert alumnos
        (nomuser,email,telefono)
        values
        (nuevoUsuario,nuevoEmail,nuevoTelefono);
        
        end;
        
    end ;
    
    
  
  end $$
  delimiter ;
  
  
  
  -- ejer 5
  
  delimiter $$
drop trigger if exists respuestasIguales$$
create trigger respuestasIguales
	before update on preguntas
for each row
begin
	if (old.resc = new.resc) or (old.resa = new.resa) or (old.resb = new.resb)
	  then
		signal sqlstate '45000' set message_text = 'La respuestas no cumplen las condiciones Indicadas';
	end if;
end $$
delimiter ;
  
