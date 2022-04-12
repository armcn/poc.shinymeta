#' Filter mtcars by cylinder
#'
#' @export
filter_cyl <- function(.mtcars, .cyl) {
  dplyr::filter(.mtcars, .data$cyl == .cyl)
}

#' Filter mtcars by max mpg
#'
#' @export
filter_max_mpg <- function(.mtcars, .mpg) {
  dplyr::filter(.mtcars, .data$mpg <= .mpg)
}

#' Select mtcars columns
#'
#' @export
select_cols <- function(.mtcars, .cols) {
  dplyr::select(.mtcars, .cols)
}
