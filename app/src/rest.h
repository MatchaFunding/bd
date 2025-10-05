#ifndef REST_H
#define REST_H

#include <microhttpd.h>
#include "utils.h"

struct MHD_Response *CrearRespuestaHTTP(const char *message);

#endif
