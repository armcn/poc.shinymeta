#' slider_mpg UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_slider_mpg_ui <- function(id) {
  ns <- NS(id)

  uiOutput(outputId = ns("slider"))
}

#' slider_mpg Server Functions
#'
#' @noRd
mod_slider_mpg_server <- function(id, .mtcars) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    min_mpg <- reactive({
      req(.mtcars())

      min(.mtcars()$mpg)
    })

    max_mpg <- reactive({
      req(.mtcars())

      max(.mtcars()$mpg)
    })

    output$slider <- renderUI({
      req(min_mpg(), max_mpg())

      sliderInput(
        inputId = ns("mpg"),
        label = "Max MPG",
        value = max_mpg(),
        min = min_mpg(),
        max = max_mpg(),
        step = 1
      )
    })

    return(reactive(input$mpg))
  })
}
