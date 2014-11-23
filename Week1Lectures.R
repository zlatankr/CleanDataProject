setwd("~/Analytics/Learning Materials/R Class/GetCleanData")

# Creating a new file directory
if(!file.exists("Data")){
  dir.create("Data")
}

# Downloading a new file
# We copy the link address that we want to download
fileurl <- "https://data.baltimorecity.gov/api/views/3i3v-ibrt/rows.csv?accessType=DOWNLOAD"

# Use this funciton to download data
# On Macs, need to set method="curl"
download.file(fileurl,destfile="./Data/arrests.csv")

# Mark the downloaded date
dateDownloaded <- date()

# READING LOCAL FILES

# read.table() is the best way to read data into R, but it's a little slow (not the best for large datasets)
arrestData <- read.table("./Data/arrests.csv", sep=",",header=TRUE,fill=TRUE)

# read.csv() automatically sets sep="," and header=TRUE

# READING EXCEL FILES
install.packages("xlsx")
install.packages("rJava")
library(rJava)
library(xlsx)
arrestDataxlsx <- read.xlsx("./Data/arrests.csv", sep=",",header=TRUE,fill=TRUE)

# READING XLM (extensible markup language)
install.packages("XML")
library(XML)
doc<-xmlTreeParse(url,useInternal=TRUE)

url<-"http://espn.go.com/nfl/team/_/name/sf/san-francisco-49ers"
doc<-htmlTreeParse(url,useInternal=TRUE)
scores<-xpathSApply(doc,"//li[@class='score']",xmlValue)
teams<-xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

# READING JSON FILES (Javascript Object Notation)
# we can use toJOSON() and fromJSON() commands to write and read JSON files

# data.table PACKAGE
# data.table is better than dataframe
tables()




