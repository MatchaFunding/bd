/*
Clase que representa los fondos concursables a los que los proyectos pueden postular.
Esta clase contiene todos los parametros y requisitos que dictan la posterior evaluacion.
Representa tanto los fondos actuales como los historicos, en donde la fecha de cierre
indica a cual de los dos corresponde.
Recursos de fondos historicos:
http://wapp.corfo.cl/transparencia/home/Subsidios.aspx
https://github.com/ANID-GITHUB?tab=repositories
https://datainnovacion.cl/api
*/
CREATE TABLE Instrumento (
	ID bigint NOT NULL AUTO_INCREMENT,
	Titulo varchar(200) NOT NULL,
	Financiador bigint NOT NULL,    
	Alcance bigint NOT NULL,
	Descripcion varchar(1000) NOT NULL,
	FechaDeApertura date NOT NULL,
	FechaDeCierre date NOT NULL,
	DuracionEnMeses int NOT NULL,
	Beneficios varchar(1000) NULL default "",
	Requisitos varchar(1000) NULL default "",
	MontoMinimo int NOT NULL,
	MontoMaximo int NOT NULL,
	Estado bigint NOT NULL,
	TipoDeBeneficio bigint NOT NULL,
	TipoDePerfil bigint NOT NULL,
	EnlaceDelDetalle varchar(300) NULL default "",
	EnlaceDeLaFoto varchar(300) NULL default "",
	PRIMARY KEY (ID),
	FOREIGN KEY (Alcance) REFERENCES Region(ID),
	FOREIGN KEY (Estado) REFERENCES EstadoDeFondo(ID),
	FOREIGN KEY (TipoDeBeneficio) REFERENCES TipoDeBeneficio(ID),
	FOREIGN KEY (TipoDePerfil) REFERENCES TipoDePerfil(ID),
	FOREIGN KEY (Financiador) REFERENCES Financiador(ID)
);

CREATE VIEW VerTodosLosInstrumentos AS SELECT
	Instrumento.ID,
	Instrumento.Titulo,
	Financiador.Nombre AS Financiador,
	Region.Nombre AS Alcance,
	Instrumento.Descripcion,
	Instrumento.FechaDeApertura,
	Instrumento.FechaDeCierre,
	Instrumento.DuracionEnMeses,
	Instrumento.Beneficios,
	Instrumento.Requisitos,
	Instrumento.MontoMinimo,
	Instrumento.MontoMaximo,
	EstadoDeFondo.Nombre AS Estado,
	TipoDeBeneficio.Nombre AS TipoDeBeneficio,
	TipoDePerfil.Nombre AS TipoDePerfil,
	Instrumento.EnlaceDelDetalle,
	Instrumento.EnlaceDeLaFoto
FROM
	Instrumento, Financiador, Region,
	EstadoDeFondo, TipoDeBeneficio, TipoDePerfil
WHERE
	Financiador.ID=Instrumento.Financiador AND
	Region.ID=Instrumento.Alcance AND
	EstadoDeFondo.ID=Instrumento.Estado AND
	TipoDeBeneficio.ID=Instrumento.TipoDeBeneficio AND
	TipoDePerfil.ID=Instrumento.TipoDePerfil;
