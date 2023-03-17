setwd('/Users/umeda.yoshinao/sandbox/nikkei_software_202307')

library(tidyverse)
library(ggplot2)
library(data.table)
library(MASS)
library(clipr)
# シードの設定
set.seed(1234)

#平均ベクトル
mu0<-c(100,100)
# 各変数の標準偏差の設定
s1<-30
s2<-30
#分散共分散行列の設定
sigma0<-rbind(
  c(s1*s1,0*s1*s2),
  c(0*s1*s2,s2*s2)
)

#多次元正規分布乱数の発生
out<-as.data.frame(mvrnorm(1000,mu0,sigma0)) 

colnames(out)<-c('english','mathmatic')

out%>%filter(english+mathmatic>260)->passDf

plot(passDf)
cor(passDf)

fwrite(out,'sellectionBias.csv')
