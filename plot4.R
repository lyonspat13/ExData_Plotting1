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



### Code to Create Plot 4 ###

dateTime <- c(data$dateTime,data$dateTime,data$dateTime)
subValue <- c(data$Sub_metering_1,data$Sub_metering_2,data$Sub_metering_3)
subText <- c(rep("Sub_metering_1",2880),rep("Sub_metering_2",2880),rep("Sub_metering_3",2880))
newdata <- data.frame(dateTime,subValue,subText)

par(mfrow = c(2,2))
with(data, plot(dateTime,Global_active_power, ylab = "Global Active Power (kilowatts)", xlab="", type="l" ))
with(data, plot(dateTime,Voltage, ylab = "Voltage", xlab="", type="l" ))
with(newdata, plot(dateTime, subValue, type = "n", ylab = "Energy sub metering"))
with(subset(newdata, subText == "Sub_metering_1"), lines(dateTime, subValue, col = "black"))
with(subset(newdata, subText == "Sub_metering_2"), lines(dateTime, subValue, col = "red"))
with(subset(newdata, subText == "Sub_metering_3"), lines(dateTime, subValue, col = "blue"))
legend("topright", lty = 1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), cex = .2)
with(data, plot(dateTime,Global_reactive_power, ylab = "Global Reactive Power (kilowatts)", xlab="", type="l" ))

dev.copy(png, file = "plot4.png")
dev.off()


### End Code to Create Plot 4 ###
