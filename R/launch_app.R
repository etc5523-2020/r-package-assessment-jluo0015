#'Launch the Shiny app
#' 
#' @description This function is used to launch the Shiny app of the Shiny assessment, 
#' where is placed in the inst/app folder.
#' 
#' @param NULL do not require any arguments to run this function. Simply enter and run this function. 
#' 
#' @return The Shiny app will run automatically, and the interface of the app will pop up.
#' 
#' @examples 
#' launch_app()
#' 
#' @export
launch_app <- function(){
  shiny::runApp(here::here("inst/app/app.R"))
}

