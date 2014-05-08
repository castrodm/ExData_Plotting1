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


#Plot Global Active Power over time and Export it to a png file
png(file = "plot4.png", bg = "transparent")

#Set number of Graphs in page to 4
par(mfrow = c(2,2))

     plot(powerconsumptiondata$date_and_time,  #time data
          powerconsumptiondata$global_active_power, #global active power dat
          xlab = "", #label x-axis
          ylab = "Global Active Power",  #label y-axis
          pch = 26,  #no points
          lines(powerconsumptiondata$date_and_time,     #add a line connecting
                powerconsumptiondata$global_active_power)  #global active power
                                                            #over time
      )

     plot(powerconsumptiondata$date_and_time,  #time data
          powerconsumptiondata$voltage,   #voltage data
          xlab = "datetime",  #label x-axis
          ylab = "Voltage",   #label y-axis
          pch = 26,   # no points
          lines(powerconsumptiondata$date_and_time,    #line connecting voltage
                powerconsumptiondata$voltage)          #over time
      )

     plot(powerconsumptiondata$date_and_time,   #time data
          powerconsumptiondata$sub_metering_1,  #sub metering 1 data
          type = "n",   #clean
          xlab = "",    #label x axis
          ylab = "Energy sub metering")   #label y axis
          
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
      
     plot(powerconsumptiondata$date_and_time,   #time data
          powerconsumptiondata$global_reactive_power,    #global reactive power data
          xlab = "datetime",   #label x-axis
          ylab = "Global Reactive Power",   #label y-axis
          pch = 26,   #not visible points
          lines(powerconsumptiondata$date_and_time,    #line: global reactive power
                  powerconsumptiondata$global_reactive_power)  #over time
      )

dev.off() #close graphics device
