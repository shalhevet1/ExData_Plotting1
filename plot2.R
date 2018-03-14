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

png("plot2.png")
plot(data$dateTime, data$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.off()
