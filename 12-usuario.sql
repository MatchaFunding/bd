/*
Clase que representa a un usuario de MatchaFunding.
*/
CREATE TABLE Usuario (
	ID bigint NOT NULL AUTO_INCREMENT,
	Persona bigint NULL,
	NombreDeUsuario varchar(200),
	Contrasena varchar(200) NOT NULL,
	Correo varchar(200) NOT NULL,
	Telefono tinyint NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Persona) REFERENCES Persona(ID)
);

CREATE VIEW VerTodosLosUsuarios AS SELECT
	Usuario.NombreDeUsuario,
	Usuario.Contrasena,
	Usuario.Correo
FROM
	Usuario;
