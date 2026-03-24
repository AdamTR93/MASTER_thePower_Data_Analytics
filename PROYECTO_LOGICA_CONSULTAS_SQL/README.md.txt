# 📑 Informe del Proyecto: BBDD Shakila

## 1. Esquema de la Base de Datos
![Esquema de Relación Entidad Shakila](shakila_esquema_realacion_entidad.png)

### Comentarios sobre el diagrama
He organizado el diagrama por colores para que quede más claro:

**Morado (Todo lo relacionado a las películas):** Tablas: `film`, `actor`, `category`, `language`, `film_actor`, `film_category`.
**Marrón (Todo lo relacionado con localización):** Tablas: `country`, `city`, `address`.
**Verde (Todo lo relacionado con la tienda y logística):** Tablas: `store`, `staff`, `inventory`.
**Azul (Todo lo relacionado con las ventas y alquileres):** Tablas: `customer`, `rental`, `payment`.

---

## 2. Pasos seguidos en el proyecto:

### Carga de los datos
Para montar el proyecto, he utilizado el archivo `BBDD_Proyecto_shakila_sinuser.sql`. Este es un script de inicialización que se encarga de crear el esquema `shakila` y definir la estructura de las 15 tablas. Además, incluye toda la carga de datos necesaria para que la base de datos sea funcional. 

### Creación del esquema y tablas
Lo primero que hice fue crear el esquema `shakila` y usar el `search_path` para no tener que escribir el nombre del esquema todo el rato. Creé las 15 tablas con sus claves primarias (PK) y luego añadí las claves foráneas (FK) con `ALTER TABLE`. He usado `ON UPDATE CASCADE` para que los cambios se propaguen y `ON DELETE RESTRICT` para asegurar que no borremos datos que están relacionados en otras tablas.


### Vistas, CTEs y Tablas temporales:

He utilizado varias herramientas para organizar mejor las consultas:

**Vistas:** He creado una vista (`view_film_category`) que junta las tablas de películas y géneros para no repetir joins en alguan de las preguntas. No la he usado siempre ya que si no algunos ejercicios se resolvían de manera demasiado simple al usar la vista.

**CTEs (WITH):** He usado expresiones de tabla comunes (CTEs) para segmentar algunas consultas complejas, para demostrar el uso práctico de este tipo de consultas con CTEs.

**Tablas temporales:** Las he usado en las preguntas que pedían guardar datos específicos, como el total de alquileres por cliente, para que las consultas sean más rápidas.

### Técnicas usadas en las consultas:

**Consultas 2 a 10:** Empiezo con filtros básicos usando `WHERE` y operadores para comparar como el igual =, mayor que >, `BETWEEN` y 'AND'. También uso `ILIKE` para buscar nombres o apellidos por el texto sin que importen las mayúsculas. También uso `MAX`, `MIN` y `STDDEV` para encontrar algún dato estadístico y uso 'ROUND' para redondear los resultados decimales. También he usado 'AS' para alias y 'concat()' sobre todo para juntar nombre-apellido. 

**Consultas 11 a 20:** Uso `ORDER BY`, `LIMIT` y `OFFSET` para ordenar los resultados y quedarme con registros específicos (como el antepenúltimo alquiler). Empiezo a unir tablas con `JOIN` y a usar `ROUND` para que los promedios (`AVG`) no saquen tantos decimales.


