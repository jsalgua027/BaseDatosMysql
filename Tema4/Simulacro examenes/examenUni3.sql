drop database if exists examenUnidad3;
create database examenUnidad3;
use examenUnidad3;
CREATE TABLE IF NOT EXISTS tiendas (
    codtienda INT UNSIGNED NOT NULL,
    nomtienda VARCHAR(30) NOT NULL,
    telftienda CHAR(9) NOT NULL,
    CONSTRAINT pk_tiendas PRIMARY KEY (codtienda)
);
CREATE TABLE IF NOT EXISTS franquicias (
    codfranqui INT UNSIGNED NOT NULL,
    codtienda INT UNSIGNED NOT NULL,
    teltienda CHAR(9) NOT NULL,
    CONSTRAINT pk_franquicias PRIMARY KEY (codfranqui),
    CONSTRAINT fk_franquicias_tiendas FOREIGN KEY (codtienda)
        REFERENCES tiendas (codtienda)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS propias (
    codpropia INT UNSIGNED NOT NULL,
    codtienda INT UNSIGNED NOT NULL,
    telpropia CHAR(9) NOT NULL,
    CONSTRAINT pk_franquicias PRIMARY KEY (codpropia),
    CONSTRAINT fk_franquicias_propias FOREIGN KEY (codtienda)
        REFERENCES tiendas (codtienda)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS eventos (
    codevento INT UNSIGNED NOT NULL,
    decrievento VARCHAR(150) NULL,
    CONSTRAINT pk_eventos PRIMARY KEY (codevento)
);

CREATE TABLE IF NOT EXISTS categorias (
    codcategoria INT UNSIGNED NOT NULL,
    nomcategoria VARCHAR(30),
    descategoria VARCHAR(150),
    CONSTRAINT pk_categorias PRIMARY KEY (codcategoria)
);

CREATE TABLE IF NOT EXISTS articulos (
    codarticulo INT UNSIGNED NOT NULL,
    codcategoria INT UNSIGNED ,
    nomarticulo VARCHAR(30),
    CONSTRAINT pk_articulos PRIMARY KEY (codarticulo),
    CONSTRAINT fk_articulos_categorias FOREIGN KEY (codcategoria)
        REFERENCES categorias (codcategoria)
        ON DELETE CASCADE ON UPDATE NO ACTION
);
/*
Una vez generada una promoción asociada a un evento, no podremos modificar el código de evento.

*/
CREATE TABLE IF NOT EXISTS promociones (
    codpromo INT UNSIGNED NOT NULL,
    codevento INT UNSIGNED,
    nomevento VARCHAR(30),
    fechaini DATE NOT NULL,
    CONSTRAINT pk_promociones PRIMARY KEY (codpromo , codevento),
    CONSTRAINT fk_promociones_eventos FOREIGN KEY (codevento)
        REFERENCES eventos (codevento)
        ON DELETE CASCADE ON UPDATE NO ACTION
);







