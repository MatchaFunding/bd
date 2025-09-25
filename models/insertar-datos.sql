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
