/*
Clase que representa a una persona que es parte de un proyecto que busca fondos.
https://dequienes.cl/
*/
CREATE TABLE Colaborador (
	ID bigint NOT NULL AUTO_INCREMENT,
	Persona bigint NOT NULL,
	Proyecto bigint NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Persona) REFERENCES Persona(ID),
	FOREIGN KEY (Proyecto) REFERENCES Proyecto(ID)
);
/*
Vista que muestra los colaboradores en formato legible
*/
CREATE VIEW VerTodosLosColaboradores AS
SELECT
	Persona.Nombre AS Persona,
	Proyecto.Titulo AS Proyecto
FROM
	Colaborador, Persona, Proyecto
WHERE
	Persona.ID=Colaborador.Persona AND
	Proyecto.ID=Colaborador.Proyecto;

