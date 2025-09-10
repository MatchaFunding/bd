/*
Clase que representa los estados en los que se puede encontrar una postulacion.
Los resultados solo pueden caer dentro de las tres categorias.
*/
CREATE TABLE Resultado (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(30) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO Resultado (ID, Codigo, Nombre)
VALUES
	(1,"ADJ","Adjudicado"),
	(2,"REC","Rechazado"),
	(3,"PEN","Pendiente");
