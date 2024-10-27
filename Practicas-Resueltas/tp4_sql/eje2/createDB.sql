CREATE TABLE Localidad (
    codigoPostal INT PRIMARY KEY,
    nombreL VARCHAR(100),
    descripcion TEXT,
    habitantes INT
);

CREATE TABLE Arbol (
    nroArbol INT PRIMARY KEY,
    especie VARCHAR(100),
    años INT,
    calle VARCHAR(100),
    nro INT,
    codigoPostal INT,
    FOREIGN KEY (codigoPostal) REFERENCES Localidad(codigoPostal)
);

CREATE TABLE Podador (
    DNI INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(20),
    fnac DATE,
    codigoPostalVive INT,
    FOREIGN KEY (codigoPostalVive) REFERENCES Localidad(codigoPostal)
);

CREATE TABLE Poda (
    codPoda INT PRIMARY KEY,
    fecha DATE,
    DNI INT,
    nroArbol INT,
    FOREIGN KEY (DNI) REFERENCES Podador(DNI),
    FOREIGN KEY (nroArbol) REFERENCES Arbol(nroArbol)
);
