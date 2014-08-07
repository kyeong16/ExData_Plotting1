library(sqldf)
library(lubridate)
link<-file.path(getwd(),"household_power_consumption.txt")
Feb1<-read.csv.sql(link,sep=";",sql='select*from file where Date="1/2/2007"')
Feb2<-read.csv.sql(link,sep=";",sql='select*from file where Date="2/2/2007"')
main<-rbind(Feb1,Feb2)
main$"Date/Time"<-paste(main$Date,main$Time,sep="_") ## creating new column that merges date and time
main$"Date/Time"<-dmy_hms(main$"Date/Time") ## converting new column into POSIXct format
main<-main[,-1:-2] ## deleting original date and original time column
main<-main[,c(8,1:7)] ## rearranging columns

## Fourth plot
par(mfrow=c(2,2))
## First row first plot shell
with(main,plot(main$"Date/Time",main$"Global_active_power",type='n',main="",xlab="",ylab="Global Active Power",cex.lab=0.8,cex.axis=0.8))
## Now we create the insides.
with(main,lines(main$"Date/Time",main$"Global_active_power",col="black"))
##First row second plot shell
with(main,plot(main$"Date/Time",main$"Voltage",main="",type='n',xlab="datetime",ylab="Voltage",cex.lab=0.8,cex.axis=0.8))
## First row second plot insides
with(main,lines(main$"Date/Time",main$"Voltage"))
##Second row first plot shell
with(main,plot(main$"Date/Time",main$"Sub_metering_1",main="",type='n',xlab="",ylab="Energy sub metering",cex.lab=0.8,cex.axis=0.8))
legend("topright",pch="",bty="n",lwd="1",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.7,inset=0)
## Second row first plot insides.
with(main,lines(main$"Date/Time",main$"Sub_metering_1",col="black"))
with(main,lines(main$"Date/Time",main$"Sub_metering_2",col="red"))
with(main,lines(main$"Date/Time",main$"Sub_metering_3",col="blue"))
## Second row second plot shell
with(main,plot(main$"Date/Time",main$"Global_reactive_power",main="",type='n',xlab="datetime",ylab="Global_reactive_power",cex.lab=0.8,cex.axis=0.8))
## Second row second plot insides
with(main,lines(main$"Date/Time",main$"Global_reactive_power"))
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()


