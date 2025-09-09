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

/*
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

/*
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

/*
Clase que representa la empresa, emprendimiento, grupo de investigacion, etc.
que desea postular al fondo. La informacion debe regirse por la descripcion
legal de la empresa.
https://www.registrodeempresasysociedades.cl/MarcaDominio.aspx
https://www.rutificador.co/empresas/buscar
https://www.boletaofactura.com/
https://registros19862.gob.cl/
https://dequienes.cl/
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
	PRIMARY KEY (ID),
	FOREIGN KEY (RegionDeCreacion) REFERENCES Region(ID),
	FOREIGN KEY (TipoDePersona) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (TipoDeEmpresa) REFERENCES TipoDeEmpresa(ID),
	FOREIGN KEY (Perfil) REFERENCES TipoDePerfil(ID)
);

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
	Problema varchar(1000) NULL default "", /* Problema que busca resolver */ 
	Publico varchar(1000) NULL default "", /* Publico objetivo destinado */ 
	Innovacion varchar(1000) NULL default "", /* Innovacion u aporte que trae */ 
	Historico boolean NULL default false, /* Indica si el proyecto es historico */
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Alcance) REFERENCES Region(ID)
);

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
	Apellido varchar(200) NULL default "",
	Sexo bigint NOT NULL,
	RUT varchar(12) NOT NULL,
	FechaDeNacimiento date NOT NULL,
	Ocupacion varchar(1000) NULL default "",
	Correo varchar(200) NULL default "",
	Telefono tinyint NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Sexo) REFERENCES Sexo(ID)
);

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
	Persona bigint,
	NombreDeUsuario varchar(200),
	Contrasena varchar(200) NOT NULL,
	Correo varchar(200) NOT NULL,
	Telefono tinyint NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Persona) REFERENCES Persona(ID)
);

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
	PRIMARY KEY (ID),
	FOREIGN KEY (RegionDeCreacion) REFERENCES Region(ID),
	FOREIGN KEY (TipoDePersona) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (TipoDeEmpresa) REFERENCES TipoDePersona(ID),
	FOREIGN KEY (Perfil) REFERENCES TipoDePerfil(ID)
);

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

/*
Tipo de beneficio que otorga cierto fondo o instrumento.
*/
CREATE TABLE TipoDeBeneficio (
	ID bigint NOT NULL,
	Codigo varchar(3) NOT NULL,
	Nombre varchar(30) NOT NULL,
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
	(7,"SUB","Subsidios");

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
	Proyecto bigint NOT NULL,
	Instrumento bigint NOT NULL,
	Resultado bigint NOT NULL default 3,
	MontoObtenido int NOT NULL,
	FechaDePostulacion date NOT NULL,
	FechaDeResultado date NOT NULL,
	Detalle varchar(2000) NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Beneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (Proyecto) REFERENCES Proyecto(ID),
	FOREIGN KEY (Instrumento) REFERENCES Instrumento(ID),
	FOREIGN KEY (Resultado) REFERENCES Resultado(ID)
);

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
	UltimaFechaDeModificaion date NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Usuario) REFERENCES Usuario(ID)
);

/*
Clase que representa la propuesta de la IA tras recibir una idea
*/
CREATE TABLE PropuestaIA (
	ID bigint NOT NULL AUTO_INCREMENT,
	Idea bigint NOT NULL,
	Resumen varchar(3000) NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (Idea) REFERENCES Idea(ID)
);

INSERT INTO Financiador (ID,Nombre,FechaDeCreacion,RegionDeCreacion,Direccion,TipoDePersona,TipoDeEmpresa,Perfil,RUTdeEmpresa,RUTdeRepresentante)
VALUES
	(1,'ANID','2005-06-23',7,'N/A',1,1,3,'60.915.000-9','14.131.587-0'),
	(2,'CORFO','2005-06-23',7,'N/A',1,1,3,'60.706.000-2','78.i39.379-3'),
	(3,'FondosGob','2005-06-23',7,'N/A',1,1,3,'60.801.000-9','60.801.000-9');

