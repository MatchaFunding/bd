DROP DATABASE IF EXISTS MatchaFundingMySQL;
CREATE DATABASE IF NOT EXISTS MatchaFundingMySQL;
USE MatchaFundingMySQL;
/*
Regiones de Chile como su propia tabla para poder hacer la validacion correcta
Es un campo sumamanete comun en este contexto.
*/
CREATE TABLE Region (
	ID bigint NOT NULL,
	Codigo varchar(2) NOT NULL,
	Nombre varchar(20) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO Region (ID, Codigo, Nombre)
VALUES
	(1,"AP","Arica y Parinacota"),
	(2,"TA","Tarapaca"),
	(3,"AN","Antofagasta"),
	(4,"AT","Atacama"),
	(5,"CO","Coquimbo"),
	(6,"VA","Valparaiso"),
	(7,"RM","Santiago"),
	(8,"LI","O Higgins"),
	(9,"ML","Maule"),
	(10,"NB","Nuble"),
	(11,"BI","Biobio"),
	(12,"AR","La Araucania"),
	(13,"LR","Los Rios"),
	(14,"LL","Los Lagos"),
	(15,"AI","Aysen"),
	(16,"MA","Magallanes"),
	(17,"NA","Nacional");

CREATE VIEW VerRegiones AS SELECT Nombre FROM Region;
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

CREATE VIEW VerTiposDePersona AS SELECT Nombre FROM TipoDePersona;/*
Tipo de empresa que representa una agrupacion en el contexto legal.
https://ipp.cl/general/tipos-de-empresas-en-chile/
*/
CREATE TABLE TipoDeEmpresa (
	ID bigint NOT NULL,
	Codigo varchar(4) NOT NULL,
	Nombre varchar(50) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO TipoDeEmpresa (ID, Codigo, Nombre)
VALUES
	(1,"SA","Sociedad Anonima"),
	(2,"SRL","Sociedad de Responsabilidad Limitada"),
	(3,"SPA","Sociedad por Acciones"),
	(4,"EIRL","Empresa Individual de Responsabilidad Limitada");

CREATE VIEW VerTiposDeEmpresa AS SELECT Nombre FROM TipoDeEmpresa;/*
Tipo de perfil que asume la empresa, para este contexto
representa su escala.
*/
CREATE TABLE TipoDePerfil (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(30) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO TipoDePerfil (ID, Codigo, Nombre)
VALUES
	(1,"EMP","Empresa"),
	(2,"EXT","Extranjero"),
	(3,"INS","Institucion"),
	(4,"MED","Intermediario"),
	(5,"ORG","Organizacion"),
	(6,"PER","Persona");

CREATE VIEW VerTiposDePerfil AS SELECT Nombre FROM TipoDePerfil;
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
	Mision varchar(1000) NULL,
	Vision varchar(1000) NULL,
	Valores varchar(1000) NULL,
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
	Proyecto.Beneficiario,
	Proyecto.Titulo,
	Proyecto.Descripcion,
	Proyecto.DuracionEnMesesMinimo,
	Proyecto.DuracionEnMesesMaximo,
	Region.Nombre AS Alcance,
	Proyecto.Area,
	Proyecto.Problema,
	Proyecto.Publico
FROM
	Proyecto, Region
WHERE
	Region.ID=Proyecto.Alcance;
/*
Genero u orientacion con la cual una persona se identifica.
Preferi hacerlo una tabla para realizar las validaciones de
fondos con enfoque de genero.
*/
CREATE TABLE Sexo (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(30) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO Sexo (ID, Codigo, Nombre)
VALUES
	(1,"VAR","Hombre"),
	(2,"MUJ","Mujer"),
	(3,"NA","Otro");

CREATE VIEW VerSexos AS SELECT Nombre FROM Sexo;
/*
Clase que representa a una persona natural, la cual puede ser miembro de una 
empresa o proyecto. Abajo de este estan las asociaciones entre persona y 
agrupacion.
https://www.nombrerutyfirma.com/nombre
https://www.nombrerutyfirma.com/rut
https://www.volanteomaleta.com/
*/
CREATE TABLE Persona (
	ID bigint NOT NULL AUTO_INCREMENT,
	Nombre varchar(200) NOT NULL,
	Apellido varchar(200) NULL,
	Sexo bigint NOT NULL,
	RUT varchar(12) NOT NULL,
	FechaDeNacimiento date NOT NULL,
	Ocupacion varchar(1000) NULL,
	Correo varchar(200) NULL,
	Telefono tinyint NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Sexo) REFERENCES Sexo(ID)
);

/*
Vista que muestra las personas en formato legible
*/
CREATE VIEW VerTodasLasPersonas AS SELECT
	Persona.Nombre,
	Persona.Apellido,
	Sexo.Nombre AS Sexo,
	Persona.RUT,
	Persona.FechaDeNacimiento,
	Persona.Ocupacion,
	Persona.Correo,
	Persona.Telefono
FROM
	Persona, Sexo
WHERE
	Sexo.ID=Persona.Sexo;
/*
Clase que representa a una persona que es parte de una empresa, 
agrupacion o grupo de investigacion.
https://dequienes.cl/
*/
CREATE TABLE Miembro (
	ID bigint NOT NULL AUTO_INCREMENT,
	Persona bigint NOT NULL,
	Beneficiario bigint NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Persona) REFERENCES Persona(ID)
);

CREATE VIEW VerMiembros AS SELECT 
Persona, Beneficiario 
FROM Miembro;
/*
Clase que representa a una persona que es parte de un proyecto que busca fondos.
https://dequienes.cl/
*/
CREATE TABLE Colaborador (
	ID bigint NOT NULL AUTO_INCREMENT,
	Persona bigint NOT NULL,
	Proyecto bigint NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Persona) REFERENCES Persona(ID),
	FOREIGN KEY (Proyecto) REFERENCES Proyecto(ID)
);
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
	Usuario.Correo,
	Usuario.Persona
FROM
	Usuario;
/*
Agrupacion de multiples empresas y agrupaciones que pretenden postular
en conjunto a un instrumento / fondo comun. A veces puede ser un
requisito para postular a ciertos beneficios.
*/
CREATE TABLE Consorcio (
	ID bigint NOT NULL AUTO_INCREMENT,
	PrimerBeneficiario bigint NOT NULL,
	SegundoBeneficiario bigint NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (PrimerBeneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (SegundoBeneficiario) REFERENCES Beneficiario(ID)
);
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
	Mision varchar(1000) NULL,
	Vision varchar(1000) NULL,
	Valores varchar(1000) NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (RegionDeCreacion) REFERENCES Region(ID),
	FOREIGN KEY (TipoDePersona) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (TipoDeEmpresa) REFERENCES TipoDeEmpresa(ID),
	FOREIGN KEY (Perfil) REFERENCES TipoDePerfil(ID)
);

/*
Vista que muestra los beneficiarios en formato legible
*/
CREATE VIEW VerTodosLosFinanciadores AS SELECT
	Financiador.Nombre,
	Region.Nombre AS RegionDeCreacion,
	Financiador.FechaDeCreacion,
	Financiador.Direccion,
	TipoDePersona.Nombre AS TipoDePersona,
	TipoDeEmpresa.Nombre AS TipoDeEmpresa,
	TipoDePerfil.Nombre AS Perfil,
	Financiador.RUTdeEmpresa,
	Financiador.RUTdeRepresentante,
	Financiador.Mision,
	Financiador.Vision,
	Financiador.Valores
FROM
	Financiador, Region, TipoDePersona, 
	TipoDeEmpresa, TipoDePerfil
WHERE
	Region.ID=Financiador.RegionDeCreacion AND
	TipoDePersona.ID=Financiador.TipoDePersona AND
	TipoDeEmpresa.ID=Financiador.TipoDeEmpresa AND
	TipoDePerfil.ID=Financiador.Perfil;

INSERT INTO Financiador (ID,Nombre,FechaDeCreacion,RegionDeCreacion,Direccion,TipoDePersona,TipoDeEmpresa,Perfil,RUTdeEmpresa,RUTdeRepresentante) VALUES
	(1,'ANID','2005-06-23',7,'N/A',1,1,3,'60.915.000-9','14.131.587-0'),
	(2,'CORFO','2005-06-23',7,'N/A',1,1,3,'60.706.000-2','78.i39.379-3'),
	(3,'FondosGob','2005-06-23',7,'N/A',1,1,3,'60.801.000-9','60.801.000-9');
/*
Estado en el que se encuentra un fondo o instrumento.
*/
CREATE TABLE EstadoDeFondo (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(40) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO EstadoDeFondo (ID, Codigo, Nombre)
VALUES
	(1,"PRX","Proximo"),
	(2,"ABI","Abierto"),
	(3,"EVA","En evaluacion"),
	(4,"ADJ","Adjudicado"),
	(5,"SUS","Suspendido"),
	(6,"PAY","Patrocinio Institucional"),
	(7,"DES","Desierto"),
	(8,"CER","Cerrrado");

CREATE VIEW VerEstadosDeFondo AS SELECT Nombre FROM EstadoDeFondo;
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

CREATE VIEW VerTiposDeBeneficio AS SELECT Nombre FROM TipoDeBeneficio;/*
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
	FechaDeResultado date NULL,
	DuracionEnMeses int NOT NULL,
	Beneficios varchar(1000) NULL,
	Requisitos varchar(1000) NULL,
	MontoMinimo int NOT NULL,
	MontoMaximo int NOT NULL,
	Estado bigint NOT NULL,
	TipoDeBeneficio bigint NOT NULL,
	TipoDePerfil bigint NOT NULL,
	ObjetivoGeneral varchar(1000) NULL,
	ObjetivoEspecifico varchar(1000) NULL,
	ResultadoEsperado varchar(1000) NULL,
	EnlaceDelDetalle varchar(300) NULL,
	EnlaceDeLaFoto varchar(300) NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Alcance) REFERENCES Region(ID),
	FOREIGN KEY (Estado) REFERENCES EstadoDeFondo(ID),
	FOREIGN KEY (TipoDeBeneficio) REFERENCES TipoDeBeneficio(ID),
	FOREIGN KEY (TipoDePerfil) REFERENCES TipoDePerfil(ID),
	FOREIGN KEY (Financiador) REFERENCES Financiador(ID)
);

/*
Vista que muestra los instrumentos en formato legible
*/
CREATE VIEW VerTodosLosInstrumentos AS SELECT
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
	Instrumento.ObjetivoGeneral,
	Instrumento.ObjetivoEspecifico,
	Instrumento.ResultadoEsperado,
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
/*
Clase que representa los estados en los que se puede encontrar una postulacion.
Los resultados solo pueden caer dentro de las tres categorias.
*/
CREATE TABLE Resultado (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(30) NOT NULL,
	PRIMARY KEY (ID)
);
INSERT INTO Resultado (ID, Codigo, Nombre)
VALUES
	(1,"ADJ","Adjudicado"),
	(2,"REC","Rechazado"),
	(3,"PEN","Pendiente");
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

CREATE VIEW VerTodasLasPostulaciones AS SELECT
	Postulacion.Beneficiario,
	Postulacion.Proyecto,
	Postulacion.Instrumento,
	Resultado.Nombre AS Resultado,
	Postulacion.MontoObtenido,
	Postulacion.FechaDePostulacion,
	Postulacion.FechaDeResultado,
	Postulacion.Detalle
FROM 
	Postulacion, Resultado
WHERE
	Resultado.ID=Postulacion.Resultado;
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
	UltimaFechaDeModificacion date NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Usuario) REFERENCES Usuario(ID)
);

