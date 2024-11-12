SELECT nombre, apellido, dni, telefono, direccion
FROM Cliente c INNER JOIN Factura f ON c.idCliente = f.idCliente  --aplica |x| donde c.idCliente = f.idCliente
WHERE f.fecha BETWEEN '2017-01-01' AND '2017-12-31' --aplica |x| donde f.fecha entre '2017-01-01' y '2017-12-31'

EXCEPT --diferencia

SELECT c.nombre, c.apellido, c.dni, c.telefono, c.direccion
FROM Cliente c 
INNER JOIN Factura f ON c.idCliente = f.idCliente
WHERE f.fecha < '2017-01-01' OR f.fecha > '2017-12-31';


--===============
-- UNION: Clientes que tienen facturas en 2017 O en 2018
SELECT nombre, apellido, dni, telefono, direccion
FROM Cliente c 
INNER JOIN Factura f ON c.idCliente = f.idCliente
WHERE f.fecha BETWEEN '2017-01-01' AND '2017-12-31'

UNION  -- Combina los resultados eliminando duplicados

SELECT nombre, apellido, dni, telefono, direccion
FROM Cliente c 
INNER JOIN Factura f ON c.idCliente = f.idCliente
WHERE f.fecha BETWEEN '2018-01-01' AND '2018-12-31';


--===============
-- INTERSECT: Clientes que tienen facturas TANTO en 2017 COMO en 2018
SELECT nombre, apellido, dni, telefono, direccion
FROM Cliente c 
INNER JOIN Factura f ON c.idCliente = f.idCliente
WHERE f.fecha BETWEEN '2017-01-01' AND '2017-12-31'

INTERSECT  -- Muestra solo los registros que aparecen en ambas consultas

SELECT nombre, apellido, dni, telefono, direccion
FROM Cliente c 
INNER JOIN Factura f ON c.idCliente = f.idCliente
WHERE f.fecha BETWEEN '2018-01-01' AND '2018-12-31';

-- Diferencias clave:
-- UNION: devuelve todos los registros que aparecen en cualquiera de las consultas
-- INTERSECT: devuelve solo los registros que aparecen en ambas consultas
-- EXCEPT: devuelve los registros de la primera consulta que no aparecen en la segunda
-- Nota: También existe UNION ALL que mantiene los duplicados, a diferencia de UNION que los elimina