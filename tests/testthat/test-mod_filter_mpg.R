testServer(
  mod_filter_mpg,
  args = list(
    .mtcars = reactive(mtcars),
    .mpg = reactive(0)
  ),
  {
    session$returned() %>%
      nrow() %>%
      expect_identical(0L)
  }
)

testServer(
  mod_filter_mpg,
  args = list(
    .mtcars = reactive(mtcars),
    .mpg = reactive(1e6)
  ),
  {
    session$returned() %>%
      expect_identical(mtcars)
  }
)

testServer(
  mod_filter_mpg,
  args = list(
    .mtcars = reactive(mtcars),
    .mpg = reactive(20.4)
  ),
  {
    max(session$returned()$mpg) <= 20.4
  }
)
