ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    tags$script('
     pressedKeyCount = 0;
        $(document).on("keydown", function (e) {
        Shiny.onInputChange("pressedKey", pressedKeyCount++);
        Shiny.onInputChange("keyPressed", e.keyCode);
        });
        '),
    # Boxes need to be put in a row (or column)
    column(
      width = 7,
      fluidRow(
        box(width = NULL,textOutput("currentTime"))
      ),
      fluidRow(

        div(style="width:100%;height:100%;",plotOutput("plot",height = "700px"))
      )
    ),
    column(
      width = 5,

      fluidRow(width=5,  box(width =9,h3(textOutput("LevelInfo"),align = "center"))),
      fluidRow(width=5, box(width =9,textOutput("ScorePanel"),height = "300px")),
      fluidPage(width=5,
                fluidRow(width=5, actionButton(width = '75%',"startGame", "Start Game")),
                fluidRow(width=5,actionButton(width = '75%',"endGame", "End Game") ),
                fluidRow(width=5,actionButton(width = '75%',"reset", "Reset") ))
    )
  )
)
