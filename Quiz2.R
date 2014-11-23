setwd("C:/Users/zlatan.kremonic/Documents/Analytics/Learning\ Materials/R\ Class/GetCleanData")

## QUESTION 1
library(httr)
install.packages("httpuv")
# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp <- oauth_app("github", "b89fd9c31cb33824fd41", "d9a4230208b3dd3c1e44017e9de7f8a38146ae13")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

## QUESTION 2

quizurlone<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(quizurlone,destfile="./Data/Quiz2Q2.csv")
acs<-read.table("./Data/Quiz2Q2.csv", sep=",",header=TRUE)

install.packages("RSQLite")
install.packages("RSQLite.extfuns")
install.packages("sqldf")
library(sqldf)
library(DBI)
require(sqldf) 
sqldf("select * from acs where AGEP  50 and pwgtp1")
sqldf("select * from acs where AGEP<50 and pwgtp1")

## QUESTION 4

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(con)
close(con)
nchar(htmlCode[c(10, 20, 30, 100)])

## QUESTION 5

x <- read.fwf(
  file=url("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
  skip=4,
  widths=c(12, 7,4, 9,4, 9,4, 9,4))

names(x)
sum(x$V4)