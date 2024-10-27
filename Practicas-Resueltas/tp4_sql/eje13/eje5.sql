--  5. Listar todos los clubes en los que entrena el entrenador “Marcos Perez”. Informar nombre del
--  club y ciudad.
SELECT DISTINCT cl.nombre, cl.ciudad
FROM Club cl 
INNER JOIN Complejo com ON com.IdClub = cl.IdClub
INNER JOIN Cancha can ON can.IdComplejo = com.IdComplejo
INNER JOIN Entrenamiento en ON en.IdCancha = can.IdCancha
INNER JOIN Entrenador ent ON ent.IdEntrenador = en.IdEntrenador

WHERE ent.nombreEntrenador = 'Marcos Perez';