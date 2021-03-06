### First we have the code for loading the data, which is the same for all plots ###

object.size(c(1)) * 2075259 * 9 / (10 ^9)  ## roughly estimates full data size in gb, says 'bytes'

data<- read.table("household_power_consumption.txt",header = TRUE, sep=";")  ## reads in full data set
data$dateTime <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S" ) ## creates new column and converts to POSIXlt
data <- subset(data, dateTime > as.POSIXlt("2007-01-31 23:59:59")) ## removes days that are too early
data <- subset(data, dateTime < as.POSIXlt("2007-02-03 00:00:00")) ## removes days that are too late
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

### End Code for loading the data ###


### Code to Create Plot 2 ###

with(data, plot(dateTime,Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="l" ))
dev.copy(png, file = "plot2.png")
dev.off()


### End Code to Create Plot 2 ###


