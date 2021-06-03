test_that("two.sided works", {
  set.seed(123)
  x <- rnorm(100, 0, 1)
  response <- list(test_stat = 0.99040684, df = 99, alternative = "two.sided",
                   p_val = 0.32438981)
  expect_equal(my_t.test(x, "two.sided", 0), response)
})

test_that("less works", {
  set.seed(123)
  x <- rnorm(100, 0, 1)
  response <- list(test_stat = 0.99040684, df = 99, alternative = "less",
                   p_val = 0.8378051)
  expect_equal(my_t.test(x, "less", 0), response)
})

test_that("greater works", {
  set.seed(123)
  x <- rnorm(100, 0, 1)
  response <- list(test_stat = 0.99040684, df = 99, alternative = "greater",
                   p_val = 0.162194906)
  expect_equal(my_t.test(x, "greater", 0), response)
})
