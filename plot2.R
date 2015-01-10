## Plotting Assignment 1 for Exploratory Data Analysis on Coursera
##
## Code for generating plot2.png
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
png(filename="plot2.png", height=480, width=480)

## We create the plot and send it to the png file:
with(my_data3, plot(DateTime, Global_active_power, type="l",
 ylab="Global Active Power (kilowatts)", xlab=""))

## We then close the graphics device:
dev.off()