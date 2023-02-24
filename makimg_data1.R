library(tidyverse)
library(ggplot2)
library(data.table)
library(MASS)
library(clipr)
# シードの設定
set.seed(1234)

#平均ベクトル
mu0<-c(40,10,600)
# 各変数の標準偏差の設定
s1<-7
s2<-1.5
s3<-150
#分散共分散行列の設定
sigma0<-rbind(
  c(s1*s1,0.95*s1*s2,0.95*s1*s3),
  c(0.95*s1*s2,s2*s2,0.80*s2*s3),
  c(0.95*s1*s3,0.80*s2*s3,s3*s3)
)

#多次元正規分布乱数の発生
out<-mvrnorm(1000,mu0,sigma0)
# カラム名の設定
colnames(out)<-c("age","time","salary")
# 型の変更
out<-as.data.frame(out)
# 桁数の調整
out$age <- as.integer(out$age)
out$time<- round(out$time, digits = 2)
out$salary<-round(out$salary,digits=2)
# データの確認
summary(out)
pairs(out)
# 作成データの出力
fwrite(out,'runtime_salary.csv')
