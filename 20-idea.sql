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
	UltimaFechaDeModificaion date NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Usuario) REFERENCES Usuario(ID)
);
