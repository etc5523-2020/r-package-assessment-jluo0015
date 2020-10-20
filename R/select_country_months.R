#'Select the monthly COVID-19 cases of a country within a range of months
#'
#' @description This function is used to find the three different monthly 
#' COVID-19 cases of the selected country within the specific range of months.
#'
#' @param country_select The name of a country as a character vector. 
#' Currently, there are three countries available, which are Japan, US, and Australia. 
#' 
#' @param start_month The number of a month that represents the start of the range of months.
#' It should be a integer, and the available months are between 1 and 10.
#' 
#' @param end_month The number of a month that represents the end of the range of months.
#' It should be a integer, and the available months are between 1 and 10.
#'
#' @return A tibble shows the country, month, monthly cases, and the cumulative cases of COVID-19. 
#'
#' @format 
#' This function will return a tibble with 8 columns.
#' @format country 
#' - Name of country
#' @format month
#' - The range of months. Each row represent a month. 
#' @format confirmed
#' - Monthly confirmed cases of COVID-19 
#' @format death
#' - Monthly mortality of COVID-19
#' @format recovered
#' - Monthly recovered cases of COVID-19
#' @format cumulative_confirmed 
#' - Cumulative confirmed cases of current month, which calculated from January. 
#' @format cumulative_death
#' - Cumulative mortality of current month, which calculated from January. 
#' @format cumulative_recovered
#' - Cumulative recovered cases of current month, which calculated from January. 
#' 
#' @examples 
#' select_country_months(country_select = "Japan", start_month = 1, end_month = 10)
#' select_country_months(country_select = "US", start_month = 3, end_month = 9)
#' select_country_months(country_select = "Australia", start_month = 5, end_month = 6)
#'
#' @export
select_country_months <- function(country_select, start_month, end_month){
  data <- coronavirus::coronavirus
  country_months <- data %>% 
    dplyr::filter(country %in% c("Australia",
                                 "US",
                                 "Japan")) %>% 
    dplyr::mutate(month = lubridate::month(date)) %>%
    dplyr::filter(country == country_select) %>%
    tidyr::pivot_wider(names_from = "type", values_from = "cases") %>%
    dplyr::group_by(country, month) %>% 
    dplyr::summarise(confirmed = sum(confirmed),
                     death  =sum(death),
                     recovered = sum(recovered)) %>% 
    dplyr::mutate(cumulative_confirmed = cumsum(confirmed),
                  cumulative_death = cumsum(death),
                  cumulative_recovered = cumsum(recovered)) %>% 
    dplyr::filter(month %in% c(start_month:end_month))
    
    
  country_months
}