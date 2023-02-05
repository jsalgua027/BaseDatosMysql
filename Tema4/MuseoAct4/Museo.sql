drop database if exists MUSEO;
create database MUSEO;
use MUSEO;
CREATE TABLE IF NOT EXISTS ESTILOS (
    codEstilo VARCHAR(30) ,
    descripcion VARCHAR(100) NULL,
    CONSTRAINT PK_ESTILOS PRIMARY KEY (codEstilo)
);

CREATE TABLE IF NOT EXISTS ARTISTAS (
    codArtista VARCHAR(30) ,
    nomArtista VARCHAR(60) ,
    fecNaciArtista DATE ,
    biografia text, -- text para textos largos
    edad tinyint,  -- para edades por espacio en memoria
    CONSTRAINT PK_ARTISTAS PRIMARY KEY (codArtista)
);

CREATE TABLE IF NOT EXISTS TIPOoBRAS (
    codTipoO VARCHAR(30) ,
    descripcionTipo VARCHAR(100) ,
    CONSTRAINT PK_TIPOoBRAS PRIMARY KEY (codTipoO)
);

CREATE TABLE IF NOT EXISTS SALAS (
    codSala VARCHAR(30) ,
    nomSala VARCHAR(60) ,
    descripcionS VARCHAR(100) ,
    CONSTRAINT PK_SALAS PRIMARY KEY (codSala)
);

CREATE TABLE IF NOT EXISTS OBRAS (
    codEstilo VARCHAR(30) ,
    codArtista VARCHAR(30) ,
    codTipoO VARCHAR(30) ,
    codSala VARCHAR(30) ,
    codObra VARCHAR(30) ,
    nomObra VARCHAR(60) ,
    fecObra DATETIME ,
    CONSTRAINT PK_OBRAS PRIMARY KEY (codObra),
    CONSTRAINT FK_OBRAS_ESTILOS FOREIGN KEY (codEstilo)
        REFERENCES ESTILOS (codEstilo)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_OBRAS_ARTISTAS FOREIGN KEY (codArtista)
        REFERENCES ARTISTAS (codArtista)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_OBRAS_TIPOoBRAS FOREIGN KEY (codTipoO)
        REFERENCES TIPOoBRAS (codTipoO)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_OBRAS_SALAS FOREIGN KEY (codSala)
        REFERENCES SALAS (codSala)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS EMPLEADOS (
    codEmpleado VARCHAR(30) NOT NULL,
    ape1Empleado VARCHAR(20) NOT NULL,
    ape2Empleado VARCHAR(20) NOT NULL,
    nomEmpleado VARCHAR(20) NOT NULL,
    edaEmpleado INT NULL,
    telefonoEmpleado CHAR NULL, -- telefonos , codigos postales siempre char
    fecNacim DATE NULL,
    CONSTRAINT PK_EMPLEADOS PRIMARY KEY (codEmpleado)
);

CREATE TABLE IF NOT EXISTS RESTAURADORES (
    codEmpleado VARCHAR(30) ,
    codRestau VARCHAR(30) ,
    sueldo DECIMAL(6 , 2 ) ,
    CONSTRAINT PK_RESTAURADORES PRIMARY KEY (codRestau),
    CONSTRAINT FK_RESTAURADORES_EMPLEADOS FOREIGN KEY (codEmpleado)
        REFERENCES EMPLEADOS (codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS SEGURIDAD (
    codSala VARCHAR(30) ,
    codEmpleado VARCHAR(30) ,
    codSeguri VARCHAR(30) ,
    sueldo DECIMAL(6 , 2 ) ,
    CONSTRAINT PK_SEGURIDAD PRIMARY KEY (codSeguri),
    CONSTRAINT FK_SEGURIDAD_EMPLEADOS FOREIGN KEY (codEmpleado)
        REFERENCES EMPLEADOS (codEmpleado)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_SEGURIDAD_SALAS FOREIGN KEY (codSala)
        REFERENCES SALAS (codSala)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS RESTAURACIONES (
    codObra VARCHAR(30) ,
    codRestau VARCHAR(30) ,
    fecIniRest DATE ,
    fecFinRest DATE  NULL,
    observaciones text,
    CONSTRAINT PK_RESTAURACIONES PRIMARY KEY (codObra , codRestau),
    CONSTRAINT FK_RESTAURACIONES_OBRAS FOREIGN KEY (codObra)
        REFERENCES OBRAS (codObra)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_RESTAURACIONES_RESTAURADORES FOREIGN KEY (codRestau)
        REFERENCES RESTAURADORES (codRestau)
        ON DELETE NO ACTION ON UPDATE CASCADE
);