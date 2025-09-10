/*
Agrupacion de multiples empresas y agrupaciones que pretenden postular
en conjunto a un instrumento / fondo comun. A veces puede ser un
requisito para postular a ciertos beneficios.
*/
CREATE TABLE Consorcio (
	ID bigint NOT NULL AUTO_INCREMENT,
	PrimerBeneficiario bigint NOT NULL,
	SegundoBeneficiario bigint NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (PrimerBeneficiario) REFERENCES Beneficiario(ID),
	FOREIGN KEY (SegundoBeneficiario) REFERENCES Beneficiario(ID)
);
