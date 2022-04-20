import pandas as pd
import numpy as np
from os import path
from PIL import Image
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
import matplotlib.pyplot as plt
from pca import pca as PCA
from sklearn.cluster import KMeans
from basic_analytics import *
import matplotlib.pyplot as plt

from sklearn.feature_extraction.text import TfidfVectorizer, ENGLISH_STOP_WORDS
from sklearn.pipeline import make_pipeline
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans, MiniBatchKMeans
from sklearn.manifold import TSNE
from sklearn.decomposition import TruncatedSVD
from sklearn.preprocessing import normalize
from sklearn.metrics.pairwise import linear_kernel
from numpy.random import RandomState

from key_word_helpers import *

def word_cloud(email_df):
    cols_to_keep = ['Body']
    email_df = email_df[cols_to_keep]
    text = " ".join(word for word in email_df.Body.astype(str))
    print("There are {} words in the combination of all cells in column body.".format(len(text)))
    stopwords = set(STOPWORDS)
    stopwords.update(["20", "00", "916"])
    wordcloud = WordCloud(stopwords=stopwords, background_color="white", width=800, height=400).generate(text)

        #  Display the generated image:
        # the matplotlib way:

    plt.axis("off")
    plt.figure( figsize=(40,20))
    plt.tight_layout(pad=0)
    plt.imshow(wordcloud, interpolation='bilinear')
    plt.show()

def word_cluster(email_df):
    # Lets create a new frame with the data we need.
    print(type(email_df))
    rng = RandomState()
    train = email_df.sample(frac=0.7, random_state=rng)
    test = email_df.loc[~email_df.index.isin(train.index)]
    stopwords = ENGLISH_STOP_WORDS.union(['ect', 'hou', 'com', 'recipient'])
    vect = TfidfVectorizer(analyzer='word', stop_words=stopwords, max_df=0.3, min_df=2)
    X = vect.fit_transform(train['Body'].values.astype('U'))  ## Even astype(str) would work
    features = vect.get_feature_names_out()

    print(top_mean_feats(X, features, None, 0.1, 10))

    # As clustering algorithm KMeams is a perfect fit.
    n_clusters = 3
    clf = KMeans(n_clusters=n_clusters,
                max_iter=100,
                init='k-means++',
                n_init=1)
    labels = clf.fit_predict(X)

    # Need to make 2D coordinates from the sparse matrix.
    X_dense = X.todense()
    pca = PCA(n_components=2).fit(X_dense)
    coords = pca.transform(X_dense)

    # This array needs to be at least the length of the n_clusters.
    label_colors = ["#2AB0E9", "#2BAF74", "#D7665E", "#CCCCCC",
                    "#D2CA0D", "#522A64", "#A3DB05", "#FC6514"]
    colors = [label_colors[i] for i in labels]

    # Plot the cluster centers
    centroids = clf.cluster_centers_
    centroid_coords = pca.transform(centroids)


    #Print the top terms per cluster with matplotlib.
    plot_tfidf_classfeats_h(top_feats_per_cluster(X, labels, features, 0.1, 25))
    return

def word_cosine(email_df):
    rng = RandomState()
    train = email_df['Body'].sample(frac=0.7, random_state=rng)
    test = email_df['Body'].loc[~email_df['Body'].index.isin(train.index)]
    stopwords = ENGLISH_STOP_WORDS.union(['ect', 'hou', 'com', 'recipient'])
    vec = TfidfVectorizer(analyzer='word', stop_words=stopwords, max_df=0.3, min_df=2)
    vec_train = vec.fit_transform(email_df['Body'])
    # Find cosine similarity between the first email and all others.
    cosine_sim = linear_kernel(vec_train[0:1], vec_train).flatten()
    # Finding emails related to a query.
    query = "cat urine odor"

    # Transform the query into the original vector
    vec_query = vec.transform([query])

    cosine_sim = linear_kernel(vec_query, vec_train).flatten()

    # Find top 10 most related emails to the query.
    related_email_indices = cosine_sim.argsort()[:-10:-1]
    # print out the indices of the 10 most related emails.
    print(related_email_indices)

    
    for x in range(1, 2):
        print(email_df['Body'].to_numpy()[related_email_indices[x]])

    return