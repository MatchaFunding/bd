#include <string.h>
#include <stdio.h>
#include "instrumento.h"
#include "query.h"

/* Muestra absolutamente todos los instrumentos existentes */
HTTP_response VerTodosLosInstrumentos(const char *url) {
	const char *query = "SELECT * FROM VerTodosLosInstrumentos";
	char *result = EjecutarQueryAJSON(query);
	return ValidarResultado(result);
}

/* Muestra solo un instrumento en base a su identificador */
HTTP_response VerSoloUnInstrumento(const char *id) {
	if (id == NULL) {
		return (HTTP_response){
			.body = MensajeSimple("No id provided"),
			.status = BAD_REQUEST
		};
	}
	char query[64];
	snprintf(query, sizeof(query), "SELECT * FROM VerTodosLosInstrumentos WHERE ID = %s", id);
	char *result = EjecutarQueryAJSON(query);
	return ValidarResultado(result);
}

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
