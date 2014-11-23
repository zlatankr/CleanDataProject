setwd("~/Analytics/Learning Materials/R Class/GetCleanData")

# Question 1
quizurlone<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(quizurlone,destfile="./Data/Quiz1Q1.csv")
q1data<-read.table("./Data/Quiz1Q1.csv", sep=",",header=TRUE)
nrow(q1data)
length(unique(q1data$SERIALNO))
colnames(q1data)
unique(q1data$VAL)
# need to remove the blank rows here, or else it will mess up the count in the next function
q1data<-subset(q1data,!is.na(VAL))
nrow(q1data[q1data$VAL=="24",])

# Question 2
q1data$FES
unique(q1data$FES)

# Question 3

quizurltwo<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(quizurltwo,destfile="./Data/Quiz1Q3.xlsx",mode="wb")
library(xlsx)
library(rJava)

q2data <- read.xlsx("./Data/Quiz1Q3.xlsx",sheetIndex=1,header=TRUE)
q2data
dat<-q2data[c(18:22),c(7:15)]
dat
(as.vector(dat[1,c(1:9)]))
colnames(dat)<-c("Zip","CuCurrent","PaCurrent","PoCurrent","Contact","Ext","Fax","email","Status")
dat
is.na(dat$Ext)
# I learned this the hard way: you need to pay attention to the classes of the columns...
class(dat$Zip)
class(dat$Ext)
# using as.numeric immediately doesn't work...
dat$Zip<-as.numeric(as.character(dat$Zip))
dat$Ext<-as.numeric(as.character(dat$Ext))
class(dat$Zip)
class(dat$Ext)
dat
sum(dat$Zip*dat$Ext,na.rm=T)

## I had to cheat...I created the Excel file below, which contained just the subset of the original datafile...
dat2 <- read.xlsx("./Data/q1q3test.xlsx",sheetIndex=1,header=TRUE)
dat2
sum(dat2$Zip*dat2$Ext,na.rm=T)
class(dat2$Zip)
class(dat2$Ext)

# Question 4

library(XML)
#need to remove the "s" from the "https" in the file link
url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc<-xmlTreeParse(url,useInternal=TRUE)
rootNode<-xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
rootNode[[1]]
zip<-data.frame(zip=xpathSApply(rootNode,"//zipcode",xmlValue))
length(zip[zip$zip=="21231",])

# Question 5
quizurlfive<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(quizurlfive,destfile="./Data/Quiz1Q5.csv")

# fread() exists in the data.table library!
library(data.table)
?fread
DT<-fread("./Data/Quiz1Q5.csv")

# option a
tapply(DT$pwgtp15,DT$SEX,mean)
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

# option b (appears faster than a)
sapply(split(DT$pwgtp15,DT$SEX),mean)
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

#option c (this one seems wrong...)
mean(DT$pwgtp15,by=DT$SEX)

#option d (seems equally fast as b)
DT[,mean(pwgtp15),by=SEX]
system.time(DT[,mean(pwgtp15),by=SEX])

# option e (wrong)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]

# option f (slower than a)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
# only calculate the speed of one of these two calculations, otherwise you'll get an error
system.time(mean(DT[DT$SEX==1,]$pwgtp15))