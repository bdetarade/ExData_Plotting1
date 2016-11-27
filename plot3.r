
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

par(mfrow = c(1,1))




plot( x= ds2$DateTime, y=ds2$Sub_metering_1, type = "o", pch = NA, axes=FALSE, ann=FALSE)
lines(x= ds2$DateTime, y= ds2$Sub_metering_2, type = "o", pch = NA, col="red")
lines(x= ds2$DateTime, y=ds2$Sub_metering_3, type = "o", pch = NA, col="blue")
axis(1, at=c(ymd_hms("2007-02-01 00:00:00"),ymd_hms("2007-02-02 00:00:00"),ymd_hms("2007-02-02 23:59:00")), lab=c("Thu", "Fri", "Sat"))
axis(2, lab=c(0,10,20,30), at=c(2,10,20,30))
title(ylab="Energy sub metering" )
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1 )
box()
dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()





