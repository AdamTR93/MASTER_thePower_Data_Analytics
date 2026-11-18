# Katas de Python — MASTER The Power Data Analytics

Colección de **40 ejercicios prácticos de Python** realizados como parte del máster en Data Analytics. El objetivo es afianzar los fundamentos del lenguaje mediante la resolución progresiva de problemas reales, desde manipulación de datos hasta control de flujo avanzado.

---

## Índice de Katas

| # | Descripción | Conceptos clave |
|---|-------------|-----------------|
| 1 | Frecuencia de letras en una cadena | Diccionarios, bucles, `.lower()` |
| 2 | Doble de cada valor en una lista | `map()`, funciones |
| 3 | Palabras que contienen una subcadena objetivo | List comprehension, `in` |
| 4 | Diferencia entre valores de dos listas | `zip()`, `map()` |
| 5 | Media de notas y estado aprobado/suspenso | Tuplas, parámetros opcionales |
| 6 | Factorial de un número (recursividad) | Recursión |
| 7 | Convertir lista de tuplas a lista de strings | `map()`, `join()` |
| 8 | Dividir dos números con manejo de errores | `try/except`, `ZeroDivisionError`, `ValueError` |
| 9 | Filtrar animales prohibidos en España | `filter()` |
| 10 | Promedio de lista con excepción personalizada | `raise`, `ValueError` |
| 11 | Validación de edad con bucle y excepciones | `while`, manejo de errores |
| 12 | Longitud de cada palabra en una frase | `map()`, `split()`, `len()` |
| 13 | Tuplas de letra en mayúsculas y minúsculas sin repetir | `map()`, `set()` |
| 14 | Palabras que empiezan por una letra específica | `filter()` |
| 15 | Números pares de una lista | `filter()`, operador módulo |
| 16 | Convertir Celsius a Fahrenheit | `map()`, fórmulas matemáticas |
| 17 | Calcular potencia de números | `map()`, `**` |
| 18 | Eliminar duplicados de una lista manteniendo orden | `set()`, listas |
| 19 | Ordenar lista de diccionarios por un campo | `sorted()`, `lambda` |
| 20 | Contar vocales en una cadena | Bucles, condicionales |
| 21 | Verificar si una cadena es palíndromo | Slicing `[::-1]` |
| 22 | Números de la secuencia Fibonacci | Recursión / iteración |
| 23 | Aplanar lista de listas | List comprehension anidado |
| 24 | Intersección de dos listas sin duplicados | `set()`, operaciones entre conjuntos |
| 25 | Validar contraseña con criterios múltiples | Condicionales, string methods |
| 26 | Calculadora básica con funciones | Funciones, condicionales |
| 27 | Convertir número a binario, octal y hexadecimal | `bin()`, `oct()`, `hex()` |
| 28 | Número primo | Bucles, condicionales |
| 29 | Anagramas entre dos palabras | `sorted()`, strings |
| 30 | Rotar lista N posiciones | Slicing |
| 31 | Suma de dígitos de un número | `str()`, bucles |
| 32 | Diccionario de frecuencia de palabras en un texto | Diccionarios, `split()` |
| 33 | Transponer una matriz | List comprehension, `zip()` |
| 34 | Número mayor y menor de una lista sin `min/max` | Bucles, comparación |
| 35 | Convertir lista de strings a enteros | `map()`, `int()` |
| 36 | Clasificar números en pares e impares | `filter()`, diccionarios |
| 37 | Determinar momento del día según la hora | Condicionales, rangos |
| 38 | Calificación en texto según nota numérica | Condicionales anidados |
| 39 | Calcular área de figura geométrica (rectángulo, triángulo, círculo) | Funciones, `math`, tuplas |
| 40 | Calculadora de precio con cupón de descuento | Input, condicionales, `float()` |

---

## Tecnologías y herramientas

- **Python 3.11**
- **Jupyter Notebook** (`.ipynb`)
- Entorno virtual con `.venv`

---

## Conceptos trabajados

- Funciones con docstrings y parámetros opcionales
- Programación funcional: `map()`, `filter()`, `zip()`
- Recursión
- Manejo de excepciones: `try / except / raise`
- Estructuras de datos: listas, tuplas, diccionarios, sets
- Comprensión de listas (*list comprehension*)
- Manipulación de strings
- Control de flujo: `while`, `for`, `if/elif/else`

---

## Cómo ejecutar el proyecto

### 1. Clona el repositorio

```bash
git clone https://github.com/TU_USUARIO/katas_python.git
cd katas_python
```

### 2. Crea y activa el entorno virtual

```bash
# Crear entorno virtual
python -m venv .venv

# Activar (Windows)
.venv\Scripts\activate

# Activar (Mac/Linux)
source .venv/bin/activate
```

### 3. Instala Jupyter

```bash
pip install notebook
```

### 4. Abre el notebook

```bash
jupyter notebook katas_python.ipynb
```

---

## Autor

**Adam**
Estudiante del Máster en Data Analytics — The Power Business School
