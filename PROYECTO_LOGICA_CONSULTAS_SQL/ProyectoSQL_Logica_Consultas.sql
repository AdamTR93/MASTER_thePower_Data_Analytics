-- DataProject: LógicaConsultas

-- 1. Crea el esquema de la BBDD.
DROP SCHEMA IF EXISTS shakila CASCADE; -- Borramos el esquema si ya existe para empezar de cero.
CREATE SCHEMA shakila; -- creamos el esquema
SET search_path TO shakila,public; -- con el search_path no hace falta estar escribiendo continuamente shakila. cada vez que busquemos la tabla.
-- ponemos public, porque es la que se pone por defecto en nuestro archivo de la creacición de la db.

-- Creamos primero todas las tablas con sus PK

-- DROP TABLE IF EXISTS shakila.actor;
CREATE TABLE shakila.actor (
    actor_id int4 NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT actor_pkey PRIMARY KEY (actor_id)
);

-- DROP TABLE IF EXISTS shakila.country;
CREATE TABLE shakila.country (
    country_id int4 NOT NULL,
    country varchar(50) NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT country_pkey PRIMARY KEY (country_id)
);

-- DROP TABLE IF EXISTS shakila.city;
CREATE TABLE shakila.city (
    city_id int4 NOT NULL,
    city varchar(50) NOT NULL,
    country_id int4 NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT city_pkey PRIMARY KEY (city_id)
);

-- DROP TABLE IF EXISTS shakila.address;
CREATE TABLE shakila.address (
    address_id int4 NOT NULL,
    address varchar(50) NOT NULL,
    address2 varchar(50),
    district varchar(20) NOT NULL,
    city_id int4 NOT NULL,
    postal_code varchar(10),
    phone varchar(20) NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT address_pkey PRIMARY KEY (address_id)
);

-- DROP TABLE IF EXISTS shakila.category;
CREATE TABLE shakila.category (
    category_id int4 NOT NULL,
    name varchar(25) NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (category_id)
);

-- DROP TABLE IF EXISTS shakila.language;
CREATE TABLE shakila.language (
    language_id int4 NOT NULL,
    name varchar(20) NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT language_pkey PRIMARY KEY (language_id)
);

-- DROP TABLE IF EXISTS shakila.film;
CREATE TABLE shakila.film (
    film_id int4 NOT NULL,
    title varchar(255) NOT NULL,
    description text,
    release_year int4,
    language_id int4 NOT NULL,
    original_language_id int4 NULL, 
    rental_duration int4 NOT NULL,
    rental_rate numeric(4,2) NOT NULL,
    length int4,
    replacement_cost numeric(5,2) NOT NULL,
    rating varchar(10),
    last_update timestamp NOT NULL,
    CONSTRAINT film_pkey PRIMARY KEY (film_id)
);

-- DROP TABLE IF EXISTS shakila.store;
CREATE TABLE shakila.store (
    store_id int4 NOT NULL,
    manager_staff_id int4 NOT NULL,
    address_id int4 NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT store_pkey PRIMARY KEY (store_id)
);

-- DROP TABLE IF EXISTS shakila.staff;
CREATE TABLE shakila.staff (
    staff_id int4 NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    address_id int4 NOT NULL,
    email varchar(50),
    store_id int4 NOT NULL,
    active bool NOT NULL,
    username varchar(16) NOT NULL,
    password varchar(40),
    last_update timestamp NOT NULL,
    CONSTRAINT staff_pkey PRIMARY KEY (staff_id)
);

-- DROP TABLE IF EXISTS shakila.customer;
CREATE TABLE shakila.customer (
    customer_id int4 NOT NULL,
    store_id int4 NOT NULL,
    first_name varchar(45) NOT NULL,
    last_name varchar(45) NOT NULL,
    email varchar(50),
    address_id int4 NOT NULL,
    activebool bool NOT NULL,
    create_date timestamp NOT NULL,
    last_update timestamp,
    CONSTRAINT customer_pkey PRIMARY KEY (customer_id)
);

-- DROP TABLE IF EXISTS shakila.inventory;
CREATE TABLE shakila.inventory (
    inventory_id int4 NOT NULL,
    film_id int4 NOT NULL,
    store_id int4 NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id)
);

-- DROP TABLE IF EXISTS shakila.rental;
CREATE TABLE shakila.rental (
    rental_id int4 NOT NULL,
    rental_date timestamp NOT NULL,
    inventory_id int4 NOT NULL,
    customer_id int4 NOT NULL,
    return_date timestamp,
    staff_id int4 NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT rental_pkey PRIMARY KEY (rental_id)
);

-- DROP TABLE IF EXISTS shakila.payment;
CREATE TABLE shakila.payment (
    payment_id int4 NOT NULL,
    customer_id int4 NOT NULL,
    staff_id int4 NOT NULL,
    rental_id int4 NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp NOT NULL,
    CONSTRAINT payment_pkey PRIMARY KEY (payment_id)
);

