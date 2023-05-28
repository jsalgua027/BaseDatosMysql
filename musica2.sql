drop database if exists musica2;

create database musica2;
use musica2;

CREATE TABLE Musico (
  idMusico INT auto_increment,
  nombre VARCHAR(50),
  genero VARCHAR(50),

  CONSTRAINT pk_musico PRIMARY KEY (idMusico)
  
);


CREATE TABLE Instrumento (
  idInstrumento INT auto_increment,
  nombre VARCHAR(50),
  tipo VARCHAR(50),
   idMusico INT,
  CONSTRAINT pk_instrumento PRIMARY KEY (idInstrumento),
  CONSTRAINT fk_instrumento_musico FOREIGN KEY (idMusico) REFERENCES Musico(idMusico)
);



CREATE TABLE Grabacion (
  idGrabacion INT auto_increment,
  titulo VARCHAR(50),
  fecha DATE,
  idInstrumento INT,
  CONSTRAINT pk_grabacion PRIMARY KEY (idGrabacion),
  CONSTRAINT fk_instrumento_grabacion FOREIGN KEY (idInstrumento) REFERENCES Instrumento(idInstrumento)
);



INSERT INTO Musico (idMusico,nombre, genero)
VALUES (1,'John Smith', 'Rock');

INSERT INTO Instrumento ( IdInstrumento,nombre, tipo, idMusico)
VALUES (1,'Guitarra', 'Cuerda',1);


INSERT INTO Grabacion (idGrabacion,titulo, fecha, idInstrumento)
VALUES (1,'Sweet Child O'' Mine', '1987-08-17', 1);