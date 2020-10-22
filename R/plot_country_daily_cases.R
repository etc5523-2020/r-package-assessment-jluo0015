#'Create the line chart of daily COVID-19 cases of a country in a month
#'
#' @description This function is used to create a line chart to display the daily COVID-19
#' situation of a inputted country in a inputted month. 
#' This line chart will show three types of COVID-19 cases. And it is a plotly line chart.
#' This function refactors one part of the server-side logic of the Shiny app, 
#' which is the plot of displaying the daily COVID-19 cases of a country in a specific month.
#' 
#' @param country_select The name of a country as a character vector. 
#' Currently, there are three countries available, which are "Japan", "US", and "Australia". 
#' @param month_select The number of a month as an integer vector. 
#' The available number of month is between 1 and 10.
#' 
#' @return A line graph that shows three types of daily COVID-19 cases for a month in a country.
#' 
#' @examples 
#' plot_country_daily_cases("Japan", 7)
#' plot_country_daily_cases("Australia", 4)
#' plot_country_daily_cases("US", 10)
#' 
#' @export
plot_country_daily_cases <- function(country_select, month_select){
  `%>%` <- magrittr::`%>%`
  plot_data <- coronavirus::coronavirus
  
  plot_data_wrangling <- plot_data %>%
    dplyr::filter(country %in% c("Australia",
                                 "US",
                                 "Japan")) %>% 
    tidyr::pivot_wider(names_from = "type", values_from = "cases") %>% 
    dplyr::group_by(country, date) %>%
    dplyr::summarise(Confirmed = sum(confirmed),
                     Death = sum(death),
                     Recovered = sum(recovered)) %>% 
    dplyr::mutate(month = lubridate::month(date),
                  day = lubridate::day(date)) %>%
    dplyr::filter(country == country_select) %>% 
    dplyr::filter(month == month_select) %>% 
    tidyr::pivot_longer(c("Confirmed","Death","Recovered"),
                        names_to = "Types", values_to = "cases")
  
  
  first_day = min(plot_data_wrangling["day"])
  last_day = max(plot_data_wrangling["day"])
  
  country_daily_plot <- plot_data_wrangling %>%
    ggplot2::ggplot(ggplot2::aes(day, cases, colour = Types)) + 
    ggplot2::geom_point() + 
    ggplot2::geom_line() + 
    ggplot2::scale_x_continuous(breaks = c(first_day:last_day)) +
    ggplot2::scale_color_manual(values = c("red", "green", "blue"),
                                breaks = c("Confirmed","Death","Recovered")) + 
    ggplot2::ggtitle(paste0("The daily COVID-19 cases of ", country_select, " in ", month_select, ", 2020")) + 
    ggplot2::theme(plot.title = ggplot2::element_text(size = 16, face = "bold"))
  
  plotly::ggplotly(country_daily_plot)
}