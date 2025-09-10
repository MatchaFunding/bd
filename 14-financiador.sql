/*
Clase que representa las entes financieras que ofrecen los fondos.
En muchos sentidos operan de la misma forma que las entes benficiarias,
lo unico que cambia en rigor son sus relaciones con las otras clases.
https://www.registrodeempresasysociedades.cl/MarcaDominio.aspx
https://www.rutificador.co/empresas/buscar
https://registros19862.gob.cl/
https://dequienes.cl/
*/
CREATE TABLE Financiador (
	ID bigint NOT NULL AUTO_INCREMENT,
	Nombre varchar(100) NOT NULL,
	FechaDeCreacion date NOT NULL,
	RegionDeCreacion bigint NOT NULL,
	Direccion varchar(300) NOT NULL,
	TipoDePersona bigint NOT NULL,
	TipoDeEmpresa bigint NOT NULL,
	Perfil bigint NOT NULL,
	RUTdeEmpresa varchar(12) NOT NULL,
	RUTdeRepresentante varchar(12) NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (RegionDeCreacion) REFERENCES Region(ID),
	FOREIGN KEY (TipoDePersona) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (TipoDeEmpresa) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (Perfil) REFERENCES TipoDePerfil(ID)
);

INSERT INTO Financiador VALUES
	(1,'ANID','2005-06-23',7,'N/A',1,1,3,'60.915.000-9','14.131.587-0'),
	(2,'CORFO','2005-06-23',7,'N/A',1,1,3,'60.706.000-2','78.i39.379-3'),
	(3,'FondosGob','2005-06-23',7,'N/A',1,1,3,'60.801.000-9','60.801.000-9');
