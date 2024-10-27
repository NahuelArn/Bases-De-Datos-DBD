-- Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
--  podadores que tengan podas realizadas durante 2023.

SELECT DISTINCT p.DNI, p.nombre, p.apellido, p.fnac, l.nombreL
FROM Podador p
INNER JOIN Localidad l ON l.codigoPostal = p.codigoPostalVive
INNER JOIN Poda pod ON pod.DNI = p.DNI
WHERE pod.fecha BETWEEN '01-01-2023' AND '31-12-2023';
