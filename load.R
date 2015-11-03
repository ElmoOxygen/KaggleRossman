train <- read.csv("train.csv")
test <- read.csv("test.csv")
storedata <- read.csv("store.csv")

sumna <- vector()
for (i in 1:length(names(train))) {
     sumna[i] <- sum(is.na(train[,i]))
}
cbind(names(train), sumna)
sumna <- vector()
for (i in 1:length(names(storedata))) {
     sumna[i] <- sum(is.na(storedata[,i]))
}
cbind(names(storedata), sumna)

storedata$CompetitionDistance[is.na(storedata$CompetitionDistance)] <- 
     mean(storedata$CompetitionDistance, na.rm=TRUE)
newstoredata <- storedata[,c(-10,-9,-8,-6,-5)]

newtrain <- merge(train, newstoredata, by = "Store", all=TRUE)
newtest <- merge(test, newstoredata, by = "Store", all=TRUE)

newtrain$Date <- as.character(newtrain$Date)
newtest$Date <- as.character(newtest$Date)

newtrain <- separate(newtrain, Date, c("Year", "Month", "Day"), sep="-")
newtest <- separate(newtest, Date, c("Year", "Month", "Day"), sep="-")

for (i in 1:length(names(newtrain))) {
     newtrain[,i] <- as.numeric(newtrain[,i])
}
for (i in 1:length(names(newtest))) {
     newtest[,i] <- as.numeric(newtest[,i])
}