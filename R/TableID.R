##' Get accuracy location (x, y) for each square for given xid and yid
##'
##' This function will get accuracy lcoation (x, y) for each square for given xid and yid.
##' @title Get location
##' @param BoxIDx the ID for X-axis
##' @param BoxIDy the ID for y-axis
##' @author Tingting & Chang
##' @export
GetxyforBoxes<-function(BoxIDx, BoxIDy)
{
  BoxIDx<-as.integer(BoxIDx)
  BoxIDy<-as.integer(BoxIDy)
  xlow<-(BoxIDx-1)*0.05
  xupper<-BoxIDx*0.05
  ylow<-(BoxIDy-1)*0.05
  yupper<-BoxIDy*0.05
  list(xlim=c(xlow,xupper),ylim=c(ylow,yupper))
}

##' Generate a random tetromino without any shape
##'
##' This function will generate a random tetromino.
##' @title Generate tetromino
##' @author Tingting & Chang
##' @export
Getinittetromino<-function()
{
  xid_coord<-1:8
  xid_LeftBottom<-sample(x = xid_coord[1:(length(xid_coord-1))],1)
  xid<-c(xid_LeftBottom,xid_LeftBottom+1,xid_LeftBottom+2)
  yid<-c(20,21,22)
  tetromino<-matrix(0,nrow = 3,ncol = 3)
  rownames(tetromino)<-rev(as.character(yid))
  colnames(tetromino)<-xid
  tetromino
}

##' assign a shape to tetromino
##'
##' This function will assign a shape to tetromino.
##' @title Shape tetromino
##' @param tetromino the matrix indicate the location of a tetromino
##' @author Tingting & Chang
##' @export
GetType<-function(tetromino)
{
  coloredID<-list()
  type<-sample(1:7,1)
  ty<-GetTypeMatrix(type)
  tetromino<-tetromino+ty
  list(Cubes=tetromino, type=4)
}


##' Write a 3x3 matrix as a specific shape tetromino
##'
##' This function will write a 3x3 matrix as a specific shape tetromino.
##' @title Write tetromino information
##' @param type a indicate for whichi shape will be chosen.
##' @author Tingting & Chang
##' @export
GetTypeMatrix<-function(type)
{
  if(type==1) ### type I
  {
    ty<-matrix(c(0,0,0,1,1,1,0,0,0),nrow = 3, ncol = 3)
  }
  if(type==2) ## type O
  {
    ty<-matrix(c(0,0,0,0,1,1,0,1,1),nrow = 3, ncol = 3)
  }
  if(type==3) ## type T
  {
    ty<-matrix(c(0,1,0,0,1,1,0,1,0),nrow = 3, ncol = 3)
  }
  if(type==4) ## type S
  {
    ty<-matrix(c(1,1,0,0,1,1,0,0,0),nrow = 3, ncol = 3)
  }
  if(type==5) ## type Z
  {
    ty<-matrix(c(0,1,1,1,1,0,0,0,0),nrow = 3, ncol = 3)
  }
  if(type==6) ## type L
  {
    ty<-matrix(c(0,0,0,1,1,1,0,0,1),nrow = 3, ncol = 3)
  }
  if(type==7) ## type J
  {
    ty<-matrix(c(0,0,1,1,1,1,0,0,0),nrow = 3, ncol = 3)
  }
  ty
}

##' Get (x,y) for squares in a tetromino which should be colored.
##'
##' This function will write a 3x3 matrix as a specific shape tetromino.
##' @title Get index of colored square in a tetromino
##' @param tetromino the matrix indicate the location of a tetromino
##' @author Tingting & Chang
##' @export
GetIndexList<-function(tetromino)
{
  row_id<-rownames(tetromino)
  col_id<-colnames(tetromino)
  nNotZeros<-length(which(tetromino!=0))
  xy_id<-data.frame(x=rep(0,nNotZeros),y=rep(0,nNotZeros))
  k=1
  for (i in row_id)
  {
    for (j in col_id)
    {
      if(tetromino[i,j]!=0)
      {
        xy_id[k,"y"]=as.integer(i)
        xy_id[k,"x"]=as.integer(j)
        k<-k+1
      }
    }
  }
  xy_id
}


##' Generate a NA 20x10 matrix for the game
##'
##' This function will generate a NA 20x10 matrix for the game.
##' @title Generate backgroud matrix
##' @author Tingting & Chang
##' @export
totalMatrix<-function()
{
  tablebg<-matrix(0,nrow = 20,ncol = 10)
  rownames(tablebg)<-rev(as.character(1:20))
  colnames(tablebg)<-as.character(1:10)
  tablebg
}

##' Generate a tetromino.
##'
##' This function will a tetromino.
##' @title Generate tetromino
##' @author Tingting & Chang
##' @export
GnrCubes<-function()
{
  tetromino<-Getinittetromino()
  tetromino<-GetType(tetromino)
  tetromino_id<-GetIndexList(tetromino$Cubes)
  list(cubesID=tetromino_id,cubeMatrix=tetromino$Cubes)
}
