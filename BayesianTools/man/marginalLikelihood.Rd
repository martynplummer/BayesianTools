% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/marginalLikelihood.R
\name{marginalLikelihood}
\alias{marginalLikelihood}
\title{Calcluated the marginal likelihood from a set of MCMC samples}
\usage{
marginalLikelihood(sampler, numSamples = 1000, method = "Chib", ...)
}
\arguments{
\item{sampler}{an object that implements the getSample function, i.e. a mcmc / smc Sampler (list)}

\item{numSamples}{number of samples to use. How this works, and if it requires recalculating the likelihood, depends on the method}

\item{method}{method to choose. Currently available are "Chib" (default), the harmonic mean "HM", and sampling from the prior "prior". See details}

\item{...}{further arguments passed to \code{\link{getSample}}}
}
\description{
Calcluated the marginal likelihood from a set of MCMC samples
}
\details{
The function currently implements three ways to calculate the marginal likelihood.\cr
 The recommended way is the method "Chib" (Chib and Jeliazkov, 2001). which is based on MCMC samples, but performs additional calculations. 
 Despite being the current recommendation, note there are some numeric issues with this algorithm that may limit reliability for larger dimensions.
  
 The harmonic mean approximation,
  is implemented only for comparison. Note that the method is numerically 
  unrealiable and usually should not be used. \cr

The third method is simply sampling from the prior. While in principle unbiased,
 it will only converge for a large number of samples, and is therefore
  numerically inefficient. \cr

The Bridge method uses bridge sampling as implemented in package "bridgesampling".
}
\examples{
# Harmonic mean works OK for a low-dim case with 

likelihood <- function(x) sum(dnorm(x, log = TRUE))
prior = createUniformPrior(lower = rep(-1,2), upper = rep(1,2))
bayesianSetup <- createBayesianSetup(likelihood = likelihood, prior = prior)
out = runMCMC(bayesianSetup = bayesianSetup, settings = list(iterations = 5000))

plot(out)


marginalLikelihood(out, numSamples = 500)[[1]]
marginalLikelihood(out, method = "HM", numSamples = 500)[[1]]
marginalLikelihood(out, method = "Prior", numSamples =  500)[[1]]

# True marginal likelihood (brute force approximation)

marginalLikelihood(out, method = "Prior", numSamples =  10000)[[1]]


# Harmonic mean goes totally wrong for higher dimendsions - wide prior. 
# Could also be a problem of numeric stability of the implementation

likelihood <- function(x) sum(dnorm(x, log = TRUE))
prior = createUniformPrior(lower = rep(-10,3), upper = rep(10,3))
bayesianSetup <- createBayesianSetup(likelihood = likelihood, prior = prior)
out = runMCMC(bayesianSetup = bayesianSetup, settings = list(iterations = 5000))

plot(out)

marginalLikelihood(out, numSamples = 500)[[1]]
marginalLikelihood(out, method = "HM", numSamples = 500)[[1]]
marginalLikelihood(out, method = "Prior", numSamples =  500)[[1]]

# True marginal likelihood (brute force approximation)

marginalLikelihood(out, method = "Prior", numSamples =  10000)[[1]]


}
\references{
Chib, Siddhartha, and Ivan Jeliazkov. "Marginal likelihood from the Metropolis-Hastings output." Journal of the American Statistical Association 96.453 (2001): 270-281.
}
\seealso{
\code{\link{WAIC}}, \code{\link{DIC}}, \code{\link{MAP}}
}
\author{
Florian Hartig
}
