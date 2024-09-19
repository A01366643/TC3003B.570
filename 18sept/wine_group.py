import pandas as pd


wine_reviews = pd.read_json("winemag-data-130k-v2.json")

#wine_group = wine_reviews.groupby('points').points.count()

#wine_group = wine_reviews.groupby('points').price.max()

#wine_group = wine_reviews.groupby(['country', 'province']).apply(lambda df: df.loc[df.points.idxmax()])

wine_group = wine_reviews.groupby(['country']).price.agg([len, min, max])

print(wine_group)