CREATE VIEW VerTodasLasIdeas AS SELECT
	Idea.Usuario,
	Idea.Campo,
	Idea.Problema,
	Idea.Publico,
	Idea.Innovacion,
	Idea.Oculta,
	Idea.FechaDeCreacion,
	Idea.UltimaFechaDeModificacion
FROM Idea;
/*
Clase que representa la propuesta de la IA tras recibir una idea
*/
CREATE TABLE Propuesta (
	ID bigint NOT NULL AUTO_INCREMENT,
	Idea bigint NOT NULL,
	Resumen varchar(3000) NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Idea) REFERENCES Idea(ID)
);
INSERT INTO Persona (Nombre,Sexo,RUT,FechaDeNacimiento) VALUES
('Miguel Soto Delgado',1,'20.430.363-0','2000-04-07'),
('Maximiliano Bardi',1,'21.030.899-7','2004-10-15'),
('Alvaro Opazo',1,'20.435.337-9','2000-09-24'),
('Vicente Alvear',1,'20.557.229-5','2000-07-25'),
('Javiera Osorio',2,'20.966.993-5','2002-05-06'),
('Nicolás Barahona',1,'21.037.987-8','2002-06-09'),
('Hernan Benavente',1,'11.111.111-1','1985-12-12'),
('Marcello Visconti',1,'22.999.666-9','1965-10-10'),
('Daniel Herrera',2,'20.200.200-2','2000-02-02'),
('Romi Gladys',2,'20.123.123-1','2003-03-12'),
('Esteban Zapata',1,'10.100.100-1','1985-04-04'),
('Bernardo Pinninghoff',1,'10.999.999-9','2000-07-07'),
('Catalina Seguel',2,'20.222.222-2','2002-02-02');

