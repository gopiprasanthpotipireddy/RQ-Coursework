library(tidyverse)
covid_data<- read.csv("1_county_level_confirmed_cases.csv")
colnames(covid_data)
names(covid_data)
summary(covid_data)
pdf("visualization.pdf")
#Preperation of Data for Bar Graph
' Data is available at county level
  Creating data at state levelby summation'
state_level_deaths=aggregate(list(Deaths=covid_data$deaths,Confirmed=covid_data$confirmed),by=list(State=covid_data$state),FUN= sum,na.rm=TRUE, na.action=NULL)
state_level_deaths$Survived<-state_level_deaths$Confirmed-state_level_deaths$Deaths
state_level_deaths$Deaths_Per_100000<- state_level_deaths$Deaths*100000/state_level_deaths$Confirmed
state_level_deaths$Survived_Per_100000<-state_level_deaths$Survived*100000/state_level_deaths$Confirmed
state_level_deaths$Deaths_Percentage<- state_level_deaths$Deaths*100/state_level_deaths$Confirmed
state_level_deaths$Survived_Percentage<-state_level_deaths$Survived*100/state_level_deaths$Confirmed

#State wise covid deaths percentage
barplot(t(as.matrix(state_level_deaths[,c('Survived_Percentage','Deaths_Percentage')])),
        names=state_level_deaths$State,
        col=c("Green","Red"),legend = TRUE,ylab="Count",
        main="Covid Deaths and Survived Percentage",las=2,
        args.legend = list(bty = "n", x = "topright", ncol = 1,ins=-0.1))
#State wise covid deaths per 100000 confirmed cases
barplot(t(as.matrix(state_level_deaths[,c('Survived_Per_100000','Deaths_Per_100000')])),
        names=state_level_deaths$State,col=c("Green","Red"),legend = TRUE,ylab="Count",
        main="Covid Deaths and Survived Per 100000 Cases",las=2,
        args.legend = list(bty = "n", x = "topright", ncol = 1,ins=-0.1),
        yaxp=c(0,100000,100) )

"color coding based on quantile values
  if value< 25 quantile
    green
  else if value < 50 quantile
    yellow 
  else if value < 75 quantile
    orange
  else 
  red
  "
quantiles<-quantile(state_level_deaths$Deaths_Per_100000)
set.seed(1)     
cols <- ifelse(state_level_deaths$Deaths_Per_100000<quantiles[2], "green", 
               ifelse(state_level_deaths$Deaths_Per_100000<quantiles[3], "yellow",
                     ifelse(state_level_deaths$Deaths_Per_100000<quantiles[4], "orange", "red")))

#State wise covid deaths for 100000 Cases
barplot(state_level_deaths$Deaths_Per_100000,names=state_level_deaths$State,col=cols, 
        main="Deaths Per 100000 Cases in USA", ylab="Deaths Per 100000",las=2,legend=TRUE)
legend(x = "topright", legend = c('Q-1','Q-2','Q-3','Q-4'), fill = c("Green","Yellow","Orange","Red"),
       bty = "n")

dev.off()

