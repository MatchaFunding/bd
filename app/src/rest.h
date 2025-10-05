#ifndef REST_H
#define REST_H

#include <microhttpd.h>
#include "utils.h"

struct MHD_Response *HTTPBuildResponseJSON(const char *message);

#endif
