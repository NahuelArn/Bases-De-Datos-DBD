-- Listar razón social, dirección y teléfono de barberías que tengan atenciones para el cliente con
--  DNI 22283566. Ordenar por razón social y dirección ascendente.

SELECT DISTINCT b.razon_social, b.direccion, b.telefono
FROM Barberia b INNER JOIN Atencion a ON b.codBarberia = a.codBarberia
    INNER JOIN Cliente c ON a.nroCliente = c.nroCliente
WHERE c.DNI = '22283566'
ORDER BY b.razon_social, b.direccion ASC