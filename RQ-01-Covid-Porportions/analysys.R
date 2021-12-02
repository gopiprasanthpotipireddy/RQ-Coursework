library(tidyverse)
covid_data<- read.csv("1_county_level_confirmed_cases.csv")
colnames(covid_data)
names(covid_data)
summary(covid_data)

' Data is available at county level
  Creating data at state levelby summation'

state_level_deaths=aggregate(list(Deaths=covid_data$deaths,Confirmed=covid_data$confirmed),by=list(State=covid_data$state),FUN= sum,na.rm=TRUE, na.action=NULL)
state_level_deaths$Survived<-state_level_deaths$Confirmed-state_level_deaths$Deaths
state_level_deaths$Deaths_Per_100000<- state_level_deaths$Deaths*100000/state_level_deaths$Confirmed
state_level_deaths$Survived_Per_100000<-state_level_deaths$Survived*100000/state_level_deaths$Confirmed
state_level_deaths$Deaths_Percentage<- state_level_deaths$Deaths*100/state_level_deaths$Confirmed
state_level_deaths$Survived_Percentage<-state_level_deaths$Survived*100/state_level_deaths$Confirmed

population<-rep(100000,52)

#Two sided Z-test
prop.test(state_level_deaths$Deaths_Per_100000,population,p = NULL,alternative = "two.sided",correct = TRUE)



