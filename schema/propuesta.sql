/*
Clase que representa la propuesta de la IA tras recibir una idea
*/
CREATE TABLE Propuesta (
	ID bigint NOT NULL AUTO_INCREMENT,
	Idea bigint NOT NULL,
	Resumen varchar(3000) NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Idea) REFERENCES Idea(ID)
);
