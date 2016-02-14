# Exploratory_Data_Analysis
# OUTPUT
> setwd("~/Downloads/coursera/exploratory_ansalysis/")
> data<-read.table("household_power_consumption.txt",header = T,sep = ";")
> head(data)
        Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1
1 16/12/2006 17:24:00               4.216                 0.418 234.840           18.400          0.000
2 16/12/2006 17:25:00               5.360                 0.436 233.630           23.000          0.000
3 16/12/2006 17:26:00               5.374                 0.498 233.290           23.000          0.000
4 16/12/2006 17:27:00               5.388                 0.502 233.740           23.000          0.000
5 16/12/2006 17:28:00               3.666                 0.528 235.680           15.800          0.000
6 16/12/2006 17:29:00               3.520                 0.522 235.020           15.000          0.000
  Sub_metering_2 Sub_metering_3
1          1.000             17
2          1.000             16
3          2.000             17
4          1.000             17
5          1.000             17
6          2.000             17
> datadate<-as.Date(data$Date,"%d/%m/%Y")
> data2<-subset(data,datadate>"2007-01-31"& datadate<"2007-02-03")
> global_active_power<-as.numeric(as.character(data2$Global_active_power))
> png(file="plot1.png",width=480,height=480)
> hist(global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power",cex.lab=0.9,cex.main=0.8,cex.axis=0.8)
> dev.off()
png 
  4 
> datetimetest<-paste(data2$Date, as.character(data2$Time))
> datetime<-strptime(as.character(datetimetest), "%d/%m/%Y %H:%M:%S")
> png(file="plot2.png",width=480,height=480)
> plot(datetime,global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="") 
> dev.off()
png 
  4 
> submetering1<-as.numeric(as.character(data2$Sub_metering_1))
> submetering2<-as.numeric(as.character(data2$Sub_metering_2))
> submetering3<-as.numeric(as.character(data2$Sub_metering_3))
> png(file="plot3.png",width=480,height=480)
> plot(datetime,submetering1,col="black",type="l",ylab="Energy submetering", xlab="")
> lines(datetime,submetering2,col="red")
> lines(datetime,submetering3,col="blue")
> legend("topright",lty = c(1,1,1),col=c("black","red","blue"),legend=c("sub_metering_1", "sub_metering_2","sub_metering_3")) 
> dev.off()
png 
  4 
> Voltage<-as.numeric(as.character(data2$Voltage))
> Global_reactive_power<-as.numeric(as.character(data2$Global_reactive_power))
> png(file="plot4.png",width=480,height=480)
> par(mfrow=c(2,2))
> plot(datetime,global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")
> plot(datetime,Voltage,type="l")
> plot(datetime,submetering1,col="black",type="l",ylab="Energy sub metering", xlab="")
> lines(datetime,submetering2,col="red")
> lines(datetime,submetering3,col="blue")
> legend("topright",lty = c(1,1,1),col=c("black","red","blue"),legend=c("sub_metering_1", "sub_metering_2","sub_metering_3"))
> plot(datetime,Global_reactive_power,type = "l") 
> dev.off()
png 
  4
