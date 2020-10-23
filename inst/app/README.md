# ETC5523 Shiny Assessment 

This is a shiny app for helping with the worldwide COVID-19 situation exploration.

## Basic Information

- **Author**: Jinhao Luo
- **Student ID**: 29012449
- **App Name**: The COVID-19 exploration app

## Instruction

### How to run this app:

1. Ensure you has installed **R** (version in 4.0.2) language and **Rstudio** (version in 1.3.1056) in your local device. 

2. Checking the required packages of this app, which is indicated in the following section called **Required Packages**. Or you could find in the **app.R** file directly, which shown at the top of the file. You should install or update the required pakcages if them are not installed locally or updated yet. (The instruction of **coronavirus** package installation would be introduced in step3.)

3. Download the dataset by installing the **coronavirus** package. Use the command _devtools::install_github("RamiKrispin/coronavirus")_ to download. The data would be loaded into the app when you run the app.  Alternatively, you could remove the hashtag in line 3 in the **app.R** file, then the dataset would be automatically downloaded and loaded when you runnig the app.  

4. This app is saved in Github repository, you should fork the repository of this app to your Github first, and then clone from your repository to your local device. The repository of this shiny app would be found in this [Github repository](https://github.com/etc5523-2020/shiny-assessment-jluo0015.git).

5. After cloning the repository, open the file and click the R file named as **app**.

6. After the interface pop up, you could find a buttom called **Run App**, which is in the top right hand side. After clicking, the app would run automatically. 

7. Clicking the **About** tab first to read the basic information of this app.

8. And you could find the instruction of how to use the functions of this app in the **Explanation** submenu under **App** section. 

### Attentions

1. If the month is shown in Chinese, please use the command _Sys.setlocale("LC_ALL", "english")_ in console to convert the system language to English, and rerun the app again. Alternatively, you could delete the hashtag in line 102 in the **app.R** file, and rerun the app again. Then the problem will be solved.

2. This app is applying the _GNU GENERAL PUBLIC LICENSE (Version 3)_. (More details could be found in this [LICENSE file](https://github.com/etc5523-2020/shiny-assessment-jluo0015/blob/main/LICENSE).)

### Required Packages

- shiny (1.5.0),
- devtools (2.3.1),
- coronavirus (0.3.0.9000),
- lubridate (1.7.9),
- ggplot2 (3.3.2),
- dplyr (1.0.1),
- tidyverse (1.3.0),
- DT (0.15),
- htmltools (0.5.0),
- plotly (4.9.2.1),
- shinythemes (1.1.2)

### Session Information

> Session info --------------------------------------------------------------------------------


 |setting  |value                       |            
 |---------|----------------------------|
 |version  |R version 4.0.2 (2020-06-22)|
 |os       |Windows 10 x64              |              
 |system   |x86_64, mingw32             |             
 |ui       |RStudio                     |                     
 |language |(EN)                        |                        
 |collate  |English_United States.1252  |  
 |ctype    |English_United States.1252  |  
 |tz       |Australia/Sydney            |            
 |date     |2020-10-09                  |
 

> Packages ------------------------------------------------------------------------------------


 |package     |* version  |date       |lib |source        |
 |------------|-----------|-----------|----|--------------|
 |assertthat  |  0.2.1    |2019-03-21 |[1] |CRAN (R 4.0.2)|  
 |backports   |  1.1.7    |2020-05-13 |[1] |CRAN (R 4.0.0)| 
 |blob        |  1.2.1    |2020-01-20 |[1] |CRAN (R 4.0.2)| 
 |broom       |  0.7.0    |2020-07-09 |[1] |CRAN (R 4.0.2)| 
 |callr       |  3.4.4    |2020-09-07 |[1] |CRAN (R 4.0.2)| 
 |cellranger  |  1.1.0    |2016-07-27 |[1] |CRAN (R 4.0.2)|                           
 |cli         |  2.0.2    |2020-02-28 |[1] |CRAN (R 4.0.2)|                          
 |colorspace  |  1.4-1    |2019-03-18 |[1] |CRAN (R 4.0.2)|                          
 |coronavirus |* 0.3.0.9000|2020-10-09|[1] |Github (RamiKrispin/coronavirus@915b52a)|
 |crayon      |  1.3.4    |2017-09-16 |[1] |CRAN (R 4.0.2)|                          
 |crosstalk   |  1.1.0.1  |2020-03-13 |[1] |CRAN (R 4.0.2)|                          
 |curl        |  4.3      |2019-12-02 |[1] |CRAN (R 4.0.2)|                          
 |data.table  |  1.13.0   |2020-07-24 |[1] |CRAN (R 4.0.2)|                          
 |DBI         |  1.1.0    |2019-12-15 |[1] |CRAN (R 4.0.2)|                          
 |dbplyr      |  1.4.4    |2020-05-27 |[1] |CRAN (R 4.0.2)|                          
 |desc        |  1.2.0    |2018-05-01 |[1] |CRAN (R 4.0.2)|                          
 |devtools    |* 2.3.1    |2020-07-21 |[1] |CRAN (R 4.0.2)|                          
 |digest      |  0.6.25   |2020-02-23 |[1] |CRAN (R 4.0.2)|                          
 |dplyr       |* 1.0.1    |2020-07-31 |[1] |CRAN (R 4.0.2)|                          
 |DT          |* 0.15     |2020-08-05 |[1] |CRAN (R 4.0.2)|                          
 |ellipsis    |  0.3.1    |2020-05-15 |[1] |CRAN (R 4.0.2)|                          
 |evaluate    |  0.14     |2019-05-28 |[1] |CRAN (R 4.0.2)|                          
 |fansi       |  0.4.1    |2020-01-08 |[1] |CRAN (R 4.0.2)|                          
 |fastmap     |  1.0.1    |2019-10-08 |[1] |CRAN (R 4.0.2)|                          
 |forcats     |* 0.5.0    |2020-03-01 |[1] |CRAN (R 4.0.2)|                          
 |fs          |  1.5.0    |2020-07-31 |[1] |CRAN (R 4.0.2)|                          
 |generics    |  0.0.2    |2018-11-29 |[1] |CRAN (R 4.0.2)|                          
 |ggplot2     |* 3.3.2    |2020-06-19 |[1] |CRAN (R 4.0.2)|                          
 |glue        |  1.4.1    |2020-05-13 |[1] |CRAN (R 4.0.2)|                          
 |gtable      |  0.3.0    |2019-03-25 |[1] |CRAN (R 4.0.2)|                          
 |haven       |  2.3.1    |2020-06-01 |[1] |CRAN (R 4.0.2)|                          
 |hms         |  0.5.3    |2020-01-08 |[1] |CRAN (R 4.0.2)|                          
 |htmltools   |* 0.5.0    |2020-06-16 |[1] |CRAN (R 4.0.2)|                          
 |htmlwidgets |  1.5.1    |2019-10-08 |[1] |CRAN (R 4.0.2)|                          
 |httpuv      |  1.5.4    |2020-06-06 |[1] |CRAN (R 4.0.2)|                          
 |httr        |  1.4.2    |2020-07-20 |[1] |CRAN (R 4.0.2)|                          
 |janitor     |  2.0.1    |2020-04-12 |[1] |CRAN (R 4.0.2)|                          
 |jsonlite    |  1.7.0    |2020-06-25 |[1] |CRAN (R 4.0.2)|                          
 |knitr       |  1.29     |2020-06-23 |[1] |CRAN (R 4.0.2)|                          
 |labeling    |  0.3      |2014-08-23 |[1] |CRAN (R 4.0.0)|                          
 |later       |  1.1.0.1  |2020-06-05 |[1] |CRAN (R 4.0.2)|                          
 |lazyeval    |  0.2.2    |2019-03-15 |[1] |CRAN (R 4.0.2)|                          
 |lifecycle   |  0.2.0    |2020-03-06 |[1] |CRAN (R 4.0.2)|                          
 |lubridate   |* 1.7.9    |2020-06-08 |[1] |CRAN (R 4.0.2)|                          
 |magrittr    |  1.5      |2014-11-22 |[1] |CRAN (R 4.0.2)|                          
 |memoise     |  1.1.0    |2017-04-21 |[1] |CRAN (R 4.0.2)|                          
 |mime        |  0.9      |2020-02-04 |[1] |CRAN (R 4.0.0)|                          
 |modelr      |  0.1.8    |2020-05-19 |[1] |CRAN (R 4.0.2)|                          
 |munsell     |  0.5.0    |2018-06-12 |[1] |CRAN (R 4.0.2)|                          
 |pillar      |  1.4.6    |2020-07-10 |[1] |CRAN (R 4.0.2)|                          
 |pkgbuild    |  1.1.0    |2020-07-13 |[1] |CRAN (R 4.0.2)|                          
 |pkgconfig   |  2.0.3    |2019-09-22 |[1] |CRAN (R 4.0.2)|                          
 |pkgload     |  1.1.0    |2020-05-29 |[1] |CRAN (R 4.0.2)|                          
 |plotly      |* 4.9.2.1  |2020-04-04 |[1] |CRAN (R 4.0.2)|                          
 |prettyunits |  1.1.1    |2020-01-24 |[1] |CRAN (R 4.0.2)|                          
 |processx    |  3.4.3    |2020-07-05 |[1] |CRAN (R 4.0.2)|                          
 |promises    |  1.1.1    |2020-06-09 |[1] |CRAN (R 4.0.2)|                          
 |ps          |  1.3.4    |2020-08-11 |[1] |CRAN (R 4.0.2)|                          
 |purrr       |* 0.3.4    |2020-04-17 |[1] |CRAN (R 4.0.2)|                          
 |R6          |  2.4.1    |2019-11-12 |[1] |CRAN (R 4.0.2)|                          
 |Rcpp        |  1.0.5    |2020-07-06 |[1] |CRAN (R 4.0.2)|                          
 |readr       |* 1.3.1    |2018-12-21 |[1] |CRAN (R 4.0.2)|                          
 |readxl      |  1.3.1    |2019-03-13 |[1] |CRAN (R 4.0.2)|                          
 |remotes     |  2.2.0    |2020-07-21 |[1] |CRAN (R 4.0.2)|                          
 |reprex      |  0.3.0    |2019-05-16 |[1] |CRAN (R 4.0.2)|                          
 |rlang       |  0.4.7    |2020-07-09 |[1] |CRAN (R 4.0.2)|                          
 |rmarkdown   |  2.3      |2020-06-18 |[1] |CRAN (R 4.0.2)|                          
 |rprojroot   |  1.3-2    |2018-01-03 |[1] |CRAN (R 4.0.2)|                          
 |rsconnect   |  0.8.16   |2019-12-13 |[1] |CRAN (R 4.0.2)|                          
 |rstudioapi  |  0.11     |2020-02-07 |[1] |CRAN (R 4.0.2)|                          
 |rvest       |  0.3.6    |2020-07-25 |[1] |CRAN (R 4.0.2)|                          
 |scales      |  1.1.1    |2020-05-11 |[1] |CRAN (R 4.0.2)|                          
 |sessioninfo |  1.1.1    |2018-11-05 |[1] |CRAN (R 4.0.2)|                          
 |shiny       |* 1.5.0    |2020-06-23 |[1] |CRAN (R 4.0.2)|                          
 |snakecase   |  0.11.0   |2019-05-25 |[1] |CRAN (R 4.0.2)|                          
 |stringi     |  1.4.6    |2020-02-17 |[1] |CRAN (R 4.0.0)|                          
 |stringr     |* 1.4.0    |2019-02-10 |[1] |CRAN (R 4.0.2)|                          
 |testthat    |  2.3.2    |2020-03-02 |[1] |CRAN (R 4.0.2)|                          
 |tibble      |* 3.0.3    |2020-07-10 |[1] |CRAN (R 4.0.2)|                          
 |tidyr       |* 1.1.1    |2020-07-31 |[1] |CRAN (R 4.0.2)|                          
 |tidyselect  |  1.1.0    |2020-05-11 |[1] |CRAN (R 4.0.2)|                          
 |tidyverse   |* 1.3.0    |2019-11-21 |[1] |CRAN (R 4.0.2)|                          
 |usethis     |* 1.6.1    |2020-04-29 |[1] |CRAN (R 4.0.2)|                          
 |vctrs       |  0.3.2    |2020-07-15 |[1] |CRAN (R 4.0.2)|                          
 |viridisLite |  0.3.0    |2018-02-01 |[1] |CRAN (R 4.0.2)|                          
 |withr       |  2.2.0    |2020-04-20 |[1] |CRAN (R 4.0.2)|                          
 |xfun        |  0.17     |2020-09-09 |[1] |CRAN (R 4.0.2)|                          
 |xml2        |  1.3.2    |2020-04-23 |[1] |CRAN (R 4.0.2)|                          
 |xtable      |  1.8-4    |2019-04-21 |[1] |CRAN (R 4.0.2)|                          
 |yaml        |  2.2.1    |2020-02-01 |[1] |CRAN (R 4.0.2)|
 
[1] C:/Users/Roger/Documents/R/win-library/4.0          
[2] C:/Program Files/R/R-4.0.2/library                  