setwd("~/Desktop/R coursera working directory/ExData_Plotting1")

library(lubridate)
library(dplyr)

#read the txt file anf keep only the rows of the two dates
table <- read.table("household_power_consumption.txt", sep=";", header = TRUE) %>% filter(Date=="1/2/2007"|Date=="2/2/2007")

table$datetime <- paste(table$Date, table$Time) #combine the two columns Date and Time together

table2 <- mutate(table, datetime=dmy_hms(table$datetime)) #change the format of the datetme column using lubridate package

#change all the factor columns into numeric; we need to first pass to character, not applicable to POSIXct column
table3 <- lapply(table2, function(table2) {
        if(is.factor(table2)) as.numeric(as.character(table2))
        else table2
})

# determine the general layout rows and columns
par(mfrow=c(2,2), mar=c(6,6,2,2))

# create the histogram of the frequencies for Global active power and modify the layout
plot(table3$datetime, table3$Global_active_power, ylab="Global Active Power", xlab="", type="l")

# create the plot of datetime vs Global active power and modify the layout
plot(table3$datetime, table3$Voltage, ylab="Voltage", xlab="datetime", type="l")

# create the plots and add seperately each column with the function lines()
plot(table3$datetime, table3$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(table3$datetime, table3$Sub_metering_2, type="l", col="red")
lines(table3$datetime, table3$Sub_metering_3, type="l", col="blue")

# add the legend
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub-metering_1", "Sub_metering_2", "Sub_metering_3"))

# create the plot of datetime vs Global active power and modify the layout
plot(table3$datetime, table3$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l")


#export the graph to a png file
dev.copy(png, file="plot4.png")

#close the png and come back to R windows
dev.off()








