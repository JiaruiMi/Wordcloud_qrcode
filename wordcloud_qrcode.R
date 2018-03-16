#============================================================================
#
#                             Wordcloud Drawing
#
#============================================================================

### Official blog:
### https://github.com/Lchiffon/wordcloud2
### http://lchiffon.github.io/2016/06/01/wordcloud2.html

## install the package from github
## load your package
library(wordcloud2)
library(dplyr)
library(RColorBrewer)

## set working directory
setwd('/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud')
## prepare your datasets
data <- read.csv('wordCloud.csv', header = F)
set.seed(100)
n <- nrow(data)
data$V2 <- seq(from = n, to = 1, by = -1)
head(data);dim(data)
data <- rename(data, word = V1, frequency = V2)
data[data$word == 'lncRNA',2] = 150
data <- rbind(data, data, data) # we can do this step several times to make the number of word a little bit larger

## Make the plot
wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/doctorcap.png')

### The point is the figure you choose is better to have large areas so that the words can reside in, otherwise
### the plot would be very ungly.
