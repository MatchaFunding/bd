/*
Conjunto de vistas pre-almacenadas como tablas para maximizar
el rendimiento. Se usa para datos que son estaticos, tales como
historicos, publicos y comparativas para hacer el calce a traves
de la IA con los datos de los usuarios.
*/

/*
Vista que muestra los beneficiarios en formato legible
*/
CREATE TABLE VerTodosLosBeneficiarios AS
SELECT
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
Vista que muestra los colaboradores en formato legible
*/
CREATE TABLE VerTodosLosColaboradores AS
SELECT
	Persona.Nombre AS Persona,
	Proyecto.Titulo AS Proyecto
FROM
	Colaborador, Persona, Proyecto
WHERE
	Persona.ID=Colaborador.Persona AND
	Proyecto.ID=Colaborador.Proyecto;

/*
Vista que muestra los consorcios en formato legible
*/
CREATE TABLE VerTodosLosConsorcios AS
SELECT
	Beneficiario.Nombre AS PrimerBeneficiario,
	Beneficiario.Nombre AS SegundoBeneficiario
FROM
	Consorcio, Beneficiario
WHERE
	Beneficiario.ID=Consorcio.PrimerBeneficiario AND
	Beneficiario.ID=Consorcio.SegundoBeneficiario;

/*
Vista que muestra los instrumentos en formato legible
*/
CREATE TABLE VerTodosLosInstrumentos AS
SELECT
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
Vista que muestra los miembros en formato legible
*/
CREATE TABLE VerTodosLosMiembros AS
SELECT
	Persona.Nombre AS Persona,
	Beneficiario.Nombre AS Beneficiario
FROM
	Miembro, Persona, Beneficiario
WHERE
	Persona.ID=Miembro.Persona AND
	Beneficiario.ID=Miembro.Beneficiario;

/*
Vista que muestra las personas en formato legible
*/
CREATE TABLE VerTodasLasPersonas AS SELECT
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
Vista que muestra las postulaciones en formato legible
*/
CREATE TABLE VerTodasLasPostulaciones AS SELECT
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

/*
Vista que muestra los proyectos en formato legible
*/
CREATE TABLE VerTodosLosProyectos AS SELECT
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
