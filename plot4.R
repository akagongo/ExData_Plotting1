# load the required libraries
library(tibble)
library(dplyr)
library(lubridate)

# read the data and filter only the rows with the specified dates
power_cons <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', na.strings = '?')
power_cons <- as_tibble(power_cons)
power_cons <- filter(power_cons, Date == '1/2/2007' | Date == '2/2/2007')

# convert the time and date variables
power_cons <- mutate(power_cons, Date = dmy(Date))
power_cons <- mutate(power_cons, Time = ymd_hms(paste(power_cons$Date, power_cons$Time)))

# plot and save the image
png('plot4.png')
par(mfrow = c(2, 2))
plot(power_cons$Time, power_cons$Global_active_power, type = 'l', ylab = 'Global Active Power', xlab = '')
plot(power_cons$Time, power_cons$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
plot(power_cons$Time, power_cons$Sub_metering_1, type = 'l', col = 'black', ylab = 'Energy sub metering', xlab = "")
lines(power_cons$Time, power_cons$Sub_metering_2, type = 'l', col = 'red')
lines(power_cons$Time, power_cons$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col = c('black', 'red', 'blue'), lty = 1, cex = 0.8)
plot(power_cons$Time, power_cons$Global_reactive_power, type = 'l', ylab = 'Global Reactive Power', xlab = 'date time')
dev.off()
