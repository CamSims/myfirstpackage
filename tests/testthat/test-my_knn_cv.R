test_that("my_knn_cv produces expected output", {
  train_dat <- subset(na.omit(my_penguins), select = c(bill_length_mm,
                                                       bill_depth_mm,
                                                       flipper_length_mm,
                                                       body_mass_g))
  correct <- data.frame("species" = na.omit(my_penguins)$species)
  expect_type(my_knn_cv(train_dat, correct, 1, 5), "list")
})
