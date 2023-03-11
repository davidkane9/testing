
<!-- README.md is generated from README.Rmd. Please edit that file -->

# testing

<!-- badges: start -->
[![R-CMD-check](https://github.com/davidkane9/testing/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/davidkane9/testing/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The purpose of this package is to provide a reproducible example of a
problem with installing packages from Github when using Github Actions,
and the resulting failure of R CMD check on Github, even for a package
which works fine locally.

1)  In the DESCRIPTION we have:

<!-- -->

    Remotes: 
        tidyverse/readr   

My actual problem is with one of my own Github packages, but I wanted to
use a high quality Github package for the example.

2)  My tests/testthat/test-ex.R file looks like:

<!-- -->

    library(readr)

    expect_equal(my_function("2"),
                 "2")

`my_function()` just returns the input. The whole packages passes R CMD
check locally with no NOTES/WARNINGS/ERRORS.

3)  The package was created with all the (wonderful!) **usethis** tools,
    including `usethis::use_github_actions()`. But when the R CMD check
    [runs](https://github.com/davidkane9/testing/actions/runs/4392864635/jobs/7692895359),
    via Github Actions, on Github, we see this error:

<!-- -->

    * checking for unstated dependencies in ‘tests’ ... WARNING
    Warning: 'library' or 'require' call not declared from: ‘readr’
    * checking tests ...
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > 
      > test_check("testing")
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error ('test-ex.R:1'): (code run outside of `test_that()`) ──────────────────
      <packageNotFoundError/error/condition>
      Error in `library(readr)`: there is no package called 'readr'
      Backtrace:
          ▆
       1. └─base::library(readr) at test-ex.R:1:0
      
      [ FAIL 1 | WARN 0 | SKIP 0 | PASS 0 ]
      Error: Test failures
      Execution halted

It is as if `tidyverse/readr` is never installed, despite its placement
in the DESCRIPTION file. This is consistent with what I see in the [log
file](https://github.com/davidkane9/testing/actions/runs/4392864635/jobs/7692895359):

    Install/update packages
      ℹ Installing lockfile '.github/pkg.lock'
       
      → Will install 38 packages.
      → Will download 37 CRAN packages (10.03 MB).
      → Will download 1 package with unknown size.

I *think* that the “1 package with unknow size” refers to
`tidyverse/readr` but I don’t see any evidence that it is is ever
downloaded or installed.

Any ideas much appreciated!

## Installation

You can install the development version of testing from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("davidkane9/testing")
```
