import pandas as pd

wine_reviews = pd.read_csv("winemag-data-130k-v2.csv")

print(wine_reviews.shape) # dimension/orden
print(wine_reviews.head ) # los primeros y ultimos registros