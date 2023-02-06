/*
deptos{pk[coddepto] nomdepto}
grupos{pk[codgrupo],nomgrupo}
ciudadanos{ pk[codciudad], nomciudam, edaciuda}
alumnos{ pk[codalumno]codciuda*, codgrupo*}
profesores{pk[codprofe,coddepto*],codciudad*,....}
asignaturas{pk[codasigna], nomasigna, desasigna}
imparten{pk[(codprofe,coddepto)*,codasigana*,codgrupo*], observacion..}


*/

drop database if exists simuclase;
create database simuclase;
use simuclase;

CREATE TABLE IF NOT EXISTS deptos (
    coddepto INT UNSIGNED NOT NULL,
    nomdepto VARCHAR(60) NOT NULL,
    CONSTRAINT pk_deptos PRIMARY KEY (coddepto)
);

CREATE TABLE IF NOT EXISTS grupos (
    codgrupo INT UNSIGNED NOT NULL,
    nomgrupo VARCHAR(30) NOT NULL,
    CONSTRAINT pk_grupos PRIMARY KEY (codgrupo)
);
-- ciudadanos{ pk[codciudad], nomciudam, edaciuda}

CREATE TABLE IF NOT EXISTS ciudadanos (
   codciudad INT UNSIGNED NOT NULL,
    nomciudad VARCHAR(30) NOT NULL,
    edaciuda TINYINT NULL,
    CONSTRAINT pk_ciudadanos PRIMARY KEY (codciudad)
);
-- alumnos{ pk[codalumno]codciuda*, codgrupo*}

CREATE TABLE IF NOT EXISTS alumnos (
    codalumno INT UNSIGNED NOT NULL,
    codciudad INT UNSIGNED NOT NULL,
    codgrupo INT UNSIGNED NOT NULL,
    CONSTRAINT pk_alumnos PRIMARY KEY (codalumno),
    CONSTRAINT fk_alumnos_ciudadanos FOREIGN KEY (codciudad)
        REFERENCES ciudadanos (codciudad)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_alumnos_grupos FOREIGN KEY (codgrupo)
        REFERENCES grupos (codgrupo)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

-- profesores{pk[codprofe,coddepto*],codciudad*,....}

create table if not exists profesores 
(
 codprofe int unsigned not null,
  coddepto INT UNSIGNED NOT NULL,
  codciudad  INT UNSIGNED NOT NULL,
 constraint pk_profesores primary key (codprofe,coddepto),
 constraint fk_profesores_deptos foreign key (coddepto)
 references deptos (coddepto)
 on delete cascade on update no action,
 constraint fk_profesores foreign key ( codciudad )
 references ciudadanos  (codciudad)
 on delete cascade on update no	action
 
 
);

-- asignaturas{pk[codasigna], nomasigna, desasigna}

CREATE TABLE IF NOT EXISTS asignaturas (
    codasigna INT UNSIGNED NOT NULL,
    nomasigna VARCHAR(30) NOT NULL,
    descasigna VARCHAR(100) NOT NULL,
    CONSTRAINT pk_asignaturas PRIMARY KEY (codasigna)
);

-- imparten{pk[(codprofe,coddepto)*,codasigana*,codgrupo*], observacion..}


CREATE TABLE IF NOT EXISTS imparten (
    codprofe INT UNSIGNED NOT NULL,
    coddepto INT UNSIGNED NOT NULL,
    codasigna INT UNSIGNED NOT NULL,
    codgrupo INT UNSIGNED NOT NULL,
    observaciones VARCHAR(200),
    CONSTRAINT pk_imparten PRIMARY KEY (codprofe , coddepto , codasigna , codgrupo),
    CONSTRAINT fk_imparten_profesores FOREIGN KEY (codprofe , coddepto)
        REFERENCES profesores (codprofe , coddepto)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_imparten_asignaturas FOREIGN KEY (codasigna)
        REFERENCES asignaturas (codasigna)
        ON DELETE CASCADE ON UPDATE NO ACTION,
    CONSTRAINT fk_imparten_grupos FOREIGN KEY (codgrupo)
        REFERENCES grupos (codgrupo)
        ON DELETE CASCADE ON UPDATE NO ACTION
);

