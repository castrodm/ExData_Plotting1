setwd("./Exploratory Data Analysis/Course Project 1")

#Extract the column classes out of the first 5 lines of the data
#Helps read.table to run faster
powerconsumption5rows <- read.table("./household_power_consumption.txt", 
                                    skip = 1, nrows = 5, sep = ";")

classes <- sapply(powerconsumption5rows, class)

#Read household power consumption data into R
powerconsumption <- read.table("./household_power_consumption.txt", 
                               sep = ";", header = T, na.strings = "?", 
                               colClasses = classes)

#Appropriately label the columns
names <- names(powerconsumption)
colnames <- tolower(names)
names(powerconsumption) <- colnames

#Appropriately turns Date and Time into date and time formats
powerconsumption$date <- strptime(powerconsumption$date, "%d/%m/%Y")

#Select the two day period that we are interested
powerconsumptiondata <- subset(powerconsumption, 
                               date %in% c("2007-02-01", "2007-02-02"))

#Create a new column: put together date and time in a single column
#Then convert to a POSIXlt format
powerconsumptiondata$date_and_time <- paste(
      powerconsumptiondata$date, powerconsumptiondata$time, sep = " ")
powerconsumptiondata$date_and_time <- as.POSIXlt(powerconsumptiondata$date_and_time)


##Plot Energy Submetering over time and Export it to a png file

png(file = "plot3.png", bg = "transparent")
with(powerconsumptiondata,    #source data
     plot(powerconsumptiondata$date_and_time,   #time data
          powerconsumptiondata$sub_metering_1,  #sub metering 1 data
          type = "n",   #clean plot
          xlab = "",    #label x axis
          ylab = "Energy sub metering"))   #label y axis
     
     ##Add lines corresponding to sub metering data 1, 2 and 3.
     
     lines(powerconsumptiondata$date_and_time,  
           powerconsumptiondata$sub_metering_1, col = "black")
     lines(powerconsumptiondata$date_and_time,  
           powerconsumptiondata$sub_metering_2, col = "red")
     lines(powerconsumptiondata$date_and_time,  
           powerconsumptiondata$sub_metering_3, col = "blue")
     
     #Add legend

     legend("topright", pch = "_", col = c("black", "red", "blue"),
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

