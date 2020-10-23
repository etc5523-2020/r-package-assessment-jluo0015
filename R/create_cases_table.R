#'Create the daily or monthly COVID-19 cases table of a country or a province
#' 
#' @description This function is used to create the table to display the daily 
#' or monthly COVID-19 cases of a inputted country or province. At the same time, 
#' the cumulative number will also be displayed in each table. 
#' This function refactors one part of the server-side logic of the Shiny app, 
#' which is the table of displaying the daily or monthly COVID-19 cases of a country or a province.
#' 
#' @param country_select The name of a country as a character vector. 
#' Currently, there are three countries available, which are "Japan", "US", and "Australia". 
#' @param province_select The name of a province as a character vector. 
#' Currently, only Australia has the provincial data. The available provinces are 
#' "Australian Capital Territory", "New South Wales", "Northern Territory", "Queensland",
#' "South Australia", "Tasmania", "Victoria", and "Western Australia".
#' @param cases_frequency A character vector indicates the frequency of cases in the table.
#' The available choices are "monthly" or "daily".
#' 
#' @return A table that shows the daily or monthly COVID-19 cases and the cumulative cases of a country or a province.
#' 
#' @note 
#' Only Australia has the available provincial data, 
#' please do not input any character string into the argument of *province_select* when choosing "Japan" or "US".
#' 
#' @examples 
#' create_cases_table(country_select = "Japan", cases_frequency = "monthly")
#' 
#' create_cases_table(country_select = "Australia", 
#'                    province_select = "Victoria", 
#'                    cases_frequency = "monthly")
#'                    
#' create_cases_table(country_select = "US", cases_frequency = "daily")
#' 
#' @export
create_cases_table <- function(country_select, 
                               province_select = "",
                               cases_frequency){
  
  country<-province<-month<-year<-confirmed<-death<-recovered<-
    `monthly confirmed`<-`monthly death`<-`monthly recovered`<-`daily confirmed`<-
    `daily death`<-`daily recovered`<-`cumulative confirmed`<-`cumulative death`<-
    `cumulative recovered`<-NULL
  
  `%>%` <- magrittr::`%>%`
  table_data <- coronavirus::coronavirus %>% 
    dplyr::filter(country %in% c("Australia",
                                 "US",
                                 "Japan"))
  
  
  str_num <- stringr::str_count(province_select)
  
  
  #province
  if(str_num > 0){
    # province monthly cases
    if(cases_frequency == "monthly"){
      
      table_data_province_monthly <- table_data %>% 
        dplyr::filter(country == country_select & province == province_select) %>% 
        tidyr::pivot_wider(names_from = "type", values_from = "cases") %>% 
        dplyr::mutate(year = lubridate::year(date),
                      month = lubridate::month(date, label = TRUE, abbr = FALSE)) %>% 
        dplyr::group_by(country, province, month, year) %>% 
        dplyr::summarise(confirmed = sum(confirmed),
                         death  =sum(death),
                         recovered = sum(recovered)) %>%
        dplyr::ungroup() %>%
        dplyr::group_by(country, province) %>% 
        dplyr::mutate(`cumulative confirmed` = cumsum(confirmed),
                      `cumulative death` = cumsum(death),
                      `cumulative recovered` = cumsum(recovered),
                      month = paste0(year, "-", month)) %>%
        dplyr::rename("monthly confirmed" = "confirmed",
                      "monthly death" = "death",
                      "monthly recovered" = "recovered") %>% 
        dplyr::select(country, 
                      province, 
                      month,
                      `monthly confirmed`, 
                      `monthly death`, 
                      `monthly recovered`, 
                      `cumulative confirmed`,
                      `cumulative death`,
                      `cumulative recovered`)
      
      DT::datatable(table_data_province_monthly,
                    extensions = "FixedColumns",
                    caption = 
                      paste0("The monthly cases and cumulative cases of COVID-19 of ", province_select, ", ", country_select),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
    }
    # province daily cases
    else{
      
      table_data_province_daily <- table_data %>%
        dplyr::filter(country == country_select & province == province_select) %>% 
        tidyr::pivot_wider(names_from = "type", values_from = "cases") %>% 
        dplyr::group_by(country, province) %>% 
        dplyr::mutate(`cumulative confirmed` = cumsum(confirmed),
                      `cumulative death` = cumsum(death),
                      `cumulative recovered` = cumsum(recovered)) %>% 
        dplyr::rename("daily confirmed" = "confirmed",
                      "daily death" = "death",
                      "daily recovered" = "recovered") %>%
        dplyr::select(country,
                      province,
                      date,
                      `daily confirmed`, 
                      `daily death`, 
                      `daily recovered`, 
                      `cumulative confirmed`,
                      `cumulative death`,
                      `cumulative recovered`)
      
      DT::datatable(table_data_province_daily,
                    extensions = "FixedColumns",
                    caption = 
                      paste0("The daily cases and cumulative cases of COVID-19 of ", province_select, ", ", country_select),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
    }
  }
  #country
  else{
    #country monthly cases
    if(cases_frequency == "monthly"){
      
      table_data_country_monthly <- table_data %>% 
        dplyr::mutate(year = lubridate::year(date),
                      month = lubridate::month(date, label = TRUE, abbr = FALSE)) %>%
        dplyr::filter(country == country_select) %>%
        tidyr::pivot_wider(names_from = "type", values_from = "cases") %>%
        dplyr::group_by(country, month, year) %>% 
        dplyr::summarise(confirmed = sum(confirmed),
                         death  =sum(death),
                         recovered = sum(recovered)) %>% 
        dplyr::mutate(`cumulative confirmed` = cumsum(confirmed),
                      `cumulative death` = cumsum(death),
                      `cumulative recovered` = cumsum(recovered),
                      month = paste0(year, "-", month)) %>% 
        dplyr::rename("monthly confirmed" = "confirmed",
                      "monthly death" = "death",
                      "monthly recovered" = "recovered") %>% 
        dplyr::select(country,
                      month,
                      `monthly confirmed`, 
                      `monthly death`, 
                      `monthly recovered`, 
                      `cumulative confirmed`,
                      `cumulative death`,
                      `cumulative recovered`)
      
      DT::datatable(table_data_country_monthly,
                    extensions = "FixedColumns",
                    caption = 
                      paste0("The monthly cases and cumulative cases of COVID-19 of ",  country_select),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
    }
    #country daily cases
    else{
      
      table_data_country_daily <- table_data %>% 
        tidyr::pivot_wider(names_from = "type", values_from = "cases") %>% 
        dplyr::filter(country == country_select) %>% 
        dplyr::group_by(country, date) %>%
        dplyr::summarise(confirmed = sum(confirmed),
                         death = sum(death),
                         recovered = sum(recovered)) %>%
        dplyr::mutate(`cumulative confirmed` = cumsum(confirmed),
                      `cumulative death` = cumsum(death),
                      `cumulative recovered` = cumsum(recovered)) %>% 
        dplyr::rename("daily confirmed" = "confirmed",
                      "daily death" = "death",
                      "daily recovered" = "recovered") %>%
        dplyr::select(country,
                      date,
                      `daily confirmed`, 
                      `daily death`, 
                      `daily recovered`, 
                      `cumulative confirmed`,
                      `cumulative death`,
                      `cumulative recovered`)
      
      DT::datatable(table_data_country_daily,
                    extensions = "FixedColumns",
                    caption = 
                      paste0("The daily cases and cumulative cases of COVID-19 of ", country_select),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
    }
  }
}