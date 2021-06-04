#' K-Nearest Neighbors function
#'
#' This function performs predicts an output class using covariates
#' given in training data.
#'
#' @param train An input data frame.
#' @param cl The true class value of the training data.
#' @param k_nn An integer representing the number of neighbors to use.
#' @param k_cv An integer representing the number of folds to use.
#' @keywords prediction
#'
#' @return A list with objects \code{class} (a vector of the predicted class
#'   for all observations) and \code{cv_err} (a numeric with the
#'   cross-validation misclassification error).
#'
#' @import dplyr
#' @importFrom dplyr %>%
#'
#' @examples
#' train_dat <- subset(na.omit(my_penguins), select = c(bill_length_mm,
#'   bill_depth_mm, flipper_length_mm, body_mass_g))
#' correct <- data.frame("species" = na.omit(my_penguins)$species)
#' my_knn_cv(train_dat, correct, 1, 5)
#'
#' @export
my_knn_cv <- function(train, cl, k_nn, k_cv) {
  # Create equal-probability folds to randomly assign observations to
  fold <- sample(rep(1:k_cv, length = length(train[[1]])))

  # Assign training observations to folds
  train$fold <- fold

  # Assign correct values to same folds
  cl$fold <- fold

  # Store cross-validation misclassification errors
  errors <- rep(0, k_cv)

  # For each fold...
  for (i in 1:k_cv) {
    # Make training data all other folds
    data_train <- train %>% dplyr::filter(fold != i) %>% dplyr::select(!fold)

    # Make training correct values come from all other folds
    cl_train <- cl %>% dplyr::filter(fold != i) %>% dplyr::select(!fold)

    # Make testing data current fold
    data_test <- train %>% dplyr::filter(fold == i) %>% dplyr::select(!fold)

    # Get correct values for testing data
    cl_test <- cl %>% dplyr::filter(fold == i) %>% dplyr::select(!fold)

    # Create predictions for current fold
    preds <- class::knn(data_train, data_test, cl_train[, 1], k = k_nn)

    # Update errors vector to show misclassification error
    errors[i] <- mean(preds != cl_test[, 1])
  }

  # Perform knn with full data as both training and test data
  result <- class::knn(train %>% dplyr::select(!fold),
               train %>% dplyr::select(!fold), cl[, 1],
               k = k_nn)

  # Make output list of predicted values and cv misclassification error
  results <- list("class" = result, "cv_err" = mean(errors))

  # Return list of results
  return(results)
}
