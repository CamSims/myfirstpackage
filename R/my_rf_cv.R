#' Random Forest function
#'
#' This function performs predicts \code{body_mass_g} using covariates
#' \code{bill_length_mm}, \code{bill_depth_mm}, and \code{flipper_length_mm}
#' using random forests.
#'
#' @param k The number of folds desired
#' @keywords prediction
#'
#' @return A numeric with the cross-validation error
#'
#' @import dplyr
#' @importFrom dplyr %>%
#' @name %>%
#'
#' @examples
#' my_rf_cv(5)
#' my_rf_cv(20)
#'
#' @export
my_rf_cv <- function(k) {
  requireNamespace("dplyr")
  # Create data from penguins, omitting na values
  dat <- stats::na.omit(my_penguins %>% dplyr::select("body_mass_g",
                                                      "bill_length_mm",
                                                      "bill_depth_mm",
                                                      "flipper_length_mm"))

  # Create equal-probability folds to randomly assign observations to
  folds <- sample(rep(1:k, length = length(dat$body_mass_g)))

  # Assign observations to folds
  dat$fold <- folds

  # Create vector to hold MSE for each fold
  mses <- c()

  # For each fold...
  for (i in 1:k) {
    # Define training data as that not in current fold
    train_dat <- dat %>% dplyr::filter(fold != i)

    # Define testing data as that in the current fold
    test_dat <- dat %>% dplyr::filter(fold == i)

    # Train a random forest model with 100 trees to predict body_mass_g
    model <- randomForest::randomForest(body_mass_g ~ bill_length_mm +
                                          bill_depth_mm + flipper_length_mm,
                                          data = train_dat, ntree = 100)

    # Predict body_mass_g using the model
    preds <- stats::predict(model, test_dat[, -1])

    # Calculate MSE for current fold and append to MSE vector
    mses <- append(mses, mean((test_dat$body_mass_g - preds)^2))
  }

  return(mean(mses))
}
