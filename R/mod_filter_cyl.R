#' filter_cyl Server Functions
#'
#' @noRd
mod_filter_cyl <- function(id, .mtcars, .cyl) {
  moduleServer(id, function(input, output, session) {
    metaReactive2({
      req(.mtcars(), .cyl())

      metaExpr(
        filter_cyl(..(.mtcars()), ..(.cyl()))
      )
    })
  })
}