-- DROP TABLE IF EXISTS shakila.film_actor
CREATE TABLE shakila.film_actor (
    actor_id int4 NOT NULL,
    film_id int4 NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id)
);

-- DROP TABLE IF EXISTS shakila.film_category
CREATE TABLE shakila.film_category (
    film_id int4 NOT NULL,
    category_id int4 NOT NULL,
    last_update timestamp NOT NULL,
    CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id)
);

----------------------------------------------------------------------------

-- Creamos las foreign keys una vez con las tablas creadas

-- shakila.city foreign keys
ALTER TABLE shakila.city
ADD CONSTRAINT city_country_id_fkey
FOREIGN KEY (country_id)
REFERENCES shakila.country(country_id)
ON DELETE RESTRICT -- esta restringido el borrado de cualuqier dato al estar en RESTRICT
ON UPDATE CASCADE; -- al actualizar el dato en esta tabla, al estar en CASCADE se actualizarian los datos en las demas tablas

-- shakila.address foreign keys
ALTER TABLE shakila.address
ADD CONSTRAINT address_city_id_fkey
FOREIGN KEY (city_id)
REFERENCES shakila.city(city_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.film foreign keys
ALTER TABLE shakila.film
ADD CONSTRAINT film_language_id_fkey
FOREIGN KEY (language_id)
REFERENCES shakila.language(language_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.store foreign keys
ALTER TABLE shakila.store
ADD CONSTRAINT store_address_id_fkey
FOREIGN KEY (address_id)
REFERENCES shakila.address(address_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.store
ADD CONSTRAINT store_manager_staff_id_fkey
FOREIGN KEY (manager_staff_id)
REFERENCES shakila.staff(staff_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.staff foreign keys
ALTER TABLE shakila.staff
ADD CONSTRAINT staff_address_id_fkey
FOREIGN KEY (address_id)
REFERENCES shakila.address(address_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.staff
ADD CONSTRAINT staff_store_id_fkey
FOREIGN KEY (store_id)
REFERENCES shakila.store(store_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.customer foreign keys
ALTER TABLE shakila.customer
ADD CONSTRAINT customer_address_id_fkey
FOREIGN KEY (address_id)
REFERENCES shakila.address(address_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.customer
ADD CONSTRAINT customer_store_id_fkey
FOREIGN KEY (store_id)
REFERENCES shakila.store(store_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.inventory foreign keys
ALTER TABLE shakila.inventory
ADD CONSTRAINT inventory_film_id_fkey
FOREIGN KEY (film_id)
REFERENCES shakila.film(film_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.inventory
ADD CONSTRAINT inventory_store_id_fkey
FOREIGN KEY (store_id)
REFERENCES shakila.store(store_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.rental foreign keys
ALTER TABLE shakila.rental
ADD CONSTRAINT rental_inventory_id_fkey
FOREIGN KEY (inventory_id)
REFERENCES shakila.inventory(inventory_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.rental
ADD CONSTRAINT rental_customer_id_fkey
FOREIGN KEY (customer_id)
REFERENCES shakila.customer(customer_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.rental
ADD CONSTRAINT rental_staff_id_fkey
FOREIGN KEY (staff_id)
REFERENCES shakila.staff(staff_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

-- shakila.payment foreign keys
ALTER TABLE shakila.payment
ADD CONSTRAINT payment_customer_id_fkey
FOREIGN KEY (customer_id)
REFERENCES shakila.customer(customer_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.payment
ADD CONSTRAINT payment_staff_id_fkey
FOREIGN KEY (staff_id)
REFERENCES shakila.staff(staff_id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

ALTER TABLE shakila.payment
ADD CONSTRAINT payment_rental_id_fkey
FOREIGN KEY (rental_id)
REFERENCES shakila.rental(rental_id)
ON DELETE SET NULL
ON UPDATE CASCADE;

-- shakila.film_actor foreign keys
ALTER TABLE shakila.film_actor
ADD CONSTRAINT film_actor_actor_id_fkey
FOREIGN KEY (actor_id) 
REFERENCES shakila.actor(actor_id) 
ON DELETE RESTRICT 
ON UPDATE CASCADE;

ALTER TABLE shakila.film_actor
ADD CONSTRAINT film_actor_film_id_fkey 
FOREIGN KEY (film_id) 
REFERENCES shakila.film(film_id) 
ON DELETE RESTRICT 
ON UPDATE CASCADE;

-- shakila.film_category foreign keys
ALTER TABLE shakila.film_category
ADD CONSTRAINT film_category_category_id_fkey 
FOREIGN KEY (category_id) 
REFERENCES shakila.category(category_id) 
ON DELETE RESTRICT 
ON UPDATE CASCADE;

ALTER TABLE shakila.film_category
ADD CONSTRAINT film_category_film_id_fkey 
FOREIGN KEY (film_id) 
REFERENCES shakila.film(film_id) 
ON DELETE RESTRICT 
ON UPDATE CASCADE;

---------------------------------------------------------------------------------------------------------

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ.

SELECT -- selecccionamos las columnas
	f.title AS titulo_pelicula
FROM film f 
WHERE f.rating = 'R'; -- añadimos el filtro por rating

---------------------------------------------------------------------------------------------------------

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.

SELECT -- seleccionamos id y concatenamos nombre y apellidos
	concat(a.first_name  , ' ',a.last_name ) AS nombre_actor 
FROM actor a 
WHERE a.actor_id BETWEEN 30 AND 40; -- añadimos el filtro de id comprendida entre 30 y 40 con un between

---------------------------------------------------------------------------------------------------------

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT  f.title  
FROM film f 
WHERE f.language_id = f.original_language_id; -- filtramos por las language_id que sean iguales a las original_language_id

-- La query no muestra resultados, ya que los registros de la columna original_language_id son todos NULL y la columna language_id son todo 1

SELECT 
	f.film_id,
	f.title AS "titulo_pelicula",
	f.language_id, 
	f.original_language_id 
FROM film f
WHERE original_language_id IS NOT NULL AND language_id = original_language_id; -- aseguramos que en original_language_id no sea nulo y que coincida con la otra columna

-- como vemo, esta query no nos muestra ningún dato, confirmando que todos los registros de original_laguage_id son NULL.

---------------------------------------------------------------------------------------------------------

-- 5. Ordena las películas por duración de forma ascendente.

SELECT f.title AS "nombre_pelicula"
FROM film f 
ORDER BY f.length; -- ordenamos por duracion, no ponemos asc ya que lo hace de manera automática

---------------------------------------------------------------------------------------------------------

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.

SELECT concat(a.first_name  , ' ',a.last_name ) AS nombre_actor  -- seleccionamos nombre y apellidos
FROM actor a
WHERE A.last_name ILIKE '%Allen%'; -- filtramos por apellido Allen usando ILIKE para ignorar mayús. o minús. y el porcentaje por el "que tengan"

---------------------------------------------------------------------------------------------------------

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.

SELECT f.rating, COUNT(f.film_id) AS cantidad_peliculas -- seleccionamos la columna ratings y hacemos un conteo de las pelis
FROM film f 
GROUP BY f.rating; -- agrupamos por clasificación

---------------------------------------------------------------------------------------------------------

-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.

SELECT f.title AS titulo_pelicula
FROM film f 
WHERE f.length > 180 
	OR f.rating = 'PG-13'; -- filtramos las que duran mas de 180min (ya que los registros de la columna estan en minutos) y el rating.

---------------------------------------------------------------------------------------------------------

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT ROUND(STDDEV(f.replacement_cost),2) -- seleccionamos la desviación estándard de replacement_cost y lo redondeamos a dos cifras tras la coma
FROM film f ; 

---------------------------------------------------------------------------------------------------------

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT MAX(f.length) AS duracion_maxima, MIN(f.length) AS duracion_minima -- seleccionamos el máximo y el mínimo de la duración 
FROM film f ;

---------------------------------------------------------------------------------------------------------

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT 
	r.rental_id ,
	r.rental_date,
	p.amount 
FROM payment p 
JOIN rental r 
	ON p.rental_id = r.rental_id -- realizamos un join para unir las tablas payment y rental
ORDER BY r.rental_date DESC -- ordenamos DESC para que se pongan los último alquileres primero
OFFSET 2 -- este OFFSET hace que no cuente los dos primeros registros entonces saltaría al 3 registro que es el que nos interesa
LIMIT 1; -- usamos LIMIT 1 para que solo nos muestre 1 dato, el antepenúltimo

---------------------------------------------------------------------------------------------------------

-- 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC17ʼ ni ‘Gʼ en cuanto a su clasificación.

SELECT f.title AS titulo_pelicula
FROM film f 
WHERE f.rating NOT IN ('NC-17','G'); -- filtramos por los ratings que no son ni NC-17 ni G

---------------------------------------------------------------------------------------------------------

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.

SELECT -- seleccionamos la calsificación y hacemos el promedio de la duración de las pelis y redondeamos el numero a dos decimales
	f.rating AS clasificacion,
	ROUND(AVG(f.length),2) AS avg_duracion 
FROM film f
GROUP BY clasificacion -- agrupamos por calsificación ya que tenemos una función de agregación
ORDER BY avg_duracion DESC; 

---------------------------------------------------------------------------------------------------------

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT f.title AS titulo_pelicula
FROM film f
WHERE f.length > 180
ORDER BY f.length DESC;

---------------------------------------------------------------------------------------------------------

-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(p.amount) AS ganancias_totales
FROM payment p;

-- 16. Muestra los 10 clientes con mayor valor de id.

SELECT *
FROM customer c
ORDER BY c.customer_id DESC
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.

SELECT -- seleccionamos nombre y apellidos de los actores concatenados y los títulos de las películas.
	concat(a.first_name  , ' ',a.last_name ) AS nombre_actor
FROM actor a
JOIN film_actor fa 
	ON a.actor_id = fa.actor_id -- tenemos que pasar por la tabla intermedia film_actor para poder unir el nombre de actor con el titulo de la peli.
JOIN film f 
	ON fa.film_id = f.film_id -- con esta join podemos seleccionar los titulos de las pelis.
WHERE (f.title) ILIKE 'Egg Igby'; -- filtramos con ILIKE para ignorar mayús. y minús. esta vez sin los % ya que pide un título específico.

---------------------------------------------------------------------------------------------------------

-- 18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT (f.title) AS peliculas_unicas -- usamos distinct para seleccionar las pelis únicas.
FROM film f;


---------------------------------------------------------------------------------------------------------

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.

SELECT -- seleccionamos titulo y duración de la tabla film y el género de la película de la tabla category
	f.title AS titulo_pelicula
FROM film f 
JOIN film_category fc  -- tenemos que pasar por la tabla film_category para poder llegar a la tabla category
	ON f.film_id = fc.film_id 
JOIN category c 
	ON fc.category_id = c.category_id -- aqui ya podemos seleccionar lo que nos interese de las 3 tablas
WHERE f.length > 180 AND c."name" = 'Comedy'; -- finalmente filtramos por duracion y género

---------------------------------------------------------------------------------------------------------

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría 
junto con el promedio de duración.*/

SELECT -- seleccionamos el género de la película y la media de la duración redondeada a 2 decimales
	c."name" AS genero_pelicula,
	ROUND(AVG(f.length),2) AS avg_duracion
FROM film f 
JOIN film_category fc  -- tenemos que pasar por la tabla film_category para poder llegar a la tabla category
	ON f.film_id = fc.film_id 
JOIN category c 
	ON fc.category_id = c.category_id -- aqui ya podemos seleccionar lo que nos interese de las 3 tablas
GROUP BY genero_pelicula -- agrupamos por genero
HAVING  AVG(f.length) > 110  -- finalmente filtramos con having la función de agregación
ORDER BY avg_duracion DESC;

---------------------------------------------------------------------------------------------------------

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT ROUND(AVG(f.rental_duration),2) AS avg_duracion_alquiler --hacemos la función de agregación AVG sobre rental_duration
FROM film f ;

---------------------------------------------------------------------------------------------------------

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT concat(a.first_name  , ' ',a.last_name ) AS nombre_actor  -- concatenamos para unir nombre y apellido en la misma columna
FROM actor a;

---------------------------------------------------------------------------------------------------------

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT -- seleccionamos la fecha en formato DATE para que coja dia, mes y año, y hacemos un COUNT de las id
	DATE(r.rental_date) AS fecha,
	count(r.rental_id ) AS total_alquileres 
FROM rental r 
GROUP BY DATE(r.rental_date) -- agrupamos por fecha para ver cuantos alquileres hay por dia.
ORDER BY total_alquileres DESC; -- ordeanamos de forma DESC en el ORDER BY.

---------------------------------------------------------------------------------------------------------

-- 24. Encuentra las películas con una duración superior al promedio.

SELECT -- seleccionamos las columnas para ver los resultados
	f.title AS titulo_pelicula
FROM film f
WHERE f.length > (SELECT AVG(f2.length) FROM film f2) -- realizamos una subquery en el WHERE para poder comparar con el AVG de la duración en nuestro filtro.
ORDER BY f.length; -- ordenamos por duracion

---------------------------------------------------------------------------------------------------------


-- 25. Averigua el número de alquileres registrados por mes.

SELECT -- hacemos un EXTRACT del año y el mes para separarlos del timestamp por defecto, y contamos todos los registros de la tabla rental
	EXTRACT (YEAR FROM r.rental_date) AS año, 
	EXTRACT (MONTH FROM r.rental_date) AS mes,
	count(*) AS total_alquileres
FROM rental r 
GROUP BY año,mes -- lo agrupamos por año y mes
ORDER BY año;

SELECT *
FROM rental r;

---------------------------------------------------------------------------------------------------------

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT 
	ROUND(AVG(p.amount),2) AS avg_amount, 
	ROUND(STDDEV(p.amount),2) AS stv_amount,
	ROUND(VARIANCE(p.amount),2) AS var_amount
FROM payment p;


-- 27. ¿Qué películas se alquilan por encima del precio medio?


WITH precio_max_peli AS( -- creamos una CTE ya que es una consulta larga y así la podemos reutilizar
	SELECT -- aqui seleccionamos el titulo de la peli y al precio máximo que esta pelicula se ha alquilado para saber si supera la media.
		f.title AS titulo_pelicula,
		MAX(p.amount) AS max_precio_alquilada
	FROM film f 
	JOIN inventory i 
		ON f.film_id = i.film_id
	JOIN rental r 
		ON i.inventory_id = r.inventory_id
	JOIN payment p 
	ON r.rental_id = p.rental_id -- realizamos las joins correspondientes para llegar a la tabla payment de donde sacamos el amount
	GROUP BY f.title -- agrupamos por peli
)
SELECT titulo_pelicula -- usamos las columnas de nuestra CTE
FROM precio_max_peli pmp
WHERE pmp.max_precio_alquilada > (SELECT AVG(p.amount)FROM payment p) -- en el WHERE realizamos una subquery para comprar el precio maximo con el avg del precio
ORDER BY pmp.max_precio_alquilada DESC;

---------------------------------------------------------------------------------------------------------

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT fa.actor_id
FROM film_actor fa
GROUP BY fa.actor_id
HAVING  count(*) > 40;

---------------------------------------------------------------------------------------------------------


-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT -- seleccionamos las peliculas de la tabla film y la pk film_id y la fk film_id de inventory
	f.title AS nombre_peli,
	count(i.film_id ) AS cantidad_disponible
FROM film f 
LEFT JOIN inventory i -- hacemos left join para poder contar también las peliculas que no tenemos en inventario
	ON f.film_id = i.film_id 
GROUP BY  f.film_id ,nombre_peli
ORDER BY f.film_id ;

---------------------------------------------------------------------------------------------------------

-- 30. Obtener los actores y el número de películas en las que ha actuado.

SELECT 
	concat(a.first_name  , ' ',a.last_name ) AS nombre_actor ,
	count(fa.film_id ) AS num_pelis
FROM actor a 
LEFT JOIN film_actor fa 
	ON a.actor_id = fa.actor_id 
GROUP BY nombre_actor,a.actor_id; -- añadimos actor_id por si algún actor se llama igual

---------------------------------------------------------------------------------------------------------


-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.


SELECT 
	f.title AS titulo_pelicula,
	concat(a.first_name  , ' ',a.last_name ) AS nombre_actor 
FROM film f 
LEFT JOIN film_actor fa -- left para traer todas las peliculas
	ON f.film_id   = fa.film_id 
LEFT JOIN actor a -- hacemos doble left join para traernos todas las peliculas desde la tabla film y aparezcan las que no tengan actores
	ON fa.actor_id = a.actor_id;
--WHERE a.actor_id  IS NULL; -- para comprobar os null

---------------------------------------------------------------------------------------------------------

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

SELECT 
	concat(a.first_name  , ' ',a.last_name ) AS nombre_actor ,
	f.title AS titulo_pelicula
FROM actor a 
LEFT JOIN film_actor fa 
	ON a.actor_id = fa.actor_id
LEFT JOIN film f 
	ON fa.film_id = f.film_id;
--WHERE f.title IS NULL; -- para comprobar los NULL

---------------------------------------------------------------------------------------------------------

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT 
	f.title AS titulo_peli,
	r.rental_id
FROM film f 
LEFT JOIN inventory i 
	ON f.film_id = i.film_id
LEFT JOIN rental r 
	ON i.inventory_id = r.inventory_id; -- hacemos doble LEFT JOIN para llevarnos todas las peliculas incluso las que no estan registradas en rental.

---------------------------------------------------------------------------------------------------------
	
-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
	
SELECT 
	concat(c.first_name ,' ',c.last_name ) AS nombre_cliente,
	ROUND(SUM(p.amount),2) AS total_gastado
FROM customer c 
JOIN payment p 
	ON c.customer_id = p.customer_id
GROUP BY c.customer_id, nombre_cliente 
ORDER BY total_gastado DESC -- ordenamos DESC para de mayor a menor gasto
LIMIT 5; -- limitamos a los 5 primeros

---------------------------------------------------------------------------------------------------------

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT 
	a.actor_id,
	a.first_name 
FROM actor a
WHERE a.first_name  ILIKE 'Johnny'; -- filtramos nombre con ILIKE para obviar mayús./minus.

---------------------------------------------------------------------------------------------------------

-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido

ALTER TABLE actor 
RENAME COLUMN first_name TO "Nombre"; -- ponemos entre "" el nuevo nombre para que respete la mayús.

ALTER TABLE actor
RENAME COLUMN last_name TO "Apellido";


SELECT *
FROM actor a;

---------------------------------------------------------------------------------------------------------

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT a.actor_id 
FROM actor a 
WHERE a.actor_id = (SELECT MIN(a.actor_id) FROM actor a) -- realizamos una subquery para encontrar la MIN id
OR a.actor_id = (SELECT MAX(a.actor_id) FROM actor a); -- realizamos una subquery para encontrar la MAX id

---------------------------------------------------------------------------------------------------------

-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.

SELECT count(*)
FROM actor a;

---------------------------------------------------------------------------------------------------------

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT *
FROM actor a
ORDER BY a."Apellido";

---------------------------------------------------------------------------------------------------------

-- 40. Selecciona las primeras 5 películas de la tabla “filmˮ.

SELECT *
FROM film f 
ORDER BY f.film_id 
LIMIT 5;

---------------------------------------------------------------------------------------------------------

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT -- esta query la he hecho así porque hay 3 nombres que se repiten 4 veces
	a."Nombre" AS nombre_actores,
	count(a."Nombre" ) AS total_nombres
FROM actor a
GROUP BY a."Nombre"
HAVING count(a."Nombre" ) = ( -- 3. en el having filtramos por el nombre que se ha repetido las mismas veces que el nombre que se ha repetido más.
	SELECT MAX(contador_nombres) -- 2. buscamos el nombre que más se ha repetido 
	FROM (
		SELECT COUNT(*) AS contador_nombres
        FROM actor
        GROUP BY "Nombre") AS tabla_conteo -- 1.creamos una subquery para contar los nombres de los actores
)
ORDER BY total_nombres DESC; 


SELECT a."Nombre" AS nombres_actores, count(*) AS total_nombres -- esta query la he puesto por si a caso solo se necesita 1 nombre
FROM actor a
GROUP BY a."Nombre"
ORDER BY  total_nombres  DESC
LIMIT 1; -- limitamos a 1 para responder el nombre más repetido

---------------------------------------------------------------------------------------------------------

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT r.rental_id, concat(c.first_name ,' ',c.last_name ) AS nombre_cliente
FROM rental r
LEFT JOIN customer c -- realizamos left join para que aparezcan todos los alquileres
	ON r.customer_id = c.customer_id;

---------------------------------------------------------------------------------------------------------

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

SELECT concat(c.first_name ,' ',c.last_name ) AS nombre_cliente,r.rental_id
FROM rental r
RIGHT  JOIN customer c -- realizamos right join para que aparezcan todos los clientes incluyendo los que no tienen alquiler
	ON r.customer_id = c.customer_id;


-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT * 
FROM film f , category c;

/* no aporta valor, ya que las tablas no tienen una columna coincidente entre si y no se relacionan entre ellas
 , eso hace que se multiplique por 16 cada pelicula porque al hacer cross join muestra todas las combinaciones posibles entre las dos tablas
 por lo tanto, generea una query que nos muestra 16000 registros y no aporta nada útil.*/


---------------------------------------------------------------------------------------------------------

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

-- vamos a crear una vista para unir que categoria tiene cada pelicula

CREATE VIEW view_film_category as
	SELECT 
		f.film_id,
		f.title AS nombre_peli,
		f.length AS duracion_peli,
		f.rating AS clasificacion,
		c.category_id,
		c."name" AS categoria
	FROM film f 
	LEFT JOIN film_category fc 
		ON f.film_id = fc.film_id 
	LEFT JOIN category c 
		ON fc.category_id = c.category_id;
		
SELECT 
	concat(a."Nombre",' ',a."Apellido" ) AS nombre_actor
FROM view_film_category vfc 
JOIN film_actor fa  
	ON vfc.film_id = fa.film_id 
JOIN actor a -- hacemos join con la vista y las dos tablas actor y film_actor para encontrar el nombre del los actores 
	ON a.actor_id = fa.actor_id
WHERE vfc.categoria ILIKE 'Action'; -- filtramos por la categoria 'Action'

---------------------------------------------------------------------------------------------------------

-- 46. Encuentra todos los actores que no han participado en películas.

SELECT 
    concat(a."Nombre", ' ', a."Apellido") AS nombre_actor,
    count(f.film_id) AS apariciones_peliculas  -- contamos en cuantas peliculas han salido los actores
FROM actor a
LEFT JOIN film_actor fa 
    ON a.actor_id = fa.actor_id
LEFT JOIN film f
	ON f.film_id = fa.film_id 
GROUP BY a.actor_id, nombre_actor
HAVING count(f.film_id) = 0; -- filtramos por los actores que tienen 0 apariciones

---------------------------------------------------------------------------------------------------------

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT 
    concat(a."Nombre", ' ', a."Apellido") AS nombre_actor,
    count(f.film_id) AS apariciones_peliculas  -- contmaos el numero de peliculas en las que han salido los actores
FROM actor a
LEFT JOIN film_actor fa 
    ON a.actor_id = fa.actor_id
LEFT JOIN film f
	ON f.film_id = fa.film_id 
GROUP BY a.actor_id, nombre_actor
ORDER BY apariciones_peliculas DESC;

---------------------------------------------------------------------------------------------------------

-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS -- declaramos la vista
	SELECT 
	    concat(a."Nombre", ' ', a."Apellido") AS nombre_actor,
	    count(f.film_id) AS apariciones_peliculas  -- contmaos el numero de peliculas en las que han salido los actores
	FROM actor a
	LEFT JOIN film_actor fa 
	    ON a.actor_id = fa.actor_id
	LEFT JOIN film f
		ON f.film_id = fa.film_id 
	GROUP BY a.actor_id, nombre_actor
	ORDER BY apariciones_peliculas DESC;

---------------------------------------------------------------------------------------------------------

-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT 
	concat(c.first_name ,' ',c.last_name ) AS nombre_cliente,
	count(r.rental_id ) AS total_alquileres -- contamos por id todo por si hay algun alquiler null
FROM customer c
LEFT JOIN rental r  -- realizamos left join para que aparezcan todos los clientes incluyendo los que no tienen alquiler
	ON r.customer_id = c.customer_id
GROUP BY c.customer_id ,nombre_cliente -- ponemos en el GROUP BY customer_id por si hubiera dos clientes con el mismo nombre + apellido
ORDER BY total_alquileres DESC;

---------------------------------------------------------------------------------------------------------

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT sum(vfc.duracion_peli) AS duracion_total -- sumamos todas las duraciones y seleccionamos las categorias
FROM view_film_category vfc
WHERE vfc.categoria ILIKE 'Action' -- filtramos por las peliculas de 'Action'
GROUP BY vfc.categoria;

---------------------------------------------------------------------------------------------------------

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.

CREATE TEMP TABLE  cliente_rentas_temporal AS -- creamos la tabla temporal
SELECT 
	c.customer_id,
	concat(c.first_name ,' ',c.last_name ) AS nombre_cliente,
	count(r.rental_id) AS total_alquileres -- contamos por id todo por si hay algun alquiler null
FROM customer c
LEFT JOIN rental r  -- realizamos left join para que aparezcan todos los clientes incluyendo los que no tienen alquiler
	ON r.customer_id = c.customer_id
GROUP BY c.customer_id ,nombre_cliente -- ponemos en el GROUP BY customer_id por si hubiera dos clientes con el mismo nombre + apellido
ORDER BY total_alquileres DESC;

SELECT *
FROM cliente_rentas_temporal;

---------------------------------------------------------------------------------------------------------

-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.

CREATE TEMP TABLE  peliculas_alquiladas AS -- creamos la tabla temporal
SELECT 
	f.film_id,
	f.title AS titulo_peli,
	count(r.rental_id ) AS veces_alquilada -- contamos las rental_id
FROM rental r 
JOIN inventory i 
	ON r.inventory_id = i.inventory_id
JOIN film f 
	ON f.film_id = i.film_id
GROUP BY f.film_id , titulo_peli
HAVING count(r.rental_id ) >=10 -- filtramos por las que han sido alquiladas 10 o más veces
ORDER BY veces_alquilada DESC;


SELECT * -- comprobamos que la tabla temporal funciona
FROM peliculas_alquiladas;

---------------------------------------------------------------------------------------------------------

/* -- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ
 y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.*/

SELECT 
	c.customer_id, -- añadimos customer_id por si tenemos dos clientes tammy sanders
	concat(c.first_name ,' ',c.last_name ) AS nombre_cliente,
	f.title AS titulo_pelicula,
	r.return_date AS fecha_devolucion -- añadimos la fecha de devolucion
FROM customer c
JOIN rental r  
	ON r.customer_id = c.customer_id
JOIN inventory i 
	ON i.inventory_id = r.inventory_id 
JOIN film f
	ON f.film_id = i.film_id 
WHERE concat(c.first_name ,' ',c.last_name ) ILIKE 'Tammy Sanders' 
	AND r.return_date IS NULL -- añadimos el is null porque esas peliculas son las que no se han devuelto
ORDER BY titulo_pelicula; -- ordenamos por el titulo de las peliculas alfabéticamente

---------------------------------------------------------------------------------------------------------

/* -- 54.  Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ.
Ordena los resultados alfabéticamente por apellido.*/

SELECT "Nombre"
FROM (
    SELECT DISTINCT a."Nombre", a."Apellido"
    FROM actor a 
    JOIN film_actor fa 
        ON a.actor_id = fa.actor_id
    JOIN view_film_category vfc 
        ON fa.film_id = vfc.film_id
    WHERE vfc.categoria = 'Sci-Fi'
) nombre_apellido -- hacemos subconsulta con nombre y apellido para poder después ordenar por apellido.
ORDER BY "Apellido";


---------------------------------------------------------------------------------------------------------

 /*-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
Cheaperʼ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.*/

SELECT DISTINCT
	a."Nombre",
	a."Apellido" 
FROM rental r 
JOIN inventory i 
	ON r.inventory_id = i.inventory_id 
JOIN film f 
	ON f.film_id = i.film_id
JOIN film_actor fa 
	ON fa.film_id = f.film_id 
JOIN actor a
	ON a.actor_id = fa.actor_id 
WHERE r.rental_date > ( -- subquery para encontrar la fecha en la que se alquiló la peli por primera vez
	SELECT r.rental_date
	FROM rental r 
	JOIN inventory i 
		ON r.inventory_id = i.inventory_id 
	JOIN film f 
		ON f.film_id = i.film_id
	WHERE f.title ILIKE 'Spartacus Cheaper'
	ORDER BY r.rental_date -- ordenamos por fecha de más antiguo a más nuevo
	LIMIT 1 -- limitamos 1 para que devuelva la primera fecha
) 
ORDER BY a."Apellido"; -- ordenamos por apellido alfabéticamente

---------------------------------------------------------------------------------------------------------

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.


WITH actores_music AS ( -- creamos un CTE con las múltiples join y el filtro de categoría
	SELECT DISTINCT a.actor_id -- hacemos un select distinct para que salgan las id una única vez
	FROM actor a 
	JOIN film_actor fa 
		ON a.actor_id = fa.actor_id 
	JOIN film f
		ON fa.film_id = f.film_id
	JOIN film_category fc 
		ON f.film_id = fc.film_id
	JOIN category c 
		ON fc.category_id = c.category_id
	WHERE c."name" = 'Music' -- filtramos por categoría 'Music'
)
SELECT concat(a."Nombre", ' ', a."Apellido" ) AS nombre_actor
FROM actor a 
WHERE a.actor_id NOT IN ( -- creamos subquery para búsqueda de actores que han participado en 'Music' y filtramos por las id que no coinciden en la subquery
	SELECT actor_id FROM actores_music
) 
;

---------------------------------------------------------------------------------------------------------

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT -- en el select incluimos los dias_alquilados para tener el resutado más visual
	f.title, 
	(r.return_date - r.rental_date) AS dias_alquilados
FROM  film f 
JOIN inventory i 
	ON f.film_id = i.film_id
JOIN rental r 
	ON i.inventory_id = r.inventory_id
WHERE (r.return_date - r.rental_date) > INTERVAL '8 DAYS'; -- ponemos interval para poder comparar con 8 días

---------------------------------------------------------------------------------------------------------

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ.

SELECT f.title
FROM film f 
WHERE f.film_id IN ( -- subquery que selecciona las id de film con categoria 'Animation'
	SELECT fc.film_id 
	FROM category c 
	JOIN film_category fc 
		ON c.category_id = fc.category_id
	WHERE c."name" ILIKE 'Animation' -- filtramos por 'Animation'
)
ORDER BY f.title; -- ordenamos alfabéticamente.

---------------------------------------------------------------------------------------------------------

/*-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ. 
Ordena los resultados alfabéticamente por título de película.*/

SELECT f.title
FROM film f 
WHERE f.length = ( -- subquery para encontrar la duracion de la peli 'Dancing Fever' para poder filtrar por pelis que duren igual.
	SELECT f.length
	FROM film f 
	WHERE f.title ILIKE 'Dancing Fever' -- filtramos por título de la peli
)
ORDER BY f.title; -- ordenamos alfabéticamente

---------------------------------------------------------------------------------------------------------

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

SELECT  
	concat(c.first_name ,' ', c.last_name) nombre_cliente,
	count(DISTINCT i.film_id) AS pelis_distintas_alquiladas -- añadimos el distinct dentro del count para que cuente id únicas
FROM customer c 
JOIN rental r 
	ON c.customer_id = r.customer_id
JOIN inventory i 
	ON r.inventory_id = i.inventory_id
GROUP BY C.customer_id ,nombre_cliente -- agrupamos por nombre y también por id para evitar nombres iguales
HAVING count(DISTINCT i.film_id) >=7 -- filtramos por mayor o igual 7 alquileres distintos
ORDER BY c.last_name -- ordenamos apellidos alfabéticamente
;	
	
---------------------------------------------------------------------------------------------------------

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

WITH alquiler_categoria AS (
	SELECT 
		c.name AS categoria,
		r.rental_id 
	FROM category c 
	JOIN film_category fc 
		ON c.category_id = fc.category_id
	JOIN inventory i 
		ON i.film_id = fc.film_id 
	JOIN rental r 
		ON r.inventory_id = i.inventory_id
)
SELECT 
	categoria,
	count(ac.rental_id) AS total_alquileres
FROM alquiler_categoria ac	
GROUP BY categoria
ORDER BY total_alquileres DESC;

---------------------------------------------------------------------------------------------------------

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

WITH categoria_peliculas AS ( -- creamos CTE con todas las peliculas estreneas en 2006 
SELECT 
	c."name" AS categoria,
	f.film_id
FROM category c 
JOIN film_category fc 
	ON c.category_id = fc.category_id
JOIN film f 
	ON fc.film_id = f.film_id
WHERE f.release_year = 2006 -- filtro por estreno en 2006
)
SELECT 
	cp.categoria,
	count(cp.film_id ) AS num_peliculas -- contamos el número de peliculas por categoria
FROM categoria_peliculas cp
GROUP BY cp.categoria
ORDER BY num_peliculas DESC; -- ordenamos por numero de pelis de más a menos

---------------------------------------------------------------------------------------------------------

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT *
FROM staff s, store st; -- realizamos CROSS JOIN para obtener todas las combinaciones.

---------------------------------------------------------------------------------------------------------

/*-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
su nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT
	c.customer_id ,
	concat(c.first_name , ' ', c.last_name ) AS nombre_cliente,
	count(r.rental_id ) AS cantidad_alquileres
FROM customer c 
JOIN rental r 
	ON c.customer_id = r.customer_id
GROUP BY c.customer_id, nombre_cliente
ORDER BY cantidad_alquileres DESC;
