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
Another good resource is [The Illustrated Transformer](https://jalammar.github.io/illustrated-transformer/#self-attention-in-detail)

![transformer-Page-3.relevance-scoring.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-3.relevance-scoring.drawio.png)

Using the queries and keys, the model calculates relevance scores for each token in the input sequence. The scores are then
multiplied by the values to produce the output vectors.

Attention is a powerful mechanism that allows the model to weigh the importance of different tokens in the input sequence
when generating text. Newer LLMs have available a more efficient attention mechanism called sparse attention, which
can be strided or fixed. These attention mechanisms use fewer input tokens as context for self-attention.

Additionally, there are other attention mechanisms such as:

* Grouped Query Attention (GQA)
* Multi-Head Attention
* Flash Attention

## Chapter 4: Text Classification

The goal of text classification is to assign a label to a piece of text based on its content.  Classification can be
used for a variety of tasks, such as:

* sentiment analysis
* topic classification
* spam detection
* intent detection
* detecting language

Techniques:

* Text Classification with Representation Models
* Text Classification with Generative Models

### Text Classification with Representation Models

How it works:

1) Based models are fine-tuned for specific tasks, like classification or embeddings.

![transformer-Page-4.fine-tuning.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-4.fine-tuning.drawio.png)

2) The models are fed inputs and outputs specific to the task are generated.

![transformer-Page-4.fine-tuning.drawio.png](https://johnmcostaiii.com/img/transformers/transformer-Page-4.fine-tuning.drawio.png)

There are some suggestions for models that are good for text classification:

* [BERT base model (uncased)](https://huggingface.co/google-bert/bert-base-uncased)
* [RoBERTa base model](https://huggingface.co/FacebookAI/roberta-base)
* [DistilBERT base model (uncased)](https://huggingface.co/distilbert/distilbert-base-uncased)
* [DeBERTa base model](https://huggingface.co/microsoft/deberta-base)
* [bert-tiny](https://huggingface.co/prajjwal1/bert-tiny)
* [ALBERT base v2](https://huggingface.co/albert/albert-base-v2)

When looking to generate embeddings the [MTEB Leaderboard](https://huggingface.co/spaces/mteb/leaderboard) is a good
resource to find models.

To evaluate the performance of classification models that have labeled data, we can use metrics such as accuracy,
precision, recall, and F1 score.

Zero-shot classification is a technique that allows us to classify text without any labeled data.

Using the cosine similarity function, we can compare the embeddings of the input text to the embeddings of the labels.

### Text Classification with Generative Models

Prompt engineering is the process of designing prompts that can effectively elicit the desired response from a generative
model.

The T5 model is similar to the original Transformer architecture, using an encoder-decoder structure.

OpenAI's GPT model training process is published here: https://openai.com/index/chatgpt/

## Chapter 5: Text Clustering and Topic Modeling

Text clustering is the process of grouping similar pieces of text together based on their content, yeilding clusters of
symantically similar text.

Text clustering can be used for topic modeling, which is the process of identifying the main topics in a collection of text.

The book example uses ArXiv papers as the text corpus.

Common Pipeline for Text Clustering:

1) convert input documents -> embeddings w/ embedding model
2) Reduce dimensionality w/ dimensionality reduction model
3) find groups of documents w/ cluster model

### Dimensionality Reduction

There are well known method for dimensionality reduction including:

* Principal Component Analysis (PCA)
* Uniform Manifold Approximation and Projection (UMAP)

### Clustering Algorithms

An example of clustering algorithms include:

* Hierarchical Density-Based Spatial Clustering of Applications with Noise (HDBSCAN)

Visualization of clusters can be done using tools like Matplotlib.

### BERTopic: Modular Topic Modeling Framework

1) Follow the same procedure in text clustering to generate clusters
2) Model distribution over words, bag of words - use frequency of words in each cluster to identify topics
3) Use class-based term frequency inverse document frequency (c-TF-IDF) to identify words that are unique to each cluster

A full pipeline for topic modeling using BERTopic:

| clustering                               | topic representation            | reranking                 |
|------------------------------------------|---------------------------------|---------------------------|
| sbert -> umap -> hdbscan                 | count vectorizaton -> c-TF-IDF  | reprentation model        |
| embed docs -> reduce dim -> cluster docs | tokenize words -> weight words  | fine tune representation  |

BERTopics can be used like Legos to build custom pipelines.

## Chapter 6: Prompt Engineering

### Basics of using text generation model

* Select a model considering:
  * opensource vs proprietary
  * output control

1) Choose opensource or proprietary model

**__suggestion__**: start with a small foundational model

2) Load the model

