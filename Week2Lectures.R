setwd("C:/Users/zlatan.kremonic/Documents/Analytics/Learning\ Materials/R\ Class/GetCleanData")

# To get going with MySQL, need to follow these instuctions: http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/
# need to follow all the steps, and then: Copy libmysql.dll from ../MySQL Server 5.6/lib to ../MySQL Server 5.6/bin


install.packages("RMySQL", type = "source")
install.packages("RTools")
library(RMySQL)

# Connecting to a public database server
ucsDb<-dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")

result<-dbGetQuery(ucsDb,"show databases;"); dbDisconnect(ucsDb);

result

# Connecting to a particular database
hg19<-dbConnect(MySQL(),user="genome",db="hg19",host="genome-mysql.cse.ucsc.edu")

allTables<-dbListTables(hg19)
length(allTables)

allTables[1:5]

# Let's take a look at the different fields in a given table:
dbListFields(hg19,"HInv")

# Let's do a query:
dbGetQuery(hg19,"select count(*) from HInv")

# Store table into R:
mytable<-dbReadTable(hg19,"HInv")
head(mytable)

# Selecting a specific subset (...still need to investigate the difference b/w SendQuery and GetQuery)
query<-dbSendQuery(hg19,"select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis<-fetch(query); quantile(affyMis$misMatches)

dbClearResult(query)

# At the end, we have to close the connection to that DB!!
dbDisconnect(hg19)


## HDF5 (used for large datasets)

source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")
created
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")

#list the contents of the H5 file:
h5ls("example.h5")

# writing to groups
A = matrix(1:10,nr=5,nc=2)
h5write(A,"example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")

# writing a dataset
df = data.frame(1L:5L,seq(0,1,length.out=5),
                c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")

# reading data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf= h5read("example.h5","df")
readA

# writing a reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")

