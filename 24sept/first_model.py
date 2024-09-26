import pandas as pd

melbourne_file_path = 'melb_data.csv'

melbourne_data = pd.read_csv(melbourne_file_path)
melbourne_data = melbourne_data.dropna(axis = 0)
y = melbourne_data.Price

print(y)
print(y.shape)


melbourne_features = ['Rooms', 'Bathroom', 'Landsize', 'Lattitude', 'Longtitude']

x = melbourne_data[melbourne_features]

print(x)
print(x.shape)


from sklearn.tree import DecisionTreeRegressor
melbourne_model = DecisionTreeRegressor(random_state = 1)

# fit model
print('trainning...')
melbourne_model.fit(x,y)
print('done.')

print('Making predictions for the following 5 houses')
print(x.head())

print('The predictions are')
print(melbourne_model.predict(x.head()))

print('Real prices')
print(y.head())