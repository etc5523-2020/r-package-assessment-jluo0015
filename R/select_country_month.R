#'Select the daily COVID-19 cases of a country within a month
#'
#' @description This function is used to find the three different daily 
#' COVID-19 cases of the selected country in a specific month.
#' This function refactors one part of the user interface-side (UI) logic of the Shiny app, 
#' which is the selection bar of selecting the country and a specific month.
#' 
#' @param country_select The name of a country as a character vector. 
#' Currently, there are three countries available, which are "Japan", "US", and "Australia". 
#' @param month_select The number of a month as an integer vector. 
#' The available number of month is between 1 and 10.
#' 
#' @return A tibble that contains the information of country, year, month, day, and daily COVID-19 cases. 
#' 
#' @format 
#' This function will return a tibble with 7 columns.
#' @format **country**
#' - Name of the country.
#' @format **year**, **month**, **day**
#' - The number of the year, month and day.
#' @format **confirmed**
#' - The number of daily confirmed cases of COVID-19.
#' @format **death**
#' - The number of daily mortality of COVID-19.
#' @format **recovered**
#' - The number of daily recovered cases of COVID-19.
#' 
#' @examples 
#' select_country_month(country_select = "Japan", month_select = 1)
#' select_country_month(country_select = "US", month_select = 3)
#' select_country_month(country_select = "Australia", month_select = 5)
#' 
#' @export
select_country_month <- function(country_select, month_select){
  
  
  `%>%` <- magrittr::`%>%`
  data <- coronavirus::coronavirus
  
  country_month <- data %>% 
    dplyr::filter(country %in% c("Australia",
                                 "US",
                                 "Japan")) %>% 
    tidyr::pivot_wider(names_from = "type", values_from = "cases") %>% 
    dplyr::group_by(country, date) %>%
    dplyr::summarise(confirmed = sum(confirmed),
                     death = sum(death),
                     recovered = sum(recovered)) %>% 
    dplyr::mutate(year = lubridate::year(date),
                  month = lubridate::month(date),
                  day = lubridate::day(date)) %>%
    dplyr::filter(country == country_select) %>% 
    dplyr::filter(month == month_select) %>% 
    dplyr::select(country, year, month, day, confirmed, death, recovered)
  country_month
}