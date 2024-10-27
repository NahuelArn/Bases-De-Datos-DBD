-- Listar para cada barbero cantidad de atenciones que realizaron durante 2023. Listar DNI,
--  nombre y apellido, dirección, teléfono de contacto, mail y cantidad de atenciones.

SELECT b.DNIB, b.nombYApB, b.direccionB, b.telefonoContacto, b.mail, COUNT(*) as Atenciones
FROM Barbero b 
LEFT JOIN Atencion a ON b.codEmpleado = a.codEmpleado
WHERE a.fecha BETWEEN "01/01/2023" AND "31/12/2023"
GROUP BY b.codEmpleado, b.DNIB, b.nombYApB, b.direccionB, b.telefonoContacto, b.mail