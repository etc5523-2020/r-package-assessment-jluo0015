library(shiny)
library(devtools)
#devtools::install_github("RamiKrispin/coronavirus")
library(coronavirus)
library(lubridate)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(DT)
library(htmltools)
library(plotly)
library(shinythemes)

# COVID-19 data ---------------------------------------
data("coronavirus")

# Monthly Data ------------------------------------------------------
covid_monthly <- coronavirus %>% 
  na.omit() %>% 
  pivot_wider(names_from = "type", values_from ="cases") %>% 
  mutate(month = month(date)) %>% 
  filter(country %in% c("Australia",
                        "US",
                        "Japan")) %>%
  group_by(country, month) %>% 
  summarise(confirmed = sum(confirmed),
            death  =sum(death),
            recovered = sum(recovered)) %>%
  ungroup() %>%
  group_by(country) %>% 
  mutate(`Total confirmed` = cumsum(confirmed),
         `Total death` = cumsum(death),
         `Total recovered` = cumsum(recovered)) %>% 
  pivot_longer(c(`Total confirmed`,`Total death`,`Total recovered`),
               names_to = "types", values_to = "cases")

# Daily Data ---------------------------------------------------

covid_daily <- coronavirus %>%
  pivot_wider(names_from = "type", values_from ="cases") %>%
  group_by(country, date) %>% 
  summarise(Confirmed = sum(confirmed),
            Death = sum(death),
            Recovered = sum(recovered)) %>% 
  ungroup() %>% 
  mutate(year = year(date),
         month = month(date),
         day = day(date)) %>%
  filter(country %in% c("Australia",
                        "US",
                        "Japan")) %>% 
  pivot_longer(c("Confirmed","Death","Recovered"),
               names_to = "types", values_to = "cases")


# Province ---------------------------------------

coun_pro <- coronavirus %>% 
  select(country, province) %>% 
  filter(country %in% c("Australia",
                        "US",
                        "Japan"))

# Province Monthly Data -------------------------------------------------------

covid_monthly_province <- coronavirus %>% 
  na.omit() %>% 
  pivot_wider(names_from = "type", values_from ="cases") %>% 
  mutate(month = month(date)) %>% 
  filter(country %in% c("Australia",
                        "US",
                        "Japan")) %>%
  group_by(country, province, month) %>% 
  summarise(confirmed = sum(confirmed),
            death  =sum(death),
            recovered = sum(recovered)) %>%
  ungroup() %>%
  group_by(country, province) %>% 
  mutate(`Total confirmed` = cumsum(confirmed),
         `Total death` = cumsum(death),
         `Total recovered` = cumsum(recovered))

# Province Daily Data ------------------------------------------------------

covid_daily_province <- coronavirus %>%
  pivot_wider(names_from = "type", values_from ="cases") %>%
  filter(country %in% c("Australia",
                        "US",
                        "Japan")) %>%
  group_by(country, province) %>% 
  mutate(`Cumulative confirmed` = cumsum(confirmed),
         `Cumulative death` = cumsum(death),
         `Cumulative recovered` = cumsum(recovered)) %>% 
  rename("Daily confirmed" = "confirmed",
         "Daily death" = "death",
         "Daily recovered" = "recovered")



# Because the reason of system language of my laptop, it always shows month in Chinese. 
# If you face this problem, please use this code below to convert the system language to English.

# Sys.setlocale("LC_ALL", "english")

