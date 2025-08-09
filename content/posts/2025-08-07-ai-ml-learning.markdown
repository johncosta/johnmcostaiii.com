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

## Taxonomy

* __Overfitting__: When the model becomes overspecialized to the training data.
* __Convolution__: Mathematical filter that works on the pixels of an image.
* __Transfer Learning__: Taking layers from another architecture.
