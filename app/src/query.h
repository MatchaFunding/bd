#ifndef QUERY_H
#define QUERY_H
#include <mysql/mysql.h>

#define PORT 8080
#define HOST "localhost"
#define USER "root"
#define DB "MatchaFundingMySQL"

char *EjecutarQueryAJSON(const char *query);
char *ParsearResultadoAJSON(MYSQL_RES *result);

#endif
