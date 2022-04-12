#' dropdown_cols UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_dropdown_cols_ui <- function(id) {
  ns <- NS(id)

  selectInput(
    inputId = ns("cols"),
    label = "Columns",
    choices = NULL,
    multiple = TRUE
  )
}

#' dropdown_cols Server Functions
#'
#' @noRd
mod_dropdown_cols_server <- function(id, .mtcars) {
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    mtcars_names <- reactive({
      req(.mtcars())

      colnames(.mtcars())
    })

    observe({
      req(mtcars_names())

      updateSelectInput(
        session = session,
        inputId = "cols",
        choices = mtcars_names(),
        selected = utils::head(mtcars_names(), 5L)
      )
    }) %>%
      bindEvent(mtcars_names())

    return(reactive(input$cols))
  })
}
