#' select_cols Server Functions
#'
#' @noRd
mod_select_cols <- function(id, .mtcars, .cols) {
  moduleServer(id, function(input, output, session) {
    mtcars_cols <- metaReactive2({
      req(.mtcars(), is.character(.cols()))

      metaExpr({
        select_cols(..(.mtcars()), ..(.cols()))
      })
    })

    return(mtcars_cols)
  })
}
