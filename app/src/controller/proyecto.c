#include <string.h>
#include <stdio.h>
#include "../headers/query.h"
#include "../headers/proyecto.h"

/* Muestra absolutamente todos los proyectos existentes */
HTTP_response VerTodosLosProyectos(const char *url) {
	const char *query = "SELECT * FROM VerTodosLosProyectos";
	char *result = EjecutarQueryEnJSON(query);
	return ValidarResultado(result);
}

/* Muestra solo un proyecto en base a su identificador */
HTTP_response VerSoloUnProyecto(const char *id) {
	if (id == NULL) {
		return (HTTP_response){
			.body = MensajeSimple("No id provided"),
			.status = BAD_REQUEST
		};
	}
	char query[64];
	snprintf(query, sizeof(query), "SELECT * FROM VerTodosLosProyectos WHERE ID = %s", id);
	char *result = EjecutarQueryEnJSON(query);
	return ValidarResultado(result);
}

/* Gestiona y enruta las llamdas hacia los proyectos */
HTTP_response URLProyecto(const char *url, const char *method, const char *body){
	char *id = strstr(url, "/proyectos/");
	if (id != NULL) {
		id += strlen("/proyectos/");
	}
	if (EsMetodo(method, "GET")) {
		if (id == NULL)
			return VerTodosLosProyectos(url);
		else
			return VerSoloUnProyecto(id);
	}
	return (HTTP_response){
		.body = MensajeSimple("Invalid method"),
		.status = NOT_IMPLEMENTED
	};
}
