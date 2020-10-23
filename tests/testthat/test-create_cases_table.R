test_that("input of create_cases_table()", {
  expect_error(create_cases_table(country_select = Japan, 
                                  cases_frequency = "monthly"))
  
  expect_error(create_cases_table(country_select = "Japan",
                                  cases_frequency = monthly))
  
  expect_error(create_cases_table(country_select = "Australia",
                                  province_select = Victoria,
                                  cases_frequency = "monthly"))
  
  expect_error(create_cases_table(country_select = "Australia",
                                  province_select = "victoria",
                                  cases_frequency = "monthly"))
  
  expect_error(create_cases_table(country_select = "Australia",
                                  province_select = "Victoria",
                                  cases_frequency = "Monthly"))
  
  expect_error(create_cases_table(country_select = "",
                                  cases_frequency = "monthly"))
  expect_error(create_cases_table(country_select = NULL,
                                  cases_frequency = "monthly"))
  expect_error(create_cases_table(country_select = "Japan",
                                  cases_frequency = ""))
  expect_error(create_cases_table(country_select = "Japan",
                                  cases_frequency = NULL))
  expect_error(create_cases_table(country_select = "Japan",
                                  province_select = "Victoria",
                                  cases_frequency = "monthly"))
  expect_error(create_cases_table(country_select = "US",
                                  province_select = "New South Wales",
                                  cases_frequency = "monthly"))
})
