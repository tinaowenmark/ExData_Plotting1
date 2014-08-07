

setwd("~/Documents/Coursera/ExplorData2/ExData_Plotting1")

# Download the file and read it in
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename <- "household.zip"

if(!file.exists("household")) {
  download.file(url, filename, method="curl")

  file <- unzip("household.zip", exdir = "household")
}
expname <- list.files("household")[1]
setwd("~/Documents/Coursera/ExplorData2/ExData_Plotting1/household")
rawdata <- read.table(file = expname, header = T, sep = ";", na.strings = "?")

# Fix the date and time columns, subset to get only the dates we want (02/01/2007 and 02/02/2007)
rawdata$DateTime <- paste(rawdata$Date, rawdata$Time, sep=" ")
rawdata$DateTime <- strptime(rawdata$DateTime, format = "%d/%m/%Y %H:%M:%S", tz = "GMT")
rawdata$Date <- as.Date(rawdata$Date, format = "%d/%m/%Y")

v <- grep(pattern = "2007-02-0[12]", x = rawdata$Date)
data <- rawdata[v,]

# Test plotting the fourth graph

par(mfrow = c(2,2))

#1st row, first column
plot(data$DateTime, data$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab = "", main = "")

#1st row, second column
plot(data$DateTime, data$Voltage, type="l")

#2nd row, first column
plot(data$DateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", main = "")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col= "blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd = c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))

#2nd row, second column
plot(data$DateTime, data$Global_reactive_power, type = "l")

par(mfrow = c(1,1))



# Construct as png

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))
plot(data$DateTime, data$Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab = "", main = "")

plot(data$DateTime, data$Voltage, type="l")

plot(data$DateTime, data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", main = "")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col= "blue")
legend(x="topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd = c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))

plot(data$DateTime, data$Global_reactive_power, type = "l")

par(mfrow = c(1,1))

dev.off()
