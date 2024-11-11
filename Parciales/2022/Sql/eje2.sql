SELECT s.nombre, s.apellido
FROM Socio s 
WHERE s.fecha_ingreso BETWEEN '01/09/2022' AND '30/09/2022'
ORDER BY s.apellido, s.nombre; -- Como no pide criterio de orden desc, lo ordeno default ascendente
