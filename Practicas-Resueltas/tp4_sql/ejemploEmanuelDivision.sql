--Necesito las tablas.... 
-- mal Sucursal, Cliente, Cuenta

-- CLiente, PropietarioCuenta, Cuenta
SELECT c.codCliente, c.dni, c.nombreCliente
FROM Cliente c
WHERE NOT EXISTS (
	SELECT *
	FROM PropietarioCuenta p 
	WHERE NOT EXISTS (
		SELECT *
		FROM Cuenta cu 
		INNER JOIN Sucursal su ON cu.nombreSucursal = su.nombreSucursal
		WHERE c.codCliente = p.codCliente AND cu.nroCuenta = p.nroCuenta
	)
)