3) Control the output

* set do_Sample=True to use temperature and top_p

4) Tune Temperature and top_p for the use case

### Intro to prompt engineering

Ingredients of a good prompt:

* When no instructions are given, the model will try to predict the next word based on the input text.
* Two components of basic instructions:
  1) Task description
  2) Input text (data)
* Extending the prompt with output indicator allows for specific output

Use cases for instruction based prompts:

* Supervised classification
* Search
* Summarization
* Code generation
* Named entity recognition

Techniques for improving prompts:

* Specificity
* Hallucination mitigation
* Order

Complex prompt components:

* Persona
* Instruction
* Context
* Format
* Audience
* Tone
* Data

In-context learning:

* Zero-shot learning
* One-shot learning
* Few-shot learning

Chain prompting:

* Break the task into smaller sub-tasks and use the output of one prompt as the input to the next prompt.
* Useful for:
    * Response validation
    * Parallel prompts
    * Writing stories

### Reasoning with Generative Models

Chain of thought:
* Prompt the model to think step-by-step

Self-consistency:
* using the same prompt multiple times to generate multiple responses
* works best with temperature and top_p sampling

Tree of thought:
* useful when needing to explore multiple paths to a solution
* ask the model to mimic multiple agents working together to solve a problem
* question each other until they reach a consensus

### Output Verification

* Useful for:
    * Structured output
    * Valid output
    * ethics
    * accuracy

Techniques:
* Provide examples of valid output

Grammar: constrained sampling
* use packages for:
    * Guidance
    * Guardrails
    * LMQL

## Taxonomy

* __Accuracy__: A metric used to evaluate the performance of classification models, measuring the proportion of correct predictions.
* __Attention__: A mechanism that allows models to focus on specific parts of the input sequence, improving context understanding.
* __Autoregressive Models__: Models that generate text by predicting the next token in a sequence based on the previous tokens.
* __Bag of Words (BoW)__: A simple representation of text that ignores grammar and word order but keeps track of word frequency.
* __BERT (Bidirectional Encoder Representations from Transformers)__: A pre-trained model that uses a Transformer architecture to understand the context of words in a sentence.
* __Byte Tokens__: A tokenization scheme that represents text as a sequence of bytes, allowing for a more compact representation.
* __Character Tokens__: A tokenization scheme where each token represents a single character, useful for languages with complex morphology.
* __Context Size__: The number of tokens the model can consider at once when generating text, affecting its ability to maintain coherence.
* __Embeddings__: Numerical representations of words or tokens that capture their semantic meaning and relationships.
* __F1 Score__: A metric that combines precision and recall to evaluate the performance of classification models.
* __Feed-Forward Neural Network__: A type of neural network where connections between nodes do not form cycles, used in Transformer blocks.
* __Flash Attention__: An efficient attention mechanism that reduces memory usage and speeds up computation in LLMs.
* __GPT (Generative Pre-trained Transformer)__: A type of LLM that is pre-trained on a large corpus of text and can generate coherent text based on a given prompt.
* __Greedy Decoding__: A text generation strategy where the model selects the token with the highest probability at each step.
* __Grouped Query Attention (GQA)__: An attention mechanism that uses a single set of keys and values for multiple queries, improving efficiency.
* __Inverse Document Frequency (IDF)__: is a measure of how important a word is to a document in a collection of documents.
* __Large Language Models (LLMs)__: A type of AI model that is trained on large datasets to understand and generate human language.
* __LM Head__: The final layer of an LLM that generates the output tokens based on the processed input.
* __Multi-Head Attention__: An attention mechanism that allows the model to focus on different parts of the input sequence simultaneously.
* __Output vectors__: The numerical representations of the output tokens generated by the LLM.
* __Parallel Processing__: The ability to process multiple input tokens simultaneously, improving efficiency.
* __Precision__: The numerical accuracy of the computations performed by the model, affecting its performance and resource usage.
* __Recall__: A metric used to evaluate the performance of classification models, measuring the ability to identify all relevant instances.
* __Self-Attention__: A mechanism that allows the model to weigh the importance of different tokens in the input sequence when generating text.
* __Sparse Attention__: An efficient attention mechanism that uses fewer input tokens as context for self-attention, reducing computational complexity.
* __Subword Tokens__: A tokenization scheme where tokens can represent parts of words, allowing for better handling of rare or unknown words.
* __T5 model__: Text-To-Text Transfer Transformer, a model that converts all NLP tasks into a text-to-text format.
* __Temperature__: A parameter that controls the randomness of the model's output, with higher values leading to more diverse text.
* __Tokenization__: The process of breaking down text into smaller units (tokens) for processing by LLMs.
* __Token Embedding__: The process of converting tokens into numerical vectors that capture their semantic meaning.
* __Token Probabilities__: The likelihood of each token in the vocabulary being the next token in a sequence, used for text generation.
* __Top-p Sampling (Nucleus Sampling)__: A text generation strategy that selects tokens from the smallest set whose cumulative probability exceeds a threshold p, allowing for more diverse outputs.
* __Transformer__: A neural network architecture that uses self-attention mechanisms to process sequences of data, widely used in LLMs.
* __Transformer Blocks__: The building blocks of the Transformer architecture, consisting of layers of attention and feed-forward neural networks.
* __Trained Transformer LLMs__: LLMs that have been trained on large datasets using the Transformer architecture, enabling them to understand and generate human language effectively.
* __Word Tokens__: A tokenization scheme where each token represents a whole word.
* __word2vec__: A technique that uses neural networks to learn word embeddings, capturing semantic relationships between words.

