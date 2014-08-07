library(sqldf)
library(lubridate)
link<-file.path(getwd(),"household_power_consumption.txt")
Feb1<-read.csv.sql(link,sep=";",sql='select*from file where Date="1/2/2007"')
Feb2<-read.csv.sql(link,sep=";",sql='select*from file where Date="2/2/2007"')
main<-rbind(Feb1,Feb2)
main$"Date/Time"<-paste(main$Date,main$Time,sep="_")
main$"Date/Time"<-dmy_hms(main$"Date/Time")
main<-main[,-1:-2]
main<-main[,c(8,1:7)]

## first plot
par(mfrow=c(1,1))
hist(main[,2],main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red",cex.lab=0.8,cex.main=0.9,cex.axis=0.8)
dev.copy(png,file="plot1.png",width=480, height=480)
dev.off()