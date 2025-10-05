#ifndef REST_H
#define REST_H

#include <microhttpd.h>
#include "utils.h"

struct MHD_Response *HTTP_build_response_JSON(const char *message);

#endif
