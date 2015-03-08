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
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

## Plot 1
plot(power$datetime, power$Global_active_power, type="l", main="", xlab="", ylab="Global Active Power")

## Plot 2
plot(power$datetime, power$Voltage, type="l", main="", xlab="datetime", ylab="Voltage")

## Plot 3
plot(range(power$datetime), range(power$Sub_metering_1), type="n", main="", xlab="", ylab="Energy sub metering")
lines(power$datetime, power$Sub_metering_1, type="l")
lines(power$datetime, power$Sub_metering_2, col="red", type="l")
lines(power$datetime, power$Sub_metering_3, col="blue", type="l")
legend('topright', names(power)[7:9] , lty=1, col=c('black', 'red', 'blue'), bty="n")

## Plot 4
plot(power$datetime, power$Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global_reactive_power")

dev.off()
