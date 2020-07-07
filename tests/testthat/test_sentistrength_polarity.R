context("sentistrength_polarity")

test_that("Polarity with default limit", {
  res <- SentiStrengthPolarity(c(1, 2, 1, 3, 5, 4, 4),
                               c(-1, -1, -2, -3, -4, -5, -4))
  expect_equal(res, c(0, 1, -1, 0, 1, -1, NA))
})

test_that("Polarity with limit = 6", {
  expect_equal(SentiStrengthPolarity(5, -5, 6), 0)
})

test_that("Polarity with limit = 2", {
  expect_equal(SentiStrengthPolarity(c(1, 2), c(-1, -2), 2), c(0, NA))
})
