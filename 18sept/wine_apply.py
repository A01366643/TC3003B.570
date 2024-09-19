import pandas as pd

def remean_point(row):
    row.point = row.points - review_point_mean
    return row


wine_reviews = pd.read_json("winemag-data-130k-v2.json")

review_point_mean = wine_reviews.points.mean()
print(review_point_mean)

wine_map = wine_reviews.apply(remean_point, axis = 'columns')
print(wine_map)
