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
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$slider <- renderUI({
      sliderInput(
        inputId = ns("mpg"),
        label = "Max MPG",
        value = max(.mtcars()$mpg),
        min = min(.mtcars()$mpg),
        max = max(.mtcars()$mpg),
        step = 1
      )
    })

    mtcars_mpg <- metaReactive2({
      req(.mtcars(), input$mpg)

      metaExpr(
        filter_max_mpg(..(.mtcars()), ..(input$mpg))
      )
    })

    return(mtcars_mpg)
  })
}
