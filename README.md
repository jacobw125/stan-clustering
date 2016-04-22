# stan-clustering

Disclaimer - I'm still setting this repo up and will be posting code shortly.


## Overview
This repository contains K-means clustering models implemented in the [Stan](http://www.mc-stan.org) modeling language. K-means is one of many types of unsupervised algorithms that attempts to sort data into clusters. The versions of k-means clustering implemented in this repository are technically "soft" k-means, since they don't use the traditional algorithm (you can read more about the traditional algorithm [here](https://en.wikipedia.org/wiki/K-means_clustering#Algorithms)). 

Instead of the traditional algorithm, these models cluster by making Stan optimize the location of each cluster center using its advanced Markov Chain methods (technically, Hamiltonian Markov Chain Monte Carlo with No U-Turn Sampling, aka HMC w/ NUTS). In the basic case, this is accomplished by calculating a "distance from each cluster" for every input observation during sampling, doing some math so those distances become probabilities (between 0 and 1), and then multiplying those probabilities together. Finally, we make Stan take care of the optimization required to minimize that product. 

The approach is generalizable to N-dimensional spaces but falls victim to the same problem that any nearest-neighbor-based algorithm does: the "curse of dimensionality". In high dimensions, a very dense dataset is required to ensure that there are enough points in each area of the space to produce a meaningful / predictive fit. 

## Variations
Credit is due to the authors of the Stan User Guide for the basic K-means algorithm, which is reproduced here. I am currently working on variations of the standard K-means algorithm for time-series data. Future goals include:

* Time-series specific models (AR1 coefficient clustering, correlation clustering)
* Clustering around multivariate normal distributions with flexible covariance matrices

## About
This repository is for my own research, I'm mostly posting it online in the hope that someone else will find it interesting or useful. I can't guarantee anything will work. Feel free to reach out to me with questions or comments.

## License
MIT.
