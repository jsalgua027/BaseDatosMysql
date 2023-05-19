
drop database if exists musica;

create database musica;
use musica;

CREATE TABLE Instrumento (
  idInstrumento INT auto_increment,
  nombre VARCHAR(50),
  tipo VARCHAR(50),
  CONSTRAINT pk_instrumento PRIMARY KEY (idInstrumento)
);

CREATE TABLE Musico (
  idMusico INT auto_increment,
  nombre VARCHAR(50),
  genero VARCHAR(50),
 idInstrumento INT ,
  CONSTRAINT pk_musico PRIMARY KEY (idMusico),
  CONSTRAINT fk_instrumento_musico FOREIGN KEY (idInstrumento) REFERENCES Instrumento(idInstrumento)
);

CREATE TABLE Biografia (
  idBiografia INT auto_increment,
  descripcion TEXT,
  fechaNacimiento DATE,
  lugarNacimiento VARCHAR(50),
  idMusico INT,
  CONSTRAINT pk_biografia PRIMARY KEY (idBiografia),
  CONSTRAINT fk_musico_biografia FOREIGN KEY (idMusico) REFERENCES Musico(idMusico)
);


CREATE TABLE Grabacion (
  idGrabacion INT auto_increment,
  titulo VARCHAR(50),
  fecha DATE,
  idInstrumento INT,
  CONSTRAINT pk_grabacion PRIMARY KEY (idGrabacion),
  CONSTRAINT fk_instrumento_grabacion FOREIGN KEY (idInstrumento) REFERENCES Instrumento(idInstrumento)
);

delete from Grabacion;
delete from Musico;
delete from Instrumento ;


INSERT INTO Instrumento ( IdInstrumento,nombre, tipo)
VALUES (1,'Guitarra', 'Cuerda');

INSERT INTO Musico (idMusico,nombre, genero, idInstrumento)
VALUES (1,'John Smith', 'Rock', 1);

INSERT INTO Biografia (descripcion, fechaNacimiento, lugarNacimiento, idMusico)
VALUES ('Roquero Vieja escuela', '1990-01-01', 'Madrid', 1);


INSERT INTO Grabacion (idGrabacion,titulo, fecha, idInstrumento)
VALUES (1,'Sweet Child O'' Mine', '1987-08-17', 1);


