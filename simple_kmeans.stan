/* simple_kmeans.stan
* This code, copied directly from the Stan User Guide, shows how to perform
* simple k-means clustering in Stan. 
* All credit is due to the Stan team for this code, I've just added some comments
* to clear things up.
*/

data {
  int<lower=0> N;  // number of data points
  int<lower=1> D;  // number of dimensions
  int<lower=1> K;  // number of clusters
  vector[D] y[N];  // observations
}
transformed data {
  real<upper=0> neg_log_K;
  neg_log_K <- -log(K); // note that this is a constant.
}
parameters {
  vector[D] mu[K]; // cluster means
}
transformed parameters {
  real<upper=0> soft_z[N,K]; // log unnormalized cluster assigns
  for (n in 1:N){
    for (k in 1:K){
      soft_z[n,k] <- neg_log_K - 0.5 * dot_self(mu[k] - y[n]); // I think 0.5 is a smoothing parameter related to the variance of y.
      // I tried setting it to -1, and my chains didn't coverge.
    }
  }
}
model {
  for (k in 1:K)
  {
    mu[k] ~ normal(0,1);  // prior
  }
  for (n in 1:N){
    increment_log_prob(log_sum_exp(soft_z[n])); // likelihood
  }
}
