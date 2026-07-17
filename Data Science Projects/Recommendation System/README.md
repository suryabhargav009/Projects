# Anime Recommendation System

A Content-Based and Collaborative Filtering Anime Recommendation System built using Python, pandas, and scikit-learn. This system analyzes anime datasets containing attributes such as genres, broadcasting types, episodes, and member counts to clean the data, visualize insights through Exploratory Data Analysis (EDA), and lay out the structure for building tailored recommendations.

## 📊 Dataset Insights & Analytics
The system processes a dataset of **12,294 anime titles** with the following raw attributes:
* `anime_id`: Unique identifier for each anime.
* `name`: The title of the anime.
* `genre`: Comma-separated list of genres.
* `type`: Broadcasting type (TV, Movie, OVA, Special, ONA, Music).
* `episodes`: Number of episodes (contains numeric values and string placeholders like 'Unknown').
* `rating`: Average user rating out of 10.
* `members`: Number of community members added to their list.

### Data Cleaning & Preprocessing
* Missing values in `genre` (62 rows) and `type` (25 rows) were filled with placeholders (`Unknown`/empty strings).
* Missing `rating` values (230 rows) and `episodes` values were imputed using their respective mathematical medians (e.g., median rating of **6.57**).
* Handled string anomalies in `episodes` by coercing non-numeric formats into valid representations.
* Cleaned HTML entities (like `&#039;`) in anime names using unescaping utilities to make text human-readable.

## 📈 Visualizations Included
The exploratory phase contains automated scripts generated to plot and save statistical charts:
1. **Distribution of Anime Ratings:** Displays a histogram showing frequency counts alongside markers pointing out the clear mean and median metrics.
2. **Top 10 Most Popular Anime:** A horizontal bar chart highlighting titles sorted by community member volumes.
3. **Top 10 Highest Rated Anime:** A horizontal bar chart breaking down the critically acclaimed masterpieces based on score thresholds.
4. **Anime by Broadcast Type:** A multi-plot visual representation comprising a pie chart and a corresponding frequency count bar chart with labels to depict distribution metrics across distribution types.
5. **Top 20 Most Common Anime Genres:** A bar chart splitting the comma-separated multi-label tokens to display total occurrences per category.
6. **Correlation Matrix Scatter Plot:** Explores statistical links mapping out the direct connection thresholds between scores and general engagement metrics (Log-transformed).

## 🚀 Key Libraries and Dependencies
The project leverages core Python packages optimized for data manipulation, mathematical operations, scientific visualization, and vector mapping:
```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import warnings
from sklearn.preprocessing import MinMaxScaler
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import html
```

## 🛠️ Step-by-Step Execution Profile
1. **Import Libraries:** Set filtering limits to hide runtime warning triggers.
2. **Load the Dataset:** Read `anime.csv` and report high-level structural shapes.
3. **Data Preprocessing:** Handle column types, correct raw encoding artifacts, and cleanly impute missing indices.
4. **Exploratory Data Analysis:** Run analytical visualizations to parse dataset density properties.
5. **Engine Construction Architecture:** Tokenize textual metadata structures using `TfidfVectorizer` and map relationship vectors via `cosine_similarity` metrics to query recommendations.
