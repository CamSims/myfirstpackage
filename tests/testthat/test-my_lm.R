test_that("my_lm performs correct regression", {
  set.seed(123)
  test_frame <- data.frame(x = rnorm(100, 0, 1), y = rnorm(100, 0, 1))
  result <- data.frame(
    "Estimate" = c(-0.102803054, -0.052471614),
    "Std. Error" = c(0.0975511837, 0.1068786165),
    "t value" = c(-1.05383707, -0.49094586),
    "Pr(>|t|)" = c(0.29454885, 0.62456234),
    check.names = FALSE,
    row.names = c('(Intercept)', 'x')
  )
  expect_equal(my_lm(y~x, test_frame), result)
})
