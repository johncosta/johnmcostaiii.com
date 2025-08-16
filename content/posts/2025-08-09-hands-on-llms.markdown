---
title: "Book Notes: Hands On Large Language Models: Language Understanding and Generation"
date: "2025-08-09"
comments: true
tags: ["software", "development", "ai", "llm", "book notes"]
categories: ["software development", "artificial intelligence"]
---

## Overview

This post contains my notes on the book *Hands-On Large Language Models: Language Understanding and Generation.

You can find the book on [Amazon](https://www.amazon.com/Hands-Large-Language-Models-Understanding/dp/1098150961/ref=sr_1_1?crid=15YBR96UBIYVO&dib=eyJ2IjoiMSJ9.1MUa46N8Y9QCki_IGnTl1T74Har-XhvVDPrysPvNR91xqhLJ0sa-Lo-hzP8m6d-7TpzEgATkhmTWKs03BoS-hwEDOJ8UNAbOsba1a0BABT9oO-kIgklm0IKct4itnWyfOMEHSECNerQ8lx8b7VWiJ-5PukzhjKCj-iJ4UrO5PhGrgMySfYZpbhYrIkEA4_JA1Yue47syrAZu414pHVdcuttxPG1hP48SxE3ZSj-3p74.Shfm-6xfdF4SfUvNKSbVNEcQM4rC4skcwznK4nbS-NM&dib_tag=se&keywords=hands+on+large+language+models&qid=1754755424&sprefix=Hands+on%2Caps%2C155&sr=8-1)

I'll be adding my notes to this post as I read through the book. The notes will be organized by chapter and will include key concepts, code examples, and any additional insights I find useful.

## Chapter 1: An Introduction to Large Language Models

Chapter 1 introduces the reader to the recent history of Large Language Models (LLMs). The diagrams in this chapter
are particularly useful for understanding the evolution of LLMs and how they relate to other AI technologies. It's a
great segway from the machine learning and neural networks covered in the [previous book I'm reading in parallel](https://johnmcostaiii.com/posts/2025-08-07-ai-ml-learning/).

## Chapter 2: Tokens and Embeddings

Chapter 2 introduces the concept of tokens and embeddings.

Tokens are the basic units of text that LLMs use to process and generate language.  The chapter covers a number of LLM
Tokenizers including BERT (cased and uncased), GPD-2, FLAN-T5, StarCoder2, and a few others.  It provides details on
how each tokenizer works and how they differ from one another.

Token embeddings are numerical representations of tokens that capture their semantic meaning. Embeddings can be used to
represent sentences, paragraphs, or even entire documents. Further, embeddings can be used in Recommendation Systems. The
chapter covers a song recommendation system that uses embeddings to recommend songs based on a song input by the user.

## Chapter 3: Looking Inside Large Language Models

**__Note:__** This chapter contains a number of useful diagrams that I've described in my own representation. However,
the diagrams are not reproduced in their entirety. Please refer to the book for the complete diagrams and explanations.

Chapter 3 takes a deeper dive into the architecture of LLMs. We start out with a view into the Inputs and Outputs of
Trained Transformer LLMs. This might be an overly simplified view, but it helps to understand the basic flow of data
through an LLM.

![transformer.highlevel.drawio.png](https://johnmcostaiii.com/img/transformers/transformer.highlevel.drawio.png)

The transformer generates a single output token at a time, using the previous tokens as context. This is known as an
autoregressive model.

Diving a little deeper, we learn about the Transformer architecture. It's composed of a Tokenizer, a stack of Transformer
blocks, and an LM Head.

![transformer.components.drawio.png](https://johnmcostaiii.com/img/transformers/transformer.components.drawio.png)

Going further, the tokenizer breaks down the input text into tokens and becomes a token vocabulary. The set of transformer
blocks have token embeddings based on the token vocabulary. The LM head is a neural network layer that contains token
probabilities for each token in the vocabulary.

![transformer.forwardpass.drawio.png](https://johnmcostaiii.com/img/transformers/transformer.forwardpass.drawio.png)

Greedy decoding is when the model selects the token with the highest probability at each step.

It is possible to process in parallel multiple input tokens and the amount of tokens that can be processed at once is
referred to as the context size.  Keep in mind that embeddings are not the same as tokens, but rather a numerical
representation of tokens that captures their semantic meaning.

![transformer-Page-2.processing-stream.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-2.processing-stream.drawio.png)

Keep in mind that only the last token in the sequence is used to generate the next token. Even though this is the case,
the processing stream results are parallelized and can be cashed to improve efficiency.

Digging even deeper, we learn about the Transformer blocks. Each block consists of a self-attention mechanism and a feed-forward
neural network.

![transformer-Page-3.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-3.drawio.png)

The feed-forward neural network is the source of learned information that enables the model to generate coherent text.

Attention is a key mechanism in LLMs that allows the model to focus on specific parts of the input sequence when
generating text.

![transformer-Page-3.simple-self-attention.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-3.simple-self-attention.drawio.png)

Taking a look into attention more closely, we see that we are getting to the core of how LLMs work.

**__Note:__** The book mentions projection matrices which are shown in the diagram below. However, it doesn't
explain them in detail. If you're interested in understanding projection matrices, a good resource that I found helpful
is [this article](https://sebastianraschka.com/blog/2023/self-attention-from-scratch.html#defining-the-weight-matrices).
The content appears to be a summarization of the original paper on self-attention, [Attention Is All You Need](https://arxiv.org/pdf/1706.03762).

![transformer-Page-3.relevance-scoring.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-3.relevance-scoring.drawio.png)

Using the queries and keys, the model calculates relevance scores for each token in the input sequence. The scores are then
multiplied by the values to produce the output vectors.



## Taxonomy

* __Attention__: A mechanism that allows models to focus on specific parts of the input sequence, improving context understanding.
* __Autoregressive Models__: Models that generate text by predicting the next token in a sequence based on the previous tokens.
* __Bag of Words (BoW)__: A simple representation of text that ignores grammar and word order but keeps track of word frequency.
* __Byte Tokens__: A tokenization scheme that represents text as a sequence of bytes, allowing for a more compact representation.
* __Character Tokens__: A tokenization scheme where each token represents a single character, useful for languages with complex morphology.
* __Context Size__: The number of tokens the model can consider at once when generating text, affecting its ability to maintain coherence.
* __Embeddings__: Numerical representations of words or tokens that capture their semantic meaning and relationships.
* __Feed-Forward Neural Network__: A type of neural network where connections between nodes do not form cycles, used in Transformer blocks.
* __GPT (Generative Pre-trained Transformer)__: A type of LLM that is pre-trained on a large corpus of text and can generate coherent text based on a given prompt.
* __Greedy Decoding__: A text generation strategy where the model selects the token with the highest probability at each step.
* __Large Language Models (LLMs)__: A type of AI model that is trained on large datasets to understand and generate human language.
* __LM Head__: The final layer of an LLM that generates the output tokens based on the processed input.
* __Output vectors__: The numerical representations of the output tokens generated by the LLM.
* __Parallel Processing__: The ability to process multiple input tokens simultaneously, improving efficiency.
* __Self-Attention__: A mechanism that allows the model to weigh the importance of different tokens in the input sequence when generating text.
* __Subword Tokens__: A tokenization scheme where tokens can represent parts of words, allowing for better handling of rare or unknown words.
* __Tokenization__: The process of breaking down text into smaller units (tokens) for processing by LLMs.
* __Token Embedding__: The process of converting tokens into numerical vectors that capture their semantic meaning.
* __Token Probabilities__: The likelihood of each token in the vocabulary being the next token in a sequence, used for text generation.
* __Transformer__: A neural network architecture that uses self-attention mechanisms to process sequences of data, widely used in LLMs.
* __Transformer Blocks__: The building blocks of the Transformer architecture, consisting of layers of attention and feed-forward neural networks.
* __Trained Transformer LLMs__: LLMs that have been trained on large datasets using the Transformer architecture, enabling them to understand and generate human language effectively.
* __Word Tokens__: A tokenization scheme where each token represents a whole word.
* __word2vec__: A technique that uses neural networks to learn word embeddings, capturing semantic relationships between words.

References:

* [Speech and Language Processing](https://web.stanford.edu/~jurafsky/slp3/)
* [Attention Is All You Need](https://arxiv.org/pdf/1706.03762)
* [Generating Long Sequences with Sparse Transformers](https://arxiv.org/pdf/1904.10509)
