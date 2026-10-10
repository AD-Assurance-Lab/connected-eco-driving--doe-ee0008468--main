# -*- coding: utf-8 -*-
"""
Created on Sun Jun 16 20:20:39 2019

@author: wmumc
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

from keras.models import Sequential
from keras.layers import LSTM, Dense
from keras import metrics

from sklearn.preprocessing import MinMaxScaler

import keras


myoptimizer = keras.optimizers.adam()

df = pd.read_csv("D04Cleaned.csv")

L = len(df)
 

Logitude = np.array ([df.ix[:,2]])
Lattitude = np.array ([df.ix[:,3]])
Velocity = np.array([df.ix[:,4]])
Label = np.array([df.ix[:,6]])
HorDilPre = np.array([df.ix[:,7]])
Altitude = np.array([df.ix[:,8]])
Bearing = np.array([df.ix[:,9]])
GX = np.array([df.ix[:,10]])
GY = np.array([df.ix[:,11]])
GZ = np.array([df.ix[:,12]])
Y = np.array ([df.ix[:,5]])

#for i in Logitude:
#    print(i)

#Logitude, = plt.plot(Logitude[0,:])
#Lattitude, = plt.plot(Lattitude[0,:])
#Y, = plt.plot(Y[0,:])
#plt.legend([Y,Logitude,Lattitude],['Velocoity','longitude', 'lattitude']) 
    
#Map = plt.scatter(Logitude[0,:],Lattitude[0,:])

print("I am finished")

X = np.concatenate([Logitude, Lattitude, Velocity, Label, HorDilPre, Altitude, Bearing, GX, GY, GZ], axis= 0) 
X = np.transpose(X)

Y = Y
Y = np.transpose(Y)

scaler = MinMaxScaler()
scaler.fit(X)
X = scaler.transform(X)

scaler1 = MinMaxScaler()
scaler1.fit(Y)
Y = scaler1.transform(Y)

# LSTM NN INPUT MUST BE 3 Dimensional Hence reshape
X = np.reshape(X,(X.shape[0],1,X.shape[1]))
print(X.shape)


model = Sequential()
#Use LSTM as input layer
model.add(LSTM(2000, activation= 'tanh' , input_shape = (1,10)))
#Make sure 1 and 2 dimention as input shape since we have 1 and 2
model.add(Dense(1))
model.compile(loss = "mean_squared_error", optimizer = 'rmsprop', metrics = [metrics.mae])
#model.fit(X,Y, epoch = 100, batch_size= 1, verbose = 2)
model.fit( X,Y,epochs = 50, batch_size =100, verbose =2)
Predict = model.predict(X, verbose = 1)
print(Predict)


plt.figure(3)
Test, =  plt.plot(Y)
Predict, = plt.plot(Predict)
plt.legend([Predict,Test], ["Predicted data", "Real data"])
plt.title("train data results")
plt.xlabel("timestep(seconds)")
plt.ylabel("velocity")
plt.show()

df1 = pd.read_csv("D01Cleaned.csv")
L = len(df1)
 
Logitude_test = np.array ([df1.ix[:,2]])
Lattitude_test = np.array ([df1.ix[:,3]])
Velocity_test = np.array([df1.ix[:,4]])
Label_test = np.array([df1.ix[:,6]])
Y_test = np.array ([df1.ix[:,5]])
HorDilPre_test = np.array([df1.ix[:,7]])
Altitude_test = np.array([df1.ix[:,8]])
Bearing_test = np.array([df1.ix[:,9]])
GX_test = np.array([df1.ix[:,10]])
GY_test = np.array([df1.ix[:,11]])
GZ_test = np.array([df1.ix[:,12]])

print(Y_test.shape)
print(Logitude_test.shape)
print(Lattitude_test.shape)
print(Velocity_test.shape)

X_test = np.concatenate([Logitude_test, Lattitude_test, Velocity_test, Label_test , HorDilPre_test, Altitude_test, Bearing_test, GX_test, GY_test, GZ_test ], axis= 0) 
X_test = np.transpose(X_test)

Y_test = Y_test
Y_test = np.transpose(Y_test)

scaler2 = MinMaxScaler()
scaler2.fit(X_test)
X_test = scaler2.transform(X_test)

scaler3 = MinMaxScaler()
scaler3.fit(Y_test)
Y_test = scaler3.transform(Y_test)

# LSTM NN INPUT MUST BE 3 Dimensional Hence reshape
X_test = np.reshape(X_test,(X_test.shape[0],1,X_test.shape[1]))
print(X_test.shape)

Predict_test = model.predict(X_test, verbose = 1)
print(Predict_test)


plt.figure(5)
Test1, =  plt.plot(Y_test)
Predict1, = plt.plot(Predict_test)
plt.legend([Predict1,Test1], ["Predicted data", "Real data"])
plt.title("test data results")
plt.xlabel("timestep(seconds)")
plt.ylabel("velocity")
plt.show()


