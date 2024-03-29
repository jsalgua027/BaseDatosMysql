drop database if exists zoologico;
create database zoologico;
use zoologico;

CREATE TABLE IF NOT EXISTS empleados (
    codemple INT UNSIGNED NOT NULL,
    nomemple VARCHAR(30) NOT NULL,
    edademple TINYINT NOT NULL,
    telemple CHAR(9) NULL,
    CONSTRAINT pk_empleados PRIMARY KEY (codemple)
);

CREATE TABLE IF NOT EXISTS cuidadores (
    codcuida INT UNSIGNED NOT NULL,
    codemple INT UNSIGNED NOT NULL,
    infocuida VARCHAR(100),
    CONSTRAINT pk_cuidadores PRIMARY KEY (codcuida),
    CONSTRAINT fk_cuidadores_empleados FOREIGN KEY (codemple)
        REFERENCES empleados (codemple)
on delete no action  on update cascade
);

create table if not exists veterinarios
(
codvete int unsigned not null,
 codemple INT UNSIGNED NOT NULL,
infovete varchar(100),
constraint pk_veterinarios primary key (codvete),
constraint fk_veterinarios_empleado foreign key(codemple)
references empleados (codemple)
on delete no action on update cascade


);

CREATE TABLE IF NOT EXISTS zonas (
    codzona INT UNSIGNED NOT NULL,
    nomzona VARCHAR(30) NOT NULL,
    desczona VARCHAR(100) NOT NULL,
    CONSTRAINT pk_zonas PRIMARY KEY (codzona)
);

create table if not exists recintos
(

codrecin int unsigned not null,
  codzona INT UNSIGNED NOT NULL,
  codcuida INT UNSIGNED,
  nomrecin varchar(30) not null,
  descrecin varchar(100) not null,
  constraint pk_recintos primary key (codrecin, codzona),
  constraint fk_recintos_zonas foreign key (codzona)
  references zonas (codzona)
  on delete cascade on update no action,
  constraint fk_recintos_cuidadores foreign key (codcuida)
  references cuidadores (codcuida)
  on delete set null on update cascade
  


);


CREATE TABLE IF NOT EXISTS ejemplares (
    codejem INT NOT NULL,
    codpadre INT ,
    codmadre INT ,
    codvete INT UNSIGNED ,
    nomejem VARCHAR(30) UNIQUE NOT NULL,
    claseejem ENUM('peces', 'anfibios', 'reptiles', 'aves', 'mamiferos'),
    tipoali set('herbivora', 'carnivora', 'insectivora', 'fructivora'),
    CONSTRAINT pk_ejemplares PRIMARY KEY (codejem),
    CONSTRAINT fk_ejemplares_parentesco FOREIGN KEY (codpadre)
        REFERENCES ejemplares (codejem)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplares_familia FOREIGN KEY (codmadre)
        REFERENCES ejemplares (codejem)
        ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT fk_ejemplares_veterinarios FOREIGN KEY (codvete)
        REFERENCES veterinarios (codvete)
        ON DELETE NO ACTION ON UPDATE CASCADE
);

create table if not exists estan

(

codrecin int unsigned not null,
codzona INT UNSIGNED NOT NULL,
  codejem INT NOT NULL,
fechaini date not null,
fechafin date null,
observaciones varchar(300) null,

constraint pk_estan primary key(codrecin,codzona,fechaini, codejem),
constraint fk_estan_recintos foreign key (codrecin,codzona)
references recintos  (codrecin,codzona)
on delete no action on update no action, -- Si desapareciera un cuidador/a del sistema, los recintos asignados a dicho cuidador/a,  quedarán sin cuidador hasta que se reasignen.

constraint fk_estan_ejemplares foreign key (codejem)
references ejemplares (codejem)
on delete no action on update no action
);
/*
Incluye el salario de los empleados que nunca será mayor de 5000 € y podrán incluir hasta dos decimales.
 Para evitar errores no se admitirán valores negativos ni nulos. Ten en cuenta que ya hay datos almacenados.
*/
alter table empleados
add column sueldo decimal (6,2) unsigned default 900;-- le doy un valor por defecto para que no de error el null
/*
Incluye la edad del ejemplar y su fecha de nacimiento (queremos saber también la hora en que nace un ejemplar).
 Asegúrate de que, en el caso de la edad, se aprovecha bien el espacio, se trata de un campo que nunca excederá del valor 130.
*/
alter table ejemplares
add column edaeje tinyint not null,
add column fechaNaci date not null,
add column horaNaci datetime not null;
/*
Vamos a convertir  la relación N:M que exite entre RECINTOS y EJEMPLARES en 2 relaciones 1:N

*/


