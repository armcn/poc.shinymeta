library(shinytest)
options(shiny.autoload.r = FALSE)
if (interactive()) shinytest::testApp("../")

