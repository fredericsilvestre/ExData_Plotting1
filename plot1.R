setwd("~/Desktop/R coursera working directory/ExData_Plotting1")

library(lubridate)
library(dplyr)

#read the txt file anf keep only the rows of the two dates
table <- read.table("household_power_consumption.txt", sep=";", header = TRUE) %>% filter(Date=="1/2/2007"|Date=="2/2/2007")

table$datetime <- paste(table$Date, table$Time) #combine the two columns Date and Time together

table2 <- mutate(table, datetime=dmy_hms(table$datetime)) #change the format of the datetime column using lubridate package

#change all the factor columns into numeric; we need to first pass to character, not applicable to POSIXct column
table3 <- lapply(table2, function(table2) {
        if(is.factor(table2)) as.numeric(as.character(table2))
        else table2
})

# creat the histogram of the frequencies for Global active power and modify the layout
hist(table3$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

#export the graph to a png file
dev.copy(png, file="plot1.png")

#close the png and come back to R windows
dev.off()







table3 <- mutate(table2, strptime(table2$Time, "%H:%M:%S"))

