--  6. Eliminar los entrenamientos del entrenador ‘Juan Perez’.
DELETE FROM Entrenamiento WHERE idEntrenador IN (
  SELECT e.IdEntrenador
  FROM Entrenador e
  INNER JOIN Entrenador ee ON ee.IdEntrenador = e.IdEntrenador 
  WHERE e.nombreEntrenador = 'Juan Perez'
)