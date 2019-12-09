##' launch the Game with shiny app
##'
##' This function will launch the Game with shiny app.
##' "W" will rotate the tetrominos, "A" will move the tetrominos to left,  and "D" will move the tetrominos to right
##' @title Launch the Game
##' @author Tingting & Chang
##' @export
launchGame<-function()
{
  appDir = system.file("shinyApp", package = "Tetris")
  if (appDir == "") {
    stop("Could not find myapp. Try re-installing `mypackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
