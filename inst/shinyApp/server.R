set.seed(200)
fullTable<-totalMatrix()
cubes<-GnrCubes()
server <- function(input, output,session) {
  totalscore<-0
  bgtable <-drawTable()
  active<-reactiveVal(FALSE)
  observeEvent(input$pressedKey,{
    if (!is.null(input$keyPressed))
    {
      active(FALSE)
      code<-input$keyPressed

      if(code==65) ##Press A
      {
        cubes<<-MoveLeft(cubes,fullTable)
      }
      if(code==68) ##Press D
      {
        cubes<<-MoveRight(cubes,fullTable)
      }
      # if(code==83) ##Press S
      # {
      #   cubes<<-MoveDown(cubes,fullTable)
      # }
      if(code==87) ##Press W
      {
        cubes<<-rotate(cubes,fullTable)
        #cubes<<-MoveRight(cubes)
      }
      active(TRUE)
    }
  })

  observe(
    {
      invalidateLater(1500, session)
      isolate({
        if(active())
        {
          bt<-UpdateTable(bgtable,cubes$cubesID)
          continueDrop<-checkNextBlock_y(cubes$cubesID,fullTable)
          if(continueDrop)
          {
            cubes$cubesID[,"y"]<<-cubes$cubesID[,"y"]-1
            rownames(cubes$cubeMatrix)<<-as.numeric(rownames(cubes$cubeMatrix))-1
          }
          else
          {
            for (i in 1:nrow(cubes$cubesID))
            {
              if(cubes$cubesID[i,"y"]>20)
                next()
              fullTable[as.character(cubes$cubesID[i,"y"]),as.character(cubes$cubesID[i,"x"])]<<-1
            }
            score<-GetScore(fullTable)
            if(score$score>0)
            {
              fullTable<<-score$tables
              totalscore<<-totalscore+score$score
              {
                output$ScorePanel <- renderText({paste0("Score: ",totalscore)   })
              }
            }
            bgtable<<-updateBackGround(fullTable)
            if(endGame(fullTable))
            {
              active(FALSE)
              output$LevelInfo<-renderText("Game Over")
            }
            cubes<<-GnrCubes()
            #active(FALSE)
          }
          output$plot <- renderPlot({
            bt
          })
        }
      })
    })


  output$plot <- renderPlot({
    bgtable
  })
  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste("Time: ", Sys.time())
  })
  output$LevelInfo<-renderText("Level 1")
  output$ScorePanel <- renderText({"Score: 0"  })
  observeEvent(input$startGame,{active(TRUE)
    cubes<<-GnrCubes()
    bgtable <<-drawTable()})
  observeEvent(input$endGame,{active(FALSE)})
  observeEvent(input$reset,{active(FALSE)
    output$LevelInfo<-renderText("Level 1")
    cubes<<-GnrCubes()
    bgtable <<-drawTable()
    output$plot <- renderPlot({
      bgtable
    })})
}



