hipiness_data<-read.csv(file.choose())
names(hapiness_data)


#shapiro-wilk Normality Test
shapiro.test(hapiness_data$Generosity)
shapiro.test(hapiness_data$Health_life_expectancy)


kend_cor<-cor.test(hapiness_data$Generosity,hapiness_data$Health_life_expectancy,method = "kendall")
spear_cor<-cor.test(hapiness_data$Generosity,hapiness_data$Health_life_expectancy,method = "spearman")
pearson_cor<-cor.test(hapiness_data$Generosity,hapiness_data$Health_life_expectancy,method = "pearson")
