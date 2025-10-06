//#include "rest.h"
#include <microhttpd.h>
#include "utils.h"
#include <setjmp.h>
#include "headers/handler.h"
#include "headers/instrumento.h"

jmp_buf ExceptionBuffer;

/* Muestra por pantalla la request solicitada por el cliente */
void LoguearAPI(const char *url, const char *method) {
	printf("[%s] %s\n", method, url);
}

/* Construye la respuesta en formato HTTP*/
struct MHD_Response *CrearRespuestaHTTP(const char *message) {
	struct MHD_Response *response;
	response = MHD_create_response_from_buffer(strlen(message), (void *)message, MHD_RESPMEM_PERSISTENT);
	if (!response)
		return NULL;
	MHD_add_response_header(response, "Content-Type", "application/json");
	MHD_add_response_header(response, "Access-Control-Allow-Origin", "*");
	return response;
}

/*
Se usa la funcion "GestorPrincipal" para redirigir las
llamadas en base al tipo de objeto que se esta invocando.

(es similar a los Routers en FastAPI)
*/
enum MHD_Result GestorPrincipal(void *cls, struct MHD_Connection *connection, const char *url, const char *method, const char *version, const char *upload_data, size_t *upload_data_size, void **con_cls) {
	char *url_str = (char *)url;
	char *method_str = (char *)method;
	struct MHD_Response *response;
	HTTP_response response_api;
	LoguearAPI(url_str, method_str);
	int ret;
	if (setjmp(ExceptionBuffer) == 0) {
		if (strcmp(url_str, "/") == 0) {
			response_api = (HTTP_response){
				.body = MensajeSimple("BackEnd activo!"),
				.status = OK
			};
		}
		else if (EsRuta(url_str, "/instrumentos")) {
			response_api = URLInstrumento(url_str, method_str, upload_data);
		}
		else {
			response_api = (HTTP_response){
				.body = MensajeSimple("Not found"),
				.status = NOT_FOUND
			};
		}
	} else {
		response_api = (HTTP_response){
			.body = MensajeSimple("Internal server error"),
			.status = INTERNAL_SERVER_ERROR
		};
		printf("Internal server error");
	}
	response = CrearRespuestaHTTP(response_api.body);
	if (!response)
		return MHD_NO;
	ret = MHD_queue_response(connection, response_api.status, response);
	MHD_destroy_response(response);
	return ret;
}
