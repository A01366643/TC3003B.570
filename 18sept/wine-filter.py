import pandas as pd

wine_reviews = pd.read_csv("winemag-data-130k-v2.csv")

#print(wine_reviews.country) # filtar por pais

#print(wine_reviews.loc[:, ['country' , 'points']]) #filtrar columnas

#print(wine_reviews.loc[wine_reviews.country == 'Italy', ['country' , 'points']]) #filtrar renglones
print(wine_reviews.loc[wine_reviews.country == 'Mexico', ['country' , 'points']]) #filtrar renglones
