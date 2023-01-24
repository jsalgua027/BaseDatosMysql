drop database if exists ALMACEN;
create database  if not exists ALMACEN;
use ALMACEN;

CREATE TABLE IF NOT EXISTS CATEGORIAS (
    codCat int  unsigned,
    nomCat VARCHAR(60) NOT NULL,
    proveedor VARCHAR(60) NOT NULL,
    CONSTRAINT PK_CATEGORIAS PRIMARY KEY (codCat)
);


CREATE TABLE IF NOT EXISTS PRODUCTOS (
    refprod int unsigned,
    
    decripc VARCHAR(60) NOT NULL,
    fecIngreso DATETIME NULL,
    precioBase DECIMAL(10 , 2 ) NOT NULL,
     precioVenta DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT PK_PRODUCTOS PRIMARY KEY (refProd )
  );

create table if not exists VENTAS
(
 codVenta int not null,
 fecVenta datetime not null,
 cliente varchar(60),
 constraint PK_ventas primary key (codVenta) 


);

CREATE TABLE IF NOT EXISTS LINVENTAS (
    refprod int unsigned,
  
    codVenta INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_LINVENTAS PRIMARY KEY (refprod  ),
    CONSTRAINT FK_LINVENTAS_PRODUCTOS FOREIGN KEY (refprod )
        REFERENCES PRODUCTOS (refprod)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_VENTAS FOREIGN KEY (codVenta)
        REFERENCES VENTAS (codVenta)
        ON DELETE NO ACTION ON UPDATE CASCADE
);
/*
1. añadir campo codCat en tabla productos 
2. añadir fk codcat en produtos de abala codCat
3 drop fk  e lineVenta a tabla productos
4 drop pk productos
5 add pk productos
6 add colunma codCat en tabla lineaVentas
7 add fk en lineaVentas a tabla produtos


*/
alter table PRODUCTOS	
ADD column codCat int unsigned after refProd,
add constraint FK_PRODUCTOS_CATEGORIAS foreign key (codCat)
references CATEGORIAS (codCat)
ON DELETE NO ACTION ON UPDATE CASCADE;

alter table LINVENTAS
drop constraint FK_LINVENTAS_PRODUCTOS;

alter table PRODUCTOS 
drop primary key,
add constraint PK_PRODUCTOS primary key (refProd, codCAt);

alter table LINVENTAS
add column codCat int unsigned not null,
-- drop index FK_LINVENTAS_PRODUCTOS,
add constraint FK_LINVENTAS_PRODUCTOS foreign key (refProd, codCat)
	references PRODUCTOS (refProd, codCat)
    ON DELETE NO ACTION ON UPDATE CASCADE,
    drop constraint FK_VENTAS,
    drop primary key,
add constraint PK_LINVENTAS primary key (refProd, codCat,codVenta),
add constraint FK_LINVENTAS_VENTAS foreign key (codVenta)
references VENTAS (codVenta)
on delete no action on update cascade;