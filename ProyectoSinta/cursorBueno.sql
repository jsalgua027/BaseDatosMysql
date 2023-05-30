

DELIMITER $$
DROP PROCEDURE IF EXISTS proyecto $$
CREATE PROCEDURE proyecto()
BEGIN
DECLARE texto varchar(100); -- Recoge el texto del enunciado
    DECLARE clasificacion varchar (120); -- Recoge todos los tipos concatenados
DECLARE fincursor bit default 0; -- Para indicar el final del cursor
   
    -- Declaramos el cursor que recoja todos los tipos y el texto de cada enunciado
DECLARE curProyecto CURSOR
FOR SELECT enunciados.texto, concat(actitudhablante.desActitudHablante,
estructura.desEstructura, naturalezapredicado.vozVerbo, '+', naturalezapredicado.verboCopulativo, '-',
naturalezapredicado.transitividad)
FROM enunciados
join detalleactitud on enunciados.codEnunciado = detalleactitud.codEnunciado
join actitudhablante on detalleactitud.codActitudHablante = actitudhablante.codActitudHablante
join estructura on enunciados.codEstructura = estructura.codEstructura
join naturalezapredicado on enunciados.codNaturalezaPredi = naturalezapredicado.codNaturalezaPredi;

    -- Si no hay más filas que recorrer, cambiamos el final del cursor para que termine
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'
SET fincursor = 1;

    -- Creamos una tabla temporal para guardar los resultados
DROP TABLE IF EXISTS listado;
CREATE TEMPORARY TABLE listado
(descripcion varchar(100));

-- Abrimos el cursor
OPEN curProyecto;
-- Guardamos en texto la primera columna del cursor
    -- y en clasificacion la segunda
FETCH FROM curProyecto INTO texto, clasificacion;

    -- Mientras haya filas en el cursor
WHILE fincursor = 0 DO
BEGIN
-- Si no es activa, es pasiva
IF clasificacion rlike 'activa' THEN
INSERT INTO listado (descripcion)
values (CONCAT('Voz activa: ', texto));
ELSE
INSERT INTO listado (descripcion)
values (CONCAT('Voz pasiva: ', texto));
END IF;
       
        -- Si no es personal, es impersonal
IF clasificacion rlike 'Personal' THEN
INSERT INTO listado (descripcion)
values (CONCAT('Personal: ' , texto));
ELSE
INSERT INTO listado (descripcion)
values (CONCAT('Impersonal: ', texto));
END IF;
       
        -- Si tiene verbo copulativo es atributiva, sino es predicativa
IF clasificacion rlike '\\+true-' THEN
INSERT INTO listado (descripcion)
values (CONCAT('Atributiva: ', texto));
ELSE
INSERT INTO listado (descripcion)
values (CONCAT('Predicativa: ', texto));
END IF;
       
        -- Si no es transitiva, es intransitiva
IF clasificacion rlike '-true' THEN
INSERT INTO listado (descripcion)
values (CONCAT('Transitiva: ', texto));
ELSE
INSERT INTO listado (descripcion)
values (CONCAT('Intransitiva: ', texto));
END IF;

        -- Puede ser negativa, afirmativa, exclamativa, interrogativa
        -- desiderativa, dubitativa o exhortativa
CASE
WHEN clasificacion rlike 'Negativa' THEN
INSERT INTO listado
(descripcion)
values
(CONCAT('Negativa: ', texto));

WHEN clasificacion rlike 'Afirmativa' THEN
INSERT INTO listado
(descripcion)
values
(CONCAT('Afirmativa: ', texto));
                       
WHEN clasificacion rlike 'Exclamativa' THEN
INSERT INTO listado
(descripcion)
values
(CONCAT('Exclamativa: ', texto));
                       
WHEN clasificacion rlike 'Interrogativa' THEN
INSERT INTO listado
(descripcion)
values
(CONCAT('Interrogativa: ', texto));
                       
WHEN clasificacion rlike 'Desiderativa' THEN
INSERT INTO listado
(descripcion)
values
(CONCAT('Desiderativa: ', texto));
                       
WHEN clasificacion rlike 'Dubitativa' THEN
INSERT INTO listado
(descripcion)
values
(CONCAT('Dubitativa: ', texto));

ELSE
INSERT INTO listado (descripcion)
values (CONCAT('Exhortativa o de orden: ', texto));
               
END CASE;

FETCH FROM curProyecto INTO texto, clasificacion;
END; -- Fin del begin dentro del while
END WHILE;
   
    -- Cerramos el cursor
CLOSE curProyecto;

    -- Si el listado tiene filas
IF (select count(*) from listado) > 0 then
-- Imprime listado ordenado por descripcion
select * from listado order by descripcion;
ELSE
-- Si no hay filas
select 'NO HAY ENUNCIADOS';
END IF;
   
    -- Borramos la tabla temporal
DROP TABLE IF EXISTS listado;
END $$
DELIMITER ;

call proyecto();
	
