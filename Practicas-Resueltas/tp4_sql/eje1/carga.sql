-- Crear la tabla Cliente
CREATE TABLE Cliente (
    idCliente INTEGER PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    DNI INTEGER,
    telefono VARCHAR(15),
    direccion VARCHAR(50)
);

-- Crear la tabla Factura
CREATE TABLE Factura (
    nroTicket INTEGER PRIMARY KEY,
    total DOUBLE,
    fecha DATE,
    hora TIME,
    idCliente INTEGER,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Crear la tabla Producto
CREATE TABLE Producto (
    idProducto INTEGER PRIMARY KEY,         -- Clave primaria
    nombreP VARCHAR(50) NOT NULL,           -- Nombre del producto
    descripcion VARCHAR(255),               -- Descripción del producto
    precio DOUBLE NOT NULL,                 -- Precio del producto
    stock INTEGER NOT NULL                  -- Stock disponible
);

-- Crear la tabla Detalle
CREATE TABLE Detalle (
    nroTicket INTEGER,                      -- Clave foránea a la tabla Factura
    idProducto INTEGER,                     -- Clave foránea a la tabla Producto
    cantidad INTEGER NOT NULL,              -- Cantidad de productos en la factura
    precioUnitario DOUBLE NOT NULL,         -- Precio unitario en el detalle
    PRIMARY KEY (nroTicket, idProducto),    -- Clave primaria compuesta
    FOREIGN KEY (nroTicket) REFERENCES Factura(nroTicket),  -- Referencia a Factura
    FOREIGN KEY (idProducto) REFERENCES Producto(idProducto) -- Referencia a Producto
);



-- Insertar datos en la tabla Cliente
INSERT INTO Cliente VALUES (1, 'Juan', 'Perez', 12345678, '2211234567', 'Calle 123');
INSERT INTO Cliente VALUES (2, 'Maria', 'Gomez', 23456789, '2212345678', 'Calle 456');
INSERT INTO Cliente VALUES (3, 'Carlos', 'Lopez', 34567890, '2213456789', 'Calle 789');
INSERT INTO Cliente VALUES (4, 'Ana', 'Martinez', 45678901, '2214567890', 'Calle 101');
INSERT INTO Cliente VALUES (5, 'Luis', 'Ramirez', 56789012, '2215678901', 'Calle 202');
INSERT INTO Cliente VALUES (6, 'Sara', 'Fernandez', 67890123, '2216789012', 'Calle 303');

-- Insertar datos en la tabla Factura para diferentes años
INSERT INTO Factura VALUES (1, 1500, '2017-03-15', '10:00:00', 1); -- Solo en 2017
INSERT INTO Factura VALUES (2, 2500, '2017-06-20', '11:30:00', 2); -- Solo en 2017
INSERT INTO Factura VALUES (3, 3200, '2018-05-10', '14:15:00', 3); -- Fuera de 2017
INSERT INTO Factura VALUES (4, 4500, '2017-07-22', '09:00:00', 4); -- Solo en 2017
INSERT INTO Factura VALUES (5, 2800, '2019-09-18', '16:45:00', 5); -- Fuera de 2017
INSERT INTO Factura VALUES (6, 3800, '2020-12-01', '18:00:00', 6); -- Fuera de 2017
INSERT INTO Factura VALUES (7, 2200, '2017-02-28', '08:30:00', 6); -- Solo en 2017

-- Insertar datos en la tabla Producto
INSERT INTO Producto VALUES (1, 'Laptop', 'Laptop Dell Inspiron', 1500.00, 50);
INSERT INTO Producto VALUES (2, 'Smartphone', 'Samsung Galaxy S21', 800.00, 100);
INSERT INTO Producto VALUES (3, 'Teclado', 'Teclado mecánico RGB', 100.00, 200);
INSERT INTO Producto VALUES (4, 'Mouse', 'Mouse Logitech MX', 50.00, 150);
INSERT INTO Producto VALUES (5, 'Monitor', 'Monitor 24 pulgadas', 300.00, 80);

-- Insertar datos en la tabla Detalle
INSERT INTO Detalle VALUES (1, 1, 1, 1); -- Factura 1, Producto 1
INSERT INTO Detalle VALUES (2, 2, 2, 1); -- Factura 2, Producto 2
INSERT INTO Detalle VALUES (3, 3, 3, 2); -- Factura 3, Producto 3
INSERT INTO Detalle VALUES (4, 4, 4, 1); -- Factura 4, Producto 4
INSERT INTO Detalle VALUES (5, 5, 5, 1); -- Factura 5, Producto 5
INSERT INTO Detalle VALUES (6, 6, 1, 1); -- Factura 6, Producto 1
INSERT INTO Detalle VALUES (7, 7, 2, 1); -- Factura 7, Producto 2


INSERT INTO Producto (idProducto, nombreP, descripcion, precio, stock)
VALUES (10, 'Laptop', 'Laptop gaming', 1500, 10),
       (11, 'Mouse', 'Mouse inalámbrico', 50, 200),
       (12, 'Teclado', 'Teclado mecánico', 100, 50);
-- Factura para Pedro Rodríguez (DNI 45789456)
INSERT INTO Factura (nroTicket, total, fecha, hora, idCliente) 
VALUES (10, 1600, '2024-10-25', '10:30:00', 7);

-- Detalles de la factura para Pedro Rodríguez
INSERT INTO Detalle (nroTicket, idProducto, cantidad)
VALUES (10, 10, 1),  -- Pedro compró una Laptop (idProducto 10)
       (10, 11, 2);  -- Pedro compró 2 Mouse (idProducto 11)
-- Cliente Luis Garcia (DNI 87654321)
INSERT INTO Cliente (idCliente, nombre, apellido, dni, telefono, direccion) 
VALUES (8, 'Luis', 'Garcia', 87654321, '2218765432', 'Calle 808');

-- Factura para Luis Garcia
INSERT INTO Factura (nroTicket, total, fecha, hora, idCliente) 
VALUES (11, 2000, '2024-10-20', '12:00:00', 8);

-- Detalles de la factura para Luis Garcia
INSERT INTO Detalle (nroTicket, idProducto, cantidad)
VALUES (11, 10, 1),  -- Garcia compró una Laptop (idProducto 10)
       (11, 12, 1);  -- Garcia compró un Teclado (idProducto 12)


INSERT INTO Cliente (idCliente, nombre, apellido, DNI, telefono, direccion)
VALUES 
(9, 'Pedro', 'Fernandez', 45612378, '2219988776', 'Calle 404'),
(10, 'Martina', 'Gomez', 98765432, '2211234432', 'Avenida 123'),
(11, 'Roberto', 'Castillo', 10111213, '2215566777', 'Calle 505'),
(12, 'Julieta', 'Perez', 44444444, '2211122333', 'Avenida 678'),
(13, 'Emilio', 'Gonzalez', 33333333, '2214433221', 'Calle 321');

INSERT INTO Factura (nroTicket, total, fecha, hora, idCliente)
VALUES 
(12, 1900, '2023-03-01', '09:45:00', 9),  -- Pedro Fernandez
(13, 3200, '2023-05-15', '14:30:00', 10), -- Martina Gomez
(14, 2800, '2023-08-20', '16:50:00', 11), -- Roberto Castillo
(15, 1500, '2023-10-10', '11:20:00', 12), -- Julieta Perez
(16, 2300, '2023-11-05', '17:00:00', 13); -- Emilio Gonzalez

INSERT INTO Producto (idProducto, nombreP, descripcion, precio, stock)
VALUES 
(13, 'Tablet', 'iPad Air 2022', 600.00, 80),
(14, 'Cargador', 'Cargador USB-C 20W', 25.00, 300),
(15, 'Auriculares', 'Sony WH-1000XM4', 300.00, 120),
(16, 'Impresora', 'Impresora HP LaserJet', 350.00, 70),
(17, 'Smartwatch', 'Apple Watch Series 6', 400.00, 150);

INSERT INTO Detalle (nroTicket, idProducto, cantidad, precioUnitario)
VALUES 
-- Factura 12 (Pedro Fernandez)
(12, 13, 1, 600.00),  -- Compró 1 Tablet
(12, 14, 2, 25.00),   -- Compró 2 Cargadores

-- Factura 13 (Martina Gomez)
(13, 15, 1, 300.00),  -- Compró 1 Auricular
(13, 16, 1, 350.00),  -- Compró 1 Impresora

-- Factura 14 (Roberto Castillo)
(14, 17, 1, 400.00),  -- Compró 1 Smartwatch
(14, 15, 1, 300.00),  -- Compró 1 Auricular

-- Factura 15 (Julieta Perez)
(15, 13, 2, 600.00),  -- Compró 2 Tablets

-- Factura 16 (Emilio Gonzalez)
(16, 14, 3, 25.00),   -- Compró 3 Cargadores
(16, 16, 1, 350.00);  -- Compró 1 Impresora
