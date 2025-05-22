#' Check regression assumptions
#'
#' This function performs base R regression diagnostics using `plot(model)`.
#' It supports linear models (`lm`) and logistic regression models (`glm` with `binomial` family).
#' Predictors are standardized (mean = 0, sd = 1) before modeling.
#'
#' @param data A data frame.
#' @param response Unquoted name of the response variable.
#' @param predictors A call to c() with unquoted variable names.
#' @param model_type Either "lm" (default) or "glm" for logistic regression.
#'
#' @return Invisibly returns the fitted model. Produces plots and prints VIFs.
#' @export
#'
#' @examples
#' check_assumptions(mtcars, mpg, c(wt, hp), model_type = "lm")
#' check_assumptions(mtcars, am, c(wt, hp), model_type = "glm")
check_assumptions <- function(data, response, predictors, model_type = "lm") {
  model_type <- match.arg(model_type, choices = c("lm", "glm"))

  response_name <- deparse(substitute(response))
  predictor_names <- as.character(substitute(predictors))[-1]

  # Create working copy of data
  data_mod <- data

  # Standardize predictor columns
  data_mod[predictor_names] <- scale(data_mod[predictor_names])

  # Build formula
  formula <- as.formula(paste(response_name, "~", paste(predictor_names, collapse = " + ")))

  # Fit model
  model <- if (model_type == "lm") {
    lm(formula, data = data_mod)
  } else {
    glm(formula, data = data_mod, family = binomial())
  }

  # Plot diagnostics
  par(mfrow = c(2, 2))
  plot(model)
  par(mfrow = c(1, 1))

  # VIF logic
  if (requireNamespace("car", quietly = TRUE)) {
    if (inherits(model, "lm")) {
      cat("\n--- Variance Inflation Factors ---\n")
      print(car::vif(model))
    } else if (inherits(model, "glm")) {
      cat("\n--- VIF (approximated from linear model) ---\n")
      lm_approx <- lm(formula, data = data_mod)
      print(car::vif(lm_approx))
    }
  } else {
    warning("Package 'car' not installed. Skipping VIF calculation.")
  }

  invisible(model)
}
