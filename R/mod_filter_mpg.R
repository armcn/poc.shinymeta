#' filter_mpg Server Functions
#'
#' @noRd
mod_filter_mpg <- function(id, .mtcars, .mpg) {
  moduleServer(id, function(input, output, session) {
    mtcars_mpg <- metaReactive2({
      req(.mtcars(), .mpg())

      metaExpr(
        filter_max_mpg(..(.mtcars()), ..(.mpg()))
      )
    })

    return(mtcars_mpg)
  })
}
