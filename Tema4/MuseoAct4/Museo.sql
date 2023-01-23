drop database if exists MUSEO;
create database MUSEO;
CREATE TABLE IF NOT EXISTS ESTILOS (
    codEstilo VARCHAR(30) NOT NULL,
    descripcion VARCHAR(100) NULL,
    CONSTRAINT PK_ESTILOS PRIMARY KEY (codEstilo)
);

create table if not exists ARTISTAS	
(
codArtista varchar(30) not null,
nomArtista varchar(60) not null,
fecNaciArtista datetime not null,
constraint PK_ARTISTAS primary key (codArtista)


);