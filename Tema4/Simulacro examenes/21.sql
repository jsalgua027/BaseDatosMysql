/*

sujetos( pk(codsujeto), nomsujeto,ape1sujeto, ape2sujeto, dni, codpostal, email,...)
clientela(pk(codclientela), codsujeto*, estadoCivil....)
abogados(ok(codabogado), codsujeto*, numcolegiado.....)
tiposCasos(pk(idtipoCaso), destipoCaso,....)
casos( pk(idtipocaso*,codcaso),codclientela* ,desCaso.... ) 
lleva (pk([idcasos, codcaso]*,codabogado*,fecini), numdias)

*/
/*** P1. ESQUEMA RELACIONAL  eva*/

/*
sujetos (PK(codsujeto), nomsujeto, ape1sujeto,ape2sujeto,dni,dirpostal,email,tlfcontacto)
clientela(PK(codcli), codsujeto*, estadocivil)
abogados(PK(codabogado), codsujeto*,numcolegiado)
tiposcasos(PK(cottipocaso),desTipoCaso)
casos(PK(codcaso,codtipocaso*),descaso,codcli*,presupuesto)
AbogadosenCasos(PK[[codcaso,codtipocaso]*,codabogado*,fecinicio], numdias)
*/


drop database  if exists abogados;
create database abogados;
use abogados;
CREATE TABLE IF NOT EXISTS sujetos (
    codsujeto INT UNSIGNED NOT NULL,
    nomsujeto VARCHAR(20) NOT NULL,
    ape1sujeto VARCHAR(20) NOT NULL,
    ape2sujeto VARCHAR(20) NULL,
    dni CHAR(9) NOT NULL,
    dirpostal CHAR(12) NULL,
    email VARCHAR(50) UNIQUE NULL,
    tlfcontacto CHAR(12) NULL,
    CONSTRAINT pk_abogados PRIMARY KEY (codsujeto)
);

create table if not exists clientela
(
	codcli int unsigned not null,
     codsujeto INT UNSIGNED NOT NULL,
     estadoCivil enum('S', 'V', 'D', 'C') not null,
     
     constraint pk_clientela primary key (codcli),
     constraint fk_clientela_sujetos foreign key (codsujeto)
     references sujetos (codsujeto)
	on delete no action on update cascade

);

create table if not exists abogado
(
	codabogado int unsigned not null,
     codsujeto INT UNSIGNED NOT NULL,
    numcolegiado int unsigned,
     
     constraint pk_clientela primary key (codabogado),
     constraint fk_clientela_abogados foreign key (codabogado)
     references sujetos (codsujeto)
	

);

-- tiposcasos(PK(cottipocaso),desTipoCaso)
CREATE TABLE IF NOT EXISTS tipocasos (
    codtipcaso INT UNSIGNED NOT NULL,
    desTipoCaso VARCHAR(60) NOT NULL,
    CONSTRAINT pk_tiposcasos PRIMARY KEY (codtipcaso)
);

-- casos(PK(codcaso,codtipocaso*),descaso,codcli*,presupuesto)

CREATE TABLE IF NOT EXISTS casos (
    codcaso INT UNSIGNED NOT NULL,
    codtipcaso INT UNSIGNED NOT NULL,
    descaso VARCHAR(100) NULL,
    codcli INT UNSIGNED NOT NULL,
    presupesto DECIMAL(7 , 2 ) NOT NULL,
    CONSTRAINT pk_casos PRIMARY KEY (codcaso , codtipcaso),
    CONSTRAINT fk_casos_tipocasos FOREIGN KEY (codtipcaso)
        REFERENCES tipocasos (codtipcaso)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_casos_clientela FOREIGN KEY (codcli)
        REFERENCES clientela (codcli)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

/*

A veces, un abogado vuelve a llevar el mismo caso en periodos de tiempo diferentes. Por esta linea se mete fecinicio como clave primaria tambien

AbogadosenCasos(PK[[codcaso,codtipocaso]*,codabogado*,fecinicio], numdias)

*/

CREATE TABLE IF NOT EXISTS AbogadosenCasos (
    codcaso INT UNSIGNED NOT NULL,
    codtipcaso INT UNSIGNED NOT NULL,
    codabogado INT UNSIGNED NOT NULL,
    fecinicio DATE NOT NULL,
    numdias INT UNSIGNED NULL,
    CONSTRAINT pk_AbogadosenCasos PRIMARY KEY (codcaso , codtipcaso , codabogado , fecinicio),
    CONSTRAINT fk_AbogadosenCasos_casos FOREIGN KEY (codcaso , codtipcaso)
        REFERENCES casos (codcaso , codtipcaso)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_abogado FOREIGN KEY (codabogado)
        REFERENCES abogado (codabogado)
        ON DELETE CASCADE ON UPDATE NO ACTION
);
