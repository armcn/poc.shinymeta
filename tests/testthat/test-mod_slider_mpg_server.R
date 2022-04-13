testServer(mod_slider_mpg_server, {
  session$setInputs(mpg = 0)
  session$returned() %>% expect_identical(0)

  session$setInputs(mpg = 5.5)
  session$returned() %>% expect_identical(5.5)

  session$setInputs(mpg = 30)
  session$returned() %>% expect_identical(30)
})

min_mpg_expected <- 1
max_mpg_expected <- as.double(nrow(mtcars))

mtcars_modified_mpg <- mtcars %>%
  dplyr::mutate(
    mpg = as.double(
      seq(min_mpg_expected, max_mpg_expected)
    )
  )

testServer(
  mod_slider_mpg_server,
  args = list(.mtcars = reactive(mtcars_modified_mpg)),
  {
    min_mpg() %>% expect_identical(min_mpg_expected)
    max_mpg() %>% expect_identical(max_mpg_expected)
  }
)

test_that("dynamic slider input generates correct HTML", {
  skip_on_covr()

  app <- shinytest::ShinyDriver$new(run_app())
  app$setInputs(`cyl-cyl` = "6")
  app$getValue("mpg-slider") %>% expect_snapshot()
})
