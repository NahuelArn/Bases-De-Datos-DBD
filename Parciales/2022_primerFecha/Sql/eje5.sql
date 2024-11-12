SELECT COUNT(DISTINCT s.nro_socio) AS CANTIDAD_SOCIOS
FROM Socio s
INNER JOIN Prestamo p ON p.nro_socio = s.nro_socio
INNER JOIN Copias c ON C.isbn = p.isbn
WHERE c.estado = 'Bueno' 