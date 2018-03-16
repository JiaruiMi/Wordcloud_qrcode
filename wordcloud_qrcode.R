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
data <- rbind(data, data, data, data, data, data, data, data, data, data, data, data, data, data, data, data) # we can do this step several times to make the number of word a little bit larger

## Make the plot
wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/doctorcap.png')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/doctorcap1.png')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/dogpaw.jpg')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/dog.jpg')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/batman.jpg')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/blackpanther.jpg')


wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/jaguar.png')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/ironman.jpg')

wordcloud2(data,size=0.5,fontFamily="Segoe UI",fontWeight = 'bold', color = 'random-dark',
           backgroundColor = "white", minRotation = -pi/4, maxRotation =pi/4, shuffle = F,
           figPath = '/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/deadpool.jpg')


### The point is the figure you choose is better to have large black areas so that the words can reside in, otherwise
### the plot would be very ungly. Another thing is the object should be dark in the picture, the very classical
### negative example is 'aula medica'.


## 使用网页爬取得文本（txt）文件构建wordcloud，需要下载文本，放置在txt文件中，综合使用jieba和wordcloud两个包
library(jiebaR)   #载入jiebaR包
engine = worker()  #生成分词器engine
text<-scan('baikal_lake.txt',what='')
seg<-segment(text,engine) ##分词
head(seg)
f1<-freq(seg)   ##统计词频
head(f1)
f2<-f1[order((f1)[2],decreasing=TRUE),]
##根据词频降序排列
x=rep(0,times=dim(f2)[1])  ##去单字
for( i in 1:dim(f2)[1]){
    if(nchar(f2[i,])[1]>1)
     x[i]=i
}
y=sort(x)[1:dim(f2)[1]]
y=f2[y,]
head(y)  ##查看y
wordcloud2(y,size = 0.5,figPath ='/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/doctorcap1.png')
#============================================================================
#
#                             qrcode generation
#
#============================================================================
library(ggplot2)
library(yyplot)
library(ggimage)
library(showtext) ## 添加中文字体

### 简单玩法，小试牛刀
ggqrcode('http://mp.weixin.qq.com/s/-56MT28D0iese6ZsBYSyRA') ## Try webpage
ggqrcode("I love you, my dear Panda")  ## Try word

### 高级玩法，二维码包含背景图
#### 二维码本质上是构建了01的矩阵，所以我们其实在上面的图上加一些自定义的内容。
#### 其实就是降低了二维码部分的透明度，然后在背后添加其他图片。
#### 首先构建一个包含图像地址的ggplot对象，其中图片层为geom_image, 背景主题为无,也就是theme_void().
d <- data.frame(x=1, y=1,
                img="http://www.twgreatdaily.com/imgs/image/15/1578770.jpg")
p <- ggplot(d, aes(x,y)) + geom_image(aes(image=img), size=Inf) + theme_void()
p2 <- ggqrcode("http://mp.weixin.qq.com/s/oLgpTGdQgcka-OD757_3lA", "black", alpha=.5)
p + geom_subview(subview = p2, width=Inf, height=Inf, x=1, y=1)


### 在二维码中间加上logo
pg <- ggqrcode("http://mp.weixin.qq.com/s/-56MT28D0iese6ZsBYSyRA")
d <- data.frame(x=15, y=15,    
                img="/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/husky.jpg")
pg + geom_image(aes(x,y, image=img), data=d, size=.2)


pg <- ggqrcode("http://mp.weixin.qq.com/s/-56MT28D0iese6ZsBYSyRA")
d <- data.frame(x=15, y=15,    
                img="/Users/mijiarui/R_bioinformatics_project/Master_thesis_project/Wordcloud/cap.png")
pg + geom_image(aes(x,y, image=img), data=d, size=.2)









