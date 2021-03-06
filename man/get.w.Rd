\name{get.w}
\alias{get.w}
\alias{get.w.matchit}
\alias{get.w.ps}
\alias{get.w.mnps}
\alias{get.w.iptw}
\alias{get.w.Match}
\alias{get.w.CBPS}
\alias{get.w.ebalance}
\alias{get.w.optmatch}
\alias{get.w.weightit}
\alias{get.w.designmatch}

\title{
Extract Weights from Preprocessing Objects
}
\description{
Extracts weights from the outputs of preprocessing functions.
}
\usage{
get.w(x, \dots)

\method{get.w}{matchit}(x, ...)

\method{get.w}{ps}(x, stop.method = NULL, estimand = NULL, s.weights = FALSE, ...)

\method{get.w}{mnps}(x, stop.method = NULL, s.weights = FALSE, ...)

\method{get.w}{iptw}(x, stop.method = NULL, s.weights = FALSE, ...)

\method{get.w}{Match}(x, ...)

\method{get.w}{CBPS}(x, estimand = NULL, ...)

\method{get.w}{ebalance}(x, treat, ...)

\method{get.w}{optmatch}(x, ...)

\method{get.w}{weightit}(x, s.weights = FALSE, ...)

\method{get.w}{designmatch}(x, treat, ...)

}

\arguments{
  \item{x}{
output from the corresponding preprocessing packages.
}
  \item{stop.method}{
the name of the stop method used in the original call to \code{ps()} or \code{mnps()} in \pkg{twang}, e.g., \code{"es.mean"}. If empty, will return weights from all stop method available into a data.frame. Abbreviations allowed.
}
  \item{estimand}{
if weights are computed using the propensity score (i.e., for the \code{ps} and \code{CBPS} methods), which estimand to use to compute the weights. If \code{"ATE"}, weights will be computed as \code{1/ps} for the treated group and \code{1/(1-ps)} for the control group. If \code{"ATT"}, weights will be computed as \code{1} for the treated group and \code{ps/(1-ps)} for the control group. If \code{NULL}, \code{get.w()} will try to figure out which estimand is desired based on the object.
}
  \item{treat}{
a vector of treatment status for each unit. This is required for methods that include \code{treat} as an argument. The treatment variable that was used in the original preprocessing function call should be used.
}
  \item{s.weights}{
whether the sampling weights included in the original call to the fitting function should be included in the weights. If \code{TRUE}, the returned weights will be the product of the balancing weights estimated by the fitting function and the sampling weights. If \code{FALSE}, only the balancing weights will be returned.
}
  \item{...}{
further arguments passed to or from other methods.
}
}
\details{
The output of \code{get.w()} can be used in calls to the formula and data frame methods of \code{\link{bal.tab}()} (see example below). In this way, the output of multiple preprocessing packages can be viewed simultaneously and compared. The weights can also be used in \code{weights} statements in regression methods to compute weighted effects.

\pkg{twang} has a function called \code{get.weights()} that performs the same function on \code{ps} objects but offers slightly finer control. Note that the weights generated by \code{get.w()} for \code{ps} objects do not include sampling weights.

When sampling weights are used with \code{CBPS()}, the returned weights will already have the sampling weights incorporated. To retrieve the balancing weights on their own, divide the returned weights by the original sampling weights. For other packages, the balancing weights are returned separately unless \code{s.weights = TRUE}, which means they must be multiplied by the sampling weights for effect estimation.

}
\value{
A vector or data frame of weights for each unit. These may be matching weights or balancing weights.
}

\author{
Noah Greifer 
}

\seealso{
\code{\link[twang]{get.weights}} in \pkg{twang}.
}
\examples{
\dontrun{
data("lalonde", package = "cobalt")
library("MatchIt"); library("WeightIt")

m.out <- matchit(treat ~ age + educ + race, data = lalonde) 

w.out <- weightit(treat ~ age + educ + race, data = lalonde,
                  estimand = "ATT")

bal.tab(treat ~ age + educ + race, data = lalonde,
        weights = data.frame(matched = get.w(m.out),
                             weighted = get.w(w.out)),
        method = c("matching", "weighting"), 
        estimand = "ATT")
}
}
