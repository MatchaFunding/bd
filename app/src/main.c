#include <stdio.h>
#include <string.h>
#include <microhttpd.h>
#include <unistd.h>
#include <curl/curl.h>
#include "handler.h"

#define PORT 8080

int main() {
	printf("Levantando Back-End de MatchaFunding...\n");
	struct MHD_Daemon *daemon;
	daemon = MHD_start_daemon(MHD_USE_THREAD_PER_CONNECTION, PORT, NULL, NULL, &DefaultHandler, NULL, MHD_OPTION_END);
	while (1) {
		sleep(1);
	}
	MHD_stop_daemon(daemon);
	return 0;
}
