library(sqldf)
library(lubridate)
link<-"/Users/CJYKJ/Desktop/Coursera_ExploratoryDA/household_power_consumption.txt"
Feb1<-read.csv.sql(link,sep=";",sql='select*from file where Date="1/2/2007"')
Feb2<-read.csv.sql(link,sep=";",sql='select*from file where Date="2/2/2007"')
main<-rbind(Feb1,Feb2)
main$"Date/Time"<-paste(main$Date,main$Time,sep="_")
main$"Date/Time"<-dmy_hms(main$"Date/Time")
main<-main[,-1:-2]
main<-main[,c(8,1:7)]

## Third plot
with(main,plot(main$"Date/Time",main[,6],main="",type='n',xlab="",ylab="energy sub metering"))
legend("topright",pch="",lwd="1",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6)
with(main,lines(main$"Date/Time",main$"Sub_metering_1",col="black"))
with(main,lines(main$"Date/Time",main$"Sub_metering_2",col="red"))
with(main,lines(main$"Date/Time",main$"Sub_metering_3",col="blue"))
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()
