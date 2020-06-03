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
png('plot1.png')
hist(power_cons$Global_active_power, main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)', col = 'red')
dev.off()
