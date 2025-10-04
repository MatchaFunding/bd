/*
Clase que representa a una persona natural, la cual puede ser miembro de una 
empresa o proyecto. Abajo de este estan las asociaciones entre persona y 
agrupacion.
https://www.nombrerutyfirma.com/nombre
https://www.nombrerutyfirma.com/rut
https://www.volanteomaleta.com/
*/
CREATE TABLE Persona (
	ID bigint NOT NULL AUTO_INCREMENT,
	Nombre varchar(200) NOT NULL,
	Apellido varchar(200) NULL,
	Sexo bigint NOT NULL,
	RUT varchar(12) NOT NULL,
	FechaDeNacimiento date NULL,
	Ocupacion varchar(1000) NULL,
	Correo varchar(200) NULL,
	Telefono tinyint NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Sexo) REFERENCES Sexo(ID)
);
