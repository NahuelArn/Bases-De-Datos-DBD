-- 1. Listar especie, años, calle, nro y localidad de árboles podados por el podador ‘Juan Perez’ y por
--  el podador ‘Jose Garcia’.

--v1 UNICA combinacion valida (de este estilo), si se hace el producto natural en otro ORDEN produce redundancia e incumpliento del enunciado
SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Podador p
INNER JOIN Poda pod ON p.DNI = pod.DNI
INNER JOIN Arbol a ON a.nroArbol = pod.nroArbol
INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal 
WHERE p.nombre = 'Juan' and p.apellido = 'Perez' and a.nroArbol IN (
	SELECT a.nroArbol
	FROM Podador p
	INNER JOIN Poda pod ON p.DNI = pod.DNI
	INNER JOIN Arbol a ON a.nroArbol = pod.nroArbol
	INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal 
	WHERE p.nombre = 'Jose' and p.apellido = 'Garcia'
)

--v2 mas clean

SELECT a.especie, a.años, a.calle, a.nro, l.nombreL
FROM Arbol a
INNER JOIN Localidad l ON a.codigoPostal = l.codigoPostal
--solo entra con los match con nroArbol =......... (ConjuntoA ∩ ConjuntoB) Proyeccion only match nroArbol
WHERE a.nroArbol IN ( 
    SELECT a1.nroArbol
    FROM Podador p1
    INNER JOIN Localidad l1 ON p1.codigoPostalVive = l1.codigoPostal
    INNER JOIN Arbol a1 ON a1.codigoPostal = l1.codigoPostal
    WHERE (p1.nombre = 'Juan' AND p1.apellido = 'Perez')
    INTERSECT
    SELECT a2.nroArbol
    FROM Podador p2
    INNER JOIN Localidad l2 ON p2.codigoPostalVive = l2.codigoPostal
    INNER JOIN Arbol a2 ON a2.codigoPostal = l2.codigoPostal
    WHERE (p2.nombre = 'Jose' AND p2.apellido = 'Garcia')
);
