retail_prices<-read.csv(file.choose())
names(retail_prices)
levels(factor(retail_prices$Commodity))

Onion_Prices <- retail_prices[retail_prices$Commodity=='Onion','Price.per.Kg']
Rice_Prices <-  retail_prices[retail_prices$Commodity=='Rice','Price.per.Kg']

avg_onion_price= mean(Onion_Prices)
sd_onion_price=sd(Onion_Prices)
avg_rice_price=mean(Rice_Prices)
sd_rice_price=sd(Rice_Prices)

#Data Peperation
onion<- data.frame(Price=Onion_Prices)
onion$Commodity<-'Onion'
rice<- data.frame(Price=Rice_Prices)
rice$Commodity<-'Rice'
hist_data<-rbind(onion,rice)

#as sample sizes > 30 no need check normality
#f-test

res.ftest <- var.test(Price ~ Commodity,data = hist_data)
res.ftest

#Using Unpaired Two sample t-test
t.test(Onion_Prices, Rice_Prices, alternative = "two.sided", var.equal = FALSE)
qqplot()