
# myfirstpackage

<!-- badges: start -->
[![R-CMD-check](https://github.com/CamSims/myfirstpackage/workflows/R-CMD-check/badge.svg)](https://github.com/CamSims/myfirstpackage/actions)
[![codecov](https://codecov.io/gh/CamSims/myfirstpackage/branch/master/graph/badge.svg?token=1EGFJE76Z4)](https://codecov.io/gh/CamSims/myfirstpackage)
<!-- badges: end -->

The goal of myfirstpackage is to perform statistical inference and prediction
methods on a variety of data. The methods included are t-test, linear
regression, k-nearest neighbors with cross validation, and random forests with 
cross validation.

## Installation

You can install the package through GitHub using 

``` r
devtools::install_github("CamSims/myfirstpackage")
```

## Use

To view the vignette:

``` r
devtools::install_github("CamSims/myfirstpackage", build_vignette = TRUE, build_opts = c())
library("myfirstpackage")
# Use this to view the vignette in the myfirstpackge HTML help
help(package = "myfirstpackage", help_type = "html")
# Use this to view the vignette as an isolated HTML file
utils::browseVignettes(package = "myfirstpackage")
```
