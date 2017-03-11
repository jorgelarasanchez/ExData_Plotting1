# File URL to download

fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
dataFileZip <- "./household_power_consumption.zip"

# Download the file

if (file.exists(dataFileZip) == FALSE) {
  download.file(fileURL,destfile=dataFileZip ,method="curl")
  # Unzip the file
  unzip(zipfile=dataFileZip ,exdir=".")
}

dataFile <- "./household_power_consumption.txt"

# We take only with field "date" 1 and 2 of February of 2007

dataFile_12 <- grep("^[1,2]/2/2007",readLines(dataFile),value=TRUE)

# Read the data

data <- read.table(text=dataFile_12, sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

## set time variable

SetTime <-strptime(paste(data$Date, data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
data <- cbind(SetTime, data)

# open device

png(filename = './plot2.png', width = 480, height = 480, units='px')

# plot
# We change Spanish to English
Sys.setlocale(category = "LC_ALL", locale = "english")
plot(data$SetTime, data$Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatts)', type = 'l', col="black")


# close device

dev.off()
