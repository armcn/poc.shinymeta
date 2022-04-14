#' filter_cyl Server Functions
#'
#' @noRd
mod_filter_cyl <- function(id, .mtcars, .cyl) {
  moduleServer(id, function(input, output, session) {
    mtcars_cyl <- metaReactive2({
      req(.mtcars(), .cyl())

      metaExpr(
        filter_cyl(..(.mtcars()), ..(.cyl()))
      )
    })

    return(mtcars_cyl)
  })
}
