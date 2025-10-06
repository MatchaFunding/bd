#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include "../headers/query.h"
#include "../headers/cache.h"
#include "../headers/instrumento.h"

/* Muestra absolutamente todos los instrumentos existentes */
HTTP_response VerTodosLosInstrumentos(const char *url) {
	char *cache = BuscarValorEnDiccionario("instrumentos");
	if (!cache) {
		const char *query = "SELECT * FROM VerTodosLosInstrumentos";
		char *result = EjecutarQueryEnJSON(query);
		GuardarValorEnDiccionario("instrumentos", result);
		return ValidarResultado(result);
	}
	return ValidarResultado(cache);
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
	char *result = EjecutarQueryEnJSON(query);
	return ValidarResultado(result);
}
