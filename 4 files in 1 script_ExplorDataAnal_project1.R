# set your working directory here:
# setwd('./DATAScience')

# Sourcing this script will generate and write 4 Exploratory Graphs (as .png file)
# to your working directory


#Read in the data
tbl<-"household_power_consumption.txt"
HHPC<-read.table(tbl, sep=";", header=TRUE) 
HH_PC<-subset(HHPC, Date=="1/2/2007" | Date=="2/2/2007" ) # subset on the 2-days set
rm(HHPC) # remove the total dataset


# Generate plot1
GAP<-as.numeric(as.character(HH_PC$Global_active_power))
hist(GAP, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()



# Generate plot2
# For this as well as subsequent plots the lubridate package has been used 
# (install it if you haven't done so already)
# The plots were generated on a computer in the Amstedam timezone
# thus yielding Dutch abbreviations of the weekday-names on the horizontal axis
# instead of the English abbreviations. In your area they just might generate
# English abbreviations
library(lubridate)
DateDim<-dmy(HH_PC$Date)+ hms(HH_PC$Time)
plot(DateDim,GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()



# Generate plot3
# Introduce SubMx vectors for readability
SubM1<-as.numeric(as.character(HH_PC$Sub_metering_1))
SubM2<-as.numeric(as.character(HH_PC$Sub_metering_2))
SubM3<-as.numeric(as.character(HH_PC$Sub_metering_3))
plot(DateDim, SubM1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(DateDim, SubM2, type="l", col="red")
lines(DateDim, SubM3, type="l", col="blue")
legend ("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3" )
        , col=c("black", "red", "blue"), lty="solid", cex=0.7, text.width=40000)
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()



# Generate plot4
par(mfcol=c(2,2))
# plot upper left = plot2
plot(DateDim,GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)"
     , cex.lab=0.7, cex.axis=0.7)
# plot lower left = plot3
plot(DateDim, SubM1, type="l", xlab="", ylab="Energy sub metering", col="black"
     , cex.lab=0.7, cex.axis=0.7)
lines(DateDim, SubM2, type="l", col="red")
lines(DateDim, SubM3, type="l", col="blue")
legend ("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3" )
        , col=c("black", "red", "blue"), lty="solid", cex=0.55, bty="n", text.width=60000)
# plot upper right
Vlt<-as.numeric(as.character(HH_PC$Voltage))
plot(DateDim, Vlt, type="l", xlab="datetime", ylab="Voltage", col="black"
     , cex.lab=0.7, cex.axis=0.7)
# plot lower right
GRP<-as.numeric(as.character(HH_PC$Global_reactive_power))
plot(DateDim, GRP, type="l", xlab="datetime", ylab="Global_reactive_power"
     , col="black", cex.lab=0.7, cex.axis=0.7)

dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()


# reset of subsequent parameter in case you want to (re-)run part of the script
# for generating either plot 1, 2 or 3.
par(mfcol=c(1,1))





