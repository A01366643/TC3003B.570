import pandas as pd


wine_reviews = pd.read_json("winemag-data-130k-v2.json")


#print(wine_reviews.loc[wine_reviews.country == 'Mexico', ['country' , 'points']]) #filtrar renglones

#print(wine_reviews.points.describe()) #datos min max 50% 75% etc 

print(wine_reviews.country.unique()) # lista con los paises sin repetir



