#' @title Naive
#' @description Calculates Crash Modification Factor (CMF) for a before/after traffic study using Naive method
#' @details None at this time
#' @aliases Naive
#' @author Jung-han Wang and Robert Norberg
#' @export Naive
#' @param before Treatment data, before some change was made
#' @param after Treatment data, after some change was made
#' @param length of time unit in before period
#' @param length of time unit in after period
#' @param alpha Level of confidence
#' @return Returns a list object containing the CMF, its variance, standard error, and 1-alpha/2 CI
#' @examples
#' data(Before)
#' data(After)
#' naive(before = Before, after = After,depVar = "kabco",db=1,da=3,alpha=0.9)

naive<-function(before, after, depVar, db=1,da=1, alpha = 0.95){

  # check data compatibility
  stopifnot(is.data.frame(before))
  stopifnot(is.data.frame(after))

  stopifnot(nrow(before) == nrow(after))

  stopifnot(depVar %in% names(before))
  stopifnot(depVar %in% names(after))

  ## Define Before and After Ratio
  ratio<-da/db
  ## Sum up After Crashes
  ta <- sum(after[, depVar])
  lamda<-sum(ta)
  ## Sum up Before Crashes adjusted by Time Ratio
  tb <- sum(before[, depVar])
  pi<-ratio*sum(tb)
  ## Calculate Variance of After Crashes
  var_lamda<-lamda
  ## Calculate Variance of After Crashes if there were no treatment
  var_pi<-ratio**2*sum(ta)
  ## Calculate Crash Reduction Index
  cmf<-(lamda/pi)/(1+var_pi/pi**2)
  ## Calculate Variance of Crash Reduction Index
  cmf_var<-cmf**2*((var_lamda/lamda**2)+(var_pi/pi**2))/(1+var_pi/pi**2)**2
  ## Calculate Standard Error of Crash Reduction Index
  cmf_se<-sqrt(cmf_var)

  ##
  if (alpha>0.5) {
    alpha<-(1-alpha)/2
    z<-qnorm(alpha)*-1
  }

  else {
    alpha<-alpha/2
    z<-qnorm(alpha)*-1
  }

  z_int<-z*sqrt(cmf_var)

  cmf_lower<-cmf-z_int
  cmf_upper<-cmf+z_int

  ## Setting up Minimum Lower Bound
  if (cmf_lower < 0) {
    cmf_lower = 0
  }

  CMF <- list('est'=cmf,
              'varince'=cmf_var,
              'stderr'=cmf_se,
              'confint'=list('lower' = cmf_lower, 'upper' = cmf_upper)
  )
  results <- list('SampleSize'=length(tb),
                  'CMF' = CMF
  )



return(list(
  "n" = nrow(before)/2,
  "cmf" = cmf,
  "cmf_variance" = cmf_var,
  "cmf_se" = cmf_se,
  "cmf_ci" = c('Lower' = cmf_lower,'Upper' = cmf_upper, 'alpha' = alpha)
))

}
