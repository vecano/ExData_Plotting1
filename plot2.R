# Download and unzip data file if not already present
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="household_power_consumption.zip", method="curl")
  unzip("household_power_consumption.zip")
}

## Read in data
power <- read.csv('household_power_consumption.txt', sep=";", header=TRUE, skip=66638, nrows=2880)

## Restore header that were lost by using `skip`
header <- read.table('household_power_consumption.txt', nrows=1, header=FALSE, sep=';', stringsAsFactors=FALSE)
colnames(power) <- unlist(header)

## Merge Date and Time into a datetime column
datetime_str <- paste(power$Date, power$Time)
power$datetime = strptime(datetime_str, "%d/%m/%Y %H:%M:%S")

## Save image
png(file="plot2.png", width=480, height=480)
plot(power$datetime, power$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
