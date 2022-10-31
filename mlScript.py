import pandas as pd
import numpy as np
import tensorflow as tf
import glob
import keras
import seaborn as sns
import pickle
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.neighbors import KNeighborsClassifier


import warnings
warnings.filterwarnings("ignore")

with open('accountDict.pkl', 'rb') as f:
    accountDict = pickle.load(f)
with open('cityDict.pkl', 'rb') as f:
    cityDict = pickle.load(f)
with open('serviceDict.pkl', 'rb') as f:
    serviceDict = pickle.load(f)

loaded_model = pickle.load(open('KNN_model.sav', 'rb'))

accountName = 'belgotex nz ltd'
senderCity = 'auckland'
receiverCity = 'christchurch'
serviceType = 'supereconomy'
leggingCost = 48.57

accountName = accountDict[accountName]
senderCity = cityDict[senderCity]
receiverCity = cityDict[receiverCity]
serviceType = serviceDict[serviceType]
print("accountName:", accountName, "\nsenderCity:", senderCity, "\nreceiverCity:",
      receiverCity, "\nserviceType:", serviceType, "\nleggingCost:", leggingCost)

predicted = loaded_model.predict(
    [[accountName, senderCity, receiverCity, serviceType, leggingCost]])
print("\nRecommending Carrier:", predicted[0].upper())
