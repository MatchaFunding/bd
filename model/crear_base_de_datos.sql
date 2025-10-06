-- Borra, Crea y Usa la Base de Datos de MatchaFunding
DROP DATABASE IF EXISTS MatchaFundingMySQL;
CREATE DATABASE IF NOT EXISTS MatchaFundingMySQL;
USE MatchaFundingMySQL;

-- Aumenta el cache disponible para optimizar vistas 
-- estaticas como datos publicos u historicos
SET GLOBAL query_cache_size = 800000000;

-- Aumenta el tamano de el pool de buffers para permitir
-- que la base de datos almacene mas datos en memoria
SET GLOBAL innodb_buffer_pool_size = 800000000;