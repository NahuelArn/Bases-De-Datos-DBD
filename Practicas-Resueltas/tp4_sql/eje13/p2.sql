-- Listar para cada cancha del complejo “Complejo 1”, la cantidad de entrenamientos que se
--  realizaron durante el 2022. Informar nombre de la cancha y cantidad de entrenamientos.

-- v2
SELECT c.nombreCancha, COUNT(*) AS cantidadDeEntrenamientos
FROM Complejo comp
INNER JOIN Cancha c ON c.idComplejo = comp.idComplejo
LEFT JOIN Entrenamiento e ON e.IdCancha = c.IdCancha  --La cancha puede tener 0 entrenamients

WHERE comp.nombreComplejo = 'Complejo 1' AND e.fecha BETWEEN '01-01-2022' AND '31-12-2022'
GROUP BY c.IdCancha, c.nombreCancha


-- v1
SELECT DISTINCT c.nombreCancha, COUNT(c.idCancha) AS cantidadDeEntrenamientos
FROM Complejo comp
INNER JOIN Cancha c ON c.idComplejo = comp.idComplejo
LEFT JOIN Entrenamiento e ON e.IdCancha = c.IdCancha  --La cancha puede tener 0 entrenamients

WHERE comp.nombreComplejo = 'Complejo 1' AND e.fecha BETWEEN '01-01-2022' AND '31-12-2022'
GROUP BY c.IdCancha
-- HAVING COUNT(*)