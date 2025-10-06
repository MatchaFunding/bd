#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include "../headers/query.h"
#include "../headers/cache.h"
#include "../headers/instrumento.h"

/* Gestiona y enruta las llamdas hacia los instrumentos */
HTTP_response URLInstrumento(const char *url, const char *method, const char *body){
	char *id = strstr(url, "/instrumentos/");
	if (id != NULL) {
		id += strlen("/instrumentos/");
	}
	if (EsMetodo(method, "GET")) {
		if (id == NULL)
			return VerTodosLosInstrumentos(url);
		else
			return VerSoloUnInstrumento(id);
	}
	return (HTTP_response){
		.body = MensajeSimple("Invalid method"),
		.status = NOT_IMPLEMENTED
	};
}
