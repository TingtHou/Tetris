##' Check if the player will win points
##'
##' This function will check if any lines are filled by same color and player will win 10 points
##' @title Win points
##' @param tables a matrix which contains the information where tetrominos locates
##' @author Tingting & Chang
##' @export
GetScore <- function(tables)
{
  xname<-colnames(tables)
  yname<-rownames(tables)
  score<-0
  index<-which(apply(tables, 1, sum)==10)
  if(length(index)>0)
  {
    score<-score+10*length(index)
    temp<-tables[-index,]
    tables<-rbind(matrix(0,ncol = ncol(tables),nrow = length(index)),temp)
  }
  colnames(tables)<-xname
  rownames(tables)<-yname
  list(tables=tables,score=score)
}

##' Check if the game will ends
##'
##' This function will check if any coloums is filled by same color and the game will be end
##' @title End Game
##' @param tables a matrix which contains the information where tetrominos locates
##' @author Tingting
##' @export
endGame<- function(tables)
{
  status<- any(tables["20",]==1)
  return(status)
}
