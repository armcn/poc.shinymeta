files_to_shinymeta_expr <- function(file_regex) {
  list.files("R", full.names = TRUE) %>%
    purrr::keep(function(file) grepl(file_regex, file)) %>%
    purrr::map(readLines) %>%
    purrr::flatten_chr() %>%
    paste0(collapse = "\n") %>%
    rlang::parse_exprs() %>%
    purrr::reduce(shinymeta::expandChain)
}
