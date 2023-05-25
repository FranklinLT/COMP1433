times = c(100000,200000,500000)   #Get a more accurate fit by a huge number of attempts
Q1C.function = function(time){     
  success = 0
  for(i in 1:time){
    m = 0
    set.seed(i)      
    test_sample = sample(1:100,500,replace = TRUE)  #Generate random numbers from 1 to 100 to simulate the cards drawn
    for (n in 1:500){
      if (test_sample[n] == 1){    #Use 1 and 2 to represent "Agrippa" and "Ptolemy"
        m = m + 1
      }
      else if (test_sample[n] == 2){
        m = m + 1
      }
    }
    if (m == 0){   #if m == 0, which means we don't get "Agrippa" and "Ptolemy" 
      success = 1 + success
    }
  }
  print (success/time)  #Show results
}
for (time in times){
  Q1C.function(time)
}
