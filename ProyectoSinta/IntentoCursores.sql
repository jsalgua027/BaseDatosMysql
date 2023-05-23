drop procedure if exists MostrarDatos;
-- Crear un procedimiento almacenado
DELIMITER //

CREATE PROCEDURE MostrarDatos()
BEGIN
    DECLARE done bit DEFAULT 0;
    DECLARE codEnunciado INT;
    DECLARE codEstructura INT;
    DECLARE codNaturalezaPredi INT;
    DECLARE texto VARCHAR(200);
    DECLARE tipo VARCHAR(10);
    DECLARE codActitudHablante INT;
    DECLARE descActitud VARCHAR(200);
    
    -- Cursor para obtener los datos de las tablas relacionadas
    DECLARE cursorDatos CURSOR FOR
    SELECT E.codEnunciado, E.codEstructura, E.codNaturalezaPredi, E.texto, E.tipo, DA.codActitudHablante, DA.descActitud
    FROM Enunciados E
    LEFT JOIN detalleActitud DA ON E.codEnunciado = DA.codEnunciado;
    
    -- Declarar manejo de errores
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Abrir el cursor
    OPEN cursorDatos;
    
    -- Obtener la primera fila
    FETCH NEXT FROM cursorDatos INTO codEnunciado, codEstructura, codNaturalezaPredi, texto, tipo, codActitudHablante, descActitud;
    
    -- Mostrar los datos fila por fila
    WHILE done = 0 DO
        -- Mostrar los datos de la fila actual
        SELECT 'codEnunciado: ' + CAST(codEnunciado AS CHAR);
        SELECT 'codEstructura: ' + CAST(codEstructura AS CHAR);
        SELECT 'codNaturalezaPredi: ' + CAST(codNaturalezaPredi AS CHAR);
        SELECT 'texto: ' + texto;
        SELECT 'tipo: ' + tipo;
        SELECT 'codActitudHablante: ' + CAST(codActitudHablante AS CHAR);
        SELECT 'descActitud: ' + descActitud;
        SELECT '';
        
        -- Obtener la siguiente fila
        FETCH NEXT FROM cursorDatos INTO codEnunciado, codEstructura, codNaturalezaPredi, texto, tipo, codActitudHablante, descActitud;
    END WHILE;
    
    -- Cerrar y liberar el cursor
    CLOSE cursorDatos;
END //

DELIMITER ;



 call MostrarDatos();
 