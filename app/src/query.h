#ifndef QUERY_H
#define QUERY_H
#include <mysql/mysql.h>

#define MYSQL_HOST "localhost"
#define MYSQL_USER "root"
#define DB "MatchaFundingMySQL"

char *EjecutarQueryAJSON(const char *query);
char *ParsearResultadoAJSON(MYSQL_RES *result);

#endif
