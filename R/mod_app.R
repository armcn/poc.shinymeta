#' app UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_app_ui <- function(id) {
  ns <- NS(id)

  header <- bs4Dash::dashboardHeader(
    title = "PoC shinymeta",
    status = "gray-dark",
    skin = "dark",
    fixed = TRUE,
    compact = TRUE
  )

  sidebar <- bs4Dash::dashboardSidebar(
    skin = "light",
    mod_radio_cyl_ui(ns("radio_cyl")),
    mod_slider_mpg_ui(ns("slider_mpg")),
    mod_select_cols_ui(ns("select_cols"))
  )

  body <- bs4Dash::dashboardBody(
    mod_table_ui(ns("table"))
  )

  bs4Dash::dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body,
    dark = NULL
  )

}

#' app Server Functions
#'
#' @noRd
mod_app_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    mtcars_copy <-
      metaReactive(mtcars, varname = "mtcars")

    mtcars_cyl <-
      mod_radio_cyl_server("radio_cyl", mtcars_copy)

    mtcars_cyl_mpg <-
      mod_slider_mpg_server("slider_mpg", mtcars_cyl)

    mtcars_cyl_mpg_cols <-
      mod_select_cols_server("select_cols", mtcars_cyl_mpg)

    mod_table_server("table", mtcars_cyl_mpg_cols)
  })
}
