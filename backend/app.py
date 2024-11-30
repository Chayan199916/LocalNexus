from flask import Flask, request, jsonify
from transformers import pipeline
from datetime import datetime
import spacy
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from collections import Counter
import json

# Download required NLTK data
nltk.download('punkt')
nltk.download('punkt_tab')
nltk.download('stopwords')
nltk.download('averaged_perceptron_tagger')
nltk.download('maxent_ne_chunker')
nltk.download('words')

# Initialize Flask app
app = Flask(__name__)

# Initialize NLP models
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")
sentiment_analyzer = pipeline("sentiment-analysis")
nlp = spacy.load("en_core_web_sm")


@app.route('/process-message', methods=['POST'])
def process_message():
    data = request.json
    text = data.get('text', '')

    # Entity extraction using spaCy
    doc = nlp(text)
    entities = [ent.text for ent in doc.ents]

    # Sentiment analysis using transformers
    sentiment_result = sentiment_analyzer(text)[0]
    sentiment_score = sentiment_result['score']
    if sentiment_result['label'] == 'NEGATIVE':
        sentiment_score = -sentiment_score

    # Topic extraction
    tokens = word_tokenize(text.lower())
    stop_words = set(stopwords.words('english'))
    tokens = [token for token in tokens if token.isalnum()
              and token not in stop_words]

    # Get frequency distribution
    freq_dist = Counter(tokens)
    topics = [word for word, _ in freq_dist.most_common(3)]

    # Calculate importance score
    urgent_words = {'urgent', 'important', 'asap',
                    'emergency', 'critical', 'deadline'}
    importance_score = sum(
        1 for token in tokens if token in urgent_words) / len(tokens)
    importance_score = min(max(importance_score + 0.3, 0),
                           1)  # Normalize between 0 and 1

    return jsonify({
        'entities': entities,
        'sentiment': sentiment_score,
        'topics': topics,
        'importance_score': importance_score
    })


@app.route('/create-summary', methods=['POST'])
def create_summary():
    data = request.json
    messages = data.get('messages', [])
    summary_type = data.get('type', '')

    # Combine all messages
    combined_text = ' '.join([msg['content'] for msg in messages])

    # Generate summary using BART
    summary = summarizer(combined_text, max_length=130,
                         min_length=30, do_sample=False)[0]['summary_text']

    # Extract entities from all messages
    doc = nlp(combined_text)
    entities = list(set(ent.text for ent in doc.ents))

    # Get overall sentiment
    sentiment_results = sentiment_analyzer(combined_text)[0]
    sentiment_score = sentiment_results['score']
    if sentiment_results['label'] == 'NEGATIVE':
        sentiment_score = -sentiment_score

    # Extract key topics
    tokens = word_tokenize(combined_text.lower())
    stop_words = set(stopwords.words('english'))
    tokens = [token for token in tokens if token.isalnum()
              and token not in stop_words]
    freq_dist = Counter(tokens)
    topics = [word for word, _ in freq_dist.most_common(5)]

    return jsonify({
        'summary': summary,
        'entities': entities,
        'sentiment': sentiment_score,
        'topics': topics
    })


if __name__ == '__main__':
    app.run(debug=True, port=5000)
