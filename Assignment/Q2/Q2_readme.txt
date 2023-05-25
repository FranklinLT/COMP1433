This R program has four parts, each part is the answer of each question in Question 2. 

In part A, the program read in the target file by using function "read.csv" and build the dataframe 
named "mydataframe" by function "data.frame"

In part B, it use function "tokenize_words" to divide each word in tweet sentence and group it, then
put them to a new column called "tokens" which build in "mydataframe"

In part C, it use the loop structure to add the words obtained in part B to a list named "tweet", then 
use function "unique" to remove duplicate words which can obtain a list to be the reference. Then find 
the words with more than three occurrences by counting them one by one and add them to vector "vocab".
Through printing the length of "vocab", we get the number of unique words in "vocab".

In part D, I firstly create a vector which include the words will influence test results. The next, use the 
column "sentiment" to separate the tweets in "Positive","Neutral" and "Negative" three part. After finding
the length of each necessary data, it uses three programs as plain Bayesian classifiers and makes an analysis 
of the three tweets used for testing. After log() the results and comparing them the program return the answer
of each test tweet at last.