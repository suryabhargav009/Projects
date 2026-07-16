
import html
import pickle
import numpy as np
import pandas as pd
import streamlit as st
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# 1. Page Configuration
st.set_page_config(page_title="Anime Recommendation System", layout="centered")
st.title("🎬 Anime Recommendation System")

# 2. Load the Pickled Dataframe & Compute TF-IDF Matrix (Cached for speed)
@st.cache_data
def load_and_process_data():
    with open("anime_list.pkl", "rb") as f:
        df_clean = pickle.load(f)

    # Re-create the TF-IDF Vectorizer on the genre column (just like your notebook)
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(df_clean['genre'])

    return df_clean, tfidf_matrix

try:
    df, tfidf_matrix = load_and_process_data()

    # 3. Dropdown Menu for Selection
    anime_list = df["name"].values
    selected_anime = st.selectbox(
        "Type or select an anime you like:", anime_list
    )

    # 4. Recommendation Logic (Triggered on Button Click)
    if st.button("Recommend"):
        st.subheader(f"Because you watched '{selected_anime}':")

        # Find the index of the selected anime
        idx = df[df['name'] == selected_anime].index[0]

        # DYNAMIC CALCULATION: Compute cosine similarity only for the SELECTED anime 
        # against the entire matrix. This keeps memory usage low and runs instantly.
        sim_scores = cosine_similarity(tfidf_matrix[idx], tfidf_matrix).flatten()

        # Get the top 11 most similar anime indices (including itself)
        similar_indices = np.argsort(sim_scores)[::-1][:11]

        # Filter out the selected anime itself and pick the top 5 distinct recommendations
        recommended_anime = []
        for i in similar_indices:
            if df.iloc[i]['name'] != selected_anime:
                recommended_anime.append(df.iloc[i])
            if len(recommended_anime) == 5:
                break

        # 5. Display Recommendations
        for anime in recommended_anime:
            # Unescape any remaining HTML characters (e.g., &#039; to ')
            clean_name = html.unescape(anime['name'])
            st.write(f"⭐ **{clean_name}** | Type: *{anime['type']}* | Rating: `{anime['rating']}`")

except FileNotFoundError:
    st.error("Error: 'anime_list.pkl' not found. Please ensure it is in your root directory.")
