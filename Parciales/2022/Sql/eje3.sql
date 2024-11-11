SELECT s.nombre, s.apellido, s.fecha_nacimiento, COUNT(*) AS cantidad_prestamos
FROM Socio s
INNER JOIN Prestamo p ON p.nro_socio = s.nro_socio
GROUP BY s.nro_socio, s.nombre, s.apellido, s.fecha_nacimiento
HAVING COUNT(*) > 5
ORDER BY s.apellido