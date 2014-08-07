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

## Second Plot. First create the shell
par(mfrow=c(1,1))
with(main,plot(main$"Date/Time",main$"Global_active_power",type='n',xlab="",ylab="Global Active Power (kilowatts)",cex.lab=0.77,cex.axis=0.77))
## Now we create the insides.
with(main,lines(main$"Date/Time",main$"Global_active_power",col="black"))
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
