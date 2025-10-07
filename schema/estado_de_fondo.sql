/*
Estado en el que se encuentra un fondo o instrumento.
*/
CREATE TABLE EstadoDeFondo (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(40) NOT NULL,
	PRIMARY KEY (ID)
);

INSERT INTO EstadoDeFondo (ID, Codigo, Nombre)
VALUES
	(1,"PRX","Proximo"),
	(2,"ABI","Abierto"),
	(3,"EVA","En evaluacion"),
	(4,"ADJ","Adjudicado"),
	(5,"SUS","Suspendido"),
	(6,"PAY","Patrocinio Institucional"),
	(7,"DES","Desierto"),
	(8,"CER","Cerrrado");

CREATE TABLE VerEstadosDeFondo AS
SELECT Nombre FROM EstadoDeFondo;
