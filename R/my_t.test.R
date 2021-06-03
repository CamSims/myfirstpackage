#' One-sample t-test function
#'
#' This function performs a one-sample t-test.
#'
#' @param x A numeric vector of data.
#' @param alternative A character string specifying the alternative hypothesis,
#'   should only be \code{"two.sided"}, \code{"less"}, or \code{"greater"}.
#' @param mu A number indicating the null hypothesis value of the mean.
#' @keywords inference
#'
#' @return A list containing four elements: \code{test_stat} (the numeric test,
#'   test statistic), \code{df} (the degrees of freedom), \code{alternative}
#'   (the value of the parameter "alternative"), and \code{p_val}
#'   (the numeric p-value).
#'
#' @examples
#' my_t.test(x = rnorm(100, 0, 1), alternative = "two.sided", mu = 0)
#' my_t.test(x = runif(20, 5, 3), alternative = "less", mu = 4)
#' my_t.test(x = rbinom(70, 6, 0.75), alternative = "greater", mu = 2)
#'
#' @export
my_t.test <- function(x, alternative, mu) {
  df <- length(x) - 1
  # Check to make sure alternative is "two.sided", "less", or "greater"
  if (alternative %in% c("two.sided", "less", "greater")) {
    se <- stats::sd(x) / sqrt(length(x))
    test_stat <- (mean(x) - mu) / se
    p_val <- round(stats::pt(test_stat, df),4)
    if (alternative == "less") {
      p_val = stats::pt(test_stat, df, lower.tail = TRUE)
    } else if (alternative == "greater") {
      p_val = stats::pt(test_stat, df, lower.tail = FALSE)
    } else {
      p_val = 2 * stats::pt(abs(test_stat), df, lower.tail = FALSE)
    }
    # If alternative none of three, provide informative error
  } else {
    stop("The alternative hypothesis must be 'two.sided', 'less', or 'greater'.")
  }
  # Return list containing one-sample t-test results
  t_results <- list("test_stat" = test_stat, "df" = df,
                    "alternative" = alternative, "p_val" = p_val)
  return(t_results)
}
