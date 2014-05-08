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

#Plot the histogram; add color, title and a x-label
#Export to a png file

png(file = "plot1.png", bg = "transparent") #open graphics devide - png file

hist(powerconsumptiondata$global_active_power,     #data to be plotted
     main = "Global Active Power",         #title
     xlab = "Global Active Power (killowatts)",    #label x axis
     col = "red")       #set the bars color

dev.off()         #close graphics device

