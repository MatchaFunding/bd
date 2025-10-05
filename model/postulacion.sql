/*
Clase que representa las postulaciones de un proyecto a un fondo
https://registros19862.gob.cl/
*/
CREATE TABLE Postulacion (
	ID bigint NOT NULL AUTO_INCREMENT,
	Beneficiario bigint NOT NULL,
	Proyecto bigint NULL,
	Instrumento bigint NOT NULL,
	Resultado bigint NOT NULL default 3,
	MontoObtenido int NULL,
	FechaDePostulacion date NULL,
	FechaDeResultado date NULL,
	Detalle varchar(2000) NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Proyecto) REFERENCES Proyecto(ID),
	FOREIGN KEY (Instrumento) REFERENCES Instrumento(ID),
	FOREIGN KEY (Resultado) REFERENCES Resultado(ID)
);
/*
Vista que muestra las postulaciones en formato legible
*/
CREATE TABLE VerTodasLasPostulaciones ENGINE = MEMORY
SELECT
	Beneficiario.Nombre AS Beneficiario,
	Proyecto.Titulo AS Proyecto,
	Instrumento.Titulo AS Instrumento,
	Resultado.Nombre AS Resultado,
	Postulacion.MontoObtenido,
	Postulacion.FechaDePostulacion,
	Postulacion.FechaDeResultado,
	Postulacion.Detalle
FROM
	Postulacion,
	Beneficiario,
	Proyecto,
	Instrumento,
	Resultado
WHERE
	Beneficiario.ID=Postulacion.Beneficiario AND
	Proyecto.ID=Postulacion.Proyecto AND
	Instrumento.ID=Postulacion.Instrumento AND
	Resultado.ID=Postulacion.Resultado;

