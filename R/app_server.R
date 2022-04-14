#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @noRd
app_server <- function(input, output, session) {
  mtcars_copy <-
    metaReactive(datasets::mtcars, varname = "mtcars_copy")

  cyl <-
    mod_radio_cyl_server("cyl")

  mtcars_cyl <-
    mod_filter_cyl("filter", mtcars_copy, cyl)

  mpg <-
    mod_slider_mpg_server("mpg", mtcars_cyl)

  mtcars_cyl_mpg <-
    mod_filter_mpg("filter", mtcars_cyl, mpg)

  cols <-
    mod_dropdown_cols_server("cols", mtcars_cyl_mpg)

  mtcars_cyl_mpg_cols <-
    mod_select_cols("select", mtcars_cyl_mpg, cols)

  mod_table_server("table", mtcars_cyl_mpg_cols)
}
