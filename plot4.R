# Hugo Rebolledo
# Exploratory Data Analysis
# Course Project 1: Household Power Consumption Graphs
# Plot 4

hpcFile <- "./household_power_consumption.txt"

if (!file.exists(hpcFile)) {
    download.file(url="http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", 
                  destfile="./household_power_consumption.zip")
    unzip("./household_power_consumption.zip", overwrite = TRUE)
    unlink("./household_power_consumption.zip")
}

require(sqldf)
qry <- "select * from file where Date in ('1/2/2007','2/2/2007')"
hpcData <- read.csv.sql(hpcFile,sql=qry,sep=";")
closeAllConnections()
hpcData$DateTime <- strptime(paste(hpcData$Date, hpcData$Time), "%d/%m/%Y %H:%M:%S")

# draw graphs by column in a 2 x 2 array
par(mfcol=c(2,2))
par(cex=0.6)
# upper left graph
plot(hpcData$DateTime, hpcData$Global_active_power, type = "l", 
     ylab = "Global Active Power",
     xlab = "")

# lower left graph
plot(hpcData$DateTime, hpcData$Sub_metering_1, type = "l", col = "black",
    ylab = "Energy sub metering",
    xlab = ""
    )
lines(hpcData$DateTime, hpcData$Sub_metering_2, type = "l", col = "red")
lines(hpcData$DateTime, hpcData$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       legend   = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col      = c("black", "red", "blue"),
       lwd = c(1,1,1), lty = c(1,1,1),
       y.intersp = 0.4, bty = "n" 
)
# upper right graph
plot(hpcData$DateTime, hpcData$Voltage, type="l", xlab="datetime", ylab="Voltage")

# lower right graph
plot(hpcData$DateTime, hpcData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="./plot4.png", width=480, height=480)
dev.off()
