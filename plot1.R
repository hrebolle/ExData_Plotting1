# Hugo Rebolledo
# Exploratory Data Analysis
# Course Project 1: Household Power Consumption Graphs
# Plot 1

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
par(mfcol=c(1,1))
par(cex=0.75)
hpcData$DateTime <- strptime(paste(hpcData$Date, hpcData$Time), "%d/%m/%Y %H:%M:%S")

hist(hpcData$Global_active_power, 
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     col="red"
     )
dev.copy(png, file="./plot1.png", width=480, height=480)
dev.off()
