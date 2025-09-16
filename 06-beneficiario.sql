/*
Clase que representa la empresa, emprendimiento, grupo de investigacion, etc.
que desea postular al fondo. La informacion debe regirse por la descripcion
legal de la empresa.
https://www.registrodeempresasysociedades.cl/MarcaDominio.aspx
https://www.rutificador.co/empresas/buscar
https://www.boletaofactura.com/
https://registros19862.gob.cl/
https://dequienes.cl/
https://www.cmfchile.cl/portal/principal/613/w3-propertyvalue-18556.html#enti_reportes
https://es.wikipedia.org/wiki/Anexo:Empresas_de_Chile
https://es.wikipedia.org/wiki/Categor%C3%ADa:Empresas_de_Chile
*/
CREATE TABLE Beneficiario (
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
	Mision varchar(1000) NULL default "",
	Vision varchar(1000) NULL default "",
	Valores varchar(1000) NULL default "",
	PRIMARY KEY (ID),
	FOREIGN KEY (RegionDeCreacion) REFERENCES Region(ID),
	FOREIGN KEY (TipoDePersona) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (TipoDeEmpresa) REFERENCES TipoDeEmpresa(ID),
	FOREIGN KEY (Perfil) REFERENCES TipoDePerfil(ID)
);

/*
Vista que muestra los beneficiarios en formato legible
*/
CREATE VIEW VerTodosLosBeneficiarios AS SELECT
	Beneficiario.Nombre,
	Region.Nombre AS RegionDeCreacion,
	Beneficiario.FechaDeCreacion,
	Beneficiario.Direccion,
	TipoDePersona.Nombre AS TipoDePersona,
	TipoDeEmpresa.Nombre AS TipoDeEmpresa,
	TipoDePerfil.Nombre AS Perfil,
	Beneficiario.RUTdeEmpresa,
	Beneficiario.RUTdeRepresentante,
	Beneficiario.Mision,
	Beneficiario.Vision,
	Beneficiario.Valores
FROM
	Beneficiario, Region, TipoDePersona, 
	TipoDeEmpresa, TipoDePerfil
WHERE
	Region.ID=Beneficiario.RegionDeCreacion AND
	TipoDePersona.ID=Beneficiario.TipoDePersona AND
	TipoDeEmpresa.ID=Beneficiario.TipoDeEmpresa AND
	TipoDePerfil.ID=Beneficiario.Perfil;
