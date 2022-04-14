#' table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_table_ui <- function(id) {
  ns <- NS(id)

  tagList(
    bs4Dash::box(
      title = "Reproducible code",
      width = 12,
      verbatimTextOutput(outputId = ns("code")),
      downloadButton(
        outputId = ns("download"),
        label = "Download Code"
      )
    ),
    bs4Dash::box(
      title = "Filtered data",
      width = 12,
      reactable::reactableOutput(outputId = ns("table"))
    )
  )
}

#' table Server Functions
#'
#' @noRd
mod_table_server <- function(id, .mtcars) {
  moduleServer(id, function(input, output, session) {
    output$table <- metaRender2(reactable::renderReactable, {
      req(.mtcars())

      metaExpr(
        reactable::reactable(..(.mtcars()))
      )
    })

    output$code <- renderPrint({
      shinymeta::expandChain(
        files_to_shinymeta_expr("^R/fct_"),
        output$table()
      )
    })

    output$download <- downloadHandler(
      filename = "script.zip",
      content = function(file) {
        functions <-
          files_to_shinymeta_expr("^R/fct_")

        table_1_code <-
          shinymeta::expandChain(output$table())

        shinymeta::buildRmdBundle(
          app_sys("app/rmd/script.Rmd"),
          file,
          vars = list(
            functions = functions,
            table_1 = table_1_code
          )
        )
      }
    )
  })
}
