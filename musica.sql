
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

CREATE TABLE Grabacion (
  idGrabacion INT auto_increment,
  titulo VARCHAR(50),
  fecha DATE,
  idInstrumento INT,
  CONSTRAINT pk_grabacion PRIMARY KEY (idGrabacion),
  CONSTRAINT fk_instrumento_grabacion FOREIGN KEY (idInstrumento) REFERENCES Instrumento(idInstrumento)
);


INSERT INTO Instrumento (nombre, tipo)
VALUES ('Guitarra', 'Cuerda');

INSERT INTO Musico (nombre, genero, idInstrumento)
VALUES ('John Smith', 'Rock', 1);

INSERT INTO Grabacion (titulo, fecha, idInstrumento)
VALUES ('Sweet Child O'' Mine', '1987-08-17', 1);


