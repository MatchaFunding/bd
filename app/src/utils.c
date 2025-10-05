#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "utils.h"

char *SimpleMessage(const char *message_str) {
	char *formatted_message = NULL;
	size_t formatted_message_size = strlen(message_str) + 20;
	formatted_message = (char *)malloc(formatted_message_size);
	if (formatted_message)
		snprintf(formatted_message, formatted_message_size, "{\"message\": \"%s\"}", message_str);
	return formatted_message;
}

bool ValidateRoute(const char *url, char *route) {
	return strstr(url, route) != NULL;
}

bool ValidateMethod(const char *method, char *valid_method) {
	return strcmp(method, valid_method) == 0;
}

HTTP_response ValidateResult(char *result) {
	if (result == NULL) {
		return (HTTP_response){
			.body = SimpleMessage("Internal server error"),
			.status = INTERNAL_SERVER_ERROR
		};
	}
	return (HTTP_response){
		.body = result,
		.status = OK
	};
}
