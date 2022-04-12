testServer(
  mod_filter_cyl,
  args = list(
    .mtcars = reactive(mtcars),
    .cyl = reactive(4)
  ),
  {
    session$returned()$cyl %>%
      unique() %>%
      expect_identical(4)
  }
)

testServer(
  mod_filter_cyl,
  args = list(
    .mtcars = reactive(mtcars),
    .cyl = reactive(6)
  ),
  {
    session$returned()$cyl %>%
      unique() %>%
      expect_identical(6)
  }
)

testServer(
  mod_filter_cyl,
  args = list(
    .mtcars = reactive(mtcars),
    .cyl = reactive(8)
  ),
  {
    session$returned()$cyl %>%
      unique() %>%
      expect_identical(8)
  }
)
