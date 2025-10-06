#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <hiredis/hiredis.h>
#include "headers/cache.h"

/* Se intenta conectar con el diccionario de cache en memoria */
redisContext *ConexionDiccionario() {
	redisContext *conn = redisConnect("127.0.0.1", 6379);
	if (conn->err) {
		printf("error: %s\n", conn->errstr);
		return NULL;
	}
	return conn;
}

/* Buscar un valor en el diccionario de cache en memoria */
char* BuscarValorEnDiccionario(const char *key) {
	char *res = NULL;
	redisContext *conn = ConexionDiccionario();
	if (conn) {
		redisReply *reply = redisCommand(conn, "GET %s", key);
		if (reply->str) {
			int len = strlen(reply->str);
			res = malloc(sizeof(char)*len);
			strcpy(res, reply->str);
		}
		freeReplyObject(reply);
		redisFree(conn);
	}
	return res;
}

/* Guarda un valor en el diccionario de cache en memoria */
void GuardarValorEnDiccionario(const char *key, const char *value) {
	redisContext *conn = ConexionDiccionario();
	if (conn) {
		redisReply *reply = redisCommand(conn, "SET %s %s", key, value);
		freeReplyObject(reply);
		redisFree(conn);
	}
}
