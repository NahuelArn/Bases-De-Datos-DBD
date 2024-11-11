-- aca asumo que el nombre "Nueva editorial" es Denominacion en la tabla EDITORIAL

--Voy a necesitar las tablas Libro, Genero y Editorial

--Libro--> Libro-Editorial--> Editorial--Genero


--Redundate la subconsulta se puede meter un where e.denominacion = 'Nueva Editorial' directamente
SELECT l.titulo, g.nombre_genero, l.descripcion
FROM Libro l
INNER JOIN Libro_Editorial le ON le.isbn = l.isbn
INNER JOIN Editorial e ON e.cod_editorial = le.cod_editorial
INNER JOIN Genero g ON g.cod_genero = l.cod_genero

WHERE e.cod_editorial IN (
  SELECT e.cod_editorial
  FROM Editorial e
  WHERE e.denominacion = 'Nueva Editorial'
)
ORDER BY l.titulo;



--Clean
SELECT l.titulo, g.nombre_genero, l.descripcion
FROM Libro l
INNER JOIN Libro_Editorial le ON le.isbn = l.isbn
INNER JOIN Editorial e ON e.cod_editorial = le.cod_editorial
INNER JOIN Genero g ON g.cod_genero = l.cod_genero
WHERE e.denominacion = 'Nueva Editorial'
ORDER BY l.titulo;