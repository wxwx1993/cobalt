\name{bal.tab.optmatch}
\alias{bal.tab.optmatch}

\title{
Balance Statistics for optmatch Objects
}
\description{
Generates balance statistics for \code{optmatch} objects from \pkg{optmatch}. Note that several arguments that used to be documented here are now documented in \link[=display_options]{display options}. They are still available.
}
\usage{
\method{bal.tab}{optmatch}(optmatch, 
    formula = NULL, 
    data = NULL, 
    treat = NULL, 
    covs = NULL, 
    int = FALSE, 
    distance = NULL, 
    addl = NULL, 
    continuous = c("std", "raw"), 
    binary = c("raw", "std"), 
    s.d.denom = c("treated", "control", "pooled"), 
    m.threshold = NULL, 
    v.threshold = NULL, 
    ks.threshold = NULL,
    cluster = NULL, 
    abs = FALSE,
    subset = NULL,
    quick = FALSE, 
    ...)
}

\arguments{
  \item{optmatch}{
an \code{optmatch} object; the output of a call to \code{pairmatch()} or \code{fullmatch()} from the \pkg{optmatch} package. This should be a factor vector containing the matching stratum membership for each unit.
}
  \item{formula}{
a \code{formula} with the treatment variable as the response and the covariates for which balanace is to be assessed as the predictors. All named variables must be in \code{data}. See Details.
}
  \item{data}{
a data frame containing all the variables named in \code{formula}. See Details.
}
  \item{treat}{
a vector of treatment statuses. See Details.
}
  \item{covs}{
a data frame of covariate values for which to check balance. See Details.
}
  \item{int}{
\code{logical} or \code{numeric}; whether or not to include powers and 2-way interactions of covariates included in \code{covs} and in \code{addl}. If \code{numeric} and equal to \code{1} or \code{2}, squares of each covariate will be displayed; greater numbers will display corresponding powers up to the provided input (e.g., \code{3} will display squares and cubes of each covariate). 
}
  \item{distance}{
Optional; either a vector containing distance values (e.g., propensity scores) for each unit or a string containing the name of the distance variable in \code{data}.
}
  \item{addl}{
a data frame of additional covariates for which to present balance. These may be covariates included in the original dataset but not included in \code{formula} or \code{covs}. In general, it makes more sense to include all desired variables in \code{formula} or \code{covs} than in \code{addl}.
}
  \item{continuous}{
whether mean differences for continuous variables should be standardized ("std") or raw ("raw"). Default "std". Abbreviations allowed.
}
  \item{binary}{
whether mean differences for binary variables (i.e., difference in proportion) should be standardized ("std") or raw ("raw"). Default "raw". Abbreviations allowed.
}
  \item{s.d.denom}{
whether the denominator for standardized differences (if any are calculated) should be the standard deviation of the treated group ("treated"), the standard deviation of the control group ("control"), or the pooled standard deviation ("pooled"), computed as the square root of the mean of the group variances. Abbreviations allowed. The default is "treated".
}
  \item{m.threshold}{
a numeric value for the threshold for mean differences. .1 is recommended. 
}
  \item{v.threshold}{
a numeric value for the threshold for variance ratios. Will automatically convert to the inverse if less than 1.
}
  \item{ks.threshold}{
a numeric value for the threshold for Kolmogorov-Smirnov statistics. Must be between 0 and 1. 
}
  \item{cluster}{
either a vector containing cluster membserhip for each unit or a string containing the name of the cluster membership variable in \code{data} or the CBPS object. See \code{\link{bal.tab.cluster}} for details.
}
  \item{abs}{
\code{logical}; whether displayed balance statistics should be in absolute value or not. 
}
  \item{subset}{
a \code{logical} vector denoting whether each observation should be included. It should be the same length as the variables in the original call to \code{optmatch()}. \code{NA}s will be treated as \code{FALSE}. This can be used as an alternative to \code{cluster} to examine balance on subsets of the data.
}
  \item{quick}{
\code{logical}; if \code{TRUE}, will not compute any values that will not be displayed. Leave \code{FALSE} if computed values not displayed will be used later.
}
  \item{...}{
further arguments to control display of output. See \link[=display_options]{display options} for details.
}
}
\details{
\code{bal.tab.optmatch()} generates a list of balance summaries for the optmatch object given.

The input to \code{bal.tab.optmatch()} must include either both \code{formula} and \code{data} or both \code{treat} and \code{covs}. 

All balance statistics are calculated whether they are displayed by print or not, unless \code{quick = TRUE}. The threshold values (\code{m.threshold}, \code{v.threshold}, and \code{ks.threshold}) control whether extra columns should be inserted into the Balance table describing whether the balance statistics in question exceeded or were within the threshold. Including these thresholds also creates summary tables tallying the number of variables that exceeded and were within the threshold and displaying the variables with the greatest imbalance on that balance measure.

The inputs (if any) to \code{covs} must be a data frame; if more than one variable is included, this is straightforward (i.e., because \code{data[,c("v1", "v2")]} is already a data frame), but if only one variable is used (e.g., \code{data[,"v1"]}), R will coerce it to a vector, thus making it unfit for input. To avoid this, simply wrap the input to \code{covs} in \code{data.frame()} or use \code{subset()} if only one variable is to be added. Again, when more than one variable is included, the input is general already a data frame and nothing needs to be done.
}
\value{
If clusters are not specified, an object of class \code{"bal.tab"} containing balance summaries for the \code{optmatch} object. See \code{\link{bal.tab}} for details.

If clusters are specified, an object of class \code{"bal.tab.cluster"} containing balance summaries within each cluster and a summary of balance across clusters. See \code{\link{bal.tab.cluster}} for details.
}

\author{
Noah Greifer 
}

\seealso{
\code{\link{bal.tab}} for details of calculations.
}
\examples{\dontrun{
library("optmatch"); data("lalonde", package = "cobalt")

lalonde$prop.score <- glm(treat ~ age + educ + race + 
            married + nodegree + re74 + re75, 
            data = lalonde, family = binomial)$fitted.values
pm <- pairmatch(treat ~ prop.score, data = lalonde)

## Using formula and data
bal.tab(pm, treat ~ age + educ + race + 
        married + nodegree + re74 + re75, data = lalonde)

## Using treat and covs
covariates <- subset(lalonde, select=-c(treat, re78, prop.score))
bal.tab(pm, treat = lalonde$treat, covs = covariates)
}}