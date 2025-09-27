/*
Tipo de beneficio que otorga cierto fondo o instrumento.
*/
CREATE TABLE TipoDeBeneficio (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(50) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO TipoDeBeneficio (ID, Codigo, Nombre)
VALUES
	(1,"CAP","Capacitacion"),
	(2,"RIE","Capital de riesgo"),
	(3,"CRE","Creditos"),
	(4,"GAR","Garantias"),
	(5,"MUJ","Incentivo mujeres"),
	(6,"OTR","Otros incentivos"),
	(7,"SUB","Subsidios"),
	(8,"HUM","Capital Humano"),
	(9,"INV","Proyectos de Investigación"),
	(10,"CEA","Centros e Investigación Asociativa"),
	(11,"IAP","Investigación Aplicada"),
	(12,"REC","Redes, Estrategia y Conocimiento");

CREATE TABLE VerTiposDeBeneficio AS
SELECT Nombre FROM TipoDeBeneficio;
