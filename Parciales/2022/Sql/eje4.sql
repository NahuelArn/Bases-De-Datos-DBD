--Necesito estos puentes

--Socio -->Prestamo-->Libro-Editorial-->Editorial

SELECT s.dni, s.nombre, s.apellido
FROM Socio s
-- INNER JOIN Prestamo p ON p.nro_socio = s.nro_socio
-- INNER JOIN Libro-Editorial le ON le.isbn = p.isbn
-- INNER JOIN Editorial e ON e.cod_editorial = le.cod_editorial
WHERE s.nro_socio NOT IN (
  SELECT s.nro_socio
  FROM Socio s
  INNER JOIN Prestamo p ON p.nro_socio = s.nro_socio
  INNER JOIN Libro-Editorial le ON le.isbn = p.isbn
  INNER JOIN Editorial e ON e.cod_editorial = le.cod_editorial
  WHERE e.denominacion = 'Gran Editorial'
)




--Socio -->Prestamo-->Libro-Editorial-->Editorial

SELECT s.dni, s.nombre, s.apellido
FROM Socio s
WHERE s.nro_socio NOT IN (
  SELECT s.nro_socio
  FROM Socio s
  INNER JOIN Prestamo p ON p.nro_socio = s.nro_socio
  INNER JOIN Libro-Editorial le ON le.isbn = p.isbn
  INNER JOIN Editorial e ON e.cod_editorial = le.cod_editorial
  WHERE e.denominacion = 'Gran Editorial'
)
ORDER BY s.apellido, s.nombre;