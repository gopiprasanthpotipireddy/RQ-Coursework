library(tidyverse)
pdf("visualization.pdf")
retail_prices<-read.csv("India_Key_Commodities_Retail_Prices_1997_2015.csv")
names(retail_prices)
levels(factor(retail_prices$Commodity))

#Stats for Commodities
avg_onion_price= mean(Onion_Prices)
sd_onion_price=sd(Onion_Prices)
avg_rice_price=mean(Rice_Prices)
sd_rice_price=sd(Rice_Prices)

#Data Peperation for Box Plot
Onion_Prices <- retail_prices[retail_prices$Commodity=='Onion','Price.per.Kg']
Rice_Prices <-  retail_prices[retail_prices$Commodity=='Rice','Price.per.Kg']
box_plot_data<- retail_prices[retail_prices$Commodity=='Onion'|retail_prices$Commodity=='Rice',c('Commodity','Price.per.Kg')]
#Boxplot for Prices of Onion and Rice
boxplot(Price.per.Kg~Commodity,data =box_plot_data,main='Price for Each Commodity')

#Data Peperation for historgram
onion<- data.frame(Price=Onion_Prices)
onion$Commodity<-'Onion'
rice<- data.frame(Price=Rice_Prices)
rice$Commodity<-'Rice'
hist_data<-rbind(onion,rice)

#historgram of both onion and rice prices on same graph
ggplot(hist_data, aes(Price, fill = Commodity)) + 
  geom_histogram(alpha = 0.5, aes(y = ..density..), position = 'identity')

dev.off()
