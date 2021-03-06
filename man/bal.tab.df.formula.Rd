\name{bal.tab.df.formula}
\alias{bal.tab.data.frame}
\alias{bal.tab.formula}
\title{
Balance Statistics for Data Sets
}
\description{
Generates balance statistics for unadjusted, matched, weighted, or stratified data using either a \code{data.frame} or formula interface. Note that several arguments that used to be documented here are now documented in \link[=options-display]{display options}. They are still available.
}
\usage{
\method{bal.tab}{data.frame}(covs, 
    treat, 
    data = NULL, 
    weights = NULL, 
    distance = NULL, 
    subclass = NULL, 
    match.strata = NULL, 
    method, 
    int = FALSE, 
    poly = 1, 
    addl = NULL, 
    continuous,  
    binary, 
    s.d.denom, 
    m.threshold = NULL, 
    v.threshold = NULL, 
    ks.threshold = NULL, 
    r.threshold = NULL, 
    cluster = NULL, 
    imp = NULL, 
    pairwise = TRUE, 
    focal = NULL, 
    s.weights = NULL, 
    estimand = NULL, 
    abs = FALSE,
    subset = NULL,
    quick = FALSE, 
    ...)

\method{bal.tab}{formula}(formula, 
    data = NULL, 
    ...)
}
\arguments{
  \item{covs}{
A \code{data.frame} containing covariate values for each unit.
}
  \item{treat}{
Either a vector containing treatment status values for each unit or a string containing the name of the treatment variable in \code{data}.
}
  \item{formula}{
  a \code{formula} with the treatment variable as the response and the covariates for which balance is to be assessed as the terms. All terms must be present as variable names in \code{data} or the global environment.
}
  \item{data}{
Optional; a \code{data.frame} containing variables with the names used in \code{formula}, \code{treat}, \code{weights}, \code{distance}, \code{addl}, \code{subclass}, \code{match.strata}, \code{cluster}, and/or \code{imp} if any.
}
  \item{weights}{
Optional; a vector, list, or \code{data.frame} containing weights for each unit or a string containing the names of the weights variables in \code{data}.  These can be weights generated by, e.g., inverse probability weighting or matching weights resulting from a matching algorithm.  This must be specified in \code{method}.   If \code{weights=NULL}, \code{subclass=NULL} and \code{match.strata=NULL}, balance information will be presented only for the unadjusted sample.
}
  \item{distance}{
Optional; either a vector or \code{data.frame} containing distance values (e.g., propensity scores) for each unit or a string containing the name of the distance variable in \code{data}.
}
  \item{subclass}{
Optional; either a vector containing subclass membership for each unit or a string containing the name of the subclass variable in \code{data}.  If \code{weights=NULL}, \code{subclass=NULL} and \code{match.strata=NULL}, balance information will be presented only for the unadjusted sample.
}
\item{match.strata}{
Optional; either a vector containing matching stratum membership for each unit or a string containing the name of the matching stratum variable in \code{data}. If \code{weights=NULL}, \code{subclass=NULL} and \code{match.strata=NULL}, balance information will be presented only for the unadjusted sample.
}
  \item{method}{
A character vector containing the method of adjustment, if any.  If \code{weights} are specified, the user must specify either "matching" or "weighting"; "weighting" is the default. If multiple sets of weights are used, each must have a corresponding value for \code{method}, but if they are all of the same type, only one value is required. If \code{subclass} is specified, "subclassification" is the default.  Abbreviations allowed.
}
  \item{int}{
\code{logical} or \code{numeric}; whether or not to include 2-way interactions of covariates included in \code{covs} and in \code{addl}. If \code{numeric}, will be passed to \code{poly} as well. In older versions of \pkg{cobalt}, setting \code{int = TRUE} displayed squares of covariates; to replicate this behavior, set \code{int = 2}.
}
  \item{poly}{
\code{numeric}; the highest polynomial of each continuous covariate to display. For example, if 2, squares of each continuous covariate will be displayed (in addition to the covariate itself); if 3, squares and cubes of each continuous covariate will be displayed, etc. If 1, the default, only the base covariate will be displayed. If \code{int} is numeric, \code{poly} will take on the value of \code{int}.
}
  \item{addl}{
A vector, \code{data.frame}, or the quoted names of additional covariates for which to present balance.  These may be covariates included in the original dataset but not included in \code{covs}.  In general, it makes more sense to include all desired variables in \code{covs} than in \code{addl}. If the argument is a vector, the variable will be displayed as "addl" in the output.
}
  \item{continuous}{
whether mean differences for continuous variables should be standardized ("std") or raw ("raw"). Default "std". Abbreviations allowed. This option can be set globally using \code{\link{set.cobalt.options}}.
}
  \item{binary}{
whether mean differences for binary variables (i.e., difference in proportion) should be standardized ("std") or raw ("raw"). Default "raw". Abbreviations allowed. This option can be set globally using \code{\link{set.cobalt.options}}.
}
  \item{s.d.denom}{
A character vector denoting whether the denominator for standardized differences (if any are calculated) should be the standard deviation of the treated group ("treated"), the standard deviation of the control group ("control"), or the pooled standard deviation ("pooled"), computed as the square root of the mean of the group variances.  Abbreviations allowed. If weights are supplied, each set of weights should have a corresponding entry to \code{s.d.denom}. If left blank and weights are supplied, \code{bal.tab()} will try to determine whether the ATT, ATC, or ATE is being estimated based on the pattern of weights and supply \code{s.d.denom} accordingly. If matching or subclassification are used, the default is \code{"treated"}; if weighting is used, the default is \code{"pooled"}. If left blank, \code{bal.tab()} will try to use the \code{estimand} argument.
}
  \item{m.threshold}{
A numeric value for the threshold for mean differences.  .1 is recommended.  
}
  \item{v.threshold}{
A numeric value for the threshold for variance ratios.  Will automatically convert to the inverse if less than 1.
}
  \item{ks.threshold}{
a numeric value for the threshold for Kolmogorov-Smirnov statistics. Must be between 0 and 1. 
}
  \item{r.threshold}{
A numeric value for the threshold for correlations between covariates and treatment when treatment is continuous.
}
  \item{cluster}{
either a vector containing cluster membership for each unit or a string containing the name of the cluster membership variable in data or the CBPS object. See \code{\link{bal.tab.cluster}} for details.
}
  \item{imp}{
either a vector containing imputation indices for each unit or a string containing the name of the imputation index variable in \code{data}. See \code{\link{bal.tab.imp}} for details.
}
  \item{pairwise}{
Whether balance should be computed for pairs of treatments or for each treatment against all others combined. See \code{\link{bal.tab.multi}} for details. 
}
  \item{focal}{
The name of the focal treatment when multiple categorical treatments are used. See \code{\link{bal.tab.multi}} for details.
}
  \item{s.weights}{
Optional; either a vector containing sampling weights for each unit or a string containing the name of the sampling weight variable in \code{data}. These function like regular weights except that both the adjusted and unadjusted samples will be weighted according to these weights if weights are used.
}
  \item{estimand}{
\code{character}; whether the desired estimand is the "ATT", "ATC", or "ATE" for each set of weights. This argument can be used in place of \code{s.d.denom} to specify how standardized differences are calculated.
}
  \item{abs}{
\code{logical}; whether displayed balance statistics should be in absolute value or not. 
}
  \item{subset}{
A \code{logical} vector denoting whether each observation should be included. It should be the same length as the treatment and covariates. \code{NA}s will be treated as \code{FALSE}. This can be used as an alternative to \code{cluster} to examine balance on subsets of the data.
}
  \item{quick}{
\code{logical}; if \code{TRUE}, will not compute any values that will not be displayed. Leave \code{FALSE} if computed values not displayed will be used later.
}
  \item{...}{
For \code{bal.tab.formula}, other arguments to be passed to \code{bal.tab.data.frame}. Otherwise, further arguments to control display of output. See \link[=options-display]{display options} for details.
}
}
\details{
\code{bal.tab.data.frame()} generates a list of balance summaries for the covariates and treatment status values given. \code{bal.tab.formula()} does the same but uses a formula interface instead.  When the formula interface is used, the formula and data are reshaped into a treatment vector and \code{data.frame} of covariates and then simply passed through the \code{data.frame} method.  

The argument to \code{match.strata} corresponds to a factor vector containing the name or index of each pair/stratum for units conditioned through matching, for example, using the \pkg{optmatch} package. If more than one of \code{weights}, \code{subclass}, or \code{match.strata} are specified, \code{bal.tab()} will attempt to figure out which one to apply. Currently only one of these can be applied ta a time. \code{bal.tab()} behaves differently depending on whether subclasses are used in conditioning or not. If they are used, \code{bal.tab()} creates balance statistics for each subclass and for the sample in aggregate. See \code{\link{bal.tab.subclass}} for more information.

All balance statistics are calculated whether they are displayed by \code{print} or not, unless \code{quick = TRUE}.  The threshold values (\code{m.threshold}, \code{v.threshold}, \code{ks.threshold}, and, for continuous treatments, \code{r.threshold}) control whether extra columns should be inserted into the Balance table describing whether the balance statistics in question exceeded or were within the threshold.  Including these thresholds also creates summary tables tallying the number of variables that exceeded and were within the threshold and displaying the variables with the greatest imbalance on that balance measure.  When subclassification is used, the extra threshold columns are placed within the balance tables for each subclass as well as in the aggregate balance table, and the summary tables display balance for each subclass.

The inputs (if any) to \code{covs} and \code{data} must be a \code{data.frame}; if more than one variable is included, this is straightforward (i.e., because \code{data[,c("v1", "v2")]} is already a \code{data.frame}), but if only one variable is used with the matrix subsetting syntax (e.g., \code{data[,"v1"]}), \R will coerce it to a vector, thus making it unfit for input. To avoid this, make sure to use the list subsetting syntax (e.g., \code{data["v1"]}) if only one variable is to be added (this can also be used for multiple variables and is good practice in general). Again, when more than one variable is included, the input is generally already a \code{data.frame} and nothing needs to be done.

Multiple sets of weights can be supplied simultaneously by entering a \code{data.frame} or a character vector containing the names of weight variables found in \code{data} or a list of weights vectors or names. The arguments to \code{method}, \code{s.d.denom}, and \code{estimand}, if any, must be either the same length as the number of sets of weights or of length one, where the sole entry is applied to all sets. When standardized differences are computed for the unadjusted group, they are done using the first entry to \code{s.d.denom} or \code{estimand}. When only one set of weights is supplied, the output for the adjusted group will simply be called \code{"Adj"}, but otherwise will be named after each corresponding set of weights. Specifying multiple sets of weights will also add components to other output of \code{bal.tab()}.

Clusters and imputations can be used at the same time, but the resulting output may be quite large. Setting \code{which.cluster} or \code{which.imp} to \code{NA} can help keep the output clean.

}
\value{
For point treatments, if clusters and imputations are not specified, an object of class \code{"bal.tab"} containing balance summaries for the specified treatment and covariates. See \code{\link{bal.tab}} for details.

If clusters are specified, an object of class \code{"bal.tab.cluster"} containing balance summaries within each cluster and a summary of balance across clusters. See \code{\link{bal.tab.cluster}} for details.

If imputations are specified, an object of class \code{"bal.tab.imp"} containing balance summaries for each imputation and a summary of balance across imputations, just as with clusters. See \code{\link{bal.tab.imp}} for details.

If both clusters and imputations are specified, an object of class \code{"bal.tab.imp.cluster"} containing summaries between and across all clusters and imputations.

If treatment is continuous, then means, mean differences, and variance ratios are replaced by (weighted) Pearson correlations between each covariate and treatment. The \code{r.threshold} argument works the same as \code{m.threshold}, \code{v.threshold}, or \code{ks.threshold}, adding an extra column to the balance table output and creating additional summaries for balance tallies and maximum imbalances. All arguments related to the calculation or display of mean differences or variance ratios are ignored. The \code{int}, \code{distance}, \code{addl}, \code{un}, cluster and imputation arguments are still used as described above.

If multiple categorical treatments are used, an object of class \code{"bal.tab.multi"} containing balance summaries for each pairwise treatment comparison and a summary of balance across pairwise comparisons. See \code{\link{bal.tab.multi}} for details.
}


