--  3. Listar especie, años, calle, nro y localidad de árboles que no fueron podados nunca.

SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Arbol a
INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
WHERE a.nroArbol NOT IN(
	SELECT p.nroArbol
	FROM Poda p
)