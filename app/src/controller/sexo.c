#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include "../headers/query.h"
#include "../headers/cache.h"
#include "../headers/sexo.h"

/* Gestiona y enruta las llamadas hacia los instrumentos */
HTTP_response URLSexo(const char *url, const char *method, const char *body){
	char *id = strstr(url, "/instrumentos/");
	if (id != NULL) {
		id += strlen("/instrumentos/");
	}
	if (EsMetodo(method, "GET")) {
		return VerSexos(url);
	}
	return (HTTP_response){
		.body = MensajeSimple("Invalid method"),
		.status = NOT_IMPLEMENTED
	};
}
