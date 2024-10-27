-- 1. Listar DNI, nombre y apellido, dirección, fecha de nacimiento y celular de clientes que no tengan
--  atenciones durante 2024.

SELECT DISTINCT c.DNI, c.nomYAp, c.direccionC, c.fechaNacimiento, c.celular
FROM Cliente c
WHERE c.nroCliente NOT IN (
	SELECT a.nroCliente 
	FROM Atencion a
	WHERE a.fecha BETWEEN '01-01-2024' AND '31-12-2024'
);