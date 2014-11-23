setwd("~/Analytics/Learning Materials/R Class/GetCleanData")

# SUBSETTING AND SORTING

set.seed(13435)

X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))

X <- X[sample(1:5),]; X$var2[c(1,3)]=NA

X

# subset a specific column

X[,1]

# or

X[,"var1"]

# or subset on both column and rows:

X[1:2,"var2"]

# logical ands and ors

X[(X$var1 <= 3 & X$var3 > 11),]

X[(X$var1 <= 3 | X$var3 > 15),]

# NA values are ignored using the 'which' command

X[which(X$var2>8),]

# sorting a data frame

sort(X$var1)

sort(X$var1,decreasing=TRUE)

# sort, but put the NAs at the end

sort(X$var2,na.last=TRUE)

# ORDERING

X[order(X$var1,X$var3),]

# we can also use the plyr package to do this stuff

library(plyr)
arrange(X,var1)

# or do it by making var1 descending order

arrange(X,desc(var1))

# adding rows and columns to the data frame

X$var4 <- rnorm(5)

X

# or use the c-bind command:

Y <- cbind(X,rnorm(5))
Y

# SUMMARIZING DATA:

fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./Data/restaurants.csv")
restData <- read.csv("./Data/restaurants.csv")

# we can start by looking at the first few rows of the data

head(restData,n=3)

# or last few rows...

tail(restData,n=3)

# we can summarize the dataset:

summary(restData)

# structure of the dataset:

str(restData)

# we can use quantile to look at the details of quantitative variables:

quantile(restData$councilDistrict,na.rm=TRUE)

# we can specify which quantiles of the data we want to see:

quantile(restData$councilDistrict,na.rm=TRUE,probs=c(.5,.75,.9))

# we can make a table that shows the count of each value in a column:

table(restData$zipCode,useNA="ifany")

# we can make these tables two-dimensional:

table(restData$councilDistrict,restData$zipCode)

# check for missing values:

sum(is.na(restData$councilDistrict))

# or see if there are ANY NAs:

any(is.na(restData$councilDistrict))

# or if all of them are NAs

all(is.na(restData$councilDistrict))

# check to see how many variable fall into a given category:

table(restData$zipCode %in% c("21212","21213"))

# or we can just subset this data 

restData[restData$zipCode %in% c("21212","21213"),]

# we can subset the data using crosstabs:

data(UCBAdmissions)
DF=as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit,data=DF)

xt

ftable(xt)

# CREATING NEW VARIABLES

# creating sequences...

s1 <- seq(1,10,by=2) ; s1

s2 <- seq(1,10,length=3) ; s2

# this one creates an index along a given vector s3:

s3 <- c(1,3,8,25,100); seq(along=s3)

# we are now subsetting the restaurants that are near me:

restData$nearMe = restData$neighborhood %in% c("Roland Park", "Homeland")

table(restData$nearMe)

# creating binary variables:

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)

table(restData$zipWrong,restData$zipCode < 0)

# we can also create categorical variables:

restData$zipGroups = cut(restData$zipCode,breaks=quantile(restData$zipCode))

table(restData$zipGroups)

table(restData$zipGroups,restData$zipCode)

# or we can use the cut2 funtion: 

install.packages("Hmisc")
library(Hmisc)
restData$zipGroups = cut2(restData$zipCode,g=4)
table(restData$zipGroups)

# this creates 'factor' variables

class(restData$zipGroups)

# we can both create a new variable and add it to an existing data frame

library(Hmisc); library(plyr)
restData2 = mutate(restData,zipGroups=cut2(zipCode,g=4))
table(restData2$zipGroups)

# RESHAPING DATA

library(reshape2)
head(mtcars)

# ...this lecture was too quick and too dense for me to take notes....

# MERGING DATA

# we can use either the 'merge' function or the plyer 'join' function
# plyr is better if you have multiple data frames and the column names are the same






























































