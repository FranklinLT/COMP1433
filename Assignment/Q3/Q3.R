#Q3
#Read in the file and build the frame
mydata = read.csv("points.txt",header = FALSE, sep = ",")
Xlocation = mydata$V1
Ylocation = mydata$V2
library(ggplot2)

redcenter = c(40,40)   #Generate the initial points and empty groups
bluecenter = c(100,0) 
greencenter = c(0,100)
Xredgroup = c()
Yredgroup = c()
Xbluegroup = c()
Ybluegroup = c()
Xgreengroup = c()
Ygreengroup = c()

#A function used to find the color of each point
distance = function(X,X1,X2,X3,Y,Y1,Y2,Y3){
  dis1 = (X - X1)^2 + (Y - Y1)^2
  dis2 = (X - X2)^2 + (Y - Y2)^2
  dis3 = (X - X3)^2 + (Y - Y3)^2
  dis = min(dis1,dis2,dis3)
  if (dis == dis1){
    return (1)
  }
  else if(dis == dis2){
    return (2)
  }
  else if(dis == dis3){
    return (3)
  }
}

#A function used to find the coordinate of new central points
newpoint = function(group){
  z =0
  for (i in group){
    z = z + i
  }
  z = z/length(group)
  return (z)
}


for (i in 1:1000){  # 1,000 iterations
  for (n in 1:length(Xlocation)){
    dis = distance(Xlocation[n],redcenter[1],bluecenter[1],greencenter[1],Ylocation[n],redcenter[2],bluecenter[2],greencenter[2])
    if (dis == 1){
      Xredgroup = append(Xredgroup,Xlocation[n])
      Yredgroup = append(Yredgroup,Ylocation[n])
    }
    else if(dis == 2){
      Xbluegroup = append(Xbluegroup,Xlocation[n])
      Ybluegroup = append(Ybluegroup,Ylocation[n])
    }
    else if(dis == 3){
      Xgreengroup = append(Xgreengroup,Xlocation[n])
      Ygreengroup = append(Ygreengroup,Ylocation[n])
    }
  }
  redcenter[1] = newpoint(Xredgroup)   #Set new center points
  redcenter[2] = newpoint(Yredgroup)
  bluecenter[1] = newpoint(Xbluegroup)
  bluecenter[2] = newpoint(Ybluegroup)
  greencenter[1] = newpoint(Xgreengroup)
  greencenter[2] = newpoint(Ygreengroup)
  if (i != 1000){  #Keep the last grouping for plotting
    Xredgroup = c()
    Yredgroup = c()
    Xbluegroup = c()
    Ybluegroup = c()
    Xgreengroup = c()
    Ygreengroup = c()
  }
}
#plotting
redgroup = data.frame(Xredgroup,Yredgroup)
bluegroup = data.frame(Xbluegroup,Ybluegroup)
greengroup = data.frame(Xgreengroup,Ygreengroup)

ggplot()+geom_point(data = redgroup,aes(Xredgroup,Yredgroup),color = "red")+geom_point(data = bluegroup,aes(Xbluegroup,Ybluegroup),color = "blue")+geom_point(data = greengroup,aes(Xgreengroup,Ygreengroup),color = "green")+labs(x = "Xline",y = "Yline")