##' Check if the tetromino should move down
##'
##' This function will check if the tetromino can move down
##' @title Check tetrominos moving towards
##' @param cubes a matrix which contains the information where tetromino locates
##' @param tables a matrix which contains the information of the current backgroup including previous tetrominos location
##' @author Tingting & Chang
##' @export
checkNextBlock_y<-function(cubes,tables)
{
  for (i in 1:nrow(cubes))
  {
    nexty=cubes[i,"y"]-1
    nextx=cubes[i,"x"]
    if(nexty>20)
      next()
    if(nexty<1)
      return(FALSE)
    if(nextx>10)
      return(FALSE)
    if(nextx<1)
      return(FALSE)
    ele<-tables[as.character(nexty),as.character(nextx)]
    if(ele==1)
    {
      return(FALSE)
    }

  }
  return(TRUE)
}

##' Check if the tetromino should move down 3
##'
##' This function will check if the tetromino can move down 3
##' @title Check tetrominos moving towards
##' @param cubes a matrix which contains the information where tetromino locates
##' @param tables a matrix which contains the information of the current backgroup including previous tetrominos location
##' @author Tingting & Chang
##' @export
checkNext3Block_y<-function(cubes,tables,direct)
{
  for (i in 1:nrow(cubes))
  {
    nexty=cubes[i,"y"]-3
    nextx=cubes[i,"x"]
    if(nexty>20)
      next()
    if(nexty<1)
      return(FALSE)
    if(nextx>10)
      return(FALSE)
    if(nextx<1)
      return(FALSE)
    ele<-tables[as.character(nexty),as.character(nextx)]
    if(ele==1)
    {
      return(FALSE)
    }

  }
  return(TRUE)
}

##' Check if the tetromino should move left or right
##'
##' This function will check if the tetromino can move right ot left.
##' @title Check tetrominos moving right/left
##' @param cubes a matrix which contains the information where tetromino locates
##' @param tables a matrix which contains the information of the current backgroup including previous tetrominos location
##' @author Tingting & Chang
##' @export
checkNextBlock_x<-function(cubes,tables,direct)
{
  for (i in 1:nrow(cubes))
  {
    nexty=cubes[i,"y"]
    nextx=cubes[i,"x"]+direct
    if(nexty>20)
      next()
    if(nexty<1)
      return(FALSE)
    if(nextx>10)
      return(FALSE)
    if(nextx<1)
      return(FALSE)
    ele<-tables[as.character(nexty),as.character(nextx)]
    if(ele==1)
    {
      return(FALSE)
    }

  }
  return(TRUE)
}

##' Move the dropping tetromino to the left
##'
##' This function will move the dropping tetromino to the left
##' @title Move left
##' @param cubes a matrix which contains the information where tetromino locates
##' @param tables a matrix which contains the information of the current backgroup including previous tetrominos location
##' @author Tingting & Chang
##' @export
MoveLeft<-function(cubes,tables)
{
  checkNext_X<-checkNextBlock_x(cubes$cubesID,tables,-1)
  if (checkNext_X)
  {
    cubes$cubesID[,'x']<- cubes$cubesID[,'x']-1
    colnames(cubes$cubeMatrix)<-as.numeric(colnames(cubes$cubeMatrix))-1
  }
  cubes
}
##' Move the dropping tetromino to the right.
##'
##' This function will move the dropping tetromino to the right.
##' @title Move right
##' @param cubes a matrix which contains the information where tetromino locates
##' @param tables a matrix which contains the information of the current backgroup including previous tetrominos location
##' @author Tingting & Chang
##' @export
MoveRight<-function(cubes,tables)
{
  checkNext_X<-checkNextBlock_x(cubes$cubesID,tables,1)
  if (checkNext_X)
  {
    cubes$cubesID[,'x']<- cubes$cubesID[,'x']+1
    colnames(cubes$cubeMatrix)<-as.numeric(colnames(cubes$cubeMatrix))+1
  }
  cubes
}

##' Move down the dropping tetromino.
##'
##' This function will move  down the dropping tetromino.
##' @title Move right
##' @param cubes a matrix which contains the information where tetromino locates
##' @param tables a matrix which contains the information of the current backgroup including previous tetrominos location
##' @author Tingting & Chang
##' @export
MoveDown<-function(cubes,tables)
{
  checkNext_y<-checkNext3Block_y(cubes$cubesID,tables)
  if (checkNext_y)
  {
    cubes$cubesID[,"y"]<-cubes$cubesID[,"y"]-3
    rownames(cubes$cubeMatrix)<-as.numeric(rownames(cubes$cubeMatrix))-3
  }
  cubes
}

##' Rotate the dropping tetromino.
##'
##' This function will rotate the dropping tetromino.
##' @title Rotate the dropping tetromino.
##' @param cubes a matrix which contains the information where tetromino locates
##' @author Tingting & Chang
##' @export
rotate<-function(cubes,tables)
{
  tetromino<-cubes$cubeMatrix
  xname<-colnames(tetromino)
  yname<-rownames(tetromino)
  if(min(as.numeric(yname))==0)
  {
    yname<-as.character(as.numeric(yname)+1)
  }
  if(min(as.numeric(xname))==0)
  {
    xname<-as.character(as.numeric(xname)+1)
  }
  if(max(as.numeric(xname))==11)
  {
    xname<-as.character(as.numeric(xname)-1)
  }
  tetromino<-t(apply(tetromino, 2, rev))
  rownames(tetromino)<-yname
  colnames(tetromino)<-xname
  cubesID<-GetIndexList(tetromino)
  cubes_after<-list(cubesID=cubesID,cubeMatrix=tetromino)
  check<-checkNextBlock_x(cubes_after$cubesID,tables,0)
  if(!check)
  {
    cubes_tmp<-MoveRight(cubes_after,tables)
    check2<-checkNextBlock_x(cubes_tmp$cubesID,tables,0)
    if(!check2)
    {
      cubes_tmp<-MoveLeft(cubes_after,tables)
      check3<-checkNextBlock_x(cubes_tmp$cubesID,tables,0)
      if(check3)
      {
        cubes<-cubes_tmp
      }
    }
    else
    {
      cubes<-cubes_tmp
    }
  }else
  {
    cubes<-cubes_after
  }
  cubes
}
