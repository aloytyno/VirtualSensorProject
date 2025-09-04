# -*- coding: utf-8 -*-
'''
Created on Tue  Apr 29th 2025

@author: aloytyno
Copyright 2025 The MathWorks, Inc.

'''

import pandas as pd
from sklearn.ensemble import BaggingRegressor
from sklearn.tree import DecisionTreeRegressor

def train_random_forest_regressor(df, n_estimators=100, random_state=42):
    """
    Trains a Random Forest Regressor.
    Excludes the first column and 'TrueAirSpeed' from predictors.
    Uses 'TrueAirSpeed' as the response variable.
    """
    if "TrueAirSpeed" not in df.columns:
        raise ValueError("The DataFrame must contain a column named 'TrueAirSpeed'.")

    # Exclude first column and 'TrueAirSpeed'
    exclude_columns = [df.columns[0], "TrueAirSpeed"]
    feature_columns = [col for col in df.columns if col not in exclude_columns]
    X = df[feature_columns]
    y = df["TrueAirSpeed"]
    
    # Define the base learner (Decision Tree with min_samples_leaf = 1)
    base_learner = DecisionTreeRegressor(min_samples_leaf=1)
    
    # Define the bagged ensemble model (100 trees)
    model = BaggingRegressor(
        estimator=base_learner,
        n_estimators=100,
        bootstrap=True,
        n_jobs=1,   # Use all CPU cores for speed
        random_state=42
    )

    # model = RandomForestRegressor(n_estimators=n_estimators, random_state=random_state)
    model.fit(X, y)
    
    return model

def predict_with_model(model, new_data):
    """
    Makes predictions using the trained Random Forest model.
    Excludes the first column and 'TrueAirSpeed' from predictors.
    """
    # Exclude first column and 'TrueAirSpeed' if present in new_data
    exclude_columns = [new_data.columns[0]]
    if "TrueAirSpeed" in new_data.columns:
        exclude_columns.append("TrueAirSpeed")
    prediction_columns = [col for col in new_data.columns if col not in exclude_columns]
    X_new = new_data[prediction_columns]
    return model.predict(X_new)

