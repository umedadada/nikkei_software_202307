library(tidyverse)
library(ggplot2)
library(data.table)
library(MASS)
library(clipr)
# シードの設定
set.seed(1234)
# 年齢変数の生成
age0<-as.integer(rnorm(1000,35,4))
age1<-as.integer(rnorm(1000,50,6))
# 誤差項の生成
e0<-rnorm(length(age0),0,50)
e1<-rnorm(length(age1),0,50)

beta1<-20
beta0<-100

y0<-round(beta1*age0+beta0+e0,2)

beta1<-20
beta0<-0

y1<-round(beta1*age1+beta0+e1,2)

data0<-cbind(age0,y0)
data1<-cbind(age1,y1)

data0<-as.data.frame(data0)
data0$company<-"Corp.Money"
data1<-as.data.frame(data1)
data1$company<-"Ltd.Forward"

colnames(data0)<-c("age","salary","company")
colnames(data1)<-c("age","salary","company")

data<-rbind(data0,data1)
bar_data <- data %>% group_by(company) %>% summarise(mean(salary))

g <- ggplot(bar_data, aes(x = bar_data$company, y = bar_data$`mean(salary)`, fill = company))
g <- g + geom_bar(stat = "identity")
plot(g)

g <- ggplot(data, aes(x = age, y = salary,color=company))
g <- g + geom_point()
g <- g + geom_smooth(method = "lm")
plot(g)

fwrite(data,'./data/company_salary.csv')
