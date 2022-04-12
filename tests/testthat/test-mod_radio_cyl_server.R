testServer(mod_radio_cyl_server, {
  session$setInputs(cyl = "4")
  session$returned() %>% expect_identical(4)

  session$setInputs(cyl = "6")
  session$returned() %>% expect_identical(6)

  session$setInputs(cyl = "8")
  session$returned() %>% expect_identical(8)
})