INSERT INTO Usuario (NombreDeUsuario,Contrasena,Correo,Persona) VALUES
('matchafunding@gmail.com','Umami1939!','matchafunding@gmail.com',1);

INSERT INTO Beneficiario (Nombre,FechaDeCreacion,RegionDeCreacion,Direccion,TipoDePersona,TipoDeEmpresa,Perfil,RUTdeEmpresa,RUTdeRepresentante) VALUES
('MatchaFunding','2023-01-01',7,'N/A',2,4,1,'20.430.363-0','20.430.363-0');

INSERT INTO Instrumento (Titulo,Financiador,Alcance,Descripcion,FechaDeApertura,FechaDeCierre,DuracionEnMeses,Beneficios,Requisitos,MontoMinimo,MontoMaximo,Estado,TipoDeBeneficio,TipoDePerfil,EnlaceDelDetalle,EnlaceDeLaFoto) VALUES
('PAR MULTISECTORIAL INCLUSION – REGION DE O’HIGGINS – AÑO 2023',2,8,'Queremos potenciar a un grupo entre 5 y 15 empresas y/o emprendedores de una localidad o sector económico determinado, para que mejoren su competencia productiva y gestión, desarrollando planes de asistencia técnica, capacitación y cofinanciando la inversión productiva.','2023-01-01','2023-12-31',0,'Hasta $2.000.000 (dos millones de pesos) para actividades de asistencia técnica, capacitación y consultoría. Hasta 80% del costo total del proyecto para Proyecto de Inversión, con tope de hasta $5.000.000 (cinco millones de pesos).','Tener RUT chileno',0,5000000,8,1,1,'https://corfo.cl/sites/cpp/convocatoria/par_multisectorial_inclusion_oh/',''),
('RED ASOCIATIVA – REGIÓN METROPOLITANA – 1° CONVOCATORIA 2025 ETAPA DESARROLLO',2,7,'El Programa Red Asociativa permite participar junto a otras Empresas para mejorar tu oferta de valor y acceder a nuevos mercados, a través del Programa RED Asociativa te apoyamos con asesoría experta para abordar oportunidades de mercado y de mejoramiento tecnológico, desarrollando estrategias de negocios colaborativos, de acuerdo con las características productivas del grupo de empresas.','2025-01-01','2025-12-31',0,'Corfo cofinanciará hasta un 70% del costo total de la Etapa de Desarrollo, con un tope de $40.000.000, por proyecto.','Tener RUT chileno',0,40000000,3,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asociativa-metropolitana-1ra-convocatoria-desarrollo-2025/',''),
('Red Tecnológica GTT+',2,7,'Si tienes interés en participar junto a otras empresas del sector silvoagropecuario en un proyecto GTT, los invitamos a postular al programa GTT+. Esta línea de apoyo busca que grupos de entre 10 y 15 empresas puedan, a través del intercambio entre pares y asistencias técnicas, cerrar brechas tecnológicas y de gestión, incorporando herramientas y mejores prácticas productivas, fomentando la construcción de alianzas entre los empresarios para ampliar el capital relacional, mejorar su productividad y posición competitiva.','2025-01-01','2025-12-31',0,'Cofinanciamiento: Hasta $3.500.000.- (tres millones quinientos mil pesos), para la Etapa de Diagnóstico.- En la Etapa de Diagnóstico se otorgará un financiamiento de hasta $3.500.000.- (tres millones quinientos mil pesos), por proyecto. Corfo cofinanciará hasta un 80% del costo total de la Etapa de Desarrollo, con un tope para cada periodo de $2.000.000.- (dos millones de pesos), por cada beneficiario que integra el proyecto.','',0,3500000,3,1,1,'https://corfo.cl/sites/cpp/convocatoria/gtt/','');

INSERT INTO Proyecto (Titulo,Descripcion,DuracionEnMesesMaximo,DuracionEnMesesMinimo,Alcance,Area,Beneficiario) VALUES
('MatchAPI - Inteligencia Artificial',' API que permite analizar proyectos y fondos a traves de similitud de topicos',6,12,7,'Asociación',1),
('MatchaFront - Pagina web','Pagina web que permite a usuarios a traves de Chile conectarse con las mejores oportunidades de fondos y beneficios',6,12,7,'Asociación',1),
('MatchaBack - Base de datos','Base de datos distribuida capaz de recuperar y almacenar fondos concursables dentro de Chile usando web-scrapping',6,12,7,'Asociación',1);

INSERT INTO Postulacion (Beneficiario,Proyecto,Instrumento,Resultado,MontoObtenido) VALUES
(1,1,1,3,0),
(1,2,2,1,5000000),
(1,3,3,2,0);

INSERT INTO Miembro (Persona,Beneficiario) VALUES
(1,1),
(2,1),
(3,1),
(4,1),
(5,1),
(6,1);