References:

* [Speech and Language Processing](https://web.stanford.edu/~jurafsky/slp3/)
* [Attention Is All You Need](https://arxiv.org/pdf/1706.03762)
* [Generating Long Sequences with Sparse Transformers](https://arxiv.org/pdf/1904.10509)
* [Fast Transformer Decoding: One Write-Head is All You Need](https://arxiv.org/abs/1911.02150)
* [GQA: Training Generalized Multi-Query Transformer Models from Multi-Head Checkpoints](https://arxiv.org/abs/2305.13245)
* [FlashAttention: Fast and Memory-Efficient Exact Attention with IO-Awareness](https://arxiv.org/abs/2205.14135)
* [FlashAttention-2:Faster Attention with Better Parallelism and Work Partitioning](https://tridao.me/publications/flash2/flash2.pdf)
* [The Illustrated Transformer](https://jalammar.github.io/illustrated-transformer/)
* [On Layer Normalization in the Transformer Architecture](https://arxiv.org/abs/2002.04745)
* [Root Mean Square Layer Normalization](https://arxiv.org/abs/1910.07467)
* [GLU Variants Improve Transformer](https://arxiv.org/pdf/2002.05202)
* [RoFormer: Enhanced Transformer with Rotary Position Embedding](https://arxiv.org/abs/2104.09864v4)
* [Efficient Sequence Packing without Cross-contamination: Accelerating Large Language Models without Impacting Performance](https://arxiv.org/abs/2107.02027)
* [Introducing packed bert for 2x faster training in natural language processing](https://www.graphcore.ai/posts/introducing-packed-bert-for-2x-faster-training-in-natural-language-processing)
* [A Survey of Transformers](https://arxiv.org/abs/2106.04554)
* [Transformers in Vision: A Survey](https://dl.acm.org/doi/abs/10.1145/3505244)
* [A Survey on Vision Transformer](https://ieeexplore.ieee.org/abstract/document/9716741)
* [Open X-Embodiment: Robotic Learning Datasets and RT-X Models](https://robotics-transformer-x.github.io/)
* [Transformers in Time Series: A Survey](https://arxiv.org/abs/2202.07125)
* [HuggingFace Datasets](https://huggingface.co/datasets)
* [HuggingFace Cornell Rotten Tomatoes](https://huggingface.co/datasets/cornell-movie-review-data/rotten_tomatoes)
* [Scaling Instruction-Finetuned Language Models](https://arxiv.org/abs/2210.11416)
* [ArXiv](https://arxiv.org/)
