#include <string.h>
#include <stdio.h>
#include "../headers/query.h"
#include "../headers/beneficiario.h"

/* Muestra absolutamente todos los beneficiarios existentes */
HTTP_response VerTodosLosBeneficiarios(const char *url) {
	const char *query = "SELECT * FROM VerTodosLosBeneficiarios";
	char *result = EjecutarQueryEnJSON(query);
	return ValidarResultado(result);
}

/* Muestra solo un beneficiarios en base a su identificador */
HTTP_response VerSoloUnBeneficiario(const char *id) {
	if (id == NULL) {
		return (HTTP_response){
			.body = MensajeSimple("No id provided"),
			.status = BAD_REQUEST
		};
	}
	char query[64];
	snprintf(query, sizeof(query), "SELECT * FROM VerTodosLosBeneficiarios WHERE ID = %s", id);
	char *result = EjecutarQueryEnJSON(query);
	return ValidarResultado(result);
}

/* Gestiona y enruta las llamadas hacia los beneficiarios */
HTTP_response URLBeneficiario(const char *url, const char *method, const char *body) {
	char *id = strstr(url, "/beneficiarios/");
	if (id != NULL) {
		id += strlen("/beneficiarios/");
	}
	if (EsMetodo(method, "GET")) {
		if (id == NULL)
			return VerTodosLosBeneficiarios(url);
		else
			return VerSoloUnBeneficiario(id);
	}
	return (HTTP_response){
		.body = MensajeSimple("Invalid method"),
		.status = NOT_IMPLEMENTED
	};
}
