#part(a)
#Read in the file and build the frame（将收集的数据导入）
mydata = read.csv("train_tweets_new.txt",header = FALSE,sep = "\t")
tweetID = mydata$V1
userID = mydata$V2
sentiment = mydata$V3
text = mydata$V4
mydataframe = data.frame(tweetID,userID,sentiment,text)

#part(b)
#（将数据进行整合、处理）
library(tokenizers)
tokens = tokenize_words(text) #create a new column
mydataframe$tokens = tokens   #add new column to data.frame
value = 0
vocab = c()
wordcounter = 0
tweet = c()
for (eachtweet in tokens){
  for (eachword in eachtweet){
    tweet = append(tweet,eachword)  #Add each word to tweet list
  }
}
tweet = unique(tweet)   #Remove duplicate words from the list

#A function to count target words
wordfinder = function(eachtweet,word){
  for (n in eachtweet){
    if(n == word){
      return (1)
    }
  }
  return(0)
}

for (i in tweet){
  wordcounter = 0
  for (eachtweet in tokens){
    wordcounter = wordfinder(eachtweet,i) + wordcounter
  }
  if (wordcounter > 3){  # add target word to list "vocab"
    vocab = append(vocab,i)
  }
}

print(length(vocab))  #the length of vocab mean the number of unique words in it

#part(c)
Positive = c()
Neutral = c()
Negative = c()
counter = 0

for (eachword in vocab){  #divide words by sentiment
  counter = 0
  for (eachtweet in tokens){
    counter = counter + 1
    for (word in eachtweet){
      if (eachword == word){
        if(sentiment[counter] == "positive"){
          Positive = append(Positive,eachword)
        }
        else if (sentiment[counter] == "neutral"){
          Neutral = append(Neutral,eachword)
        }
        else{
          Negative = append(Negative,eachword)
        }
      }
    }
  }
}

uniquelengh = length(vocab)   #find the length of each list
neutrallength = length(Neutral)
negativelength = length(Negative)
positivelength = length(Positive)

sentence1 = tokenize_words("@grandvincenzo on November 16 be ready to head to the movies. Breaking Dawn: Part 2. (;")
sentence2 = tokenize_words("@rosanne_89 Nooooooooo rosanne! They've just restocked them and me going overseas Sunday means I can't afford them :'(")
sentence3 = tokenize_words("The pain is far deeper than a Billy cundiff missed field goal. Gotta wake up and forget about it tomorrow. #Orioles #stayhungry")

positivetweet = 0    #Calculate the number of tweets of each sentiment
negativetweet = 0
neutraltweet = 0
for (i in sentiment){
  if (i == "positive"){
    positivetweet = positivetweet + 1
  }
  else if (i == "neutral"){
    neutraltweet = neutraltweet + 1
  }
  else{
    negativetweet = negativetweet + 1
  }
}

#The following three functions form the Naive Bayesian classifier
typefinder_Positive = function(sentence){
  number1 = positivetweet/(positivetweet + negativetweet + neutraltweet)
  for (sen in sentence){
    for (word in sen){
      number2 = 1
      for (i in Positive){
        if (i == word){
          number2 = number2 + 1
        }
      }
      number1 = number1 * number2 / (uniquelengh + positivelength)
    }
  }
  number1 = log(number1)
  return (number1)
}

typefinder_Negative = function(sentence){
  number1 = negativetweet/(positivetweet + negativetweet + neutraltweet)
  for (sen in sentence){
    for (word in sen){
      number2 = 1
      for (i in Negative){
        if (i == word){
          number2 = number2 + 1
        }
      }
      number1 = number1 * number2 / (uniquelengh + negativelength)
    }
  }
  number1 = log(number1)
  return (number1)
}

typefinder_Neutral = function(sentence){
  number1 = neutraltweet/(positivetweet + negativetweet + neutraltweet)
  for (sen in sentence){
    for (word in sen){
      number2 = 1
      for (i in Neutral){
        if (i == word){
          number2 = number2 + 1
        }
      }
      number1 = number1 * number2 / (uniquelengh + neutrallength)
    }
  }
  number1 = log(number1)
  return (number1)
}

#A function to determine the sentiment of test tweet
Typefinder = function(Max, num1,num2,num3){
  if(Max == num1){
    SentenceType = "Positive"
  }
  else if(Max == num2){
    SentenceType = "Negative"
  }
  else if(Max == num3){
    SentenceType = "Neutral"
  }
  return (SentenceType)
}

#Sample 1:
P1 = typefinder_Positive(sentence1)
P2 = typefinder_Negative(sentence1)
P3 = typefinder_Neutral(sentence1)
Max = max(P1,P2,P3)
SentenceType = Typefinder(Max,P1,P2,P3)
print("Tweet1:")
print(SentenceType)

#Sample 2:
P1 = typefinder_Positive(sentence2)
P2 = typefinder_Negative(sentence2)
P3 = typefinder_Neutral(sentence2)
Max = max(P1,P2,P3)
SentenceType = Typefinder(Max,P1,P2,P3)
print("Tweet2:")
print(SentenceType)

#Sample 3:
P1 = typefinder_Positive(sentence3)
P2 = typefinder_Negative(sentence3)
P3 = typefinder_Neutral(sentence3)
Max = max(P1,P2,P3)
SentenceType = Typefinder(Max,P1,P2,P3)
print("Tweet3:")
print(SentenceType)

