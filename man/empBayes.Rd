% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/empBayes.R
\name{empBayes}
\alias{empBayes}
\title{empBayes}
\usage{
empBayes(reference, before, after, depVar, offsetVar = NULL,
  indepVars = setdiff(names(reference), c(depVar, offsetVar)),
  forceKeep = NULL, alpha = 0.95)
}
\arguments{
\item{reference}{Reference data}

\item{before}{Treatment data, before some change was made}

\item{after}{Treatment data, after some change was made}

\item{depVar}{The dependent variable (the number of crashes - should always be of class integer or numeric).}

\item{offsetVar}{An offset variable (eg years)}

\item{indepVars}{Variables used to model the outcome variable depVar}

\item{forceKeep}{A character vector of variable names.
These variables will not be considered for removal during the variable selection process.}

\item{alpha}{Level of confidence}
}
\value{
Returns a list object containing the CMF, its variance, standard error, and 1-alpha/2 CI
}
\description{
Calculates Crash Modification Factor (CMF) for a before/after traffic study using Empirical Bayes to avoid regression to the mean (RTM)
}
\details{
None at this time
}
\examples{
data(Reference)
data(Before)
data(After)
empBayes(reference = Reference, before = Before, after = After,
 depVar = "kabco", offsetVar = "year")
}
\author{
Jung-han Wang and Robert Norberg
}
