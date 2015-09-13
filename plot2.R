# Hugo Rebolledo
# Exploratory Data Analysis
# Course Project 1: Household Power Consumption Graphs
# Plot 2, version 2

# Find data source
hpcFile <- "./household_power_consumption.txt"
if (!file.exists(hpcFile)) {
    download.file(url="http://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip", 
                  destfile="./household_power_consumption.zip")
    unzip("./household_power_consumption.zip", overwrite = TRUE)
    unlink("./household_power_consumption.zip")
}

# Read data filtering only required rows (saving memory)
require(sqldf)
qry <- "select * from file where Date in ('1/2/2007','2/2/2007')"
hpcData <- read.csv.sql(hpcFile,sql=qry,sep=";")
closeAllConnections()

# Add a timestamp column (Date + Time)
hpcData$DateTime <- strptime(paste(hpcData$Date, hpcData$Time), "%d/%m/%Y %H:%M:%S")

# Plot data into a PNG device (it will not appear on screen)
png("./plot2.png",width = 480, height = 480)
plot(hpcData$DateTime, hpcData$Global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = ""
    )

dev.off()
print (paste("Plot 2 finished. See ", getwd(), "/plot2.png", sep=""))
