testServer(
  mod_select_cols,
  args = list(
    .mtcars = reactive(mtcars),
    .cols = reactive(character(0))
  ),
  {
    session$returned() %>%
      ncol() %>%
      expect_identical(0L)
  }
)

testServer(
  mod_select_cols,
  args = list(
    .mtcars = reactive(mtcars),
    .cols = reactive("mpg")
  ),
  {
    session$returned() %>%
      colnames() %>%
      expect_identical("mpg")
  }
)

testServer(
  mod_select_cols,
  args = list(
    .mtcars = reactive(mtcars),
    .cols = reactive(c("mpg", "cyl"))
  ),
  {
    session$returned() %>%
      colnames() %>%
      expect_identical(c("mpg", "cyl"))
  }
)
