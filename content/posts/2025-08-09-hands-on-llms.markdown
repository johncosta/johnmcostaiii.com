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

## Taxonomy

* __Large Language Models (LLMs)__: A type of AI model that is trained on large datasets to understand and generate human language.
* __Bag of Words (BoW)__: A simple representation of text that ignores grammar and word order but keeps track of word frequency.
* __word2vec__: A technique that uses neural networks to learn word embeddings, capturing semantic relationships between words.
* __Attention__: A mechanism that allows models to focus on specific parts of the input sequence, improving context understanding.
* __GPT (Generative Pre-trained Transformer)__: A type of LLM that is pre-trained on a large corpus of text and can generate coherent text based on a given prompt.
* __Tokenization__: The process of breaking down text into smaller units (tokens) for processing by LLMs.
* __Word Tokens__: A tokenization scheme where each token represents a whole word.
* __Subword Tokens__: A tokenization scheme where tokens can represent parts of words, allowing for better handling of rare or unknown words.
* __Character Tokens__: A tokenization scheme where each token represents a single character, useful for languages with complex morphology.
* __Byte Tokens__: A tokenization scheme that represents text as a sequence of bytes, allowing for a more compact representation.
* __Embeddings__: Numerical representations of words or tokens that capture their semantic meaning and relationships.
