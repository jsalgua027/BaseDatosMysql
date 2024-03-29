

drop database if exists proyectosintaxisrelacional;
create database proyectosintaxisrelacional;
use proyectosintaxisrelacional;

CREATE TABLE IF NOT EXISTS estructura (
    codEstructura INT,
    desEstructura VARCHAR(200),
    CONSTRAINT PK_Estructura PRIMARY KEY (codEstructura)
);

CREATE TABLE IF NOT EXISTS naturalezapredicado (
    codNaturalezaPredi INT,
    vozVerbo VARCHAR(30),
    verboCopulativo BOOLEAN,
    transitividad BOOLEAN,
    CONSTRAINT PK_NaturalezaPredicado PRIMARY KEY (codNaturalezaPredi)
);
CREATE TABLE IF NOT EXISTS actitudhablante (
    codActitudHablante INT,
    desActitudHablante VARCHAR(100),
    CONSTRAINT PK_ActitudHablante PRIMARY KEY (codActitudHablante)
);


CREATE TABLE IF NOT EXISTS enunciados (
    codEnunciado INT UNSIGNED,
    codEstructura INT,
    codNaturalezaPredi INT,
    texto VARCHAR(200) NOT NULL,
    tipo ENUM('Frase', 'Oración'),
    CONSTRAINT PK_Enunciado PRIMARY KEY (codEnunciado),
    CONSTRAINT FK_Enunciado_estructura FOREIGN KEY (codEstructura)
        REFERENCES estructura (codEstructura)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Enunciado_NaturalezaPre FOREIGN KEY (codNaturalezaPredi)
        REFERENCES naturalezapredicado (codNaturalezaPredi)
);

CREATE TABLE IF NOT EXISTS detalleactitud (
    codEnunciado INT UNSIGNED,
    codActitudHablante INT,
    descActitud VARCHAR(200),
    CONSTRAINT PK_detalleActitud PRIMARY KEY (codEnunciado , codActitudHablante),
    CONSTRAINT FK_detalleActitud_Enunciado FOREIGN KEY (codEnunciado)
        REFERENCES enunciados (codEnunciado)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_detalleActitud_ActitudHablante FOREIGN KEY (codActitudHablante)
        REFERENCES actitudhablante (codActitudHablante)
        ON DELETE NO ACTION ON UPDATE CASCADE
);  

-- Insersión de datos
--
insert into estructura
(codEstructura, desEstructura)
values
(1,'Personal'),
(2,'Impersonal');
--
insert into naturalezapredicado
(codNaturalezaPredi, vozVerbo,verboCopulativo, transitividad)
values
(1, 'pasiva', true, true),
    (2, 'activa', false, false),
    (3, 'pasiva', false, true),
    (4, 'pasiva', true, false),
    (5, 'activa', true, true),
    (6, 'pasiva', false, false),
    (7, 'activa', false, true),
    (8, 'activa', true, false);
--
insert into actitudhablante
(codActitudHablante,desActitudHablante)
values
(1, 'Negativa'),
(2,'Afirmativa'),
(3,'Exclamativa'),
(4,'Interrogativa'),
(5,'Desiderativa'),
(6,'Dubitativa'),
(7,'Exhortatuva o de orden');
--  
insert into enunciados
(codEnunciado, codEstructura, codNaturalezaPredi, texto, tipo)
values
(1, 1, 7, 'Me seco la cara con una toalla muy suave', 'Oración'),
    (2, 1, 7, '¡Que tengas suerte!', 'Oración'),
    (3, 1, 7, 'El tabaco perjudica la salud', 'Oración'),
    (4, 2, 6, 'Se alquila apartamento grande y silencioso', 'Oración');
--
insert into detalleactitud
(codEnunciado, codActitudHablante, descActitud)
values
(1, 2, 'Indica una afirmación'),
(2, 5, 'Expresa deseo'),
(3, 2, 'Indica una afirmación'),
(4, 2, 'Indica una afirmación');
