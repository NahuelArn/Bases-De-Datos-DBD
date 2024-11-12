-- Reportar nombre, descripción y cantidad de habitantes de localidades que tengan menos de 100
--  árboles.

SELECT l.nombreL, l.descripcion, l.habitantes
FROM Localidad l
--QUE TENGAN MENOS DE 100 ARBOLES! si la localidad no tienen ningun arbol, me quedo igual con sus cantHabitantes
LEFT JOIN Arbol a ON a.codigoPostal = l.codigoPostal 
GROUP BY l.codigoPostal, l.nombreL, l.descripcion, l.habitantes
HAVING COUNT(*) < 100

--========================================

SELECT l.nombreL, l.descripcion, l.habitantes --4
FROM Localidad l LEFT JOIN Arbol a ON a.codigoPostal = l.codigoPostal  --1

GROUP BY l.nombreL, l.descripcion --2
HAVING COUNT(*) < 100 --3  --para cada fila de nroArbol se cuenta(se cuenta el grupo).. anteriormente lo agrupe





--Con Count cuento la cantidad de filas que agrupe en GROUP BY no es necesario especificar algo dentro (*) tods

--Ahora si necesito sumar una cantidad dentro del grupo, ahi si me aseguro de ordenar por una PK y especificar el campo que tengo que sumar()



-- Tabla: Localidad
-- codigoPostal	nombreL	descripcion	habitantes
-- 1	La Plata	Ciudad de la Plata	800000
-- 2	Salta	Ciudad de Salta	600000
-- 3	Buenos Aires	Capital Federal	3000000

-- Tabla: Arbol
-- nroArbol	especie	años	calle	nro	codigoPostal
-- 101	Conífera	5	Calle A	1	1
-- 102	Conífera	3	Calle B	2	1
-- 201	Frutal	10	Calle C	3	2
-- 202	Conífera	8	Calle D	4	2
-- 301	Frutal	15	Calle E	5	3


-- 2 LEFT JOIN:
-- Combina las filas de Localidad con las de Arbol donde codigoPostal coincida.
-- Resultado del LEFT JOIN:
-- codigoPostal	nombreL	descripcion	habitantes	nroArbol	especie	años	calle	nro
-- 1	La Plata	Ciudad de la Plata	800000	101	Conífera	5	Calle A	1
-- 1	La Plata	Ciudad de la Plata	800000	102	Conífera	3	Calle B	2
-- 2	Salta	Ciudad de Salta	600000	201	Frutal	10	Calle C	3
-- 2	Salta	Ciudad de Salta	600000	202	Conífera	8	Calle D	4
-- 3	Buenos Aires	Capital Federal	3000000	NULL	NULL	NULL	NULL	NULL


-- 3 GROUP BY:

-- Agrupa los resultados por codigoPostal, nombreL, descripcion, y habitantes.
-- Para cada grupo, se cuenta el número de árboles (nroArbol).

-- 4 HAVING:

-- Filtra los grupos resultantes. En este caso, solo se incluyen las localidades donde el número de árboles es menor que 3.



Claro, vamos a trabajar con la consulta que proporcionaste y crear un ejemplo paso a paso utilizando las tablas completas. 

### Tablas de Ejemplo

#### Tabla `Localidad`
| codigoPostal | nombreL    | descripcion       | habitantes |
|--------------|------------|-------------------|------------|
| 1001         | La Plata   | Ciudad de Plata   | 800000     |
| 1002         | Salta      | Ciudad de Salta   | 500000     |
| 1003         | Mendoza    | Ciudad de Mendoza  | 200000     |

#### Tabla `Arbol`
| nroArbol | especie      | años | calle          | nro | codigoPostal |
|----------|--------------|------|----------------|-----|--------------|
| 1        | Conífera    | 10   | Calle A        | 10  | 1001         |
| 2        | Conífera    | 5    | Calle B        | 20  | 1001         |
| 3        | Frutal      | 8    | Calle C        | 30  | 1002         |
| 4        | Frutal      | 15   | Calle D        | 40  | 1002         |
| 5        | Conífera    | 7    | Calle E        | 50  | 1003         |

### Paso 1: Realizar el `INNER JOIN`

Al hacer el `INNER JOIN` entre `Localidad` y `Arbol`, se combinan las filas donde el `codigoPostal` coincide:

```sql
SELECT l.nombreL, l.descripcion, l.habitantes
FROM Arbol a INNER JOIN Localidad l ON (a.codigoPostal = l.codigoPostal)
```

#### Resultado del `INNER JOIN`
| nombreL    | descripcion       | habitantes | nroArbol | especie      | años | calle   | nro |
|------------|-------------------|------------|----------|--------------|------|---------|-----|
| La Plata   | Ciudad de Plata   | 800000     | 1        | Conífera    | 10   | Calle A | 10  |
| La Plata   | Ciudad de Plata   | 800000     | 2        | Conífera    | 5    | Calle B | 20  |
| Salta      | Ciudad de Salta   | 500000     | 3        | Frutal      | 8    | Calle C | 30  |
| Salta      | Ciudad de Salta   | 500000     | 4        | Frutal      | 15   | Calle D | 40  |
| Mendoza    | Ciudad de Mendoza  | 200000     | 5        | Conífera    | 7    | Calle E | 50  |

### Paso 2: Aplicar `GROUP BY`

Al aplicar el `GROUP BY`, agrupamos por los campos que seleccionamos y contamos el número total de árboles en cada localidad:

```sql
GROUP BY l.codigoPostal, l.nombreL, l.descripcion, l.habitantes
```

#### Resultado del `GROUP BY`
| nombreL    | descripcion       | habitantes | COUNT(*) |
|------------|-------------------|------------|----------|
| La Plata   | Ciudad de Plata   | 800000     | 2        |
| Salta      | Ciudad de Salta   | 500000     | 2        |
| Mendoza    | Ciudad de Mendoza  | 200000     | 1        |

### Paso 3: Aplicar `HAVING`

Finalmente, aplicamos el `HAVING COUNT(*) < 100` para filtrar solo aquellas localidades que tienen menos de 100 árboles. En este caso, si seguimos el ejemplo, suponiendo que todas tienen más de 100 árboles, no se mostraría ningún resultado. 

Sin embargo, si quisiéramos ver cómo se vería la tabla de resultados si alguna localidad tuviera menos de 100 árboles, imaginemos que "Mendoza" tiene solo 1 árbol:

#### Resultado Final
| nombreL    | descripcion       | habitantes |
|------------|-------------------|------------|
| Mendoza    | Ciudad de Mendoza  | 200000     |

### Consulta Final

Aquí está tu consulta completa con el contexto:

```sql
SELECT l.nombreL, l.descripcion, l.habitantes
FROM Arbol a INNER JOIN Localidad l ON (a.codigoPostal = l.codigoPostal)
GROUP BY l.codigoPostal, l.nombreL, l.descripcion, l.habitantes
HAVING COUNT(*) < 100;
```

Esto reportaría solo aquellas localidades que tienen menos de 100 árboles.