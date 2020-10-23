#'Launch the Shiny app
#' 
#' @description This function is used to launch the Shiny app of the Shiny assessment, 
#' where is placed in the inst/app folder.
#' 
#' @return The Shiny app will run automatically, and the interface of the app will pop up.
#' 
#' @note This function does not require any arguments to run this function. Simply enter and run this function. 
#' 
#' @examples 
#' launch_app()
#' # No any argument required.
#' 
#' @source The Shiny app could be found in [here]( https://jinhao-luo.shinyapps.io/shiny-assessment-jluo0015/)
#' 
#' @export
launch_app <- function(){
  
  app_directory <- system.file("inst", "app", package = "launchshiny")
  
  shiny::runApp(app_directory)
}

