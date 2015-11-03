means <- data.frame(matrix(nrow=length(storedata$Store), ncol=3))
for (i in 1:length(storedata$Store)) {
     numbers <- newtrain[which(as.integer(newtrain$Store) == storedata$Store[i]),]$Customers
     if (length(numbers[which(numbers == 0)]) > 0) {numbers <- numbers[-which(numbers == 0)]}
     else {}
     means[i,] <- c(storedata$Store[i], 
                    mean(numbers, na.rm = TRUE),
                    sqrt(var(numbers)))
}

colnames(means) <- c("Store", "MeanCust", "SDCust")
summary(means)
plot(means$MeanCust)

means <- means[order(means$MeanCust),]
means$Tier <- rep(1, length(means$Store))

means[1:(length(means$Store)/5)-1,]$Tier <- 5
means[(length(means$Store)/5):(length(means$Store)*2/5)-1,]$Tier <- 4
means[(length(means$Store)*2/5):(length(means$Store)*3/5)-1,]$Tier <- 3
means[(length(means$Store)*3/5):(length(means$Store)*4/5)-1,]$Tier <- 2
means[(length(means$Store)*4/5):(length(means$Store)),]$Tier <- 1

newtrain <- merge(newtrain, means, by="Store", all=TRUE)