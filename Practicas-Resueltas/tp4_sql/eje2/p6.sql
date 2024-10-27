-- 6. Listar DNI, apellido, nombre, teléfono y fecha de nacimiento de podadores que solo podaron
--  árboles de especie ‘Coníferas’.

SELECT DISTINCT p.DNI, p.apellido, p.nombre, p.telefono, p.fnac
FROM Podador p
WHERE p.DNI IN (
  SELECT p.DNI
  FROM Podador p
  INNER JOIN Poda po ON po.DNI = p.DNI 
  INNER JOIN Arbol a ON a.nroArbol = p.nroArbol
  WHERE a.especie = 'Coníferas'
  
  EXCEPT

  SELECT p.DNI
  FROM Podador p
  INNER JOIN Poda po ON po.DNI = p.DNI 
  INNER JOIN Arbol a ON a.nroArbol = p.nroArbol
  WHERE a.especie <> 'Coníferas'
)