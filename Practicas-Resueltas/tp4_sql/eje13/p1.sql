-- Listar nombre, fecha de nacimiento y dirección de entrenadores que hayan tenido
--  entrenamientos durante 2023.

SELECT DISTINCT e.nombreEntrenador, e.fechaNacimiento, e.direccion
FROM Entrenador e
INNER JOIN Entrenamiento ent ON ent.IdEntrenador = e.IdEntrenador
WHERE ent.fecha BETWEEN '01-01-2023' AND '31-12-2023';