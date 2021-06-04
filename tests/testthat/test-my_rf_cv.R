test_that("my_rf_cv works mathematically", {
  set.seed(123)
  expect_equal(my_rf_cv(5), 120419.736)
})
