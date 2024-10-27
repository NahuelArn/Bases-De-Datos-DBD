-- Reportar DNI, nombre, apellido, fecha de nacimiento y localidad donde viven de aquellos
--  podadores con apellido terminado con el string ‘ata’ y que tengan al menos una poda durante
--  2024. Ordenar por apellido y nombre.

--v1 logica de + innecesaria
SELECT  DISTINCT p.DNI, p.nombre, p.apellido, p.fnac, l.nombreL
FROM Poda po
INNER JOIN Podador p ON p.DNI = po.DNI
INNER JOIN Localidad l ON l.codigoPostal = p.codigoPostalVive
INNER JOIN Arbol a ON po.nroArbol = a.nroArbol

WHERE p.apellido LIKE '%ata' AND po.fecha BETWEEN '01-01-2024' AND '31-12-2024'
GROUP BY p.DNI, p.nombre, p.apellido, p.fnac, l.nombreL
HAVING COUNT(po.nroArbol) > 0
ORDER BY p.apellido, p.nombre

--v2 como te pide al menos una, con el where te aseguras que se va mostrar si se encuentra alguna poda
SELECT DISTINCT p.DNI, p.nombre, p.apellido, p.fnac, l.nombreL
FROM Podador p
INNER JOIN Poda po ON po.DNI = p.DNI
INNER JOIN Localidad l ON l.codigoPostal = p.codigoPostalVive
WHERE p.apellido LIKE '%ata' 
AND po.fecha BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY p.apellido, p.nombre;