INSERT INTO Beneficiario (ID,Nombre,FechaDeCreacion,RegionDeCreacion,Direccion,TipoDePersona,TipoDeEmpresa,Perfil,RUTdeEmpresa,RUTdeRepresentante)
VALUES
	(1,'ASOCIACION CHILE DISENO ASOCIACION GREMIAL','2025-01-01',17,'N/A',2,4,1,'507412300','507412300'),
	(2,'AGRICOLA JULIO GIDDINGS E I R L','2025-01-01',17,'N/A',2,4,1,'520014225','520014225'),
	(3,'BEATRIZ EDITH ARAYA ARANCIBIA ASESORIAS EN TECNOLOGIAS DE INFORMACION SPA','2025-01-01',17,'N/A',2,4,1,'52001578-7','52001578-7'),
	(4,'SAENS POLIMEROS Y REVESTIMIENTOS LIMITADA','2025-01-01',17,'N/A',2,4,1,'520035087','520035087'),
	(5,'LACTEOS CHAUQUEN SPA','2025-01-01',17,'N/A',2,4,1,'52004143-5','52004143-5'),
	(6,'CALEB OTONIEL ARAYA CASTILLO SPA','2025-01-01',17,'N/A',2,4,1,'52004346-2','52004346-2'),
	(7,'IQUIQUE TELEVISION PRODUCCIONES TELEVISIVAS Y EVENTOS LIMITADA','2025-01-01',17,'N/A',2,4,1,'520046666','520046666'),
	(8,'ALEJANDRO MARIO CAEROLS SILVA EIRL','2025-01-01',17,'N/A',2,4,1,'520050310','520050310'),
	(9,'OSCAR ALCIDES TORRES CORTES E.I.R.L.','2025-01-01',17,'N/A',2,4,1,'520054642','520054642'),
	(10,'SOCIEDAD AGRICOLA Y VIVERO SAN RAFAEL LIMITADA','2025-01-01',17,'N/A',2,4,1,'53306574-0','53306574-0'),
	(11,'FUNDACION DESAFIO','2025-01-01',17,'N/A',2,4,1,'533090079','533090079'),
	(12,'FUNDACION BASURA','2025-01-01',17,'N/A',2,4,1,'53323226-4','53323226-4'),
	(13,'FRIMA S A','2025-01-01',17,'N/A',2,4,1,'590291404','590291404'),
	(14,'ACCIONA CONSTRUCCION S.A. AGENCIA CHILE','2025-01-01',17,'N/A',2,4,1,'59069860-1','59069860-1'),
	(15,'ENYSE AGENCIA CHILE S A','2025-01-01',17,'N/A',2,4,1,'591087800','591087800'),
	(16,'ANGLO AMERICAN TECHNICAL & SUSTAINABILITY SERVICES LTD - AGENCIA EN CHILE','2025-01-01',17,'N/A',2,4,1,'592803909','592803909'),
	(17,'LABORELEC LATIN AMERICA','2025-01-01',17,'N/A',2,4,1,'5928196-0','5928196-0'),
	(18,'INSTITUTO ANTARTICO CHILENO','2025-01-01',17,'N/A',2,4,1,'606050003','606050003'),
	(19,'INSTITUTO NACIONAL DE ESTADISTICAS','2025-01-01',17,'N/A',2,4,1,'607030006','607030006'),
	(20,'CASA DE MONEDA DE CHILE S.A.','2025-01-01',17,'N/A',2,4,1,'608060006','608060006'),
	(21,'SERVICIO NACIONAL DEL PATRIMONIO CULTURAL','2025-01-01',17,'N/A',2,4,1,'609050004','609050004'),
	(22,'UNIVERSIDAD DE CHILE','2025-01-01',17,'N/A',2,4,1,'609100001','609100001'),
	(23,'UNIVERSIDAD DE SANTIAGO DE CHILE','2025-01-01',17,'N/A',2,4,1,'609110007','609110007'),
	(24,'UNIVERSIDAD DEL BIO BIO','2025-01-01',17,'N/A',2,4,1,'609110066','609110066'),
	(25,'UNIVERSIDAD DE VALPARAISO','2025-01-01',17,'N/A',2,4,1,'609210001','609210001'),
	(26,'ACADEMIA POLITECNICA MILITAR','2025-01-01',17,'N/A',2,4,1,'61.101.021-4','61.101.021-4'),
	(27,'INSTITUTO DE FOMENTO PESQUERO','2025-01-01',17,'N/A',2,4,1,'613100008','613100008'),
	(28,'INSTITUTO FORESTAL','2025-01-01',17,'N/A',2,4,1,'613110003','613110003'),
	(29,'INSTITUTO DE INVESTIGACIONES AGROPECUARIAS','2025-01-01',17,'N/A',2,4,1,'613120009','613120009'),
	(30,'AGUAS ANDINAS S A','2025-01-01',17,'N/A',2,4,1,'618080005','618080005'),
	(31,'CENTRO DEL AGUA PARA ZONAS ARIDAS Y SEMIARIDAS DE AMERICA LATINA','2025-01-01',17,'N/A',2,4,1,'619686004','619686004'),
	(32,'UNIVERSIDAD DE O\'HIGGINS','2025-01-01',17,'N/A',2,4,1,'61980530-5','61980530-5'),
	(33,'FUNDACION PATRIMONIO NUESTRO','2025-01-01',17,'N/A',2,4,1,'650028449','650028449'),
	(34,'ASOCIACION GREMIAL DE PRODUCTORES DE OVINOS DE LA NOVENA REGION - OVINOS ARAUCAN','2025-01-01',17,'N/A',2,4,1,'650030354','650030354'),
	(35,'FUNDACION SNP PATAGONIA SUR','2025-01-01',17,'N/A',2,4,1,'650034244','650034244'),
	(36,'FUNDACION SENDERO DE CHILE','2025-01-01',17,'N/A',2,4,1,'650164067','650164067'),
	(37,'PEQUENOS Y MEDIANOS INDUSTRIALES MADEREROS DEL BIO BIO A.G.','2025-01-01',17,'N/A',2,4,1,'650175484','650175484'),
	(38,'ASOCIACION GREMIAL DE CANALES REGIONALES DE TELEVISION DE SENAL ABIERTA DE CHILE','2025-01-01',17,'N/A',2,4,1,'65018149-2','65018149-2'),
	(39,'FEDERACION DE EMPRESAS DE TURISMO DE CHILE - FEDERACION GREMIAL','2025-01-01',17,'N/A',2,4,1,'650195086','650195086'),
	(40,'FUNDACION URBANISMO SOCIAL','2025-01-01',17,'N/A',2,4,1,'650222784','650222784'),
	(41,'ASOC CHILENA DE ORGANIZACIONES DE FERIAS LIBRES ASOF A G','2025-01-01',17,'N/A',2,4,1,'65024560-1','65024560-1'),
	(42,'FUNDACION BANIGUALDAD','2025-01-01',17,'N/A',2,4,1,'650251504','650251504'),
	(43,'FUNDACION PROCULTURA','2025-01-01',17,'N/A',2,4,1,'650262166','650262166'),
	(44,'ASOCIACION GREMIAL DE EMPRESAS DE LA CIRUELA DESHIDRATADA','2025-01-01',17,'N/A',2,4,1,'650269551','650269551'),
	(45,'ASOCIACION GREMIAL CHILENA DE DESARROLLADORES DE VIDEOJUEGOS','2025-01-01',17,'N/A',2,4,1,'65027653-1','65027653-1'),
	(46,'VISION VALDIVIA,CAPITAL NAUTICA DEL PACIFICO SUR-ASOCIACION GREMIAL','2025-01-01',17,'N/A',2,4,1,'65029077-1','65029077-1'),
	(47,'AGENCIA CHILENA DE EFICIENCIA ENERGETICA','2025-01-01',17,'N/A',2,4,1,'65030848-4','65030848-4'),
	(48,'FUNDACION SERVICIO JESUITA A MIGRANTES','2025-01-01',17,'N/A',2,4,1,'650308921','650308921'),
	(49,'FUND JUVENTUD EMPRENDEDORA','2025-01-01',17,'N/A',2,4,1,'650324900','650324900'),
	(50,'FUNDACION FRAUNHOFER CHILE RESEARCH','2025-01-01',17,'N/A',2,4,1,'65033192-3','65033192-3'),
	(51,'ORGANIZACION NO GUBERNAMENTAL DE DESARROLLO CORPORACION DE DESARROLLO PHOENIX BR','2025-01-01',17,'N/A',2,4,1,'65034573-8','65034573-8'),
	(52,'SOCIEDAD GEOGRAFICA DE DOCUMENTACION ANDINA','2025-01-01',17,'N/A',2,4,1,'650348397','650348397'),
	(53,'CORPORACION CULTIVA','2025-01-01',17,'N/A',2,4,1,'65034868-0','65034868-0'),
	(54,'AGENCIA REGIONAL DE DESARROLLO PRODUCTIVO DE LA ARAUCANIA','2025-01-01',17,'N/A',2,4,1,'65034891-5','65034891-5'),
	(55,'ASOCIACION GREMIAL DE PROPIETARIOS, TENEDORES Y USUARIOS DE TIERRAS PRIVADAS Y D','2025-01-01',17,'N/A',2,4,1,'650349784','650349784'),
	(56,'ASOCIACION DE ARQUITECTOS Y PROFESIONALES POR EL PATRIMONIO DE VALPARAISO PLAN','2025-01-01',17,'N/A',2,4,1,'65041039-4','65041039-4'),
	(57,'FUNDACION GRANDES VALORES','2025-01-01',17,'N/A',2,4,1,'65041318-0','65041318-0'),
	(58,'ORGANIZACION NO GUBERNAMENTAL DE DESARROLLO SANTA MARIA','2025-01-01',17,'N/A',2,4,1,'65041820-4','65041820-4'),
	(59,'FUNDACION GANAMOS TODOS','2025-01-01',17,'N/A',2,4,1,'650421396','650421396'),
	(60,'CORPORACION REGIONAL DE DESARROLLO DE LA REGION DE TARAPACA','2025-01-01',17,'N/A',2,4,1,'650429044','650429044'),
	(61,'ASOCIACION GREMIAL DE EMPRENDEDORES EN CHILE A.G','2025-01-01',17,'N/A',2,4,1,'65046213-0','65046213-0'),
	(62,'ORGANIZACIÓN NO GUBERNAMENTAL DE DESARROLLO LA RUTA SOLAR EN LIQUIDACIÓN','2025-01-01',17,'N/A',2,4,1,'650505573','650505573'),
	(63,'FUNDACION IMPULSORA DE UN NUEVO SECTOR EN LA ECONOMIA SISTEMA B','2025-01-01',17,'N/A',2,4,1,'65052193-5','65052193-5'),
	(64,'ORGANIZACION NO GUBERNAMENTAL DE DESARROLLO CANALES U ONG CANALES','2025-01-01',17,'N/A',2,4,1,'65052395-4','65052395-4'),
	(65,'ASOCIACION NACIONAL DE EMPRESAS ESCOS, ANESCO CHILE A.G.','2025-01-01',17,'N/A',2,4,1,'65053196-5','65053196-5'),
	(66,'CENTRO DE INVESTIGACION DE POLIMEROS AVANZADOS, CIPA','2025-01-01',17,'N/A',2,4,1,'65053487-5','65053487-5'),
	(67,'CONSEJO DE INST. PROFESIONALES Y CENTROS DE FORMACION TECNICA A.G','2025-01-01',17,'N/A',2,4,1,'650544846','650544846'),
	(68,'PROPIETARIOS E INDUSTRIALES FORESTALES','2025-01-01',17,'N/A',2,4,1,'65054509-5','65054509-5'),
	(69,'FUNDACION INRIA CHILE','2025-01-01',17,'N/A',2,4,1,'650580443','650580443'),
	(70,'INSTITUTO DE NEUROCIENCIA BIOMEDICA','2025-01-01',17,'N/A',2,4,1,'65059721-4','65059721-4'),
	(71,'ASOCIACION DE MUNICIPALIDADES PARQUE CORDILLERA','2025-01-01',17,'N/A',2,4,1,'650604849','650604849'),
	(72,'FUNDACION DE BENEFICENCIA RECYCLAPOLIS','2025-01-01',17,'N/A',2,4,1,'65060486-5','65060486-5'),
	(73,'FUND CIENTIFICA Y CULTURAL BIOCIENCIA','2025-01-01',17,'N/A',2,4,1,'650612108','650612108'),
	(74,'CORPORACION PARA EL DESARROLLO DE MALLECO','2025-01-01',17,'N/A',2,4,1,'65062346-0','65062346-0'),
	(75,'CORPORACION CULTURAL ACONCAGUA SUMMIT','2025-01-01',17,'N/A',2,4,1,'65064666-5','65064666-5'),
	(79,'ASOCIACION INDIGENA AYMARA SUMA JUIRA DE CARIQUIMA','2025-01-01',17,'N/A',2,4,1,'650694422','650694422'),
	(80,'FUNDACION DEPORTE LIBRE','2025-01-01',17,'N/A',2,4,1,'650707044','650707044'),
	(81,'FUNDACION PARA EL TRABAJO UNIVERSIDAD ARTURO PRAT','2025-01-01',17,'N/A',2,4,1,'650718593','650718593'),
	(82,'CENTRO REGIONAL DE ESTUDIOS EN ALIMENTOS SALUDABLES','2025-01-01',17,'N/A',2,4,1,'650725166','650725166'),
	(83,'FUNDACION PARA EL DESARROLLO SUSTENTABLE DE FRUTILLAR','2025-01-01',17,'N/A',2,4,1,'65074257-5','65074257-5'),
	(84,'FUNDACION CSIRO-CHILE RESEARCH','2025-01-01',17,'N/A',2,4,1,'650756444','650756444'),
	(85,'CORPORACION YO TAMBIEN','2025-01-01',17,'N/A',2,4,1,'650766989','650766989'),
	(86,'O N G DE DESARROLLO CORPORACION DE DESARROLLO LONKO KILAPANG','2025-01-01',17,'N/A',2,4,1,'650776003','650776003'),
	(87,'CORPORACION MUNICIPAL DE TURISMO VICUNA','2025-01-01',17,'N/A',2,4,1,'65080284-5','65080284-5'),
	(88,'FUNDACION LEITAT CHILE','2025-01-01',17,'N/A',2,4,1,'65081283-2','65081283-2'),
	(89,'LO BARNECHEA EMPRENDE','2025-01-01',17,'N/A',2,4,1,'650816412','650816412'),
	(90,'FUNDACION CERROS ISLA','2025-01-01',17,'N/A',2,4,1,'65084846-2','65084846-2'),
	(91,'FUNDACION PATIO VIVO','2025-01-01',17,'N/A',2,4,1,'65086999-0','65086999-0'),
	(92,'CORPORACION CONSTRUYENDO MIS SUENOS','2025-01-01',17,'N/A',2,4,1,'65087946-5','65087946-5'),
	(93,'FUNDACION PARQUE CIENTIFICO TECNOLOGICO DE LA REGION DE ANTOFAGASTA','2025-01-01',17,'N/A',2,4,1,'650881222','650881222'),
	(94,'COOPERATIVA PESQUERA Y COMERCIALIZADORA CALETA SAN PEDRO','2025-01-01',17,'N/A',2,4,1,'650886666','650886666'),
	(95,'COOPERATIVA M-31 DE TONGOY','2025-01-01',17,'N/A',2,4,1,'650899466','650899466'),
	(96,'COOPERATIVA DE TRABAJO PARA EL DESARROLLO LOCAL Y LA ECONOMÍA SOLIDARIA','2025-01-01',17,'N/A',2,4,1,'65091056-7','65091056-7'),
	(97,'CORP. REG.. AYSEN DE INV. Y DES. COOPER. CENTRO DE INV.EN ECOSIST.DE LA PATAGONI','2025-01-01',17,'N/A',2,4,1,'650911466','650911466'),
	(98,'FUNDACION CENTRO DE ESTUDIOS DE MONTANA','2025-01-01',17,'N/A',2,4,1,'650922875','650922875'),
	(99,'FUNDACION LABORATORIO CAMBIO SOCIAL','2025-01-01',17,'N/A',2,4,1,'65092353-7','65092353-7'),
	(100,'FUNDACION TANTI','2025-01-01',17,'N/A',2,4,1,'65094167-5','65094167-5'),
	(101,'ASOCIACION CHILENA DE BIOMASA A.G','2025-01-01',17,'N/A',2,4,1,'65094557-3','65094557-3'),
	(102,'TAYON SPA','2025-01-01',17,'N/A',2,4,1,'77.822.744-4','77.822.744-4'),
	(103,'Instituto Milenio en Amoníaco Verde como Vector Energético (MIGA)','2023-01-01',7,'N/A',2,4,1,'65.225.271-0','65.225.271-0');

