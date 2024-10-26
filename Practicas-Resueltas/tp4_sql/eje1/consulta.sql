-- 1. Listar datos personales de clientes cuyo apellido comience con el string ‘Pe’. Ordenar por DNI

SELECT * --Columnas a seleccionar
FROM Cliente  --Tabla a seleccionar
WHERE (apellido LIKE 'Pe%') ORDER BY dni; --Condicion de seleccion

--===================================================================================================

-- 2. Listar nombre, apellido, DNI, teléfono y dirección de clientes que realizaron compras solamente durante 2017.

SELECT nombre, apellido, dni, telefono, direccion
FROM Cliente c INNER JOIN Factura f ON c.idCliente = f.idCliente  --aplica |x| donde c.idCliente = f.idCliente
WHERE f.fecha BETWEEN '2017-01-01' AND '2017-12-31' --aplica |x| donde f.fecha entre '2017-01-01' y '2017-12-31'

EXCEPT --diferencia

SELECT c.nombre, c.apellido, c.dni, c.telefono, c.direccion
FROM Cliente c 
INNER JOIN Factura f ON c.idCliente = f.idCliente
WHERE f.fecha < '2017-01-01' OR f.fecha > '2017-12-31';

--===================================================================================================

-- 3. Listar nombre, descripción, precio y stock de productos vendidos al cliente con DNI 45789456,
-- pero que no fueron vendidos a clientes de apellido ‘Garcia’.

-- Aplico subconsulta
SELECT p.nombreP, p.descripcion, p.precio, p.stock  --Selecciono las columnas a mostrar
FROM Producto p --Tabla a seleccionar
--Selecciona los detalles de productos, para los id obtenidos en subconsulta(en la resta)
WHERE p.idProducto IN ( 
    SELECT p.idProducto
    FROM Producto p
    INNER JOIN Detalle d ON p.idProducto = d.idProducto
    INNER JOIN Factura f ON d.nroTicket = f.nroTicket
    INNER JOIN Cliente c ON f.idCliente = c.idCliente
    WHERE c.dni = 45789456
    EXCEPT
    SELECT p.idProducto
    FROM Producto p
    INNER JOIN Detalle d ON p.idProducto = d.idProducto
    INNER JOIN Factura f ON d.nroTicket = f.nroTicket
    INNER JOIN Cliente c ON f.idCliente = c.idCliente
    WHERE c.apellido = 'Garcia'
);

--===================================================================================================

--  4. Listar nombre, descripción, precio y stock de productos no vendidos a clientes que tengan
--  teléfono con característica 221 (la característica está al comienzo del teléfono). Ordenar por
--  nombre.
--V1
--mas orientado a algebra relacional
SELECT p.nombreP, p.descripcion, p.precio, p.stock
FROM Producto p 

EXCEPT

SELECT p.nombreP, p.descripcion, p.precio, p.stock
FROM Producto p 
INNER JOIN Detalle d ON p.idProducto = d.idProducto
INNER JOIN Factura f ON d.nroTicket = f.nroTicket
INNER JOIN Cliente c ON d.idCliente = c.idCliente
WHERE c.telefono LIKE '221%'

ORDER BY p.nombreP;


--V2
SELECT nombreP, descripcion, precio, stock
FROM Producto p
--El not IN, se queda con todos los Productos que no esten en la subconsulta (lo q esta entre () )
WHERE idProducto NOT IN (
  SELECT p.idProducto
  FROM Producto p 
  INNER JOIN Detalle d ON (p.idProducto = d.idProducto)
  INNER JOIN Factura f ON (d.nroTicket = f.nroTicket) 
  INNER JOIN Cliente c ON (f.idCliente =  c.idCliente)
  WHERE (c.telefono LIKE "221%")
)
ORDER BY p.nombreP, p.idProducto


--===================================================================================================

-- 5. Listar para cada producto nombre, descripción, precio y cuantas veces fue vendido. Tenga en
--  cuenta que puede no haberse vendido nunca el producto.

SELECT p.nombreP, p.descripcion, p.precio, p.stock, SUM(d.cantidad) AS cantidad --Selecciono las columnas a mostrar
FROM Producto p --Tabla a arrancar
INNER JOIN Detalle d ON p.idProducto = d.idProducto --aplica |x| donde p.idProducto = d.idProducto
GROUP BY p.idProducto, p.nombreP, p.descripcion, p.precio, p.stock --con esto agrupo la cantidad de productos vendidos SUM(d.cantidad)

--  6. Listar nombre, apellido, DNI, teléfono y dirección de clientes que compraron los productos con
--  nombre ‘prod1’ y ‘prod2’ pero nunca compraron el producto con nombre ‘prod3’.

--v1 algebra relacional mental

-- Subconsulta para obtener IDs de clientes que compraron 'prod1'
WITH clientes_prod1 AS (
    SELECT DISTINCT v.id_cliente
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    WHERE p.nombre = 'prod1'
),

-- Subconsulta para obtener IDs de clientes que compraron 'prod2'
clientes_prod2 AS (
    SELECT DISTINCT v.id_cliente
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    WHERE p.nombre = 'prod2'
),

-- Subconsulta para obtener IDs de clientes que compraron 'prod3'
clientes_prod3 AS (
    SELECT DISTINCT v.id_cliente
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    WHERE p.nombre = 'prod3'
)

-- Consulta final para obtener la intersección y la diferencia
SELECT c.nombre, c.apellido, c.dni, c.telefono, c.direccion
FROM clientes c
WHERE c.id_cliente IN (
    SELECT id_cliente FROM clientes_prod1
    INTERSECT
    SELECT id_cliente FROM clientes_prod2
) 
AND c.id_cliente NOT IN (
    SELECT id_cliente FROM clientes_prod3
);


