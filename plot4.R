library(lubridate)
library(dplyr)

url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile = "epc.zip")
unzip("epc.zip")
min_i<-min(grep("\\b1/2/2007\\b", readLines("household_power_consumption.txt")))
max_i<-max(grep("\\b2/2/2007\\b", readLines("household_power_consumption.txt")))

data<-read.table("household_power_consumption.txt",skip=min_i-1,nrows=max_i-min_i, sep = ";", na.strings = "?")

headers<-read.table("household_power_consumption.txt", nrows = 1, sep = ";", header = TRUE)
names(data)<-names(headers)

data<- data %>%
        mutate(dateTime=paste(Date, " ", Time)) %>%
        mutate(dateTime=dmy_hms(dateTime))

png("plot4.png")
par(mfrow= c(2,2), mar=c(5,4,4,1))
#1
plot(data$dateTime, data$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
#2
plot(data$dateTime,data$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")
#3
plot(data$dateTime, data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(data$dateTime, data$Sub_metering_2, col= "red")
lines(data$dateTime, data$Sub_metering_3, col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty = "n" )
#4
plot(data$dateTime, data$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

dev.off()
