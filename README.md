
<!-- README.md is generated from README.Rmd. Please edit that file -->

# shinymeta Proof of Concept

## Overview

This is a proof of concept to use the
[`shinymeta`](https://rstudio.github.io/shinymeta/) package for
reproducible code generation in a shiny app. This app also experiments
with other best practices including:

-   Using the [`golem`](https://thinkr-open.github.io/golem/) framework
    to build a shiny app as an R package

-   Extracting domain logic into [pure
    functions](https://adv-r.hadley.nz/fp.html)

-   Organizing R code into [shiny
    modules](https://mastering-shiny.org/scaling-modules.html)

-   Testing modules with
    [`testServer`](https://shiny.rstudio.com/reference/shiny/1.5.0/testServer.html)

-   Testing the whole app with
    [`shinytest`](https://rstudio.github.io/shinytest/)

-   Building the UI with the
    [`bs4Dash`](https://rinterface.github.io/bs4Dash/) package

The proposed best practices make using
[`shinymeta`](https://rstudio.github.io/shinymeta/) much easier and they
are also good practices to use with any shiny app.

## Proposed Best Practices

### golem

> `golem` is an opinionated framework for building production-grade
> shiny applications.

[`golem`](https://thinkr-open.github.io/golem/) allows you to build a
shiny app as an R package. This comes with many benefits including easer
testing, file structure conventions, function docs and vignettes, app
metadata, and dependency management.

All non-reactive functions used in the app should be saved in the “R”
directory with file names prefixed by “fct\_” (short for functions). All
reactive functions should be contained in [shiny
modules](https://mastering-shiny.org/scaling-modules.html) with file
names prefixed by “mod\_” (short for module).

### shinymeta

> The **shinymeta** R package provides tools for capturing logic in a
> Shiny app and exposing it as code that can be run outside of Shiny
> (e.g., from an R console). It also provides tools for bundling both
> the code and results to the end user.

This demo app generates the following code. The code contains everything
needed to generate the output (an HTML table).

    filter_cyl <- function(.mtcars, .cyl) {
      dplyr::filter(.mtcars, .data$cyl == .cyl)
    }
    filter_max_mpg <- function(.mtcars, .mpg) {
      dplyr::filter(.mtcars, .data$mpg <= .mpg)
    }
    select_cols <- function(.mtcars, .cols) {
      dplyr::select(.mtcars, dplyr::all_of(.cols))
    }
    mtcars_copy <- datasets::mtcars
    filter_mtcars_cyl <- filter_cyl(mtcars_copy, 4)
    filter_mtcars_mpg <- filter_max_mpg(filter_mtcars_cyl, 33.9)
    select_mtcars_cols <- select_cols(filter_mtcars_mpg, c("mpg", "cyl", "disp", "hp", "drat"))
    reactable::reactable(select_mtcars_cols)

[`shinymeta`](https://rstudio.github.io/shinymeta/) requires a few
changes to regular shiny code to allow for automatic code generation.
See the package [documentation](https://rstudio.github.io/shinymeta/)
for more details.

1.  All non-reactive functions must be defined in a known location
    ("R/fct\_\*.R") and added to the start of the generated script. This
    can be done in several ways but this app uses the function
    `files_to_shinymeta_expr` to do so.

2.  All `reactive`, `observe`, or `render` blocks must be replaced with
    their `metaReactive`, `metaObserve`, or `metaRender` equivalents.

For example

    mtcars_cyl <- reactive({
      req(mtcars(), cyl())

      filter_cyl(mtcars(), cyl())
    })

becomes

    mtcars_cyl <- metaReactive2({
      req(mtcars(), cyl())

      metaExpr({
        filter_cyl(..(mtcars()), ..(cyl()))
      })
    })

It is recommended to include a `req()` or `validate()` call at the start
of any reactive block to prevent displaying error states in outputs. In
the context of [`shinymeta`](https://rstudio.github.io/shinymeta/) this
requires using `metaReactive2` and `metaExpr`.

To improve the readability of the generated code `metaExpr` should only
contain one function call. This function can be as complex as you need
but should have a descriptive name and be saved in a file with the
“R/fct\_” prefix.

### Pure Functions

> A function is pure if it satisfies two properties: The output only
> depends on the inputs, i.e. if you call it again with the same inputs,
> you get the same outputs. This excludes functions like runif(),
> read.csv(), or Sys.time() that can return different values. The
> function has no side-effects, like changing the value of a global
> variable, writing to disk, or displaying to the screen. This excludes
> functions like print(), write.csv() and &lt;-.

Each `metaReactive` or `metaReactive2` block should have all logic
encapsulated into a single [pure
function](https://adv-r.hadley.nz/fp.html). This has multiple benefits
including more readable generated code and easier testing/debugging.

### Shiny Modules

> Shiny modules have two big advantages. Firstly, namespacing makes it
> easier to understand how your app works because you can write,
> analyse, and test individual components in isolation. Secondly,
> because modules are functions they help you reuse code; anything you
> can do with a function, you can do with a module.

All reactive code should be contained in [shiny
modules](https://mastering-shiny.org/scaling-modules.html). This means
that you should never be dealing with `input` or `output` values outside
of a module. [shiny
modules](https://mastering-shiny.org/scaling-modules.html) may contain
inputs and/or outputs and they can accept reactive arguments and/or
return reactive values.

For [`shinymeta`](https://rstudio.github.io/shinymeta/) to generate the
best variable names any non-reactive arguments must first be wrapped in
`metaReactive` and given a name with “varname”.

    mtcars_copy <- metaReactive(mtcars, varname = "mtcars_copy")

### testServer

> A way to test the reactive interactions in Shiny applications.
> Reactive interactions are defined in the server function of
> applications and in modules.

Testing individual modules can give you confidence that the reactive
interactions are working as expected. This is particularily useful when
a module returns a reactive value.

### shinytest

> shinytest provides a simulation of a Shiny app that you can control in
> order to automate testing. shinytest uses a snapshot-based testing
> strategy: the first time it runs a set of tests for an application, it
> performs some scripted interactions with the app and takes one or more
> snapshots of the application’s state. Subsequent runs perform the same
> scripted interactions then compare the results; you’ll get an error if
> they’re different.

### bs4Dash

> Bootstrap 4 shinydashboard using AdminLTE3

[`bs4Dash`](https://rinterface.github.io/bs4Dash/) is a UI framework for
shiny which has a modern feel and allows easy customization using the
[`fresh`](https://dreamrs.github.io/fresh/) package.
