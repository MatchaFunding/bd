#include "rest.h"
#include "instrumento.h"
#include <setjmp.h>
#include "handler.h"

jmp_buf exceptionBuffer;

/*
Muestra por pantalla la request solicitada por el cliente
*/
void LoguearAPI(const char *url, const char *method) {
	printf("[%s] %s\n", method, url);
}

/*
Rutea las llamadas desde el cliente hacia el controlador correspondiente
*/
enum MHD_Result GestorPrincipal(void *cls, struct MHD_Connection *connection,  const char *url, const char *method, const char *version, const char *upload_data, size_t *upload_data_size, void **con_cls) {
	char *url_str = (char *)url;
	char *method_str = (char *)method;
	struct MHD_Response *response;
	HTTP_response response_api;
	LoguearAPI(url_str, method_str);
	int ret;
	if (setjmp(exceptionBuffer) == 0) {
		if (strcmp(url_str, "/") == 0) {
			response_api = (HTTP_response){
				.body = MensajeSimple("BackEnd activo!"),
				.status = OK
			};
		}
		else if (ValidarRuta(url_str, "/instrumentos")) {
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
