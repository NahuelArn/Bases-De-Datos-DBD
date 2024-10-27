-- Listar DNI, nombYAp, direccionC, fechaNacimiento y celular de clientes que tengan atenciones
--  en la barbería con razón social: ‘Corta barba’ y también se hayan atendido en la barbería con
--  razón social: ‘Barberia Barbara’.

SELECT c.DNI, c.nombYAp, c.direccionC, c.fechaNacimiento, c.celular
FROM Cliente c 
INNER JOIN Atencion a ON c.nroCliente = a.nroCliente
INNER JOIN Barberia b ON a.codBarberia = b.codBarberia
WHERE b.razon_social = "Corta barba"

INTERSECT 

SELECT c.DNI, c.nombYAp, c.direccionC, c.fechaNacimiento, c.celular
FROM Cliente c INNER JOIN Atencion a ON c.nroCliente = a.nroCliente
INNER JOIN Barberia b ON a.codBarberia = b.codBarberia
WHERE b.razon_social = 'Barberia Barbara'
