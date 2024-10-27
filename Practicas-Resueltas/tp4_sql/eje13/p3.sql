--  3. Listar los complejos donde haya realizado entrenamientos el entrenador “Jorge Gonzalez”.
--  Informar nombre de complejo, ordenar el resultado de manera ascendente.
SELECT DISTINCT c.nombreComplejo
FROM Complejo com 
INNER JOIN Cancha can ON can.idComplejo = com.idComplejo
INNER JOIN Entrenamiento en ON en.idCancha = can.idCancha
INNER JOIN Entrenador ent ON ent.idEntrenador = en.idEntrenador

WHERE ent.nombreEntrenador = 'Jorge Gonzales' --no existe el atributo apellido
ORDER BY com.nombreComplejo ASC; --Por defecto se ordenado Ascendente (Order by)