library(rstanarm)

stan_glm(
  mpg ~ wt + cyl + am,
  data = mtcars,
  QR = TRUE,
  # for speed of example only (default is "sampling")
  algorithm = "fullrank",
  refresh = 0
)
