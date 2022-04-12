#' select_cols UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_select_cols_ui <- function(id) {
  ns <- NS(id)

  selectInput(
    inputId = ns("cols"),
    label = "Columns",
    choices = NULL,
    multiple = TRUE
  )
}

#' select_cols Server Functions
#'
#' @noRd
mod_select_cols_server <- function(id, .mtcars) {
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    updateSelectInput(
      session = session,
      inputId = "cols",
      choices = colnames(.mtcars()),
      selected = colnames(.mtcars())[1:5]
    ) %>%
      observe() %>%
      bindEvent(.mtcars())

    mtcars_cols <- metaReactive2({
      req(input$cols)

      metaExpr({
        select_cols(..(.mtcars()), ..(input$cols))
      })
    })

    return(mtcars_cols)
  })
}
