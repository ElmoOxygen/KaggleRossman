inTrain <- which(newtrain$Year == 2015)

trainfit <- newtrain[-inTrain,]
testfit <- newtrain[-inTrain,]
