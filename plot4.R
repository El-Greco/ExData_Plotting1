## Plotting Assignment 1 for Exploratory Data Analysis on Coursera
##
## Code for generating plot4.png
##
## In order for the code to work we need to download and extract the
## dataset on electric power consumption so that the 
## "household_power_consumption.txt" file is in our working directory.

## First, we load the dataset into R.
hpc <- read.table("./household_power_consumption.txt", header=T, sep=";",
 na.strings="?", stringsAsFactors=F)

## We then load packages lubridate and dplyr to manipulate and subset our dataset.
## We create a new column that consists of the Date and Time columns. This serves
## as a new and more complete timestamp. We then take a subset of the two days we are
## interested in and assign the result to a new dataframe that we will use for our plots.
require(lubridate)
require(dplyr)
my_data1 <- tbl_df(hpc)
my_data2 <- mutate(my_data1, DateTime=dmy(Date, tz="UTC")+hms(Time))
my_data3 <- filter(my_data2, year(DateTime)=="2007", month(DateTime)=="2",
 day(DateTime)=="1" | day(DateTime)=="2")

## We then open a png graphics device:
png(filename="plot4.png", height=480, width=480)

## We create a 4 by 4 "array" to fit our four separate plots in one "window".
## We then create the four plots and send the result to the png file:
par(mfrow=c(2,2))

with(my_data3, plot(DateTime, Global_active_power, type="l",
 ylab="Global Active Power", xlab=""))

with(my_data3, plot(DateTime, Voltage, type="l",
 ylab="Voltage", xlab="datetime"))

with(my_data3, {
 plot(DateTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
 lines(DateTime, Sub_metering_2, col="red")
 lines(DateTime, Sub_metering_3, col="blue")
 legend("topright", col=c("black","red","blue"),
 legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty="solid")
})

with(my_data3, plot(DateTime, Global_reactive_power, type="l",
 ylab="Global_reactive_power", xlab="datetime"))

## We then close the graphics device:
dev.off()