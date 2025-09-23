/*
Clase que representa las postulaciones de un proyecto a un fondo
https://registros19862.gob.cl/
*/
CREATE TABLE Postulacion (
	ID bigint NOT NULL AUTO_INCREMENT,
	Beneficiario bigint NOT NULL,
	Proyecto bigint NOT NULL,
	Instrumento bigint NOT NULL,
	Resultado bigint NOT NULL default 3,
	MontoObtenido int NOT NULL,
	FechaDePostulacion date NULL,
	FechaDeResultado date NULL,
	Detalle varchar(2000) NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Proyecto) REFERENCES Proyecto(ID),
	FOREIGN KEY (Instrumento) REFERENCES Instrumento(ID),
	FOREIGN KEY (Resultado) REFERENCES Resultado(ID)
);

CREATE VIEW VerTodasLasPostulaciones AS SELECT
	Postulacion.Beneficiario,
	Postulacion.Proyecto,
	Postulacion.Instrumento,
	Postulacion.Resultado,
	Postulacion.MontoObtenido,
	Postulacion.FechaDePostulacion,
	Postulacion.FechaDeResultado,
	Postulacion.Detalle
FROM Postulacion;
