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


from sklearn.metrics import mean_absolute_error

predicted_home_price = melbourne_model.predict(x)
print(mean_absolute_error(y,predicted_home_price ))

