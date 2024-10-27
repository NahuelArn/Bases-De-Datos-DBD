--  4. Listar nombre, fecha de nacimiento y dirección de entrenadores que hayan entrenado en los
--  clubes con nombre “Everton” y “Estrella de Berisso”.

SELECT e.nombreEntrenador, e.fechaNacimiento, e.direccion
FROM Entrenador e 
INNER JOIN Entrenamiento en ON en.IdEntrenador = e.IdEntrenador
INNER JOIN Cancha can ON can.IdCancha = en.IdCancha
INNER JOIN Complejo com ON com.IdComplejo = can.IdComplejo
INNER JOIN Club cl ON cl.IdClub = com.IdClub
WHERE cl.nombreClub = 'Everton'

INTERSECT 

SELECT e.nombreEntrenador, e.fechaNacimiento, e.direccion
FROM Entrenador e 
INNER JOIN Entrenamiento en ON en.IdEntrenador = e.IdEntrenador
INNER JOIN Cancha can ON can.IdCancha = en.IdCancha
INNER JOIN Complejo com ON com.IdComplejo = can.IdComplejo
INNER JOIN Club cl ON cl.IdClub = com.IdClub
WHERE cl.nombreClub = 'Estrella de Berisso';













-- SELECT e.nombreEntrenador, e.fechaNacimiento, e.direccion
-- FROM Entrenador e 
-- INNER JOIN Entrenamiento en ON en.IdEntrenador = e.IdEntrenador
-- INNER JOIN Cancha can ON can.IdCancha = en.IdCancha
-- INNER JOIN Complejo com ON com.IdComplejo = can.IdComplejo
-- INNER JOIN Club cl ON cl.IdClub = com.IdClub
-- -- INNER JOIN Club cl2 ON cl2.IdClub = com.IdClub

-- WHERE cl.nombreClub = 'Everton' --AND cl2.nombreClub = 'Estrella de Berisso'

-- INTERSECT 

-- SELECT e.nombreEntrenador, e.fechaNacimiento, e.direccion
-- INNER JOIN Entrenamiento en ON en.IdEntrenador = e.IdEntrenador
-- INNER JOIN Cancha can ON can.IdCancha = en.IdCancha
-- INNER JOIN Complejo com ON com.IdComplejo = can.IdComplejo
-- INNER JOIN Club cl ON cl.IdClub = com.IdClub
-- WHERE cl.nombreClub = 'Estrella de Berisso';


--al final se rompia
SELECT e.nombreEntrenador, e.fechaNacimiento, e.direccion
FROM Entrenador e 
INNER JOIN Entrenamiento en ON en.IdEntrenador = e.IdEntrenador
INNER JOIN Cancha can ON can.IdCancha = en.IdCancha
INNER JOIN Complejo com ON com.IdComplejo = can.IdComplejo
INNER JOIN Club cl ON cl.IdClub = com.IdClub
INNER JOIN Club cl2 ON cl2.IdClub = com.IdClub

WHERE cl.nombreClub = 'Everton' AND cl2.nombreClub = 'Estrella de Berisso';