import pandas as pd


wine_reviews = pd.read_json("winemag-data-130k-v2.json")

review_point_mean = wine_reviews.points.mean()
print(review_point_mean)

wine_map = wine_reviews.points.map(lambda p:p - review_point_mean)
print(wine_map)
