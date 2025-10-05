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