# ui ---------------------------------------------------
ui <- fluidPage(
  theme = shinytheme("cerulean"),
  br(),
  h1("The COVID-19 exploration app"),
  tabsetPanel(
    tabPanel("About", 
             br(),
             div(strong("Author:"), "Jinhao Luo",
                 br(),
                 strong("Student ID:"), "29012449",
                 br(),
                 strong("Purposes:"), "COVID-19 is still epidemic over the world. If an app related to the worldwide COVID-19 situation could be generated might help people realise the real situation easily.
                 Therefore, this app is used for helping explore the worldwide COVID-19 situation and focuses on particular three countries, which are US, Australia and Japan.
                 This app contains two figures and a table, which have provided different ways to help users compare the different types of cases of different countries.
                 Users could observe the monthly cases or daily cases of different countries, or even the cases of a province in a selected country, if the data of province are available.
                 This app could help users to realise and analyse the COVID-19 situation of the selected country, like the pandemic trend. 
                 "),
               br(),
               "More details could be found in the",  strong("App"),  "section.",
               br(),
               "Enjoy the app!",
             style = "font-size: 20px; text-align: justify;"),
    navbarMenu("App",
               tabPanel("Explanation",
                        br(),
                        h1("Instruction"),
                        h2("Structure"),
                        br(),
                        div("There are three main sections in this app. The first one is", strong("About"), "section. You could find the author information and the purposes of this app in there."),
                          br(),
                        div("The second section is", strong("App."), "This is the main body of this app. Using the drop-down menu, you could find there are three submenu there. The first submenu is ", strong("Explanation."),
                          "You could find the explanations of this app there, included the structure of this app, as well as the guidelines of how to use this app. The second submenu is ", strong("Figure."), 
                          "This section contains two figures. The first one indicates the total cases of the selected country and shows the general trend. The second figure is more detail which show the daily cases within a
                          particular month you want to investigate. It indicates the general trend of a month. The third submenu is ", strong("Table."), "It could show the country-based or province-based of a country in the table,
                          if the data of provinces are available. In addition, the users could specify whether investigate monthly cases or daily cases of the selected country or province."),
                          br(),
                        div("The third section is ", strong("Citation."), "You could find the references of the packages used in this app, as well as the data which used to generate this app."),
                        br(),
                        h2("How to use this app"),
                        br(),
                        div("Simply, clicking the section you want to read. But, please read the", strong("About"), "section first to understand the purpose this app."),
                            br(),
                        div("In the", strong("Figure"), "submenu, select the country you want to investigate first. Then, select the range of months you want to observe, and the corresponding figure would show in the top right hand side.
                            Because the unit of date range input is month only, you could select the month only. You can type the month you want in the range input, directly. Or you could choose by the calendar. Just clicking the blank of range input,
                            selecting the month you want, clicking any one day in the calendar, and the blank would show the number of month. 
                            The last input requirement is used to select a particular month to observe the daily cases within that month. The corresponding figure would show in the bottom right hand side. Users could type the number of month directly or use the calendar to choose, 
                            which is as same as the usage explained above. In addition, these two figure are plotly figure, which means the information in figure could show up when users put the arrow in a point of the figure.
                            Furthermore, Users could choose a particular month by clicking the point in the top right hand side figure, the selected month would show in the particular month selection input bar (the last input requirement), and the corresponding figure would also alter."),
                            br(),
                        div("In the", strong("Table"), "submenu, select the country first. Then, select which type of data you want to show in the table. You could select the country-based data which are summarised by level of country. 
                            Or you could select province-based data which are summarised based on the level of province of your selected country, if the database provides the data of province. If you select the province-based table, you could select the province you want to analysis in the following selection bar.
                            At last, select the frequency of the cases. There are two types of frequency which are monthly cases or daily cases. After you selecting, the final table would show up."),
                        br(),
                        style = "font-size: 20px; text-align: justify;"
                        ),
               tabPanel("Figure",
                        br(),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("country", "Select a country",
                                        choices = covid_monthly$country,
                                        selected = ""),
                            dateRangeInput("month", 
                                           label="Select the range of months you want (monthly)",
                                           format = "m",
                                           start = "2020-01-01",
                                           end = "2020-10-31",
                                           min = "2020-01-01",
                                           max = "2020-10-31"),
                            dateInput("date",
                                      label = "Select the particular month you want (monthly)",
                                      format = "m",
                                      min = "2020-01-01",
                                      max = "2020-10-31")),
                          mainPanel(
                            br(),
                            plotlyOutput("monthlyPlot"),
                            fluidPage(fluidRow(column(actionButton("guide", "Guide"), width = 1),
                                               column(actionButton("output", "Output"), width = 2))),
                            br(),
                            br(),
                            htmlOutput("figureGuide1"),
                            htmlOutput("figureOutput1"),
                            br(),
                            plotlyOutput("dailyPlot"),
                            fluidPage(fluidRow(column(actionButton("guide2", "Guide"), width = 1),
                                               column(actionButton("output2", "Output"), width = 2))),
                            br(),
                            br(),
                            htmlOutput("figureGuide2"),
                            htmlOutput("figureOutput2"),
                            br()
                            ))),
               
               tabPanel("Table",
                        br(),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("country_table", "Select a country",
                                        choices = covid_monthly$country,
                                        selected = ""),
                            selectInput("base", "Select the country-based or province-based data in table",
                                        choice = c("Country-based", "Province-based")),
                            selectInput("province", "If you selected the province-based data, please choose a province (if the province data are not provided, it would keep showing the country-based data table)",
                                        choice = ""),
                            selectInput("type", "Select the frequency of cases you want to observe in the table",
                                        choices = c("The monthly cases","The daily cases"),
                                        selected = "The monthly cases")),
                          mainPanel(br(),
                                    dataTableOutput("table"),
                                    fluidPage(fluidRow(column(actionButton("guide3", "Guide"), width = 1),
                                                       column(actionButton("output3", "Output"), width = 2))),
                                    br(),
                                    br(),
                                    htmlOutput("tableGuide"),
                                    htmlOutput("tableOutput"),
                                    br()
                                    )))),
    tabPanel("Citation",
             br(),
             h1("Acknowledgement"),
             div("The data is loaded from the coronavirus package, You could find more information from this Github repository[https://github.com/RamiKrispin/coronavirus].
                 In addition, the versions of R and packages which used in this app would be listed in the following.",
                 br(),
                 "The programming language used to generate this shiny app is R (4.0.2). Following packages has been included in this app:"),
             br(),
             div("- shiny (1.5.0)",
                 br(),
                 "- devtools (2.3.1)",
                 br(),
                 "- coronavirus (0.3.0.9000)",
                 br(),
                 "- lubridate (1.7.9)",
                 br(),
                 "- ggplot2 (3.3.2)",
                 br(),
                 "- dplyr (1.0.1)",
                 br(),
                 "- tidyverse (1.3.0)",
                 br(),
                 "- DT (0.15)",
                 br(),
                 "- htmltools (0.5.0)",
                 br(),
                 "- plotly (4.9.2.1)",
                 br(),
                 "- shinythemes (1.1.2)"),
             br(),
             h1("References"),
             div("C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and shiny. Chapman and Hall/CRC Florida,
  2020.",
                 br(),
                 "Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with lubridate. Journal of Statistical
  Software, 40(3), 1-25. URL http://www.jstatsoft.org/v40/i03/.",
                 br(),
                 " H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.",
                 br(),
                 "Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2020). dplyr: A Grammar of Data Manipulation. R
  package version 1.0.1. https://CRAN.R-project.org/package=dplyr",
                 br(),
                 "Hadley Wickham, Jim Hester and Winston Chang (2020). devtools: Tools to Make Developing R Packages Easier. R
  package version 2.3.1. https://CRAN.R-project.org/package=devtools",
                 br(),
                 "Joe Cheng, Carson Sievert, Winston Chang, Yihui Xie and Jeff Allen (2020). htmltools: Tools for HTML. R package
  version 0.5.0. https://CRAN.R-project.org/package=htmltools",
                 br(),
                 "Rami Krispin and Jarrett Byrnes (2020). coronavirus: The 2019 Novel Coronavirus COVID-19 (2019-nCoV) Dataset. R
  package version 0.3.0.9000. https://github.com/RamiKrispin/coronavirus",
                 br(),
                 "Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686,
  https://doi.org/10.21105/joss.01686",
                 br(),
                 "Winston Chang (2018). shinythemes: Themes for Shiny. R package version 1.1.2.
  https://CRAN.R-project.org/package=shinythemes",
                 br(),
                 " Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework
  for R. R package version 1.5.0. https://CRAN.R-project.org/package=shiny",
                 br(),
                 "Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library 'DataTables'. R package
  version 0.15. https://CRAN.R-project.org/package=DT"),
             br(),
             style = "font-size: 20px; text-align: justify;"
             )),

)

# server -------------------------------------------------

server <- function(input, output, session) {
  
  
  observeEvent(event_data("plotly_click"),{
    click_month <- event_data("plotly_click")
    num_month <- filter(covid_daily, month == click_month$x) %>% pull(month) %>% unique()
    month_date <- as.Date(paste0("2020-", num_month, "-01"))
    updateSelectInput(session, "date", selected = month_date)
  })
  
  observeEvent(input$country_table, {
    num_str = sum(str_count(unique(filter(coun_pro, country == input$country_table)$province)))
    if(input$base == "Province-based"){
      if(num_str >0){
        updateSelectInput(session, 
                          "province",
                          choices = unique(filter(coun_pro, country == input$country_table)$province))
      }
      else{
        updateSelectInput(session,
                          "province",
                          choices = "The province data are not provided")
      }
    }
    else{
      updateSelectInput(session, 
                        "province",
                        choices = "")
    }
  })
  
  
  observeEvent(input$base, {
    num_str = sum(str_count(unique(filter(coun_pro, country == input$country_table)$province)))
    if(input$base == "Province-based"){
      if(num_str >0){
        updateSelectInput(session, 
                          "province",
                          choices = unique(filter(coun_pro, country == input$country_table)$province))
      }
      else{
        updateSelectInput(session,
                          "province",
                          choices = "The province data are not provided")
      }
    }
    else{
      updateSelectInput(session, 
                        "province",
                        choices = "")
    }
  })
  
  
  output$monthlyPlot <- renderPlotly({
    
    month_df <- covid_monthly %>% 
      filter(country == input$country) %>% 
      filter(month %in% c(month(input$month[1]):month(input$month[2])))
    
    tot_cases <- ggplot(data = month_df, 
           aes(month, cases, colour = types)) + 
      geom_point() + 
      geom_line() +
      scale_x_continuous(breaks = c(month(input$month[1]):month(input$month[2]))) + 
      scale_color_manual(name = "Types",
                         values = c("red", "green", "blue"),
                         breaks = c("Total confirmed","Total death","Total recovered")) +
      ggtitle(paste("Total Cases of ", 
                         input$country, 
                         "(From", 
                         month(input$month[1], label = TRUE, abbr = FALSE),
                         "to",
                         month(input$month[2], label = TRUE, abbr = FALSE), 
                         ")"))+
      theme(plot.title = element_text(size = 16, face = "bold"))
    
    ggplotly(tot_cases) %>% 
      config(displayModeBar = F) 
    
  })
  
  
  

  output$m <- renderUI({
    req(input$month)
    div(month(input$month[1]),
        br(),
        month(input$month[2]))
  })
  
  output$plotlyClick <- renderPrint({event_data("plotly_click")})
  
  output$n <- renderUI({
    req(input$date)
    div(month(input$date))
  })
  
  output$dailyPlot <- renderPlotly({
    
    day_df <- covid_daily %>%
      filter(country == input$country) %>% 
      dplyr::filter(month == month(input$date))
    
    first_day = day_df %>% select(day) %>% min()
    last_day = day_df %>% select(day) %>% max()

    
   daily_cases<-  ggplot(data = day_df, aes(day, cases, colour = types)) +
      geom_point() + 
      geom_line() +
      scale_x_continuous(breaks = c(first_day:last_day)) +
      scale_color_manual(name = "Types",
                         values = c("red", "green", "blue"),
                         breaks = c("Confirmed","Death","Recovered")) + 
      ggtitle(paste("Daily cases of ",
                    input$country,
                    "in ",
                    month(input$date, label = TRUE, abbr = FALSE))) + 
     theme(plot.title = element_text(size = 16, face = "bold"))
    
    ggplotly(daily_cases, source = "B") %>% 
      config(displayModeBar = F) 
    
  })
  
  
  output$table <- renderDataTable({
    if(input$base == "Country-based"){
      if (input$type == "The monthly cases") {
        new_month_df <- covid_monthly %>% 
          filter(country == input$country_table) %>% 
          pivot_wider(names_from = "types", values_from ="cases")  %>% 
          rename("Monthly confirmed" = "confirmed",
                 "Monthly death" = "death",
                 "Monthly recovered" = "recovered",
                 "Cumulative confirmed" = `Total confirmed`,
                 "Cumulative death" = `Total death`,
                 "Cumulative recovered" = `Total recovered`)
        
        datatable(new_month_df,
                  extensions = "FixedColumns",
                  caption = tags$caption(
                    style = "caption-side : top; text-align: left; font-size: 22px; font-weight: bold; color: black;",
                    paste(input$type, " of ", input$country_table)),
                  filter = "top",
                  options = list(pageLength = 10,
                                 autoWidth = TRUE,
                                 scrollx = TRUE))
          
      }
      else {
        new_daily_df <- covid_daily %>%
          filter(country == input$country_table) %>% 
          pivot_wider(names_from = "types", values_from ="cases") %>%
          group_by(country) %>% 
          mutate(cum_confirmed = cumsum(Confirmed),
                 cum_death = cumsum(Death),
                 cum_recovered = cumsum(Recovered)) %>% 
          rename("Daily confirmed" = "Confirmed",
                 "Daily death" = "Death",
                 "Daily recovered" = "Recovered",
                 "Cumulative confirmed" = "cum_confirmed",
                 "Cumulative death" = "cum_death",
                 "Cumulative recovered" = "cum_recovered") %>% 
          select(-year, -month, -day)
        
        datatable(new_daily_df,
                  extensions = "FixedColumns",
                  caption = tags$caption(
                   style = "caption-side : top; text-align: left; font-size: 24px; font-weight: bold; color: black;",
                   paste(input$type, " of ", input$country_table)),
                  filter = "top",
                  options = list(pageLength = 10,
                                 autoWidth = TRUE,
                                 scrollx = TRUE))
      }
    }
    else{
      if(input$province == "The province data are not provided"){
        if (input$type == "The monthly cases") {
          new_month_df <- covid_monthly %>% 
            filter(country == input$country_table) %>% 
            pivot_wider(names_from = "types", values_from ="cases")  %>% 
            rename("Monthly confirmed" = "confirmed",
                   "Monthly death" = "death",
                   "Monthly recovered" = "recovered",
                   "Cumulative confirmed" = `Total confirmed`,
                   "Cumulative death" = `Total death`,
                   "Cumulative recovered" = `Total recovered`)
          
          datatable(new_month_df,
                    extensions = "FixedColumns",
                    caption = tags$caption(
                      style = "caption-side : top; text-align: left; font-size: 22px; font-weight: bold; color: black;",
                      paste(input$type, " of ", input$country_table)),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
          
        }
        else {
          new_daily_df <- covid_daily %>%
            filter(country == input$country_table) %>% 
            pivot_wider(names_from = "types", values_from ="cases") %>%
            group_by(country) %>% 
            mutate(cum_confirmed = cumsum(Confirmed),
                   cum_death = cumsum(Death),
                   cum_recovered = cumsum(Recovered)) %>% 
            rename("Daily confirmed" = "Confirmed",
                   "Daily death" = "Death",
                   "Daily recovered" = "Recovered",
                   "Cumulative confirmed" = "cum_confirmed",
                   "Cumulative death" = "cum_death",
                   "Cumulative recovered" = "cum_recovered") %>% 
            select(-year, -month, -day)
          
          datatable(new_daily_df,
                    extensions = "FixedColumns",
                    caption = tags$caption(
                      style = "caption-side : top; text-align: left; font-size: 24px; font-weight: bold; color: black;",
                      paste(input$type, " of ", input$country_table)),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
        }
      }
      else{
        if(input$type == "The monthly cases"){
           new_month_df_province <- covid_monthly_province %>% 
             filter(country == input$country_table) %>% 
             filter(province == input$province) %>% 
             rename("Monthly confirmed" = "confirmed",
                    "Monthly death" = "death",
                    "Monthly recovered" = "recovered",
                    "Cumulative confirmed" = `Total confirmed`,
                    "Cumulative death" = `Total death`,
                    "Cumulative recovered" = `Total recovered`)
           
           datatable(new_month_df_province,
                     extensions = "FixedColumns",
                     caption = tags$caption(
                       style = "caption-side : top; text-align: left; font-size: 22px; font-weight: bold; color: black;",
                       paste(input$type, " of ", input$province, "(", input$country_table, ")")),
                     filter = "top",
                     options = list(pageLength = 10,
                                    autoWidth = TRUE,
                                    scrollx = TRUE))
        }
        else{
          new_daily_df_province <- covid_daily_province %>% 
            filter(country == input$country_table) %>% 
            filter(province == input$province)
          
          datatable(new_daily_df_province,
                    extensions = "FixedColumns",
                    caption = tags$caption(
                      style = "caption-side : top; text-align: left; font-size: 22px; font-weight: bold; color: black;",
                      paste(input$type, " of ", input$province, "(", input$country_table, ")")),
                    filter = "top",
                    options = list(pageLength = 10,
                                   autoWidth = TRUE,
                                   scrollx = TRUE))
        }
      }
    }
  })
  
  output$pp <- renderText({
    input$type
  })
  
  output$figureGuide1 <- renderUI({
    req(input$guide %% 2 != 0)
    div("Step 1: Select the country you want to analysis.",
        br(),
        "Step 2: Input the range of months. By typing directly or select in calendar.",
        br(),
        "Step 3: Click the Guide/Output button again, the guidelines would disappear.")
  })
  
  output$figureOutput1 <- renderUI({
    req(input$output %% 2 != 0)
    div("The figure above shows the trends of total COVID-19 cases of three different types in",
        input$country,
        "from", 
        month(input$month[1], label = TRUE, abbr = FALSE),
        "to",
        month(input$month[2], label = TRUE, abbr = FALSE),
        ". The x-axis indicates the number of months, while the y-axis indicates the total cases.
        The legend explains that three different types of cases and their corresponding colours.
        In addition, the particular information will show up when you put the mouse in the point.")
    
  })
  
  output$figureGuide2 <- renderUI({
    req(input$guide2 %% 2 != 0)
    div("Step 1: Select the country you want to analysis.",
        br(),
        "Step 2: Input a particular month. By typing directly or select in calendar.",
        br(),
        "Alternative Step 2: Select a particular month by clicking the point in the top figure.",
        br(),
        "Step 3: Click the Guide/Output button again, the guidelines would disappear.")
  })
  
  output$figureOutput2 <- renderUI({
    req(input$output2 %% 2 != 0)
    div("The figure above shows the trends of daily COVID-19 cases of three different types in",
        input$country,
        "within your selected particular month which is ", 
        month(input$date, label = TRUE, abbr = FALSE),
        ". The x-axis indicates the number of days within that month, while the y-axis indicates the total cases.
        The legend explains that three different types of cases and their corresponding colours.
        In addition, the particular information will show up when you put the mouse in the point.")
  })
  
  output$tableGuide <- renderUI({
    req(input$guide3 %% 2 != 0)
    div("Step 1: Select the country you want to analysis.",
        br(),
        "Step 2: Select the level of observation object. You could choose country-based or province-based data for the table.",
        br(),
        "Step 3: If the province-based data are available, you could choose the province you want to investigate. Otherwise, the bar would show 'The province data are not provided'.",
        br(),
        "Step 4: Select the frequency of cases you want to display in the table. You could choose the monthly cases or daily cases.",
        br(),
        "Step 5: Click the Guide/Output button again, the guidelines would disappear.")
  })
  
  output$tableOutput <- renderUI({
    req(input$output3 %% 2 != 0)
    num_str = sum(str_count(unique(filter(coun_pro, country == input$country_table)$province)))
    if(num_str >0){
      div("The table above shows ",
          input$type, 
          "of", input$province, "of", input$country_table,
          ". There are nine columns in the table, which indicate ",
          input$type, "of that three different types and the corresponding cumulative cases. 
          In addition, you could filter the data within the table by the top filter bar, 
          or search the particular information by using the search bar.")
    }
    else{
      div("The table above shows ",
          input$type, 
          "of",
          input$country_table,
          ". There are nine columns in the table, which indicate ",
          input$type, "of that three different types and the corresponding cumulative cases. 
        In addition, you could filter the data within the table by the top filter bar, 
        or search the particular information by using the search bar.")
    }
  })
}


shinyApp(ui, server)