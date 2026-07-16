import streamlit as st
import pickle
import re

# Load the pkl files
model = pickle.load(open('sentiment_model.pkl','rb'))
vectorizer = pickle.load(open('tfidf_vectorizer.pkl', 'rb'))


def clean_text(text):
    text = str(text).lower()
    text = re.sub(r'[^a-zA-Z\s]', ' ', text)
    return text



st.title("Sentiment Analysis Tool")
user_input = st.text_area("Enter your product review here:")

if st.button("Predict Sentiment"):
    if user_input:
        # Preprocess and predict
        cleaned_input = clean_text(user_input)
        vectorized_input = vectorizer.transform([cleaned_input])
        prediction = model.predict(vectorized_input)

        print(f"User Review :",{user_input})
        st.success(f"The predicted sentiment is: {prediction[0]}")
    else:
        st.warning("Please enter some text.")