
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
ds2$DateTime <- as.POSIXct(paste(ds2$Date, ds2$Time))


ds2$Global_active_power <- as.numeric(ds2$Global_active_power)
ds2$Sub_metering_1 <- as.numeric(ds2$Sub_metering_1)
ds2$Sub_metering_2 <- as.numeric(ds2$Sub_metering_2)
ds2$Sub_metering_3 <- as.numeric(ds2$Sub_metering_3)
ds2$Voltage <- as.numeric(ds2$Voltage)

par(mfrow = c(1,1))


plot( ds2$Global_active_power ~ ds2$DateTime, type = "o", pch = NA, ann=FALSE)
title(ylab="Global Active Power (kilowatts)" )
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()


