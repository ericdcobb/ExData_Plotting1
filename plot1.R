#Download and unzip the file
message("downloading and unzipping file")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, method = "curl", destfile = "./consumption.zip")
unzip("./consumption.zip")

#Load the data get just the target days.
data <- read.table(file="household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE, stringsAsFactors = FALSE,na.strings = c("?"))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
targetDates <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]

##Make the graph
png(filename="./plot1.png", width = 480, height = 480)

hist(targetDates$Global_active_power, col = "red", xlab = "Glolbal Active Power (kilowatts)", main="Global Active Power")

dev.off()

