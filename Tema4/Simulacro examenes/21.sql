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
     
     constraint pk_clientela primary key (codclien),
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
    CONSTRAINT pk_tiposcasos PRIMARY KEY (codTipocaso)
);






