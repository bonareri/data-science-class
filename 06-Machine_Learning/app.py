import streamlit as st
import pandas as pd
import joblib
import numpy as np

# Load model and scaler
model = joblib.load("gradient_boosting_model.pkl")
scaler = joblib.load("scaler.pkl")

st.title("Loan Approval Prediction App")
st.write("Enter applicant information to predict loan approval:")

# Collect user input
Gender = st.selectbox("Gender", ["Male", "Female"])
Married = st.selectbox("Married", ["Yes", "No"])
Education = st.selectbox("Education", ["Graduate", "Not Graduate"])
Self_Employed = st.selectbox("Self Employed", ["Yes", "No"])
ApplicantIncome = st.number_input("Applicant Income", min_value=0)
CoapplicantIncome = st.number_input("Coapplicant Income", min_value=0.0)
LoanAmount = st.number_input("Loan Amount", min_value=0.0)
Loan_Amount_Term = st.number_input("Loan Term (in months)", min_value=0)
Credit_History = st.selectbox("Credit History", [1.0, 0.0])
Property_Area = st.selectbox("Property Area", ["Urban", "Semiurban", "Rural"])

# Encode inputs
input_dict = {
    "Gender": 1 if Gender == "Male" else 0,
    "Married": 1 if Married == "Yes" else 0,
    "Education": 1 if Education == "Graduate" else 0,
    "Self_Employed": 1 if Self_Employed == "Yes" else 0,
    "ApplicantIncome": ApplicantIncome,
    "CoapplicantIncome": CoapplicantIncome,
    "LoanAmount": LoanAmount,
    "Loan_Amount_Term": Loan_Amount_Term,
    "Credit_History": Credit_History,
    "Property_Area_Semiurban": 1 if Property_Area == "Semiurban" else 0,
    "Property_Area_Urban": 1 if Property_Area == "Urban" else 0
}

input_df = pd.DataFrame([input_dict])

# Define numeric features
num_features = ["ApplicantIncome", "CoapplicantIncome", "LoanAmount", "Loan_Amount_Term", "Credit_History"]

# Preprocessing function to handle missing/extra columns and scaling
def preprocess_input(input_df, scaler, num_features):
    # Add missing numeric columns with default 0
    missing_cols = [col for col in num_features if col not in input_df.columns]
    for col in missing_cols:
        input_df[col] = 0

    # Drop extra columns not used in training
    extra_cols = [col for col in input_df.columns if col not in num_features and col not in ["Gender","Married","Education","Self_Employed","Property_Area_Semiurban","Property_Area_Urban"]]
    if extra_cols:
        input_df = input_df.drop(columns=extra_cols)

    # Reorder numeric columns
    input_df[num_features] = input_df[num_features][num_features]

    # Scale numeric features
    input_df[num_features] = scaler.transform(input_df[num_features])
    return input_df

# Preprocess input
input_df_scaled = preprocess_input(input_df.copy(), scaler, num_features)

# Predict
prediction = model.predict(input_df_scaled)[0]
prediction_proba = model.predict_proba(input_df_scaled)[0][1]

# Display results
st.subheader("Prediction:")
if prediction == 1:
    st.success(f"Loan Approved! Probability: {prediction_proba:.2f}")
else:
    st.error(f"Loan Not Approved. Probability: {prediction_proba:.2f}")
