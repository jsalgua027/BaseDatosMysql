drop database if exists ALMACEN;
create database  if not exists ALMACEN;
use ALMACEN;

CREATE TABLE IF NOT EXISTS CATEGORIAS (
    codCat VARCHAR(30) NOT NULL,
    nomCat VARCHAR(60) NOT NULL,
    proveedor VARCHAR(60) NOT NULL,
    CONSTRAINT PK_CATEGORIAS PRIMARY KEY (codCat)
);


CREATE TABLE IF NOT EXISTS PRODUCTOS (
    refprod VARCHAR(30) NOT NULL,
    codCat VARCHAR(30) NOT NULL,
    decripc VARCHAR(60) NOT NULL,
    fecIngreso DATETIME NULL,
    precio DECIMAL(4 , 2 ) NOT NULL,
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY (refProd , codCat),
    CONSTRAINT FK_PRODUCTOS_CATEGORIAS FOREIGN KEY (codCat)
        REFERENCES CATEGORIAS (codCat)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

create table if not exists VENTAS
(
 codVenta int not null,
 fecVenta datetime not null,
 cliente varchar(60),
 constraint PK_ventas primary key (codVenta) 


);

CREATE TABLE IF NOT EXISTS LINVENTAS (
    refprod VARCHAR(30) NOT NULL,
    codCat VARCHAR(30) NOT NULL,
    codVenta INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_LINVENTAS PRIMARY KEY (refprod , codCat , codVenta),
    CONSTRAINT FK_LINVENTAS_PRODUCTOS FOREIGN KEY (refprod , codCat)
        REFERENCES PRODUCTOS (refprod , codCat)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_VENTAS FOREIGN KEY (codVenta)
        REFERENCES VENTAS (codVenta)
        ON DELETE NO ACTION ON UPDATE CASCADE
);