--v2 --mas orientado a sql
SELECT c.nombre, c.apellido, c.dni, c.telefono, c.direccion -- esto es lo que se va a mostrar
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente
JOIN productos p ON v.id_producto = p.id_producto
WHERE p.nombre IN ('prod1', 'prod2', 'prod3') --si el producto es prod1 o prod2 o prod3 entra (se queda con esa tabla los campos del select)
GROUP BY c.id_cliente, c.nombre, c.apellido, c.dni, c.telefono, c.direccion --agrupa por los campos del select para un ID de cliente
-- Para cada ID (grupo) de cliente, se fija si aparece prod1 y prod2, pero no prod3
HAVING COUNT(CASE WHEN p.nombre = 'prod1' THEN 1 END) > 0 --Si en el grupo aparece prod1 N veces, entra y se queda con ese grupo
   AND COUNT(CASE WHEN p.nombre = 'prod2' THEN 1 END) > 0 --Si en el grupo aparece prod2 N veces, entra y se queda con ese mismo grupo
   AND COUNT(CASE WHEN p.nombre = 'prod3' THEN 1 END) = 0;  --Si en el grupo aparece prod3 N veces, no entra y no se queda con ese grupo

--v3 con subconsulta
SELECT c.nombre, c.apellido, c.dni, c.telefono, c.direccion
FROM cliente c
INNER JOIN factura f ON f.idCliente = c.idCliente
INNER JOIN detalle d ON d.nroTicket = f.nroTicket
INNER JOIN producto pr ON pr.idProducto = d.idProducto
WHERE pr.nombreP IN ('prod1', 'prod2')
AND c.idCliente NOT IN (
    SELECT c.idCliente
    FROM cliente c 
    INNER JOIN factura f ON f.idCliente = c.idCliente
    INNER JOIN detalle d ON d.nroTicket = f.nroTicket
    INNER JOIN producto pr ON pr.idProducto = d.idProducto	
    WHERE pr.nombreP = 'prod3'
)
GROUP BY c.idCliente, c.nombre, c.apellido, c.dni, c.telefono, c.direccion
HAVING COUNT(DISTINCT pr.nombreP) = 2
   AND SUM(CASE WHEN pr.nombreP = 'prod1' THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN pr.nombreP = 'prod2' THEN 1 ELSE 0 END) > 0;

--===================================================================================================

--  7. Listar nroTicket, total, fecha, hora y DNI del cliente, de aquellas facturas donde se haya
-- comprado el producto ‘prod38’ o la factura tenga fecha de 2019.

--v1 menos eficiente, hago 2 consultas a nivel de datos

SELECT f.nroTicket, f.total, f.fecha, c.DNI 
FROM Producto p
INNER JOIN Detalle d ON d.idProducto = p.idProducto
INNER JOIN Factura f ON f.nroTicket = d.nroTicket
INNER JOIN Cliente c ON c.idCliente = f.idCliente
WHERE p.nombreP = 'prod38' or f.fecha IN (
	SELECT f.fecha
	FROM Factura f
	WHERE f.fecha BETWEEN '01-01-2019' AND '31-12-2019' 
) 

--v2 sin subconsulta, hago una consulta y filtrado sobre 1 sola consulta

SELECT f.nroTicket, f.total, f.fecha, c.DNI 
FROM Producto p
INNER JOIN Detalle d ON d.idProducto = p.idProducto
INNER JOIN Factura f ON f.nroTicket = d.nroTicket
INNER JOIN Cliente c ON c.idCliente = f.idCliente
WHERE p.nombreP = 'prod38' 
   OR f.fecha BETWEEN '2019-01-01' AND '2019-12-31';

--===================================================================================================

-- 8.Agregar un cliente con los siguientes datos: nombre:’Jorge Luis’, apellido:’Castor’, DNI:
--  40578999, teléfono: ‘221-4400789’, dirección:’11 entre 500 y 501 nro:2587’ y el id de cliente:
--  500002. Se supone que el idCliente 500002 no existe.

INSERT INTO Cliente (idCliente, nombre, apellido, DNI, telefono, direccion) VALUES (500002, 'Jorge Luis', 'Castor', 40578999, '221-4400789', '11 entre 500 y 501 nro:2587')

--===================================================================================================

-- 9. Listar nroTicket, total, fecha, hora para las facturas del cliente ´Jorge Pérez´ donde no haya
--  comprado el producto ´Z´.

SELECT f.nroTicket, f.total, f.fecha, f.hora
FROM Factura f
INNER JOIN Cliente c ON c.idCliente = f.idCliente
WHERE c.nombre = 'Jorge' and c.apellido = 'Perez' AND c.idCliente NOT IN(
	SELECT f.idCliente	--va matchear con c.idCliente y f.idCliente... tienen que ser el mismo se refiere a una factura de un cliente
	FROM Producto p
	INNER JOIN Detalle d ON d.idProducto = p.idProducto
	INNER JOIN Factura f ON f.nroTicket = d.nroTicket --en este punto ya puedo sacar el idCliente
	WHERE p.nombreP = 'Z'
)

--===================================================================================================

-- 10. Listar DNI, apellido y nombre de clientes donde el monto total comprado, teniendo en cuenta
--  todas sus facturas, supere $10.000.000.

SELECT c.DNI, c.nombre, c.apellido
FROM Cliente c
WHERE c.idCliente IN (
	SELECT f.idCliente
	FROM Factura f
	-- WHERE f.total > 0
	GROUP BY f.idCliente --, SUM (f.total) AS totalSuma NO VA, aca recien esta agrupando
	HAVING SUM (f.total) > 10000000 --De todo el grupo armado por Group BY, sumame los totales... si es >10mill? return f.id: ignorar 
)