INSERT INTO Instrumento VALUES
(1,'DESARROLLA INVERSIÓN PRODUCTIVA – REGIÓN DE TARAPACÁ – CONVOCATORIA 2025',2,2,'Buscamos contribuir al desarrollo de la Región de Tarapacá mediante el crecimiento económico de sus empresas – pequeñas y medianas. Apoyando la materialización de proyectos de inversión productiva cofinanciando la adquisición de activo fijo, habilitación de infraestructura productiva y capital de trabajo.','2025-08-28','2025-09-16',0,'Corfo cofinanciará hasta el 60% del costo total de cada proyecto, con tope de $15.000.000, de acuerdo al tramo de inversión total del proyecto. Se podrá cofinanciar con el subsidio la adquisición de activo fijo, habilitación de infraestructura productiva y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,15000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/dip-tarapaca-2025/',''),
(2,'DESARROLLA INVERSIÓN PRODUCTIVA – REGIÓN DE TARAPACÁ – CONVOCATORIA 2025 COMERCIO Y LOGÍSTICA',2,2,'Buscamos contribuir al desarrollo de la Región de Tarapacá mediante el crecimiento económico de sus empresas – pequeñas y medianas. Apoyando la materialización de proyectos de inversión productiva cofinanciando la adquisición de activo fijo, habilitación de infraestructura productiva y capital de trabajo.','2025-08-28','2025-09-16',0,'Corfo cofinanciará hasta el 60% del costo total de cada proyecto, con tope de $15.000.000, de acuerdo al tramo de inversión total del proyecto. Se podrá cofinanciar con el subsidio la adquisición de activo fijo, habilitación de infraestructura productiva y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,15000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/dip-tarapaca-comercio-logistica-2025/',''),
(3,'DESARROLLA INVERSIÓN PRODUCTIVA – REGIÓN METROPOLITANA – 2° CONVOCATORIA 2025',2,7,'Apoyo a proyectos de inversión productiva con potencial de generación de externalidades positivas mediante un cofinanciamiento para la adquisición de activo fijo, infraestructura y capital de trabajo. El cofinanciamiento cubre hasta el 60% del costo total del proyecto, con un tope de $20.000.000.','2025-08-27','2025-09-10',1,'El cofinanciamiento cubre hasta el 60% del costo total del proyecto, con un tope de $20.000.000. Para cofinanciar capital de trabajo, se podrá destinar hasta un 20% del monto total de cofinanciamiento entregado por CDPR al proyecto.','Tener RUT chileno',0,20000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/dip-metropolitana-segunda-convocatoria-2025/',''),
(4,'PAR – REGIÓN DE TARAPACÁ – CONVOCATORIA 2025 COMERCIO Y LOGÍSTICA',2,2,'Buscamos mejorar el potencial productivo y fortalecer la gestión de las empresas y/o emprendedores de la región de Tarapacá, apoyando el desarrollo de sus competencias y capacidades y cofinanciando proyectos de inversión, que les permitan acceder a nuevas oportunidades de negocios y/o mantener los existentes.','2025-08-25','2025-09-11',0,'Corfo cofinanciará hasta el 80% del costo total de cada proyecto, con tope de $4.000.000. Se podrá cofinanciar con el subsidio la adquisición de activos, gastos operacionales como capacitaciones, insumos, planes de negocios, consultorías, asistencias técnicas y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,4000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/par-tarapaca-comercio-logistica-2025/',''),
(5,'PAR – REGIÓN DE TARAPACÁ – CONVOCATORIA 2025 PESCA Y AGRICULTURA',2,2,'Buscamos mejorar el potencial productivo y fortalecer la gestión de las empresas y/o emprendedores de la región de Tarapacá, apoyando el desarrollo de sus competencias y capacidades y cofinanciando proyectos de inversión, que les permitan acceder a nuevas oportunidades de negocios y/o mantener los existentes.','2025-08-25','2025-09-11',0,'Corfo cofinanciará hasta el 80% del costo total de cada proyecto, con tope de $4.000.000. Se podrá cofinanciar con el subsidio la adquisición de activos, gastos operacionales como capacitaciones, insumos, planes de negocios, consultorías, asistencias técnicas y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,4000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/par-tarapaca-pesca-agricultura-2025/',''),
(6,'PAR – REGIÓN DE TARAPACÁ – CONVOCATORIA 2025 PROVEEDORES DE LA MINERÍA',2,2,'Buscamos mejorar el potencial productivo y fortalecer la gestión de las empresas y/o emprendedores de la región de Tarapacá, apoyando el desarrollo de sus competencias y capacidades y cofinanciando proyectos de inversión, que les permitan acceder a nuevas oportunidades de negocios y/o mantener los existentes.','2025-08-25','2025-09-11',0,'Corfo cofinanciará hasta el 80% del costo total de cada proyecto, con tope de $4.000.000. Se podrá cofinanciar con el subsidio la adquisición de activos, gastos operacionales como capacitaciones, insumos, planes de negocios, consultorias, asistencias técnicas y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,4000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/par-tarapaca-proveedores-mineria-2025/',''),
(7,'PAR – REGIÓN DE TARAPACÁ – CONVOCATORIA 2025 TURISMO',2,2,'Buscamos mejorar el potencial productivo y fortalecer la gestión de las empresas y/o emprendedores de la región de Tarapacá, apoyando el desarrollo de sus competencias y capacidades y cofinanciando proyectos de inversión, que les permitan acceder a nuevas oportunidades de negocios y/o mantener los existentes.','2025-08-25','2025-09-10',0,'Corfo cofinanciará hasta el 80% del costo total de cada proyecto, con tope de $4.000.000. Se podrá cofinanciar con el subsidio la adquisición de activos, gastos operacionales como capacitaciones, insumos, planes de negocios, consultorías, asistencias técnicas y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,4000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/par-tarapaca-turismo-2025/',''),
(8,'RED DE ASISTENCIA DIGITAL FORTALECE PYME – REGIÓN DE LA ARAUCANÍA – 1° CONVOCATORIA 2025',2,12,'La Red de Asistencia Digital Fortalece Pyme busca contribuir a que las Pymes aumenten sus ingresos y/o mejoren sus niveles de productividad. Esta convocatoria busca proyectos que contemplen la incorporación de tecnologías digitales en los beneficiarios atendidos de sectores económicos vinculados a Turismo, Agropecuario, Silvícola, Pesca y Acuicultura, Construcción, Manufactura, Tecnologías de Información y Comunicaciones, Energía e Industrias Creativas.','2025-08-19','2025-09-22',3,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto. El monto restante debe ser aportado por los participantes y al menos, el 5% del costo total del proyecto debe ser pecuniario.','Tener RUT chileno',0,600000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asistencia-digital-fortalece-pyme-araucania-1ra-2025/',''),
(9,'RED DE ASISTENCIA DIGITAL FORTALECE PYME – REGIÓN DE LOS RÍOS – 1° CONVOCATORIA 2025',2,13,'La Red de Asistencia Digital Fortalece Pyme busca contribuir a que las Pymes de todos los sectores económicos de la región, aumenten sus ingresos y/o mejoren sus niveles de productividad a través de la adopción y utilización de tecnologías digitales en sus procesos de negocio (productivos, de gestión y/o comerciales), mediante el apoyo a la operación de proyectos ‘Red de Asistencia Digital Fortalece Pyme, FPyme’ que entregarán servicios en dichos ámbitos.','2025-08-19','2025-09-22',3,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto. El monto restante debe ser aportado por los participantes y al menos, el 5% del costo total del proyecto debe ser pecuniario.','Tener RUT chileno',0,600000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asistencia-digital-fortalece-pyme-los-rios-1ra-2025/',''),
(10,'RED DE ASISTENCIA DIGITAL FORTALECE PYME – REGIÓN DE ÑUBLE – 1° CONVOCATORIA 2025',2,10,'La Red de Asistencia Digital Fortalece Pyme busca contribuir a que las Pymes aumenten sus ingresos y/o mejoren sus niveles de productividad. Esta convocatoria busca proyectos que contemplen la incorporación de tecnologías digitales en los beneficiarios atendidos de sectores económicos vinculados a agropecuario – silvícola, construcción, industria manufacturera, turismo y comercio.','2025-08-19','2025-09-22',3,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto. El monto restante debe ser aportado por los participantes y al menos, el 5% del costo total del proyecto debe ser pecuniario.','Tener RUT chileno',0,600000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asistencia-digital-fortalece-pyme-nuble-1ra-2025/',''),
(11,'RED DE ASISTENCIA DIGITAL FORTALECE PYME – REGIÓN DE O’HIGGINS – 1° CONVOCATORIA 2025',2,8,'La Red de Asistencia Digital Fortalece Pyme busca contribuir a que las Pymes aumenten sus ingresos y/o mejoren sus niveles de productividad. Esta convocatoria busca proyectos que contemplen la incorporación de tecnologías digitales en los beneficiarios atendidos, Pymes, de todos los sectores económicos de la región, priorizando durante el primer año de ejecución la búsqueda y atención de empresas de los sectores vinculados a la minería, agricultura, manufactura y turismo.','2025-08-19','2025-09-22',3,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto. El monto restante debe ser aportado por los participantes y al menos, el 5% del costo total del proyecto debe ser pecuniario.','Tener RUT chileno',0,600000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red-asistencia-digital-fortalece-pyme-ohiggins-1ra-2025/',''),
(12,'RED DE ASISTENCIA DIGITAL FORTALECE PYME – REGIÓN DE VALPARAÍSO – 1° CONVOCATORIA 2025',2,6,'La Red de Asistencia Digital Fortalece Pyme busca contribuir a que las Pymes aumenten sus ingresos y/o mejoren sus niveles de productividad. Esta convocatoria busca proyectos que contemplen la incorporación de tecnologías digitales en los beneficiarios atendidos de sectores económicos vinculados a a la agricultura y manufactura (este último, vinculado a la agroindustria alimentaria).','2025-08-19','2025-09-22',3,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto. El monto restante debe ser aportado por los participantes y al menos, el 5% del costo total del proyecto debe ser pecuniario.','Tener RUT chileno',0,600000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red-asistencia-digital-fortalece-pyme-valparaiso-1ra-2025/',''),
(13,'RED DE ASISTENCIA DIGITAL FORTALECE PYME – REGIÓN DEL MAULE – 1° CONVOCATORIA 2025',2,16,'La Red de Asistencia Digital Fortalece Pyme busca contribuir a que las Pymes aumenten sus ingresos y/o mejoren sus niveles de productividad. Esta convocatoria busca proyectos que contemplen la incorporación de tecnologías digitales en los beneficiarios atendidos de sectores económicos vinculados a agropecuario – silvícola, manufactura, construcción y turismo.','2025-08-19','2025-09-22',3,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto. El monto restante debe ser aportado por los participantes y al menos, el 5% del costo total del proyecto debe ser pecuniario.','Tener RUT chileno',0,600000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asistencia-digital-fortalece-pyme-maule-1ra-2025/',''),
(14,'PRIMER CONCURSO PDT REGIÓN DE COQUIMBO',2,5,'El objetivo es contribuir al cierre de brechas de productividad del sector empresarial, de preferencia Pymes, de la región de Coquimbo, a través de la difusión de tecnologías y mejores prácticas innovadoras, con el propósito de fomentar su adopción y potenciar la competitividad de un grupo de empresas de una industria o sector que enfrentan una problemática común.','2025-08-14','2025-09-15',0,'InnovaChile cofinanciará hasta el 70,0% del costo total del proyecto, con un tope de hasta $90.000.000.- (noventa millones de pesos). El aporte restante del 30% como mínimo del costo total del proyecto, puede ser pecuniario y valorado.','',0,90000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/primer-concurso-pdt-coquimbo-2025/',''),
(15,'SEGUNDO CONCURSO PDT VIENTO NORTE',2,5,'El objetivo es contribuir al cierre de brechas de productividad del sector empresarial, de preferencia Pymes, a través de la difusión de tecnologías y mejores prácticas innovadoras, con el propósito de fomentar su adopción y potenciar la competitividad de un grupo de empresas de una industria o sector que enfrentan una problemática común, fomentando el triple impacto (económico, social, medioambiental).','2025-08-14','2025-09-15',1,'InnovaChile cofinanciará hasta el 70,00% del costo total del proyecto, con un tope de hasta $90.000.000. (noventa millones de pesos). El aporte restante del 30% como mínimo del costo total del proyecto, puede ser pecuniario y valorado.','Ser persona natural o jurídica',0,90000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/segundo-concurso-pdt-viento-norte-coquimbo-2025/',''),
(16,'RED DE FOMENTO SOSTENIBLE – CONVOCATORIA 2025, CONSTRUCCIÓN SUSTENTABLE',2,11,'Queremos que las Pymes puedan aumentar sus ingresos y/o mejoren su productividad, a través del acceso a servicios de extensionismo tecnológico que les permitan adoptar y utilizar tecnologías, mediante el cofinanciamiento de la operación de proyectos \"Red de Fomento Sostenible\" que entregarán servicios en dicho ámbito a Pymes del sector de la construcción.','2025-08-14','2025-09-22',0,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto.','Tener RUT chileno',0,900000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red-fomento-sostenible-construccion-sustentable-2025/',''),
(17,'RED DE FOMENTO SOSTENIBLE – CONVOCATORIA 2025, PESCA Y ACUICULTURA',2,15,'Queremos que las Pymes puedan aumentar sus ingresos y/o mejoren su productividad, a través del acceso a servicios de extensionismo tecnológico que les permitan adoptar y utilizar tecnologías, mediante el cofinanciamiento de la operación de proyectos \"Red de Fomento Sostenible\" que entregarán servicios en dicho ámbito a Pymes del sector de la pesca y acuicultura.','2025-08-14','2025-09-22',0,'El cofinanciamiento cubre hasta el 80% del costo total del proyecto.','Tener RUT chileno',0,900000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red-fomento-sostenible-pesca-acuicultura-2025/',''),
(18,'RED MERCADOS – REGIÓN DE LA ARAUCANÍA – 2° CONVOCATORIA 2025 ETAPA DIAGNÓSTICO',2,12,'Red Mercados apoya a grupos de empresas a incorporar capacidades y conocimientos para acceder, directa o indirectamente a mercados internacionales.','2025-08-13','2025-09-03',2,'Corfo/Comité de Desarrollo Productivo Regional financiará hasta $4.000.000.- (cuatro millones de pesos) de la Etapa de Diagnóstico, por proyecto. El plazo máximo de ejecución será de hasta 2 (dos) meses. El plazo podrá ser prorrogado, previa solicitud presentada antes del vencimiento. El plazo total del proyecto (incluidas sus prórrogas) no podrá superar los 3 (tres) meses.','Tener RUT chileno',0,4000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-mercados-araucania-segunda-convocatoria-diagnostico-2025/',''),
(19,'DESARROLLA INVERSIÓN PRODUCTIVA –REGIÓN DE COQUIMBO – 2° CONVOCATORIA 2025',2,5,'El llamado a concurso se focalizará temáticamente, por lo que sólo podrán postular proyectos de inversión productiva con potencial de generación de externalidades positivas, contribución al crecimiento sostenible y la reactivación económica de la Región de Coquimbo, mediante la adquisición de activo fijo, habilitación de infraestructura productiva y/o equipamiento tecnológico en etapas relevantes del proceso productivo.','2025-08-11','2025-09-01',1,'Corfo cofinanciará hasta el 60% del costo total de cada proyecto, con tope de $50.000.000, de acuerdo con el tramo de inversión total del proyecto indicado en la resolución de focalización de esta convocatoria (revisar bases). El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,5000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/dip-coquimbo-segunda-convocatoria-2025/',''),
(20,'DESARROLLA INVERSIÓN PRODUCTIVA –REGIÓN DE COQUIMBO – 3° CONV. 2025, TERRITORIOS VIENTO NORTE',2,5,'El llamado a concurso se focalizará temáticamente, por lo que sólo podrán postular proyectos de inversión productiva con potencial de generación de externalidades positivas, contribución al crecimiento sostenible y la reactivación económica de las comunas de Vicuña, Andacollo, La Higuera, Río Hurtado, mediante la adquisición de activo fijo, habilitación de infraestructura productiva y/o equipamiento tecnológico en etapas relevantes del proceso productivo.','2025-08-11','2025-09-01',1,'Corfo cofinanciará hasta el 70% del costo total de cada proyecto, con tope de $50.000.000. Se podrá cofinanciar con el subsidio la adquisición de activo fijo, habilitación de infraestructura productiva y capital de trabajo. El porcentaje de capital de trabajo no podrá exceder del 20% del costo total del proyecto individual.','Tener RUT chileno',0,50000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/dip-coquimbo-tercera-convocatoria-territorios-viento-norte-2025/',''),
(21,'RED ASOCIATIVA – 1° CONV. ZONAL 2025 DESARROLLO SILVOAGROPECUARIO SUSTENTABLE, ETAPA DIAGNÓSTICO',2,1,'Red Asociativa busca contribuir al aumento de la competitividad de un grupo de al menos 3 empresas, para mejorar su oferta de valor y acceder a nuevos mercados, a través del cofinanciamiento de proyectos asociativos que incorporen mejoras en gestión, productividad, sustentabilidad e innovación.','2025-01-01','2025-12-31',8,'Corfo cofinanciará hasta un 70% del costo total de la Etapa de Diagnóstico, con un tope de $8.000.000, por proyecto. La Etapa de diagnóstico se podrá extender por hasta 6 meses, prorrogable hasta 8 meses.','Tener RUT chileno',0,8000000,3,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asociativa-desarrollo-silvoagropecuario-sustentable-diagnostico-2025/',''),
(22,'RED ASOCIATIVA AGRO+ – 1° CONV. ZONAL 2025 DESARROLLO SILVOAGROPECUARIO SUSTENTABLE',2,1,'Red Asociativa AGRO+”, fomenta el cooperativismo, a través de: Beneficio: Corfo/Comité de Desarrollo Productivo Regional cofinanciará hasta un 80% del costo total de la Etapa de Diagnóstico, con un tope de $10.000.000.- (diez millones de pesos), por proyecto. Finalizada la Etapa de Diagnóstico, el proyecto podrá postular a la Etapa de Desarrollo, cuyo financiamiento será de hasta un 80% del costo total de la Etapa, con un tope para cada periodo de $45.000.000.- (cuarenta y cinco millones de pesos) por proyecto.','2025-01-01','2025-12-31',0,'Capacitación, Inversión en infraestructura','Tener RUT chileno, Estar insrito en un programa x',0,45000000,3,1,5,'https://corfo.cl/sites/cpp/convocatoria/red-asociativa-agro-desarrollo-silvoagropecuario-sustentable-diagnostico-2025/',''),
(23,'RED TECNOLÓGICA GTT – 1° CONV. ZONAL 2025 DESARROLLO SILVOAGROPECUARIO SUSTENTABLE',2,12,'Red Tecnológica GTT+ busca que grupos de entre 10 y 15 empresas puedan, a través del intercambio entre pares y asistencias técnicas, cerrar brechas tecnológicas y de gestión, incorporando herramientas y mejores prácticas productivas, fomentando la construcción de alianzas entre los empresarios, mejorar su productividad y posición competitiva.','2025-01-01','2025-12-31',0,'Corfo otorgará, para la ejecución de la Etapa de Desarrollo un cofinanciamiento de hasta un 80% del costo total de la Etapa con un tope para cada año de ejecución de $2.000.000.- (dos millones de pesos), por cada beneficiario que integra el proyecto. La Etapa de desarrollo se podrá extender por hasta tres años, aprobándose anualmente el proyecto y asignándose su presupuesto.','Tener RUT chileno',0,2000000,3,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-tecnologica-gtt-desarrollo-silvoagropecuario-sustentable-desarrollo-2025/',''),
(24,'RED TECNOLÓGICA GTT – 1° CONV. ZONAL 2025 DESARROLLO SILVOAGROPECUARIO SUSTENTABLE',2,7,'Red Tecnológica GTT+ busca que grupos de entre 10 y 15 empresas puedan, a través del intercambio entre pares y asistencias técnicas, cerrar brechas tecnológicas y de gestión, incorporando herramientas y mejores prácticas productivas, fomentando la construcción de alianzas entre empresas para ampliar el capital relacional, mejorar su productividad y posición competitiva.','2025-01-01','2025-12-31',0,'Corfo financiará hasta $3.500.000 para la Etapa de Diagnóstico, por proyecto.','Tener RUT chileno',0,3500000,3,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-tecnologica-gtt-desarrollo-silvoagropecuario-sustentable-diagnostico-2025/',''),
(25,'CREACIÓN DE CENTRO TECNOLÓGICO DE BIOTECNOLOGÍA PARA LA SOSTENIBILIDAD',2,13,'La convocatoria tiene como objetivo crear y/o fortalecer infraestructura tecnológica y capital humano avanzado mediante la implementación de un Centro Tecnológico de Biotecnología para la Sostenibilidad, en la región de Los Ríos, que permita que empresas y emprendedores desarrollen soluciones sostenibles de alto valor y potencial de mercado con base en biotecnología.','2025-07-28','2025-09-30',3,'Cofinanciamiento: Etapa 1: cofinanciamiento hasta 4.000.000.000.- (cuatro mil millones de pesos) con un tope de hasta el 80,00% del costo total de la primera etapa. Los participantes deberán aportar el financiamiento restante, de los cuales al menos 5,00% del costo total de la Etapa deberá ser mediante aportes nuevos o pecuniarios. Etapa 2: cofinanciamiento hasta 3.900.000.000.- (tres mil novecientos millones de pesos) con un tope de hasta el 65,00% del costo total de la segunda etapa. Los participantes deberán aportar el financiamiento restante, de los cuales al menos 10,00% del costo total de la Etapa deberá ser mediante aportes nuevos o pecuniarios. Etapa 3: cofinanciamiento hasta 1.800.000.000.- (il ochocientos millones de pesos) con un tope de hasta el 35,00% del costo total de la tercera etapa. Los participantes deberán aportar el financiamiento restante, de los cuales al menos 15,00% del costo total de la Etapa deberá ser mediante aportes nuevos o pecuniarios.','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',0,400000000,2,3,1,'https://corfo.cl/sites/cpp/convocatoria/creacion-centro-tecnologico-biotecnologia-sostenibilidad-los-rios-2025/',''),
(26,'CREACIÓN DE UN CENTRO TECNOLÓGICO PARA LA ECONOMÍA CIRCULAR',2,14,'La convocatoria tiene como objetivo principal la creación y puesta en marcha de un \"Centro Tecnológico para la Economía Circular, en la Región de Los Lagos\" que permita crear, habilitar y/o fortalecer infraestructura y equipamiento tecnológico para el desarrollo de soluciones basadas en modelos de economía circular, abordando las brechas y oportunidades que enfrenta la región de Los Lagos, relacionadas con la prevención en generación de residuos, así como también, de estrategias de reparación, remanufactura, reutilización, reciclaje y disposición final de residuos generados por las actividades productivas, con el fin de transitar hacia un modelo de desarrollo económico circular.','2025-07-22','2025-09-30',3,'Cofinanciamiento hasta $9.700.000.000 (nueve mil setecientos millones de pesos) en tres etapas.','Tener RUT chileno',0,9700000,2,3,5,'https://corfo.cl/sites/cpp/convocatoria/creacion-centro-tecnologico-economia-circular-los-lagos-2025/',''),
(27,'Programa de Difusión Tecnológica CDPR Atacama 2025',2,4,'El objetivo es contribuir al cierre de brechas de productividad del sector empresarial vinculados a la agroindustria, minería, turismo, eficiencia hídrica y energética, de preferencia Pymes, de la región de Atacama, a través de la difusión de tecnologías y mejores prácticas innovadoras, con el propósito de fomentar su adopción y potenciar la competitividad de un grupo de empresas de una industria o sector que enfrentan una problemática común.','2025-01-01','2025-12-31',0,'InnovaChile cofinanciará hasta el 70,00% del costo total del proyecto, con un tope de hasta $90.000.000.- (noventa millones de pesos). El aporte restante del 30% como mínimo del costo total del proyecto, puede ser pecuniario y valorado.','Tener RUT chileno',0,90000000,3,2,1,'https://corfo.cl/sites/cpp/convocatoria/programa-difusion-tecnologica-cdpr-atacama-2025/',''),
(28,'RED PROVEEDORES – REGIÓN METROPOLITANA – 1° CONVOCATORIA 2025 ETAPA DESARROLLO',2,7,'Si tienes interés en fortalecer tu cadena productiva, promoviendo el trabajo colaborativo con proveedores actuales o nuevos, fortaleciendo la relación estratégica Proveedores – Demandante, para mejorar la oferta de valor y el acceso a nuevos mercados, te invitamos a postular a Red Proveedores.  El Comité de Desarrollo Productivo Regional cofinanciará hasta un 50% del costo total de la Etapa de Desarrollo, con un tope para cada periodo de $60.000.000.- (sesenta millones de pesos), por proyecto, cuando éste sea sustentable.  En caso contrario, Corfo cofinanciará hasta un 40% del costo total de la Etapa de Desarrollo, con un tope para cada periodo de $50.000.000.- (cincuenta millones de pesos), por proyecto.','2025-01-01','2025-12-31',0,'Financiamiento: El Comité de Desarrollo Productivo Regional cofinanciará hasta un 50% del costo total de la Etapa de Desarrollo, con un tope para cada periodo de $60.000.000.- (sesenta millones de pesos), por proyecto, cuando éste sea sustentable.  En caso contrario, Corfo cofinanciará hasta un 40% del costo total de la Etapa de Desarrollo, con un tope para cada periodo de $50.000.000.- (cincuenta millones de pesos), por proyecto.  Un proyecto “RED Proveedores” es sustentable cuando, además de cumplir con los objetivos del programa y línea de apoyo, busca generar impacto en tres ámbitos: Social: busca implementar prácticas que defiendan los valores sociales, la equidad y el cumplimiento irrestricto de leyes vigentes, además del compromiso con el desarrollo de la comunidad que le rodea. Ambiental: Se preocupa de la preservación del medioambiente y del uso eficiente y racional de los recursos naturales. Económico: busca hacer sustentable su iniciativa desde el punto de vista comercial pe','',0,120000000,3,7,5,'https://corfo.cl/sites/cpp/convocatoria/red-proveedores-metropolitana-1ra-convocatoria-desarrollo-2025/',''),
(29,'PAR – REGIÓN DE O’HIGGINS – GESTIÓN EFICIENTE DE RECURSOS HÍDRICOS 2024',2,8,'Queremos potenciar a un grupo entre 5 y 15 empresas y/o emprendedores de una localidad o sector económico determinado, para que mejoren su competencia productiva y gestión, desarrollando planes de asistencia técnica, capacitación y cofinanciando la inversión productiva.','2024-02-05','2025-12-01',10,'Hasta $2.000.000 (dos millones de pesos) para actividades de asistencia técnica, capacitación y consultoría. Hasta 80% del costo total del proyecto para Proyecto de Inversión, con tope de hasta $5.000.000 (cinco millones de pesos).','Un contribuyente o un emprendedor podrá beneficiarse de este instrumento sólo en una oportunidad.',0,5000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/par_ohiggins_gestion_eficiente_recursos_hidricos/',''),
(30,'FOCAL – REGIÓN DE O’HIGGINS – INDIVIDUAL AVANCE 2023',2,8,'Subsidio que busca contribuir a la diversificación productiva de la Región de O’Higgins, a través de generar condiciones para potenciar el desarrollo de proveedores de servicios a la minería, mediante el fortalecimiento del Capital humano, el fomento de nuevos emprendimientos e incentivo a la innovación tecnológica minera.','2023-10-25','2025-12-30',2,'Cofinanciamiento para la implementación de un documento normativo, con tope de hasta $3.500.000 (tres millones quinientos mil pesos). El cofinanciamiento cubre hasta el 70% del costo total del proyecto. El porcentaje restante debe ser cubierto por el beneficiario con aportes pecuniarios.','Tener RUT chileno',0,3500000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/focal_ohiggins_individual_avance-2/',''),
(31,'FOCAL – REGIÓN DE O’HIGGINS – INDIVIDUAL REEMBOLSO 2023',2,8,'Subsidio que busca contribuir a la diversificación productiva de la Región de O’Higgins, a través de generar condiciones para potenciar el desarrollo de proveedores de servicios a la minería, mediante el fortalecimiento del Capital humano, el fomento de nuevos emprendimientos e incentivo a la innovación tecnológica minera.','2023-10-25','2025-12-30',0,'Cofinanciamiento para la implementación de un documento normativo, con tope de hasta $3.500.000 (tres millones quinientos mil pesos). El cofinanciamiento cubre hasta el 70% del costo total del proyecto. El porcentaje restante debe ser cubierto por el beneficiario con aportes pecuniarios.','Tener RUT chileno',0,3500000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/focal_ohiggins_individual_reembolso-2/',''),
(32,'RED ASOCIATIVA – REGIÓN DE O’HIGGINS – ETAPA DE DIAGNÓSTICO Y DESARROLLO 2023',2,8,'Si tienes interés en participar junto a otras Empresas para mejorar tu oferta de valor y acceder a nuevos mercados, a través del Programa RED Asociativa te apoyamos con asesoría experta para abordar oportunidades de mercado y de mejoramiento tecnológico, desarrollando estrategias de negocios colaborativos, de acuerdo a las características productivas del grupo de empresas.','2023-06-30','2025-12-30',2,'Se financiará hasta el 70% del costo total de la Etapa de Diagnóstico y Desarrollo. Hasta el 70% del costo total de la Etapa de Diagnóstico, con un tope de $8.000.000 (ocho millones de pesos) por proyecto.','Tener RUT chileno',0,8000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red_asociativa_ohiggins_diagdesa-2/',''),
(33,'RED ASOCIATIVA – REGIÓN DE O’HIGGINS – ETAPA DE DIAGNÓSTICO Y DESARROLLO 2023',2,8,'Si tienes interés en participar junto a otras Empresas para mejorar tu oferta de valor y acceder a nuevos mercados, a través del Programa RED Asociativa te apoyamos con asesoría experta para abordar oportunidades de mercado y de mejoramiento tecnológico, desarrollando estrategias de negocios colaborativos, de acuerdo a las características productivas del grupo de empresas.','2023-06-30','2025-12-30',2,'Se financiará hasta el 70% del costo total de la Etapa de Diagnóstico y Desarrollo. Hasta el 70% del costo total de la Etapa de Diagnóstico, con un tope de $8.000.000 (ocho millones de pesos) por proyecto.','Tener RUT chileno',0,8000000,2,2,1,'https://corfo.cl/sites/cpp/convocatoria/red_asociativa_ohiggins_diagdesa/',''),
(34,'RED MERCADOS – REGIÓN DE O’HIGGINS – ETAPA DE DIAGNÓSTICO Y DESARROLLO 2023',2,8,'Buscamos apoyar a grupos de empresas a incorporar las capacidades y conocimientos necesarios para acceder, directa o indirectamente a mercados internacionales.','2023-06-30','2025-12-30',2,'Para la Etapa de Diagnostico cofinanciara hasta $4.000.000.- (cuatro millones de pesos), por proyecto. Para la Etapa de Desarrollo, Corfo cofinanciará hasta un 90% del costo total de ésta, con un tope de $40.000.000 (cuarenta millones de pesos), por proyecto.','',0,4000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red_mercados_ohiggins_diagndesar/',''),
(35,'RED PROVEEDORES – REGIÓN DE O’HIGGINS – ETAPA DE DIAGNÓSTICO Y DESARROLLO 2023',2,8,'Buscamos fortalecer la relación Proveedor – Demandante, promueve el trabajo colaborativo para mejorar la oferta de valor de las empresas y así aumentar la competitividad de la cadena productiva.','2023-06-30','2025-12-30',24,'Etapa Diagnostico: Corfo cofinanciará hasta un 50% del costo total de la Etapa de Diagnóstico, con un tope de $10.000.000, por proyecto. Etapa Desarrollo: Corfo cofinanciará hasta un 40% del costo total de la Etapa de Desarrollo, con tope $50.000.000 (cincuenta millones) para cada año de ejecución, por proyecto.','Tener RUT chileno',0,50000000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red_proveedores_ohiggins_diagndesarrollo/',''),
(36,'RED TECNOLÓGICA GTT – REGIÓN DE O’HIGGINS – ETAPA DE DIAGNÓSTICO Y DESARROLLO 2023',2,8,'Buscamos empresas con interés en participar junto a otras, para aumentar tu competitividad a través del Programa RED GTT para abordar brechas en ámbitos tecnológicos y de gestión, desarrollando actividades de construcción de capital social de Pymes silvoagropecuarias, a través de la organización y el trabajo en grupo de los productores, de acuerdo con las características productivas del grupo de empresas. Convocatoria abierta para la Región de O’Higgins.','2023-06-30','2025-12-30',2,'Se financiará hasta $3.500.000.- (tres millones quinientos mil pesos) de la Etapa de Diagnóstico, por proyecto. El cofinanciamiento cubre hasta un 80% del costo total de la Etapa de Desarrollo.','Tener RUT chileno',0,3500000,2,1,1,'https://corfo.cl/sites/cpp/convocatoria/red_tecnologica_gtt_oh_diag_desar/',''),
(37,'Innova Región Atacama 2025',2,4,'Apoyamos el desarrollo de nuevos o mejorados productos (bienes o servicios) y/o procesos desde la fase de prototipo, hasta la fase de validación técnica a escala productiva y/o validación comercial, que aporten a la economía regional y fortalezcan las capacidades de innovación en la empresa en los ámbitos minería, agroindustria, eficiencia hídrica y energética.','2025-01-01','2025-12-31',0,'Se cofinanciará los proyectos con un tope de hasta $60.000.000.- (sesenta millones de pesos). Se financiará un porcentaje del costo total del proyecto, dependiendo de los ingresos por ventas del beneficiario: Empresa Micro y pequeña (ventas por hasta 25.000 UF anual): hasta 80% Empresa Mediana (ventas por sobre 25.000 UF y hasta 100.000 UF anual) hasta 60% Empresa Grande (ventas por sobre 100.000 UF anual) hasta 40% Aumento de hasta un 10 % más de cofinanciamiento para \"Empresas lideradas por mujeres\".','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',0,60000000,3,1,1,'https://corfo.cl/sites/cpp/convocatoria/innova-region-atacama-2025/',''),
(38,'PAR GESTIÓN EFICIENTE DE RECURSOS HÍDRICOS – REGIÓN DE O’HIGGINS 2022',2,8,'Subsidio que busca mejorar el potencial productivo y fortalecer la gestión de las empresas y/o emprendedores de un territorio, apoyando proyectos vinculados a la sustentabilidad medioambiental, que incorporen la gestión eficiente de recursos hídricos, fomentando el desarrollo de sus competencias y capacidades y cofinanciando proyectos de inversión, que les permitan acceder a nuevas oportunidades de negocio y/o mantener las existentes.','2022-01-01','2022-12-31',12,'Hasta $2.000.000 (dos millones de pesos) para actividades de asistencia técnica, capacitación y consultoría. Hasta 80% del costo total del proyecto para Proyecto de Inversión, con tope de hasta $5.000.000 (cinco millones de pesos).','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',0,5000000,8,7,1,'https://corfo.cl/sites/cpp/convocatoria/par_gestion_eficiente_de_recursos_hidricos_ohiggins/',''),
(39,'PAR MULTISECTORIAL IDENTIDAD REGIONAL Y PATRIMONIAL – REGIÓN DE O’HIGGINS – AÑO 2023',2,8,'Queremos potenciar a un grupo entre 5 y 15 empresas y/o emprendedores de una localidad o sector económico determinado, para que mejoren su competencia productiva y gestión, desarrollando planes de asistencia técnica, capacitación y cofinanciando la inversión productiva.','2023-01-01','2023-12-31',12,'Hasta $2.000.000 (dos millones de pesos) para actividades de asistencia técnica, capacitación y consultoría. Hasta 80% del costo total del proyecto para Proyecto de Inversión, con tope de hasta $5.000.000 (cinco millones de pesos).','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',0,5000000,8,1,1,'https://corfo.cl/sites/cpp/convocatoria/par_multisectorial_identidad_regional_y_patrimonial_oh/',''),
(40,'PAR MULTISECTORIAL INCLUSION – REGION DE O’HIGGINS – AÑO 2023',2,8,'Queremos potenciar a un grupo entre 5 y 15 empresas y/o emprendedores de una localidad o sector económico determinado, para que mejoren su competencia productiva y gestión, desarrollando planes de asistencia técnica, capacitación y cofinanciando la inversión productiva.','2023-01-01','2023-12-31',0,'Hasta $2.000.000 (dos millones de pesos) para actividades de asistencia técnica, capacitación y consultoría. Hasta 80% del costo total del proyecto para Proyecto de Inversión, con tope de hasta $5.000.000 (cinco millones de pesos).','Tener RUT chileno',0,5000000,8,1,1,'https://corfo.cl/sites/cpp/convocatoria/par_multisectorial_inclusion_oh/',''),
(41,'RED ASOCIATIVA – REGIÓN METROPOLITANA – 1° CONVOCATORIA 2025 ETAPA DESARROLLO',2,7,'El Programa Red Asociativa permite participar junto a otras Empresas para mejorar tu oferta de valor y acceder a nuevos mercados, a través del Programa RED Asociativa te apoyamos con asesoría experta para abordar oportunidades de mercado y de mejoramiento tecnológico, desarrollando estrategias de negocios colaborativos, de acuerdo con las características productivas del grupo de empresas.','2025-01-01','2025-12-31',0,'Corfo cofinanciará hasta un 70% del costo total de la Etapa de Desarrollo, con un tope de $40.000.000, por proyecto.','Tener RUT chileno',0,40000000,3,2,1,'https://corfo.cl/sites/cpp/convocatoria/red-asociativa-metropolitana-1ra-convocatoria-desarrollo-2025/',''),
(42,'Red Tecnológica GTT+',2,7,'Si tienes interés en participar junto a otras empresas del sector silvoagropecuario en un proyecto GTT, los invitamos a postular al programa GTT+. Esta línea de apoyo busca que grupos de entre 10 y 15 empresas puedan, a través del intercambio entre pares y asistencias técnicas, cerrar brechas tecnológicas y de gestión, incorporando herramientas y mejores prácticas productivas, fomentando la construcción de alianzas entre los empresarios para ampliar el capital relacional, mejorar su productividad y posición competitiva.','2025-01-01','2025-12-31',0,'Cofinanciamiento: Hasta $3.500.000.- (tres millones quinientos mil pesos), para la Etapa de Diagnóstico.- En la Etapa de Diagnóstico se otorgará un financiamiento de hasta $3.500.000.- (tres millones quinientos mil pesos), por proyecto. Corfo cofinanciará hasta un 80% del costo total de la Etapa de Desarrollo, con un tope para cada periodo de $2.000.000.- (dos millones de pesos), por cada beneficiario que integra el proyecto.','',0,3500000,3,1,1,'https://corfo.cl/sites/cpp/convocatoria/gtt/',''),
(43,'PAMMA Asistencia Técnica 2025',3,2,'Este instrumento entregará asistencia técnica a las y los productores de la pequeña minería de las regiones de Antofagasta, Atacama y Coquimbo. Este servicio será entregado por la Universidad de Atacama, incluyendo dos líneas de trabajo especificas: Regularización ante Sernageomin y Asesoría técnica productiva.','2025-08-13','2025-09-01',1,'Capacitación, Asesoría técnica','Tener RUT chileno, Ser persona natural o jurídica',0,0,2,1,6,'https://www.fondos.gob.cl/ficha/minmineria/pamma-at-2025/',''),
(44,'Proyectos Culturales y Deportivos',3,4,'Este Fondo, a través de las Bases Generales, regula el proceso de concursabilidad y de asignación de recursos para subvencionar las actividades mencionadas en la Glosa 07 de la Ley N°21.722 del Sector Público año 2025, para que postulen instituciones privadas sin fines de lucro a proyectos cultureles y deportivos con actividades de vinculación con la comunidad Atacameña.','2025-08-19','2025-09-01',0,'Capacitación','Tener RUT chileno',0,4000000,2,1,5,'https://www.fondos.gob.cl/ficha/goreatacama/proyectos-culturales-deportivos-atacama/',''),
(45,'Fondo de Protección Ambiental: Puesta en valor de los Ecosistemas Altoandinos – Humedales y Criósfera',3,4,'A través de este concurso, el Ministerio del Medio Ambiente, por medio del Fondo de Protección Ambiental, busca promover la puesta en valor y gestión sustentable de los ecosistemas altoandinos de la comuna de Alto del Carmen, Región de Atacama, con especial énfasis en los humedales y la criósfera. Para ello, se apoyarán proyectos ejecutados por universidades, centros de investigación, fundaciones, corporaciones y ONG, orientados a generar conocimiento científico sobre estos ecosistemas, acercarlos a la comunidad mediante infraestructura educativa itinerante y fortalecer su protección a través de actividades de educación ambiental.','2025-08-05','2025-09-17',7,'Capacitación, Inversión en infraestructura','Tener RUT chileno, Ser persona jurídica',0,7000000,2,1,5,'https://www.fondos.gob.cl/ficha/mma/fpa-alto-del-carmen-hidrico/',''),
(46,'Fondo de Protección Ambiental: Puesta en valor de los Ecosistemas Altoandinos – Biodiversidad',3,4,'A través de este concurso, el Ministerio del Medio Ambiente, por medio del Fondo de Protección Ambiental, busca promover el conocimiento y la conservación de la biodiversidad de los ecosistemas altoandinos en la comuna de Alto del Carmen, Región de Atacama. La convocatoria está dirigida a universidades, centros de investigación, fundaciones, corporaciones y ONG, y contempla el financiamiento de proyectos que permitan diagnosticar los principales componentes de la biodiversidad local, identificar sitios prioritarios para su protección y fortalecer la valoración de estos ecosistemas mediante actividades de educación ambiental dirigidas a la comunidad.','2025-08-05','2025-09-17',6,'Capacitación, Asesoría técnica','Tener RUT chileno, Ser persona jurídica',0,6000000,2,1,5,'https://www.fondos.gob.cl/ficha/mma/fpa-alto-del-carmen-biodiversidad/',''),
(47,'Fondo de Protección Ambiental - Tocopilla',3,2,'A través de este Concurso, el MMA por medio del Fondo de Protección Ambiental, busca contribuir al proceso de Transición Socioecológica Justa de la comuna de Tocopilla Región del Antofagasta, por medio de la ejecución de proyectos ciudadanos, focalizados en las temáticas de Innovación en energías renovables y eficiencia energética y Adaptación al Cambio Climático, incorporando la educación ambiental como un proceso permanente.','2025-07-01','2025-09-24',6,'CAP, RIE','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',0,1000000,2,2,5,'https://www.fondos.gob.cl/ficha/mma/fpatocopilla-2025/',''),
(48,'PROYECTOS CIUDADANOS CON ENFOQUE DE TRANSICIÓN SOCIOECOLÓGICA JUSTA',3,2,'A través de este Concurso, el MMA por medio del Fondo de Protección Ambiental, busca contribuir al proceso de Transición Socioecológica Justa de la comuna de Mejillones Región del Antofagasta, por medio de la ejecución de proyectos ciudadanos, focalizados en las temáticas de Innovación en energías renovables y eficiencia energética y Adaptación al Cambio Climático, incorporando la educación ambiental como un proceso permanente.','2025-07-01','2025-09-24',6,'CAP','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',0,10000000,2,1,5,'https://www.fondos.gob.cl/ficha/mma/fpamejillones-2025/',''),
(49,'MI TAXI ELÉCTRICO ATACAMA',3,4,'Este fondo cofinancia la inversión para el reemplazo de un vehículo con motor de combustión interna, que sea taxi en todas sus modalidades, según DS-212 de MTT a un vehículo eléctrico. El vehículo a reemplazar debe estar inscrito en el registro nacional de transporte de pasajeros en la región y el propietario debe contar con un lugar o estacionamiento bajo su control y que pueda ser instalado un cargador para el vehículo eléctrico. Este Fondo se encontrará abierto hasta completar los cupos (158).','2024-04-30','2025-10-30',12,'Capacitación','Tener RUT chileno, Estar inscrito en un programa x',0,16000000,2,1,6,'https://www.fondos.gob.cl/ficha/minenergia/mte-atacama/',''),
(50,'MI TAXI ELÉCTRICO O\'HIGGINS',3,8,'Este fondo cofinancia la inversión para el reemplazo de un vehículo con motor de combustión interna, que sea taxi en todas sus modalidades, según DS-212 de MTT a un vehículo eléctrico. El vehículo a reemplazar debe estar inscrito en el registro nacional de transporte de pasajeros en la región y el propietario debe contar con un lugar o estacionamiento bajo su control y que pueda ser instalado un cargador para el vehículo eléctrico. Este Fondo se encontrará abierto hasta completar los cupos (152).','2024-03-13','2025-10-30',12,'Capacitación','Tener RUT chileno, Estar inscrito en un programa x',0,16000000,2,1,6,'https://www.fondos.gob.cl/ficha/minenergia/mte-ohiggins/',''),
(51,'MI TAXI ELÉCTRICO BÍOBÍO',3,11,'Este fondo cofinancia la inversión para el reemplazo de un vehículo con motor de combustión interna, que sea taxi en todas sus modalidades, según DS-212 de MTT a un vehículo eléctrico. El vehículo a reemplazar debe estar inscrito en el registro nacional de transporte de pasajeros en la región y el propietario debe contar con un lugar o estacionamiento bajo su control y que pueda ser instalado un cargador para el vehículo eléctrico. Este Fondo se encontrará abierto hasta completar los cupos (299).','2024-04-30','2025-10-30',12,'Capacitación','Tener RUT chileno, Estar inscrito en un programa x',0,16000000,2,1,6,'https://www.fondos.gob.cl/ficha/minenergia/mte-biobio/',''),
(52,'MI TAXI ELÉCTRICO ANTOFAGASTA',3,2,'Este fondo cofinancia la inversión para el reemplazo de un vehículo con motor de combustión interna, que sea taxi en todas sus modalidades, según DS-212 de MTT a un vehículo eléctrico. El vehículo a reemplazar debe estar inscrito en el registro nacional de transporte de pasajeros en la región y el propietario debe contar con un lugar o estacionamiento bajo su control y que pueda ser instalado un cargador para el vehículo eléctrico. Este Fondo se encontrará abierto hasta completar los cupos (59).','2024-03-26','2025-10-30',12,'Capacitación','Tener RUT chileno, Estar inscrito en un programa x',0,16000000,2,1,6,'https://www.fondos.gob.cl/ficha/minenergia/mte-antofagasta/',''),
(53,'FNDR Deportistas O’Higgins 2025',3,8,'Apoyar procesos de preparación y/o entrenamientos para competencias de deportistas destacados, convencionales y paralímpicos. Dichos deportistas deben tener domicilio (residencia) y afiliación deportiva en la Región de O’Higgins. Sin perjuicio de lo anterior, y con respecto al punto de la exigencia de afiliación deportiva, se considerarán casos excepcionales, pero debidamente calificados, por ejemplo, para aquellas disciplinas que no posean clubes federados en la región, seleccionados/as nacionales que, a pesar de tener domicilio en la región, por motivos fundamentados, han debido afiliarse a clubes fuera de esta, (entre otros similares). Cabe señalar, que la pertinencia de dichos casos será evaluada por la Unidad FNDR 8%.','2025-05-06','2025-12-31',7,'Capacitación','Tener RUT chileno, Ser persona natural o jurídica, Estar insrito en un programa x',6000000,8000000,2,1,6,'https://www.fondos.gob.cl/ficha/goreohiggins/fndr_deportistas_ohiggins-2025/','');
