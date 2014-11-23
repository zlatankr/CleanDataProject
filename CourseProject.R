setwd("~/Analytics/Learning Materials/R Class/GetCleanData")

# save the URL

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download the Zip file

download.file(fileurl,"C:/Users/zlatan.kremonic/Downloads/getdata-projectfiles-UCI HAR Dataset.zip")

# unzip the file

unzip("C:/Users/zlatan.kremonic/Downloads/getdata-projectfiles-UCI HAR Dataset.zip")

# read the files

testX <- read.table("./UCI HAR Dataset/test/X_test.txt", sep="",header=FALSE,blank.lines.skip=TRUE)
testY <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep="",header=FALSE,blank.lines.skip=TRUE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep="",header=FALSE,blank.lines.skip=TRUE)

trainX <- read.table("./UCI HAR Dataset/train/X_train.txt", sep="",header=FALSE,blank.lines.skip=TRUE)
trainY <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep="",header=FALSE,blank.lines.skip=TRUE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep="",header=FALSE,blank.lines.skip=TRUE)

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", sep="",header=FALSE,blank.lines.skip=TRUE)

features <- read.table("./UCI HAR Dataset/features.txt", sep="",header=FALSE,blank.lines.skip=TRUE)

# properly name the X datasets:
unique(features$V2)
featurenames <- features$V2

colnames(testX) <- featurenames
colnames(trainX) <- featurenames
colnames(subject_test) <- "Subjects"
colnames(subject_train) <- "Subjects"

# keep only mean and standard deviation columns:

testX2 <- testX[,grep("mean\\(\\)|std\\(\\)",colnames(testX))]
trainX2 <- trainX[,grep("mean\\(\\)|std\\(\\)",colnames(trainX))]

# merge the X and Y datasets

test <- cbind("Group"="Test",subject_test,testY,testX2)

train <- cbind("Group"="Train",subject_train,trainY,trainX2)

# merge the test and train datasets together

combined <- rbind(test,train)

# clean up the names of Activity Labels column before merging activity label data

colnames(combined)[3] <- "Act_ID"

colnames(activity_labels)[2] <- "Activity"
colnames(activity_labels)[1] <- "Act_ID"

combined2 <- merge(activity_labels,combined,by.x="Act_ID",by.y="Act_ID",all=TRUE)

dcast(combined2, Subjects+Activity~variable,mean)

names(combined2)
vars <- colnames(combined2[,5:70])

library(reshape2)

stack <- melt(combined2,id=c("Subjects","Activity"), measure.vars=c(vars) )

tidy <- dcast(stack, Subjects + Activity ~ variable, mean)

write.table(tidy, file="Final_Tidy.txt", row.names=FALSE)















