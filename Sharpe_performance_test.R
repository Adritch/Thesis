setwd("C:/Users/AdrianMoeller/Downloads/SharpeR/SharpeR")

load("Sharpe.RData")

library(readxl)
R_2021 <- read_excel("C:/Users/AdrianMoeller/Dropbox/Uni/Speciale/R_2021.xlsx")
View(R_2021_Copy)



#blockpars = [63, 126, 189, 252];


strats = list(4, 5 , 6 ,7 ,3)


# 2015: :5033
# 2021: :6542

for (i in strats) {
  
  ret <- data.matrix(R_2021[c(1:5033),c(i,2)]) #
  b = 252
  M = 1000
  
  res <- boot.time.inference(ret, b, M)
  
  print(i)
  print(res[1])
  print(res[2])
  
}



strats = list(4, 5 , 6 ,7 ,3)


strats <- seq(9, 56, by=1)


# 2015: :5033
# 2021: :6542

for (i in strats) {
  
  ret <- data.matrix(R_2021[c(1:5033),c(i,8)]) #
  b = 252
  M = 1000
  
  res <- boot.time.inference(ret, b, M)
  
  print(i)
  print(res[1])
  print(res[2])
  
}