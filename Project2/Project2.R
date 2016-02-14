# This R script assumes that you are in the working directory containing the uncompressed RDS files


#PLOT1
#reading in data
NEI<-readRDS("summarySCC_PM25.rds")#reading in data
Scc<-readRDS("Source_Classification_Code.rds")
Total_NEI<-tapply(NEI$Emissions,INDEX=NEI$year,sum)# sum of emissions per year
barplot(Total_NEI,xlab = "Years",ylab = "Emissions",main = "Toatal Emissions by Year(tons)")#Creating plot on screen device
dev.copy(png,file="plot1.png")#coping plot to png file
dev.off()


#PLOT2
#reading in data
NEI<-readRDS("summarySCC_PM25.rds")#reading in data
Scc<-readRDS("Source_Classification_Code.rds")
Baltimore<-subset(NEI,fips=="24510")# Subsetting Baltinore County data
Total_Baltimore<-tapply(Baltimore$Emissions,INDEX = Baltimore$year,sum)#summing up emissions for Baltimore by year
barplot(Total_Baltimore,xlab = "Years",ylab = "Emissions",main = "Total Emissions for Baltimore by year(tons)")# Creating a barplot for Baltimore emissions
dev.copy(png,file="plot2.png")#copying the plot to png
dev.off()

#PLOT3
library(ggplot2)# loading ggplot2
#reading in data
NEI<-readRDS("summarySCC_PM25.rds")#reading in data
Scc<-readRDS("Source_Classification_Code.rds")
Baltimore<-subset(NEI,fips=="24510")# Subsetting Baltimore County data 
ggplot(data = Baltimore,aes(x=year,y=Emissions,fill=type))+geom_bar(stat = "identity",position = "dodge")+ggtitle("Baltimore Emissions by Type from 1999-2008")#Creating barplot for Baltimore by type
dev.copy(png,file="plot3.png")
dev.off()

#PLOT4
NEI<-readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
x1<-unique(grep("coal",SCC$EI.Sector,ignore.case=TRUE,value=TRUE))# Isolating instances of coal
data_x<-subset(SCC,EI.Sector%in%x1)#subsetting SCC by coal labels
Coal<-subset(NEI,SCC%in%data_x$SCC)#subsettinh NEI by data_x overlaps
ggplot(data = Coal,aes(x=year,y=Emissions,fill=type))+geom_bar(stat = "identity",position = position_dodge())+ggtitle("Coal Emissions in United States from1999-2008")# creating plot
dev.copy(png,file="plot4.png")# copying plot to png
dev.off()


#PLOT5
x2<-unique(grep("mobile",SCC$EI.Sector,ignore.case=TRUE,value=TRUE))# isolating instances of mobile
gasheavy<-subset(SCC,EI.Sector%in%x2[1])# subsetting SCC by vehicle type
gaslight<-subset(SCC,EI.Sector%in%x2[2])
diselheavy<-subset(SCC,EI.Sector%in%x2[3])
disellight<-subset(SCC,EI.Sector%in%x2[4])

gas_heavy<-subset(Baltimore,SCC%in%gasheavy$SCC)# subsetting Baltimore by SCC retaining vehicle type
gas_light<-subset(Baltimore,SCC%in%gaslight$SCC)
disel_heavy<-subset(Baltimore,SCC%in%diselheavy$SCC)
disel_light<-subset(Baltimore,SCC%in%disellight$SCC)

car1<-data.frame(gas_heavy,vehicle="Gas-Heavy Duty")# creating data frame for vehicle type
car2<-data.frame(gas_light,vehicle="Gas-Light Duty")
car3<-data.frame(disel_heavy,vehicle="Disel-Heavy Duty")
car4<-data.frame(disel_light,vehicle="Disel-Light Duty")

cars<-rbind(car1,car2,car3,car4)

ggplot(data = cars,aes(x=year,y=Emissions,fill=vehicle))+geom_bar(stat = "identity",position = position_dodge())+ggtitle("Motor Vehicle related Emissions for Baltimore from 1999-2008")#plotting the graph
dev.copy(png,file="plot5.png")
dev.off
dev.off()


#PLOT6
LA<-subset(NEI,NEI$fips=="06037")
LAgas_heavy<-subset(LA,SCC%in%gasheavy$SCC)# subsetting LA BY SCC retaining vehicle type
LAgas_light<-subset(LA,SCC%in%gaslight$SCC)
LAdisel_heavy<-subset(LA,SCC%in%diselheavy$SCC)
LAdisel_light<-subset(LA,SCC%in%disellight$SCC)
car1_LA<-data.frame(LAgas_heavy,vehicle="Gas-Heavy Duty")
car2_LA<-data.frame(LAgas_light,vehicle="Gas-Light Duty")
car3_LA<-data.frame(LAdisel_heavy,vehicle="Disel-Heavy Duty")
car4_LA<-data.frame(LAdisel_light,vehicle="Disel-Light Duty")
cars_LA<-rbind(car1_LA,car2_LA,car3_LA,car4_LA)
carsall<-rbind(cars,car1_LA,car2_LA,car3_LA,car4_LA)
carsall$fip<-gsub("24510","Baltimore",carsall$fips)
carsall$fip<-gsub("06037","Los Angeles",carsall$fips)
ggplot(data = carsall,aes(x=year,y=Emissions,fill=vehicle))+facet_grid(.~fips)+geom_bar(stat = "identity",position = position_dodge())+ggtitle("Motor Vehicle Emissions for Baltimore and Los Angeles")
dev.copy(png,file="plot6.png")
dev.off()