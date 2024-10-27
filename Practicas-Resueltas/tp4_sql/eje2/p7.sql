-- 7. Listar especies de árboles que se encuentren en la localidad de ‘La Plata’ y también en la
--  localidad de ‘Salta’.
SELECT DISTINCT a.especie
FROM Arbol a
WHERE a.nroArbol IN (
  SELECT a.nroArbol 
  FROM Arbol a 
  INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
  WHERE l.nombreL = 'La Plata'
  
  INTERSECT

  SELECT a.nroArbol
  FROM Arbol a
  INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
  WHERE l.nombreL = 'Salta'
)

--v2
-- forkeas otra version desde la misma tabla
SELECT DISTINCT a.especie
FROM Arbol a
INNER JOIN Localidad l1 ON l1.codigoPostal = a.codigoPostal
INNER JOIN Localidad l2 ON l2.codigoPostal = a.codigoPostal
WHERE l1.nombreL = 'La Plata' AND l2.nombreL = 'Salta';


--Inventado____ Listar especies de árboles que se encuentren SOLO en la localidad de ‘La Plata’ y también en la
--  localidad de ‘Salta’.
SELECT DISTINCT a.especie
FROM Arbol a
INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
WHERE a.nroArbol IN (
  SELECT a.nroArbol 
  FROM Arbol a 
  INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
  WHERE l.nombreL = 'La Plata'
  
  INTERSECT

  SELECT a.nroArbol
  FROM Arbol a
  INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
  WHERE l.nombreL = 'Salta'
)
AND a.nroArbol NOT IN (
  SELECT a.nroArbol 
  FROM Arbol a 
  INNER JOIN Localidad l ON l.codigoPostal = a.codigoPostal
  WHERE l.nombreL NOT IN ('La Plata', 'Salta')
);
