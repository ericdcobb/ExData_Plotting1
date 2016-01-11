#Download and unzip the file
message("downloading and unzipping file")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, method = "curl", destfile = "./consumption.zip")
unzip("./consumption.zip")

#Load the data get just the target days.
data <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, stringsAsFactors = FALSE,na.strings = c("?"))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
targetDates <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]
targetDates$DateTime <-as.POSIXct(paste(targetDates$Date, targetDates$Time), format="%Y-%m-%d %H:%M:%S")

##Make the graph
png(filename="./plot4.png", width = 480, height = 480)

par(mfrow= c(2,2))

plot(targetDates$DateTime, targetDates$Global_active_power, type = "l", ylab = "Global Active Power (Kilowatts)")

plot(targetDates$DateTime, targetDates$Voltage, type = "l", ylab = "Voltage", xlab ="datetime")

plot(targetDates$DateTime, targetDates$Sub_metering_1, type = "l")
lines(targetDates$DateTime, targetDates$Sub_metering_2, type = "l", col="red")
lines(targetDates$DateTime, targetDates$Sub_metering_3, type = "l", col="blue")

legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=.4)

plot(targetDates$DateTime, targetDates$Global_reactive_power, type = "l", xlab ="datetime", ylab= "Global_reactive_power")

dev.off()

