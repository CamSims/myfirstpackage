#' Linear Model function
#'
#' This function fits a linear model.
#'
#' @param formula a formula class object, similar to lm().
#' @param data An input data frame.
#' @keywords inference, prediction
#'
#' @return A dataframe with rows for each coefficient and columns for
#'   the \code{Estimate}, \code{Std. Error}, \code{t value}, and \code{Pr(>|t|)}
#'   with row and column names.
#'
#' @examples
#' my_lm(y ~ x, data.frame(x = rnorm(100, 0, 1), y = rnorm(100, 0, 1)))
#'
#' @export
my_lm <- function(formula, data) {
  x_mat <- stats::model.matrix(object = formula, data = data)
  y_mat <- stats::model.response(stats::model.frame(formula = formula,
                                                    data = data))
  beta_hat <- solve(t(x_mat) %*% x_mat) %*% t(x_mat) %*% y_mat
  df <- length(data[[1]]) - length(beta_hat)
  variance <- sum((y_mat - x_mat %*% beta_hat)**2) / df
  se <- sqrt(diag(variance * solve(t(x_mat) %*% x_mat)))
  test_stat <- beta_hat / se
  p_vals <- 2 * stats::pt(abs(test_stat), df, lower.tail = FALSE)
  results <- data.frame(
    "Estimate" = beta_hat,
    "Std. Error" = se,
    "t value" = test_stat,
    "Pr(>|t|)" = p_vals,
    check.names = FALSE
  )
  return(results)
}
