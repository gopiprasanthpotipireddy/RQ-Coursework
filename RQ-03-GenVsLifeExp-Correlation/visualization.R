library(tidyverse)
pdf("visualization.pdf")

hapiness_data<-read.csv("World-Happiness-2015-2019.csv")
names(hapiness_data)
summary(hapiness_data)
generosity<-hapiness_data$Generosity
life_expectancy<-hapiness_data$Health_life_expectancy

#scatter plot between Generosity Score vs Life Expectancy
plot(hapiness_data$Generosity,hapiness_data$Health_life_expectancy, main= "Generosity vs Life Expectancy", xlab="Generosity",ylab="Life Expectancy",pch=19, frame=T)
model<-lm(Generosity~Health_life_expectancy, data=hapiness_data)
abline(model,col="blue")

genMean<-mean(hapiness_data$Generosity,na.rm=TRUE)
genSD<-sd(hapiness_data$Generosity,na.rm=TRUE)
lifeExpMean<-mean(hapiness_data$Health_life_expectancy,na.rm=TRUE)
lifeExpSD<-sd(hapiness_data$Health_life_expectancy,na.rm=TRUE)

#histogram of life expectancy 
hist(hapiness_data$Health_life_expectancy, freq=F, main ="Distribution of Health_life_expectancy", xlab="Health_life_expectancy", ylab="Frequency Density of Health_life_expectancy")
lines(seq(1, 5, by=.1), dnorm(seq(1, 5, by=.1), lifeExpMean, lifeExpSD), col="blue")


#quantile-quantile plots for better understanding of normality of data
ggplot(hapiness_data, aes(sample = Health_life_expectancy),ylab = "Health_life_expectancy Score") + 
  labs(title="Q-Q Plot for Health_life_expectancy",y="Health_life_expectancy")+
  stat_qq()+
  stat_qq_line()
dev.off()
