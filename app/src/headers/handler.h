#ifndef HANDLER_H
#define HANDLER_H
#include <setjmp.h>

void LoguearAPI(const char *url, const char *method);
struct MHD_Response *CrearRespuestaHTTP(const char *message);
enum MHD_Result GestorPrincipal(void *cls, struct MHD_Connection *connection, const char *url, const char *method, const char *version, const char *upload_data, size_t *upload_data_size, void **con_cls); 

#endif
