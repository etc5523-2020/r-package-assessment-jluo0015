test_that("select_country_month()", {
  case <- select_country_month(country_select = "Japan",
                               month_select = 3)
  
  
  expect_match(unique(case$country), "Japan")
  expect_equal(unique(case$month), 3)
  expect_error(select_country_month(country_select = Japan, month_select = 3))
  expect_error(select_country_month(country_select = "Japan", month_select = "March"))
  expect_error(select_country_month(country_select = "Japan", month_select = "3"))
  expect_error(select_country_month(country_select = NULL, month_select = 3))
  expect_error(select_country_month(country_select = "", month_select = 3))
  expect_error(select_country_month(country_select = "Japan", month_select = NULL))
  expect_error(select_country_month(country_select = "Japan", month_select = ""))
  
})
