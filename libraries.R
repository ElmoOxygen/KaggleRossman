library(tidyr)
library(dplyr)
library(caret)

library(parallel)
library(doParallel)

no_cores <- detectCores() - 1
cl <- makeCluster(no_cores)
registerDoParallel(cl)

set.seed(4484)