\author{
Noah Greifer 
}

\seealso{
\code{\link{bal.tab}} for output and details of calculations.
\code{\link{bal.tab.cluster}} for more information on clustered data.
\code{\link{bal.tab.imp}} for more information on multiply imputed data.
\code{\link{bal.tab.multi}} for more information on multiple categorical treatments.
}
\examples{
data("lalonde", package = "cobalt")
lalonde$p.score <- glm(treat ~ age + educ + race, data = lalonde, 
            family = "binomial")$fitted.values
covariates <- subset(lalonde, 
                     select = c(age, educ, race))
                     
## Propensity score weighting using IPTW
lalonde$iptw.weights <- ifelse(lalonde$treat==1, 
                               1/lalonde$p.score, 
                               1/(1-lalonde$p.score))

# data frame interface:
bal.tab(covariates, treat = "treat", data = lalonde, 
      weights = "iptw.weights", method = "weighting", 
      s.d.denom = "pooled")

# Formula interface:
bal.tab(treat ~ age + educ + race, data = lalonde, 
      weights = "iptw.weights", method = "weighting", 
      s.d.denom = "pooled")
      
## Propensity score subclassification
lalonde$subclass <- findInterval(lalonde$p.score, 
                        quantile(lalonde$p.score, 
                        (0:6)/6), all.inside = TRUE)

# data frame interface:
bal.tab(covariates, treat = "treat", data = lalonde, 
      subclass = "subclass", method = "subclassification", 
      disp.subclass = TRUE, s.d.denom = "pooled")

# Formula interface:
bal.tab(treat ~ age + educ + race, data = lalonde, 
      subclass = "subclass", method = "subclassification", 
      disp.subclass = TRUE, s.d.denom = "pooled")
}
