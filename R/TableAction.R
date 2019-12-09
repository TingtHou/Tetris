##' Backgroup initialization
##'
##' This function will draw a blank table in Website before starting game
##' @title Backgroup initialization
##' @author Tingting & Chang
##' @export
drawTable<-function()
{
  step<-0.5/10
  x<-seq(0,0.5,by=step)
  y<-seq(0,1,by=step)
  gp<-ggplot(data = data.frame(0,0))+xlim(c(0,0.5))+ylim(c(0,1))+
    geom_vline(xintercept=seq(0,0.5,by=step),aes(col="gray"))+
    geom_hline(yintercept=seq(0,1,by=step),aes(col="gray"))+
    scale_y_continuous(expand=c(0,0))+
    scale_x_continuous(expand = c(0,0))+
    xlab("")+ylab("")+
    theme(axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank())
  gp
}

##' Update the whole sreen of Teris
##'
##' This function will update the figure when location of tetriminos is change.
##' when the location of tetriminos is changed, the variable TableMatrix will change as well.
##' @title Update location of tetriminos
##' @param TableMatrix the matrix indicates will part should be colored as blue
##' @author Tingting & Chang
##' @export
updateBackGround<-function(TableMatrix)
{
  step<-0.5/10
  x<-seq(0,0.5,by=step)
  y<-seq(0,1,by=step)
  gp<-ggplot(data = data.frame(0,0))+xlim(c(0,0.5))+ylim(c(0,1))+
    geom_vline(xintercept=seq(0,0.5,by=step),aes(col="gray"))+
    geom_hline(yintercept=seq(0,1,by=step),aes(col="gray"))+
    scale_y_continuous(expand=c(0,0))+
    scale_x_continuous(expand = c(0,0))+
    xlab("")+ylab("")+
    theme(axis.title=element_blank(),
          axis.text=element_blank(),
          axis.ticks=element_blank())
  for (i in 1:nrow(TableMatrix))
  {
    for (j in 1:ncol(TableMatrix))
    {
      e<-TableMatrix[as.character(i),as.character(j)]
      if(e==1)
      {
        xylim<-GetxyforBoxes(j,i)
        gp<-gp+ geom_rect(xmin=xylim$xlim[1],xmax=xylim$xlim[2], ymin=xylim$ylim[1],ymax=xylim$ylim[2],fill="blue",alpha=0.5)
      }
    }
  }
  gp
}

##' Update Teris figure when a tetromino is dropping
##'
##' This function will update the figure when location of tetriminos is dropping or rotating.
##' @title Update location of tetriminos
##' @param gp plot object which contian current backgroup
##' @param tetromino the matrix indicates the location of dropping tetromino
##' @author Tingting & Chang
##' @export
UpdateTable<-function(gp, tetromino)
{
  for (i in 1:nrow(tetromino))
  {
    if(tetromino [i,"y"]>20)
      next()
    xylim<-GetxyforBoxes(tetromino [i,"x"],tetromino [i,"y"])
    gp<-gp+ geom_rect(xmin=xylim$xlim[1],xmax=xylim$xlim[2], ymin=xylim$ylim[1],ymax=xylim$ylim[2],fill="blue",alpha=0.5)
  }
  gp
}