**Filtrado y Selección:** Uso constante de `WHERE` con operadores de comparación `=, >, <) y lógicos como `AND` y `OR`. He aplicado `BETWEEN` para rangos (como en los IDs de actores), `IN` para listas de valores y `IS NULL` / `IS NOT NULL` para gestionar datos vacíos. Para buscar texto, he usado `ILIKE` para buscar nombres o apellidos por el texto sin que importen las mayúsculas o minúsculas. También he usado  'IN' y 'NOT IN' para incluir o excluir valores específicos, como filtrar categorías de películas.

**Funciones de Agregación y Cálculo:** He utilizado `COUNT` para contar registros (películas, alquileres o actores). También he usado `SUM` para ingresos, `AVG` para promedios de duración y precio, y funciones estadísticas más avanzadas como `STDDEV` (desviación estándar) y `VARIANCE` (varianza) para encontrar algún dato estadístico y uso 'ROUND' para redondear los resultados decimales.

**Agrupación y Filtrado de Grupos:** Uso de `GROUP BY` para organizar los datos por categorías, fechas o clientes. He usado `HAVING` en múltiples ocasiones para filtrar los resultados después de haber hecho los cálculos de agregación.

**Unión de tablas:** He unido varias tablas usando `JOIN` (Inner Join) para datos relacionados. He aplicado `LEFT JOIN` y `RIGHT JOIN` cuando ha sido necesario asegurar que aparezcan registros aunque no tengan relación (como actores sin películas o clientes sin alquileres). También he usado el `CROSS JOIN` para ver todas las combinaciones posibles entre tablas.

**Subconsultas:** He anidado consultas dentro de otras en el `WHERE` o en el `HAVING`, para comparar registros contra valores calculados (como películas que duran más que la media). También he usado `DISTINCT` para eliminar duplicados en los resultados de actores y títulos.

**Gestión de Fechas y Tiempo:** Uso de `DATE()` para limpiar marcas de tiempo, `EXTRACT` para sacar meses o años específicos, y el operador `INTERVAL` para comparar duraciones de alquiler (como alquileres superiores a 8 días).
---

## 3. Informe del análisis


En la base de datos tenemos 1000 películas. Hay mucha variedad en la duración de las películas, con algunas que superan las 3 horas, hasta la que menos dura que son 46min. He observado que todas las películas del catálogo se estrenaron en el año 2006 y que el idioma de todas es el Inglés (language_id = 1). Me he dado cuenta de que en la tabla `film`, la columna `original_language_id` solo tiene valores nulos, por lo que no podemos saber el idioma original real con los datos actuales.

He sacado los datos de que películas se alquilan más y cuáles todavía no se han devuelto (los que tienen return_date como NULL). También he visto que el tiempo máximo de alquiler permitido (rental_duration) es de 7 días.


Con la BBDD se puede saber qué películas son las que más se alquilan y cuáles no se alquilan nunca a través de las tablas 'film','rental','inventory'.

Pasando por las tablas 'customer','payment','rental' se puede buscar los clientes que más/menos peliculas alquilan, cuando devuelven las peliculas o si aún no las han devuelto. También podemos encontrar que clientes más/menos ingresos generan.

Para buscar información de actores y peliculas, `film`, `actor`, `film_actor`, a través de la tabla intermedia `film_actor`, podemos saber en cuántas películas ha participado cada actor o qué reparto completo tiene una película. Para poder buscar por ejmeplo en las películas que ha actuado un actor.

Si relacionamos 'film','categroy','film_category', uniendo por `film_category`, podemos agrupar todas las peliculas por géneros. Así podemos saber cuantas peliculas tenemos de cada categoría (Acción, Comedia...) incluso uniendo con las tablas de clientes y alquieleres, podemos saber que categroias son las más alquiladas o las que menos. En este caso los musicales son la categoría menos alquilada de la base de datos.

La relación de tablas 'film','inventory','rental', nos permite saber que películas son las que más y las que menos se alquilan e inculso en que tienda las podemos encontrar.

Las tablas `address`, `city`, `country`, uqnue no han sido usadas en este análisis, nos dan información de donde son nuestros clientes y trabajadores. Estos datos podrían servirnos para abrir nuevos negocios en ciudades donde los cleitnes alquilen muchas peliculas  hacer promociones en sitios donde se alquilen pocas.

---

## 4. Archivos proporcionados en el repositorio

El archivo ProyectoSQL_Logica_Consultas.sql adjunto tiene todas las consultas resueltas, identificadas con su número y su enunciado como comentario. He añadido comentarios en cada una explicando por qué he usado cada `JOIN`, `GROUP BY` o las subconsultas para que se entienda bien la lógica aplicada.

El archivo BBDD_Proyecto_shakila_sinuser.sql es el script que nos sirve para cargar todos los datos necesarios y poder trabajar con la base de datos.

El archivo shakila_esquema_realacion_entidad es un archivo PNG con una imagen del esquema relacion-entidad de la base de datos.


Repositorio del curso en Data Analytics: https://github.com/AdamTR93/MASTER_thePower_Data_Analytics
