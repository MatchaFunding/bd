#ifndef INSTRUMENTO_H
#define INSTRUMENTO_H

#include "utils.h"

typedef struct {
	long long ID;
	char Titulo[200];
	long long Financiador;
	long long Alcance;
	char Descripcion[1000];
	char FechaDeApertura[10];
	char FechaDeCierre[10];
	int DuracionEnMeses;
	char Beneficios[1000];
	char Requisitos[1000];
	int MontoMinimo;
	int MontoMaximo;
	long long Estado;
	long long TipoDeBeneficio;
	long long TipoDePerfil;
	char Proposito[1000];
	char ObjetivoGeneral[1000];
	char ObjetivoEspecifico[1000];
	char ResultadoEsperado[1000];
	char EnlaceDelDetalle[300];
	char EnlaceDeLaFoto[300];
} Instrumento;

HTTP_response VerTodosLosInstrumentos(const char *url);
HTTP_response ObtenerInstrumento(const char *id);
HTTP_response CrearInstrumento(const char *body);
HTTP_response CambiarInstrumento(const char *id, const char *body);
HTTP_response BorrarInstrumento(const char *id);
HTTP_response URLInstrumento(const char *url, const char *method, const char *body);

#endif
