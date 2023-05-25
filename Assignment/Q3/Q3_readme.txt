This R program is used to plot the classified points after 1000 iterations of the given points in the file.

In each iteration, the program splits the coordinates of a point (x,y) into two data "x" and "y" and stores them 
in "Xlocation" and "Ylocation". After calculating the distance from each point to the three centers, the program 
finds the closest center by comparing the distances and adds the coordinates to the group of corresponding colors. 
Then the new center point coordinates are calculated from the data in each group, and the next iteration is performed.

As a result, after 1000 iterations, images with well classification results were obtained.