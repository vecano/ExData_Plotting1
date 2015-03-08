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

## Save image
png(file="plot1.png", width=480, height=480)
hist(power$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
