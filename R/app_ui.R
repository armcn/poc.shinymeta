#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @noRd
app_ui <- function(request) {
  header <- bs4Dash::dashboardHeader(
    title = "PoC shinymeta",
    status = "gray-dark",
    skin = "dark",
    fixed = TRUE,
    compact = TRUE
  )

  sidebar <- bs4Dash::dashboardSidebar(
    skin = "light",
    mod_radio_cyl_ui("cyl"),
    mod_slider_mpg_ui("mpg"),
    mod_dropdown_cols_ui("cols")
  )

  body <- bs4Dash::dashboardBody(
    mod_table_ui("table")
  )

  tagList(
    golem_add_external_resources(),
    bs4Dash::dashboardPage(
      header = header,
      sidebar = sidebar,
      body = body,
      dark = NULL
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){

  add_resource_path(
    'www', app_sys('app/www')
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'poc.shinymeta'
    )
  )
}

