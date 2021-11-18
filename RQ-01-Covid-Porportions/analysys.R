covid_data<- read.csv(file.choose())
colnames(covid_data)
names(covid_data)
summary(covid_data)

#Data deaths per 100000 is available for counties so taking the average of counties as the state proportion
state_death_proportions=aggregate(x=covid_data$deaths_per_100000,by=list(covid_data$state),FUN= mean,na.rm=TRUE, na.action=NULL)
#Populations n=100000 is same for all the states 
state_populations<-rep(100000,52)

prop.test(state_death_proportions$x,state_populations,alternative = "two.sided")


#Linear trend of proportions
prop.trend.test(state_death_proportions$x,state_populations)

