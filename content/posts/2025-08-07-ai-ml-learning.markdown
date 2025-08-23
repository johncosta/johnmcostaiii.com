---
title: "Book Notes: AI and Machine Learning for Coders - A Programmer's Guide to Artificial Intelligence"
date: "2025-08-07"
comments: true
tags: ["software", "development", "ai", "machine learning", "book notes"]
categories: ["software development", "artificial intelligence"]
---

## Overview

This post contains my notes on the book *AI and Machine Learning for Coders - A Programmer's Guide to Artificial Intelligence* by Laurence Moroney[^1]. The book is a practical guide to building AI and machine learning applications using TensorFlow and Keras. It covers the basics of machine learning, deep learning, and neural networks, and provides hands-on examples of how to build and deploy AI applications.

You can find the book on [Amazon](https://www.amazon.com/Machine-Learning-Coders-Programmers-Intelligence/dp/1492078190/ref=sr_1_1?crid=Z4Y21T5D2TAI&dib=eyJ2IjoiMSJ9.r49jgbX_SxOsAZOy3KnPP4zUnXMLep1iiHFoMbAvbRsRlUX2YSooedGJq2RJXEJT9_RHinf54LLJqGo6eLNnr27slD-DFFOUfkCF7d-8iJpZNCYMK2fxwSDBBT0z9yqJ2fIYGX0xe-mfUQfyZVRnTrpxk7zohe1mUWhyfOGCaeQeMVF8NBCUDleKtd_fHYVde3d76lbpeMRHF1Lfvdz71yV4lwQmTvJDcaMszRwEEVc.BZ4X38MP0_chxsMnb5xEIbPPj7AB4VYi5MRNKgnQfa8&dib_tag=se&keywords=ai+and+machine+learning+for+coders&qid=1754566931&sprefix=AI+and+Mac%2Caps%2C154&sr=8-1)

I'll be adding my notes to this post as I read through the book. The notes will be organized by chapter and will include key concepts, code examples, and any additional insights I find useful.

## Chapter 1: Introduction to tensorflow

In chapter 1 you’ll learn about the limitations of traditional programming and get some initial insight into Machine Learning.  You’ll learn how to install tensorflow, in my case on a M2 Mac.

I searched around a little to see what common issues occurred for mac installations and came across [a handy blog](https://medium.com/@auslei/how-to-install-tensorflow-with-gpu-for-apple-silicon-and-windows-with-nvidia-gpu-0409d13c56eb) that covered different tensorflow installation options and included a handy script to verify tensorflow was indeed using my gpu. After a brief hiccup I added the following packages to my installation, re-ran the script and was on my way.

```bash
pip install tensorflow
pip install tensorflow-macos tensorflow-metal
```

At the end of this chapter you’ll build and train your first model, a simple linear regression model that predicts the output of a linear equation.

**__Note__**: Using the coding samples located in GitHub will make following along really easy. https://github.com/lmoroney/tfbook

## Chapter 2: Introduction to Computer Vision

Using the Fashion MNIST dataset, chapter 2 introduces the reader to Neural Network design. Using a real, but simiple
dataset, you’ll learn how to build a neural network that can classify images of clothing.

## Chapter 3: Convolutional Neural Networks

In chapter three, you'll explore Convolutional Neural Networks using images of humans and horses. You'll use training
and validation data to build up a model as well as learn about image augmentation to broaden the data and reduce
overspecialization. Additional concepts introduced include Transferred Learning, Multiclass Classification, and
Dropout Regularization.

## Chapter 4: Using Public Datasets with TensorFlow Datasets

Using the TensorFlow Datasets library, chapter 4 introduces the reader to ETL which is a core pattern for training data.
The chapter covers a practical example as well as how to use parallelization ETL to speed up the process.

## Chapter 5: Natural Language Processing

Chapter 5 introduces the reader to tokenization, taking text and breaking it down into smaller units (tokens) for
processing. It covers basics like Turning sentences into tokens, padding sequences, as well as more advanced techniques
like removing stop words, and text cleaning.

The examples in this chapter use the IMDB, emotional sentiment, and scarcasim classification datasets as examples for
building datasets from html like data, csv files, and json.

## Chapter 6: Making Sentiment Programmable Using Embeddings

Chapter 6 uses a Sarcasm dataset to introduce the reader to word embeddings. Words are given a numerical representation
of positive numbers that represent Sarcasm and negative numbers that represent realistic statements. Sentences could then
be represented as a series of these numbers and evaluated for a Sarcasm score.

The example in this chapter begins to analyze accuracy and loss against the training and validation datasets. This can
help identify overfitting, which is when the model becomes overspecialized to the training data.

![accuracy-vs-val_accuracy.png](https://johnmcostaiii.com/img/ai-ml/accuracy-vs-val_accuracy.png)
![loss-vs-val_loss.png](https://johnmcostaiii.com/img/ai-ml/loss-vs-val_loss.png)

The example goes on to cover various techniques to improve the model. These include:

* Adjusting the learning rate
* Adjusting the vocabulary size
* Adjusting the embedding dimension

When these techniques are applied, finer tuning of the model can be achieved by:

* Using dropout
* Using regularization

## Chapter 7: Recurrent Neural Networks for Natural Language Processing

Chapter 7 introduces Recurrent Neural Networks (RNNs) and how they can be used for Natural Language Processing tasks.

They provide a diagram of a recurrent neuron which shows how a recurrent neuron is architected.

![ai-ml.recurrent_neuron.drawio.png](https://johnmcostaiii.com/img/ai-ml/ai-ml.recurrent_neuron.drawio.png)

Long Short-Term Memory (LSTM) is a type of RNN that is capable of learning long-term dependencies.

Bidirectional LSTMs are a type of LSTM that can process data in both directions, which can be useful for tasks like
sentiment analysis where context from both the past and future can be important.

The exercise in this chapter reuses the exercise from chapter 6 and introduces stacked LSTMs.

Overtraining occurs in the example, so optimization techniques are applied to improve the model. These include:

* Adjust the learning rate
* Using dropout in the LSTM layers

A second example in this chapter uses pretrained embeddings, the GloVe set. In this second example, after the model is downloaded, an
exercise to determine how many of the words in the corpus are in the GloVe vocabulary is performed.

## Using TensorFlow to Create Text

This chapter starts out with an example of tokenizing text and creating a word index. Then a model is built so that it
can be trained.

With a trained model it can be used to predict the next word in a seqence. We can then use seed text to generate a
token and test the model.  We can then repeat this process to generate mode text with alternate seed text.

Using the same process we can use a differet, larger dataset to generate more complex text. The example adjusts the
model slightly by adding an additional LSTM layer and increasing the number of epochs.

## Taxonomy

* __Convolution__: Mathematical filter that works on the pixels of an image.
* __Dropout__: A regularization technique that randomly sets a fraction of input units to 0 at each update during training time, which helps prevent overfitting.
* __Embedding Dimension__: The size of the vector representation of each word in the vocabulary.
* __Learning Rate__: A hyperparameter that controls how much to change the model in response to the estimated error each time the model weights are updated.
* __Long Short-Term Memory (LSTM)__: A type of recurrent neural network (RNN) architecture that is capable of learning long-term dependencies.
* __Natural Language Processing (NLP)__: A field of AI that focuses on the interaction between computers and humans through natural language.
* __Out of Vocabulary (OOV)__: Words that are not present in the training vocabulary.
* __Overfitting__: When the model becomes overspecialized to the training data.
* __Padding__: Adding zeros to the beginning or end of a sequence to make it a fixed length.
* __Regularization__: Techniques used to prevent overfitting by adding a penalty to the loss function based on the complexity of the model.
* __Stop Words__: Common words that are often removed from text data to reduce noise and improve model performance.
* __Tokenization__: The process of breaking down text into smaller units (tokens) for processing.
* __Transfer Learning__: Taking layers from another architecture.
* __Vocabulary Size__: The number of unique words in the training dataset.

## References:

* [Understanding LSTM Networks](https://colah.github.io/posts/2015-08-Understanding-LSTMs/)
* [GloVe: Global Vectors for Word Representation](https://nlp.stanford.edu/projects/glove/)
