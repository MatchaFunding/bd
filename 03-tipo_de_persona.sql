/*
Tipo de persona que representa a una empresa en terminos juridicos. 
En este contexto los beneficiarios y financiadores
pueden ser empresas formales.
https://www.sii.cl/mipyme/emprendedor/documentos/fac_Datos_Comenzar_2.htm
*/
CREATE TABLE TipoDePersona (
	ID bigint NOT NULL,
	Codigo varchar(2) NOT NULL,
	Nombre varchar(10) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO TipoDePersona (ID, Codigo, Nombre)
VALUES
	(1,"JU","Juridica"),
	(2,"NA","Natural");
