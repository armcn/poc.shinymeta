#' Filter mtcars by cylinder
#'
#' @param .mtcars Filtered or unfiltered mtcars data
#' @param .cyl A numeric cylinder value of 4, 6, or 8
#'
#' @return mtcars data filtered by cylinder
#' @export
filter_cyl <- function(.mtcars, .cyl) {
  dplyr::filter(.mtcars, .data$cyl == .cyl)
}

#' Filter mtcars by max mpg
#'
#' @param .mtcars Filtered or unfiltered mtcars data
#' @param .mpg A numeric value of miles per gallon
#'
#' @return mtcars data filtered with miles per gallon less than '.mpg'
#' @export
filter_max_mpg <- function(.mtcars, .mpg) {
  dplyr::filter(.mtcars, .data$mpg <= .mpg)
}

#' Select mtcars columns
#'
#' @param .mtcars Filtered or unfiltered mtcars data
#' @param .cols A character vector of column names to select
#'
#' @return mtcars data containing a subset of columns
#' @export
select_cols <- function(.mtcars, .cols) {
  dplyr::select(.mtcars, dplyr::all_of(.cols))
}
