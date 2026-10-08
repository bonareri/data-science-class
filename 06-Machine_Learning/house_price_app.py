import streamlit as st
import pandas as pd
import joblib

model = joblib.load("nairobi_house_price_model.pkl")

st.title("Nairobi House Price Predictor")

location = st.selectbox(
    "Location",
    [
        "Kileleshwa",
        "Kilimani",
        "Riverside",
        "Westlands",
        "Lavington",
        "Nyari",
        "Runda",
        "Kitisuru",
        "Other"
    ]
)

property_type = st.selectbox(
    "Property Type",
    ["Apartment", "Townhouse"]
)

bedroom = st.number_input(
    "Number of Bedrooms",
    min_value=1,
    max_value=10,
    value=3
)

bathroom = st.number_input(
    "Number of Bathrooms",
    min_value=1,
    max_value=10,
    value=2
)

house_size = st.number_input(
    "House Size",
    min_value=1.0,
    value=100.0
)

if st.button("Predict Price"):

    new_house = pd.DataFrame({
        "Location": [location],
        "propertyType": [property_type],
        "Bedroom": [bedroom],
        "bathroom": [bathroom],
        "House size": [house_size]
    })

    prediction = model.predict(new_house)[0]

    st.success(
        f"Estimated House Price: KSh {prediction:,.2f} Million"
    )