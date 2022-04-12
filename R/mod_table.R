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
    ns <- session$ns

    output$table <- metaRender2(reactable::renderReactable, {
      req(.mtcars())

      metaExpr(
        reactable::reactable(..(.mtcars()))
      )
    })

    output$code <- renderPrint({
      expandChain(
        quote(library(poc.shinymeta)),
        output$table()
      )
    })

    output$download <- downloadHandler(
      filename = "script.zip",
      content = function(file) {
        table_1_code <- expandChain(
          quote(library(poc.shinymeta)),
          output$table()
        )

        shinymeta::buildRmdBundle(
          app_sys("app/rmd/script.Rmd"),
          file,
          vars = list(
            table_1 = table_1_code
          )
        )
      }
    )
  })
}
