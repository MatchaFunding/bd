#include <string.h>
#include <stdio.h>
#include "instrumento.h"
#include "query.h"

/*
Muestra absolutamente todos los instrumentos existentes
*/
HTTP_response VerTodosLosInstrumentos(const char *url) {
	const char *query = "SELECT * FROM VerTodosLosInstrumentos";
	char *result = ExecuteQueryToJSON(query);
	return ValidateResult(result);
}

/*
Muestra un instrumento en base a su identificador
*/
HTTP_response ObtenerInstrumento(const char *id) {
	if (id == NULL) {
		return (HTTP_response){
			.body = SimpleMessage("No id provided"),
			.status = BAD_REQUEST
		};
	}
	char query[64];
	snprintf(query, sizeof(query), "SELECT * FROM VerTodosLosInstrumentos WHERE ID = %s", id);
	char *result = ExecuteQueryToJSON(query);
	return ValidateResult(result);
}

/*
Crea un instrumento a partir de los datos entregados en el body
*/
HTTP_response CrearInstrumento(const char *body) {
	if (body == NULL) {
		return (HTTP_response){
			.body = SimpleMessage("No body provided"),
			.status = BAD_REQUEST
		};
	}
	char query[256];
	snprintf(query, sizeof(query),"INSERT INTO Instrumento VALUES ('%s', '%s')", "name","email");
	char *result = ExecuteQueryToJSON(query);
	return ValidateResult(result);
}

/*
Modifica un instrumento a partir de los datos entregados en el body
*/
HTTP_response CambiarInstrumento(const char *id, const char *body) {
	if (id == NULL) {
		return (HTTP_response){
			.body = SimpleMessage("No id provided"),
			.status = BAD_REQUEST
		};
	}
	if (body == NULL) {
		return (HTTP_response){
			.body = SimpleMessage("No body provided"),
			.status = BAD_REQUEST
		};
	}
	char query[256];
	snprintf(query, sizeof(query),"UPDATE Instrumento SET name = '%s', email = '%s' WHERE id = %s", "name", "email", id);
	char *result = ExecuteQueryToJSON(query);
	return ValidateResult(result);
}

/*
Borra un instrumento a partir de su identificador
*/
HTTP_response BorrarInstrumento(const char *id) {
	char query[64];
	snprintf(query, sizeof(query), "DELETE FROM Instrumento WHERE id = %s", id);
	char *result = ExecuteQueryToJSON(query);
	return ValidateResult(result);
}

/*
Gestiona y enruta las llamdas hacia los instrumentos dependiendo del metodo
que se esta invocando hacia la API
*/
HTTP_response URLInstrumento(const char *url, const char *method, const char *body){
	char *id = strstr(url, "/instrumentos/");
	if (id != NULL) {
		id += strlen("/instrumentos/");
	}
	if (ValidateMethod(method, "GET")) {
		if (id == NULL){
			return VerTodosLosInstrumentos(url);
		}
		else {
			return ObtenerInstrumento(id);
		}
	}
	if (ValidateMethod(method, "POST")) {
		return CrearInstrumento(body);
	}
	if (ValidateMethod(method, "PUT")) {
		return CambiarInstrumento(id, body);
	} 
	if (ValidateMethod(method, "DELETE")) {
		return BorrarInstrumento(id);
	}
	return (HTTP_response){
		.body = SimpleMessage("Invalid method"),
		.status = NOT_IMPLEMENTED
	};
}
