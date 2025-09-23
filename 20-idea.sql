/*
Clase que representa la idea para un proyecto
*/
CREATE TABLE Idea (
	ID bigint NOT NULL AUTO_INCREMENT,
	Usuario bigint NOT NULL,
	Campo varchar(1000) NOT NULL,
	Problema varchar(1000) NOT NULL,
	Publico varchar(1000) NOT NULL,
	Innovacion varchar(1000) NOT NULL,
	Oculta boolean NULL default false,
	FechaDeCreacion date NULL,
	UltimaFechaDeModificacion date NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Usuario) REFERENCES Usuario(ID)
);

CREATE VIEW VerTodasLasIdeas AS SELECT
	Idea.Usuario,
	Idea.Campo,
	Idea.Problema,
	Idea.Publico,
	Idea.Innovacion,
	Idea.Oculta,
	Idea.FechaDeCreacion,
	Idea.UltimaFechaDeModificacion
FROM Idea;
