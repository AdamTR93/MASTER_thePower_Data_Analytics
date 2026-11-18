#Tratamiento de datos
import pandas as pd
from IPython.display import display
import numpy as np

#visualizaciones
import seaborn as sns
import matplotlib.pyplot as plt



def analisis_rapido(df, n=5):
    """
    Proporciona un vistazo veloz al DataFrame: dimensiones, primeras filas,
    info general, duplicados y nulos.
    """
    print(f"--- Dimensiones del dataset: {df.shape[0]} filas y {df.shape[1]} columnas ---")
    print(f"--- Las {n} primeras filas de df_mkt son: ---")
    display(df.head(n))
    
    print("\n--- Información básica y tipos de datos: ---")
    df.info()
    
    print(f"\n--- Número de filas duplicadas: {df.duplicated().sum()} ---")
    
    print("\n--- Porcentaje de valores nulos por columna (%): ---")
    nulos = (df.isna().mean() * 100).round(2)
    if not nulos[nulos > 0].empty:
        display(nulos[nulos > 0])
    else:
        print("No hay valores nulos en el dataset.")

def calcular_tasa_base(df, columna_target="subscribed"):
    """
    Calcula y muestra la tasa base de la variable objetivo.
    """
    tasa_base = (df[columna_target] == "yes").mean() * 100
    print(f"Tasa base ({columna_target}): {tasa_base:.2f}%")
    return tasa_base

def revision_datos(df, n=2):
    """
    Realiza una revisión analítica profunda separando variables numéricas 
    (con sus estadísticos) y categóricas (con sus frecuencias).
    """
    num_cols = df.select_dtypes(include='number').columns
    cat_cols = df.select_dtypes(include=['object', 'category']).columns

    print(f"Variables numéricas ({len(num_cols)}): {list(num_cols)}")
    print(f"Variables categóricas ({len(cat_cols)}): {list(cat_cols)}")

    print("\n--- Estadísticas básicas (Numéricas): ---")
    display(df.describe().T.round(n))
    
    print("\n--- Estadísticas básicas (Categóricas): ---")
    display(df.describe(include=['category', 'object']).T.round(n))

    print("\n--- Desglose detallado de Variables Categóricas: ---")
    for col in cat_cols:
        print(f"\n* Columna: '{col}' (Únicos: {df[col].nunique()})")
        display(df[col].value_counts(dropna=False))


def formatear_p(p):
    """
    Función para escribir p-valores de forma legible
    
    """
    if p < 0.001:
        return "< 0.001"
    return round(p, 3)

def cohen_d(a, b):
    desv = ((a.std() ** 2 + b.std() ** 2) / 2) ** 0.5    # Desviación típica combinada
    return (a.mean() - b.mean()) / desv                  # Diferencia de medias entre esa desviación



COLOR_YES = "#E4572E"          # Naranja: línea de la tasa base
COLOR_PRINCIPAL = "#1F3A5F"    # Azul oscuro: gráficos de una sola serie

def tabla_tasa(df, variable):
    """
    Tabla con nº de clientes y % de yes/no en cada categoría.
    
    """
    conteo = pd.crosstab(df[variable], df["subscribed"])
    porcentaje = pd.crosstab(df[variable], df["subscribed"], normalize="index") * 100
    return pd.concat([conteo, porcentaje.round(2)], axis=1,
                     keys=["num. clientes", "porcentaje (%)"])

def grafico_tasa(df, variable, titulo, xlabel, ordenar=False, rotar=0, ancho=7,excluir=None):
    """
    Barras con la tasa de contratación de cada categoría y la tasa base.
    
    """
    tasa_base = (df["subscribed"] == "yes").mean() * 100
    tasa = pd.crosstab(df[variable], df["subscribed"], normalize="index")["yes"] * 100

    if excluir:
        tasa = tasa.drop(excluir)
    if ordenar:
        tasa = tasa.sort_values(ascending=False)

    plt.figure(figsize=(ancho, 4)) 
    sns.barplot(x=tasa.index.astype(str), y=tasa.values, color=COLOR_PRINCIPAL)
    plt.axhline(tasa_base, color=COLOR_YES, linestyle="--",label=f"Tasa base ({tasa_base:.2f} %)")
    for i, valor in enumerate(tasa.values):
        plt.text(i, valor + 0.3, f"{valor:.1f} %", ha="center")
    plt.title(titulo)
    plt.xlabel(xlabel)
    plt.ylabel("% que contrata")
    plt.xticks(rotation=rotar, ha="right" if rotar else "center")
    plt.legend()
    plt.show()