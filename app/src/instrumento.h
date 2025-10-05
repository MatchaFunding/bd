#ifndef INSTRUMENTO_H
#define INSTRUMENTO_H

#include "utils.h"

HTTP_response VerTodosLosInstrumentos(const char *url);
HTTP_response ObtenerInstrumento(const char *id);
HTTP_response CrearInstrumento(const char *body);
HTTP_response CambiarInstrumento(const char *id, const char *body);
HTTP_response BorrarInstrumento(const char *id);
HTTP_response URLInstrumento(const char *url, const char *method, const char *body);

#endif
