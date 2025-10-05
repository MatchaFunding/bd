#ifndef QUERY_H
#define QUERY_H

#include <mysql/mysql.h>

#define PORT 8080
#define HOST "localhost"
#define USER "root"
#define DB "MatchaFundingMySQL"

// Ejecuta la query en MySQL / MariaDB y luego devuelve un JSON
char *execute_query_to_json(const char *query);

// Convierte la respuesta de la query en JSON
char *parse_result_to_json(MYSQL_RES *result);

#endif
