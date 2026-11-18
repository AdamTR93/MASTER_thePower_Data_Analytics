⚽📊Análisis de Lesiones en el Fútbol Profesional (Excel)

📖 Descripción del Proyecto

Este proyecto consiste en un análisis exploratorio de datos (EDA) y la creación de un dashboard en Excel a partir de un dataset de lesiones de jugadores de fútbol profesional.

El objetivo principal es analizar el impacto de las lesiones en términos de días de baja y partidos perdidos, así como identificar patrones relevantes según posición, club, liga y temporada.

El proyecto se ha planteado como un caso práctico real, simulando un análisis que podría ser utilizado por departamentos deportivos, médicos o de rendimiento para la toma de decisiones basada en datos de lesiones.

Las principales técnicas utilizadas incluyen:

- Limpieza y preparación de datos en Excel
- Análisis exploratorio mediante tablas dinámicas
- Creación de KPIs y visualizaciones
- Diseño de un dashboard interactivo con segmentadores

-------------------------------------------------------------------------------------------------------------------------------------------------------------

🖼️ Vista Previa del Dashboard
![Dashboard de Lesiones](DASHBOARD_LESIONES.png)

-------------------------------------------------------------------------------------------------------------------------------------------------------------

🗂️ Estructura del Proyecto

.
├── full_dataset_thesis - 1.csv    # Dataset original con los datos brutos
├── Proyecto_Dashboard_EDA.xlsx    # Archivo Excel (Power Query, Limpieza y Dashboard)
└── README.md                      # Documentación detallada del proyecto

----------------------------------------------------------------------------------------------------------------------------------------------------------------


🛠️ Herramientas:

Este proyecto se ha desarrollado en Microsoft Excel.

No se requieren librerías externas ni entornos adicionales.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

📊 Resultados y Conclusiones

Transformación del dataset:

- Se ha ajustado el formato de las fechas de mm/dd/yy a dd/mm/yy para una mejor comprensión. A través de power query. 
- Se ha creado la columna total_days para tener la columna de los días totales lesionado sin la palabra days. =VALOR(SUSTITUIR(C2;" days";""))
- Se ha creado la columna injury_calculate para calcular manualmente los días lesionados para compararlo con la columna total_days. =([@[injury_end_date]]-[@[injury_start_date]])
- Se ha creado una columna revisión para ver si coincidían los dos números, pero no coincidían, eso se debe a que Excel al restar no cuenta con el primer día, por lo tanto    hemos tenido que sumarle 1 a la columna de injury_calculate. =([@[injury_end_date]]-[@[injury_start_date]])+1
- Ocultamos las dos columnas, injury_calculate y revisión, y nos quedamos con la columna total_days una vez comprobado que todo es correcto. =SI(G2=I2;"OK";"Revisar")
- Se comprueba que no hay duplicados.
- Se decide realizar el análisis a partir de junio de 2020 ya que solo había 5 datos previos a ese mes en febrero y en mayo, por lo tanto se descartan para el análisis.
- Se crea una columna de duración de la lesión (injury_length) para saber si es de corta, media o larga duración con la siguiente fórmula =SI([@[total_days]]<=7;"Short";SI([@[total_days]]<=30;"Medium";"Long"))
- Se ha encontrado en el dataset que Midfielder había un único jugador "Mohamed Gouaida", se ha buscado su posición y se le ha incluido en "Central Midfield".
- Se ha modificado el formato de la columna injury a la primera letra mayúscula ya que había algunas lesiones en minúscula. A través de power query Transformar->Formato ->Poner en Mayúsculas cada palabra.



A partir del análisis realizado, se pueden extraer conclusiones como:

- Qué ligas sufren una mayor carga de lesiones y cómo varía la disponibilidad de los jugadores según la competición.

- Qué posiciones en el campo muestran una mayor frecuencia de lesiones, permitiendo identificar si el desgaste físico es mayor en posiciones de campo específicas.

- La proporción entre lesiones de corta, media y larga duración, y cómo esto afecta a la planificación de las plantillas.

- Cuáles son los diagnósticos más comunes (isquiotibiales, musculares, etc.) que afectan más a los jugadores.

El dashboard permite:

- Segmentar la información por temporada, liga, posición del jugador y la duración de la lesión para un análisis de los datos.

- Visualizar rápidamente el volumen total de lesiones, los días acumulados de baja y el promedio de partidos perdidos. (KPI's)

- Identificar picos de lesiones a lo largo de los meses del año para detectar periodos de mayor riesgo de lesión.

- Identificar el "Top de lesiones" más frecuentes para enfocar los esfuerzos en esos tipos de lesiones.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

🔄 Próximos Pasos

Posibles mejoras y ampliaciones del proyecto:

- Añadir más temporadas para analizar tendencias a largo plazo.
- Incorporar métricas de reincidencia de lesiones.
- Comparar lesiones antes y después de determinadas edades.
- Añadir ligas fuera de Europa para posibles comparaciones.
.

----------------------------------------------------------------------------------------------------------------------------------------------------------------

🤝 Contribuciones

Las contribuciones son bienvenidas.

Si deseas mejorar el proyecto, puedes:

- Abrir una *issue* con sugerencias
- Proponer mejoras mediante un *pull request*

----------------------------------------------------------------------------------------------------------------------------------------------------------------

✒️ Autor

- Proyecto desarrollado por Adam Tomàs
- GitHub: 

----------------------------------------------------------------------------------------------------------------------------------------------------------------

📌 Este proyecto forma parte de un ejercicio práctico de análisis de datos orientado a portfolio.
