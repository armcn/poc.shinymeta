#' radio_cyl UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_radio_cyl_ui <- function(id) {
  ns <- NS(id)

  radioButtons(
    inputId = ns("cyl"),
    label = "Cylinders",
    choices = c(4L, 6L, 8L),
    inline = TRUE
  )
}

#' radio_cyl Server Functions
#'
#' @noRd
mod_radio_cyl_server <- function(id, .mtcars) {
  moduleServer(id, function(input, output, session) {
    return(reactive(as.double(input$cyl)))
  })
}
