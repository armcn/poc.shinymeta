testServer(
  mod_dropdown_cols_server,
  args = list(.mtcars = reactive(mtcars)),
  {
    session$setInputs(cols = character(0))
    session$returned() %>% expect_identical(character(0))

    session$setInputs(cols = "mpg")
    session$returned() %>% expect_identical("mpg")

    session$setInputs(cols = c("mpg", "cyl"))
    session$returned() %>% expect_identical(c("mpg", "cyl"))
  }
)

testServer(
  mod_dropdown_cols_server,
  args = list(
    .mtcars = reactive(dplyr::select(mtcars, character(0)))
  ),
  {
    mtcars_names() %>% expect_identical(character(0))
  }
)

testServer(
  mod_dropdown_cols_server,
  args = list(
    .mtcars = reactive(dplyr::select(mtcars, "mpg"))
  ),
  {
    mtcars_names() %>% expect_identical("mpg")
  }
)

testServer(
  mod_dropdown_cols_server,
  args = list(
    .mtcars = reactive(dplyr::select(mtcars, c("mpg", "cyl")))
  ),
  {
    mtcars_names() %>% expect_identical(c("mpg", "cyl"))
  }
)
