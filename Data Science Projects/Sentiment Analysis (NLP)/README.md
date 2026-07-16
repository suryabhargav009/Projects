# 📊 Product Review Sentiment Analysis System

An end-to-end Machine Learning pipeline for processing, visualizing, and classifying eCommerce product reviews into **Positive**, **Neutral**, or **Negative** sentiments based on user ratings and textual reviews.

This project implements various Text Vectorization techniques (TF-IDF) alongside multiple Classical Machine Learning and Deep Learning architectures to deliver precise text classification boundaries and insights.

---

## 🚀 System Architecture & Pipeline

```
  [ Raw Dataset (.xlsx) ]
             │
             ▼
  [ Data Preprocessing ] ─────► Handle Duplicates & Missing Values
             │
             ▼
  [ Sentiment Mapping ]  ─────► Map 1-5 Ratings to Positive / Neutral / Negative
             │
             ▼
  [ Exploratory Data Analysis ] ──► Class Distributions, Word Lengths, Word Clouds
             │
             ▼
  [ Text Tokenization & NLTK ] ───► Tokenization, Lemmatization, Stop-word Removal
             │
             ▼
  [ Feature Extraction ] ─────► TF-IDF Vectorizer
             │
             ▼
  [ Predictive Modeling ] ────► Multi-Model Training, Cross-Validation & Diagnostics
             │
             ▼
  [ Performance Evaluation ] ──► Accuracy, F1-Score, Confusion Matrices
```

---

## 🛠️ Tech Stack & Key Dependencies

- **Core Analysis:** `Python 3.10+`, `Pandas`, `NumPy`
- **Natural Language Processing:** `NLTK` (WordNetLemmatizer, Stopwords), `Scikit-Learn` (TfidfVectorizer)
- **Data Visualization:** `Matplotlib`, `Seaborn`, `WordCloud`
- **Machine Learning Classifiers:**
  - Multinomial & Gaussian Naive Bayes (`MultinomialNB`, `GaussianNB`)
  - Logistic Regression & Linear Regression (`LogisticRegression`, `LinearRegression`)
  - Linear Support Vector Classification (`LinearSVC`)
  - Ensemble Methods (`RandomForestClassifier`, `GradientBoostingClassifier`)
  - Neural Networks (`MLPClassifier` Multi-layer Perceptron)

---

## 📊 Dataset Insights & Exploratory Data Analysis (EDA)

The system works on target labels derived from explicit review ratings mapping to continuous structural behavior:
- ⭐⭐⭐⭐ & ⭐⭐⭐⭐⭐ $ightarrow$ **Positive**
- ⭐⭐⭐ $ightarrow$ **Neutral**
- ⭐ & ⭐⭐ $ightarrow$ **Negative**

### Sample Target Feature Distributions
The dataset contains **1,440 structural observation rows** across 3 primary source attributes: `title`, `rating`, and `body`.

```
Attributes Details:
 0   title   1440 non-null   object (Review Heading)
 1   rating  1440 non-null   int64  (Explicit Score 1-5)
 2   body    1440 non-null   object (Textual Review Content)
```

---

## ⚙️ Execution Pipeline & Code Footprint

### 1. Data Cleaning & Processing
```python
# Initial Setup & Cleaning
import pandas as pd

df = pd.read_excel('dataset -P684.xlsx')
df.dropna(inplace=True)
df.drop_duplicates(inplace=True)

# Categorical Label Mapping
def map_sentiment(rating):
    if rating >= 4: return "Positive"
    elif rating <= 2: return "Negative"
    else: return "Neutral"

df['Sentiment'] = df['rating'].apply(map_sentiment)
```

### 2. Text Engineering & Natural Language Normalization
Prior to model ingest, text sequences go through tokenization, casing normalization, and lemmatization:
```python
import re
import string
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer

lemmatizer = WordNetLemmatizer()
stop_words = set(stopwords.words('english'))

def clean_text(text):
    text = str(text).lower()
    text = re.sub(r'[^a-zA-Z\s]', '', text) # Remove punctuation & numbers
    words = text.split()
    cleaned_words = [lemmatizer.lemmatize(w) for words in words if w not in stop_words]
    return ' '.join(cleaned_words)
```

### 3. Model Training & Validation
Features are parsed through an $N$-gram structural TF-IDF vector space before fitting across the multi-model architecture matrix:
```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.model_selection import train_test_split

tfidf = TfidfVectorizer(max_features=5000)
X = tfidf.fit_transform(df['body'])
y = df['Sentiment']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Classifier Evaluation Loop Execution Example
model = RandomForestClassifier()
model.fit(X_train, y_train)
preds = model.predict(X_test)
```

---

## 📈 Evaluation Matrix & Key Reports

Performance metrics evaluated on unseen text spaces include:
* **Precision / Recall / F1-Score Matrix** per class level (Positive, Neutral, Negative).
* **Confusion Matrix Generation** via `seaborn` hitmaps to diagnose misclassification bounds between structural margins (e.g., Neutral vs. Negative boundaries).

---

## 📋 Installation & Set Up

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/sentiment-analysis-pipeline.git
cd sentiment-analysis-pipeline
```

### Step 2: Install Virtual Environment & Requirements
```bash
python -m venv venv
source venv/bin/activate  # On Windows use: venv\Scripts\activate
pip install -r requirements.txt
```

### Step 3: Run Jupyter Notebook Pipeline
```bash
jupyter notebook sentiment_analysis.ipynb
```

---

## 📜 License
This project is open-source software licensed under the MIT License.
