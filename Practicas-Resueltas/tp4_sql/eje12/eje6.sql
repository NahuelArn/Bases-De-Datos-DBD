--  6. Eliminar el cliente con DNI 22222222.

--CASCADAAA

DELETE FROM Atencion WHERE nroCliente IN (
    SELECT c.nroCliente
    FROM Cliente c
    WHERE dni= '22222222'
)


DELETE FROM Cliente WHERE dni="22222222";