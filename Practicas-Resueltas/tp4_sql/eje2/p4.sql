--  4. Reportar especie, años,calle, nro y localidad de árboles que fueron podados durante 2022 y no
--  fueron podados durante 2023.

SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Poda p
INNER JOIN Arbol a ON a.nroArbol = p.nroArbol
INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
WHERE p.fecha BETWEEN '01-01-2022' AND '31-12-2022' AND a.nroArbol NOT IN(
	SELECT a.nroArbol
	FROM Poda p
	INNER JOIN Arbol a ON a.nroArbol = p.nroArbol
	WHERE p.fecha BETWEEN '01-01-2023' AND '31-12-2023'
)