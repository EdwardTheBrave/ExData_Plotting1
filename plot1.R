
## load libraries

library(lubridate)
library(dplyr)

##set working directory ###  Make sure to update this to your local environment
setwd("~/Projects/ds200/ExData_Plotting1")


##download data, read it, and save it in a variable

########################################

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
raw_data <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, na.strings="?", sep=";")
unlink(temp)


#######################################

### create DateTime column with combined date/time converted to objects.
raw_data$DateTime <- lubridate::dmy_hms(paste(raw_data$Date, raw_data$Time))

# get the dates we need
raw_data <- raw_data %>%
  filter(year(DateTime) == 2007 & month(DateTime) == 2 & (day(DateTime) == 1 | day(DateTime) == 2)  )

### check data
# summary(raw_data)

## generate plot
hist(raw_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red", cex.sub=0.8)

# copy plot to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
