/*
Clase que representa los proyectos de una misma empresa.
https://www.boletaofactura.com/
*/
CREATE TABLE Proyecto (
	ID bigint NOT NULL AUTO_INCREMENT,
	Beneficiario bigint NOT NULL,
	Titulo varchar(500) NOT NULL,
	Descripcion varchar(2000) NOT NULL,
	DuracionEnMesesMinimo int NOT NULL,
	DuracionEnMesesMaximo int NOT NULL,
	Alcance bigint NOT NULL,
	Area varchar(500) NOT NULL, /* Area o campo bajo el cual se desarrolla */
	Problema varchar(1000) NULL, /* Problema que busca resolver */ 
	Publico varchar(1000) NULL, /* Publico objetivo destinado */ 
	Innovacion varchar(1000) NULL, /* Innovacion u aporte que trae */ 
	Proposito varchar(1000) NULL,
	ObjetivoGeneral varchar(1000) NULL,
	ObjetivoEspecifico varchar(1000) NULL,
	ResultadoEsperado varchar(1000) NULL,
	Historico boolean NULL default false, /* Indica si el proyecto es historico */
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Alcance) REFERENCES Region(ID)
);

/*
Vista que muestra los proyectos en formato legible
*/
CREATE VIEW VerTodosLosProyectos AS SELECT
	Beneficiario.Nombre AS Beneficiario,
	Proyecto.Titulo,
	Proyecto.Descripcion,
	Proyecto.DuracionEnMesesMinimo,
	Proyecto.DuracionEnMesesMaximo,
	Region.Nombre AS Alcance,
	Proyecto.Area,
	Proyecto.Problema,
	Proyecto.Publico
FROM
	Proyecto, Beneficiario, Region
WHERE
	Beneficiario.ID=Proyecto.Beneficiario AND
	Region.ID=Proyecto.Alcance;
