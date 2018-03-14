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

png("plot3.png")
plot(data$dateTime, data$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(data$dateTime, data$Sub_metering_2, col= "red")
lines(data$dateTime, data$Sub_metering_3, col= "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
