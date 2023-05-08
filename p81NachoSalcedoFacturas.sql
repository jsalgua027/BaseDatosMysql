create database p81NachoSalcedoFacturas;

create table facturas
(
  codigoUnico int,
  fechaEmision Date,
  descripcion varchar(30),
  totalImporte decimal(6,2),
  constraint pk_facturas primary key (codigoUnico)


);