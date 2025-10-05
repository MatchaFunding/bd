/*
Clase que representa a una persona que es parte de una empresa, 
agrupacion o grupo de investigacion.
https://dequienes.cl/
*/
CREATE TABLE Miembro (
	ID bigint NOT NULL AUTO_INCREMENT,
	Persona bigint NOT NULL,
	Beneficiario bigint NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Persona) REFERENCES Persona(ID)
);
/*
Vista que muestra los miembros en formato legible
*/
CREATE TABLE VerTodosLosMiembros ENGINE = MEMORY
SELECT
	Persona.Nombre AS Persona,
	Beneficiario.Nombre AS Beneficiario
FROM
	Miembro, Persona, Beneficiario
WHERE
	Persona.ID=Miembro.Persona AND
	Beneficiario.ID=Miembro.Beneficiario;

