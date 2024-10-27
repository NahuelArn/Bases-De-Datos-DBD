-- Listar razón social, dirección y teléfono de barberías que tengan atenciones para el cliente con
--  DNI 22283566. Ordenar por razón social y dirección ascendente.

SELECT b.DNIB, b.nombYApB, b.direccionB, b.telefonoContacto, b.mail
--FROM Barbero b LEFT JOIN Atencion a ON b.codEmpleado = a.codEmpleado --puede no tener atencione, pero si no tiene atencion no tiene valor
FROM Barbero b 
INNER JOIN Atencion a ON b.codEmpleado = a.codEmpleado
WHERE a.valor > 5000