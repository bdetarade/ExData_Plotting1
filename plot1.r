library(lubridate)

ds <- read.csv("household_power_consumption.txt", sep=";")

ds2 <- ds[ds$Date == "1/2/2007" | ds$Date == "2/2/2007",]
ds2$Day <- weekdays(as.Date(ds2$Date))
ds2$DateTime <- dmy_hms(paste(ds2$Date, ds2$Time))


ds2$Global_active_power <- as.numeric(ds2$Global_active_power)
ds2$Sub_metering_1 <- as.numeric(ds2$Sub_metering_1)
ds2$Sub_metering_2 <- as.numeric(ds2$Sub_metering_2)
ds2$Sub_metering_3 <- as.numeric(ds2$Sub_metering_3)
ds2$Voltage <- as.numeric(ds2$Voltage)

par(mfrow = c(1,1))

hist(ds2$Global_active_power / 1000, freq = TRUE, col="red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

