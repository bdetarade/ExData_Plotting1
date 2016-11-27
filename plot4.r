
if (!require("sqldf")) {
  install.packages("sqldf")
}

if (!require("lubridate")) {
  install.packages("lubridate")
}


library(lubridate)
library(sqldf)


ds2 <- read.csv.sql("household_power_consumption.txt", 
                    sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", 
                    header = TRUE, 
                    sep = ";")

ds2$Day <- weekdays(as.Date(ds2$Date))
ds2$DateTime <- dmy_hms(paste(ds2$Date, ds2$Time))



ds2$Global_active_power <- as.numeric(ds2$Global_active_power)
ds2$Sub_metering_1 <- as.numeric(ds2$Sub_metering_1)
ds2$Sub_metering_2 <- as.numeric(ds2$Sub_metering_2)
ds2$Sub_metering_3 <- as.numeric(ds2$Sub_metering_3)
ds2$Voltage <- as.numeric(ds2$Voltage)

par(mfrow = c(2,2))


plot( x= ds2$DateTime, y=ds2$Global_active_power / 1000, type = "o", pch = NA, axes=FALSE, ann=FALSE)
axis(1, at=c(ymd_hms("2007-02-01 00:00:00"),ymd_hms("2007-02-02 00:00:00"),ymd_hms("2007-02-02 23:59:00")), lab=c("Thu", "Fri", "Sat"))
axis(2, lab=c(0,2,4,6), at=c(0,1,2,3))
box()
title(ylab="Global Active Power" )

plot(x= ds2$DateTime , y=ds2$Voltage, type = "o", pch = NA, axes=FALSE, ann=FALSE)
axis(1, at=c(ymd_hms("2007-02-01 00:00:00"),ymd_hms("2007-02-02 00:00:00"),ymd_hms("2007-02-02 23:59:00")), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(800,1000,1200,1400,1600,1800,2000,2200), lab=c("234","","238","","242","","246",""))
box()
title(ylab="Voltage" )
title(xlab="datetime" )


plot( x= ds2$DateTime, y=ds2$Sub_metering_1, type = "o", pch = NA, axes=FALSE, ann=FALSE)
lines(x= ds2$DateTime, y= ds2$Sub_metering_2, type = "o", pch = NA, col="red")
lines(x= ds2$DateTime, y=ds2$Sub_metering_3, type = "o", pch = NA, col="blue")
axis(1, at=c(ymd_hms("2007-02-01 00:00:00"),ymd_hms("2007-02-02 00:00:00"),ymd_hms("2007-02-02 23:59:00")), lab=c("Thu", "Fri", "Sat"))
axis(2, lab=c(0,10,20,30), at=c(2,10,20,30))
title(ylab="Energy sub metering" )
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1 )
box()


plot(x= ds2$DateTime , y=ds2$Global_reactive_power, type = "o", pch = NA, axes=FALSE, ann=FALSE)
axis(1, at=c(ymd_hms("2007-02-01 00:00:00"),ymd_hms("2007-02-02 00:00:00"),ymd_hms("2007-02-02 23:59:00")), lab=c("Thu", "Fri", "Sat"))
axis(2, at=c(0,50,100,150,200,250), lab=c("0.0","0.1","0.2","0.3","0.4","0.5"))
box()
title(ylab="Global_reactive_power" )
title(xlab="datetime" )

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()



