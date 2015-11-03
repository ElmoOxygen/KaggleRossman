pc <- preProcess(trainfit[,-6], method=c("pca"))
predict(pc, trainfit)

fitlm <- train(Sales~.,data=trainfit,method="lm")

rffit <- train(Sales~., data=trainfit, method="rf")

library(biglm)
glmfit <- bigglm(Sales~Open+DayOfWeek+Month+CompetitionDistance+
                      DayOfWeek+StateHoliday+Assortment+Day+MeanCust,
                 data=trainfit)
prediction <- predict(glmfit, testfit)
sum((testfit$Sales-prediction)^2)

library(bigrf)
bigrf(trainfit[,-6],as.integer(trainfit$Sales))

libary(rpart)
library(rpart.plot)
rpartfit <- train(Sales ~ Open + MeanCust + Month 
                  + Assortment + StateHoliday + Promo + DayOfWeek + Day, 
                  method=c("rpart"),
                  data=trainfit,
                  control = rpart.control(minsplit = 3,
                                          cp=0,
                                          maxdepth=10))
rpart.plot(rpartfit)

prediction <- predict(rpartfit, testfit)
cbind(testfit$Sales, prediction)
confusionMatrix(testfit$Sales, prediction)