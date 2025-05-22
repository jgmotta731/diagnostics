
# diagnostics <img src="https://img.shields.io/badge/R%20Package-Diagnostics-blue.svg" align="right" height="30"/>

A lightweight, base R–driven tool for quickly checking linear and
logistic regression assumptions.

## 🔍 Features

The `diagnostics` package provides a simple interface for assumption
checking in linear and logistic regression models:

- ✅ Residual diagnostics using `plot(lm)` or `plot(glm)`
- ✅ Automatic standardization of predictors (mean = 0, sd = 1)
- ✅ Multicollinearity checks via VIF (including approximate VIF for
  GLMs)

## 📦 Installation

``` r
# install.packages("remotes")
remotes::install_github("jgmotta731/diagnostics")
```

    ## Using GitHub PAT from the git credential store.

    ## Skipping install of 'diagnostics' from a github remote, the SHA1 (ed78196c) has not changed since last install.
    ##   Use `force = TRUE` to force installation

## 🚀 Quick Start

``` r
library(diagnostics)

# Linear regression assumption checks (predictors are standardized automatically)
check_assumptions(mtcars, mpg, c(wt, hp, qsec), model_type = "lm")
```

![](README_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

    ## 
    ## --- Variance Inflation Factors ---
    ##       wt       hp     qsec 
    ## 2.530443 4.921956 2.873804

``` r
# Logistic regression assumption checks (binary response required)
check_assumptions(mtcars, am, c(wt, hp), model_type = "glm")
```

![](README_files/figure-gfm/unnamed-chunk-2-2.png)<!-- -->

    ## 
    ## --- Variance Inflation Factors ---
    ##       wt       hp 
    ## 2.444297 2.444297

## 📊 Outputs

- Displays 4 base R diagnostic plots using `plot(model)`
- Automatically standardizes predictors before model fitting
- Prints Variance Inflation Factors (VIF) to console:
  - For `lm`: directly from `car::vif()`
  - For `glm`: approximated using a linear model

## 📚 Function Reference

| Function | Description |
|----|----|
| `check_assumptions()` | Run all core diagnostics for `lm` or `glm` models using base R plotting |

## 🛠 Requirements

- R 4.1 or later  
- Suggested: `car` (for VIF calculation)

## 📄 License

MIT © Jack Motta
