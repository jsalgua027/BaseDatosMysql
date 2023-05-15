drop database ProyectoSintaxis;
create database ProyectoSintaxis;
use ProyectoSintaxis;

CREATE TABLE IF NOT EXISTS Estructura (
    codEstructura INT,
    desEstructura VARCHAR(200),
    CONSTRAINT PK_Estructura PRIMARY KEY (codEstructura)
);

CREATE TABLE IF NOT EXISTS NaturalezaPredicado (
    codNaturalezaPredi INT,
    vozVerbo VARCHAR(30),
    verboCopulativo BOOLEAN,
    transitividad BOOLEAN,
    CONSTRAINT PK_NaturalezaPredicado PRIMARY KEY (codNaturalezaPredi)
);
CREATE TABLE IF NOT EXISTS ActitudHablante (
    codActitudHablante INT,
    desActitudHablante VARCHAR(100),
    CONSTRAINT PK_ActitudHablante PRIMARY KEY (codActitudHablante)
);


CREATE TABLE IF NOT EXISTS Enunciado (
    codEnunciado INT UNSIGNED,
    codEstructura INT,
    codNaturalezaPredi INT,
    texto VARCHAR(200) NOT NULL,
    tipo ENUM('Frase', 'Oración'),
    CONSTRAINT PK_Enunciado PRIMARY KEY (codEnunciado),
    CONSTRAINT FK_Enunciado_estructura FOREIGN KEY (codEstructura)
        REFERENCES Estructura (codEstructura)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Enunciado_NaturalezaPre FOREIGN KEY (codNaturalezaPredi)
        REFERENCES NaturalezaPredicado (codNaturalezaPredi)
);

CREATE TABLE IF NOT EXISTS detalleActitud (
    codEnunciado INT UNSIGNED,
    codActitudHablante INT,
    descActitud VARCHAR(200),
    CONSTRAINT PK_detalleActitud PRIMARY KEY (codEnunciado , codActitudHablante),
    CONSTRAINT FK_detalleActitud_Enunciado FOREIGN KEY (codEnunciado)
        REFERENCES Enunciado (codEnunciado)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_detalleActitud_ActitudHablante FOREIGN KEY (codActitudHablante)
        REFERENCES ActitudHablante (codActitudHablante)
        ON DELETE NO ACTION ON UPDATE CASCADE
        );
