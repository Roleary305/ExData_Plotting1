 
 #Reads in the Data formats and sub sets it
 # All PlotScripts wil check if powerset already exists and only read it in iff neccisary.
 getandsubset <- function(){
 rawpowerdata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
 
 dtg <- paste(rawpowerdata$Date,rawpowerdata$Time)
 rawpowerdata$DTG <- strptime(dtg, format = "%d/%m/%Y %H:%M:%S")
 rawpowerdata$Date <- as.Date(rawpowerdata$Date, format = "%d/%m/%Y")

 powerset <- subset(rawpowerdata, (rawpowerdata$Date == "2007/02/01" | rawpowerdata$Date =="2007/02/02"))
 powerset$Global_active_power <- as.numeric(as.character(powerset$Global_active_power)) 
 powerset$Sub_metering_1 <- as.numeric(as.character(powerset$Sub_metering_1)) 
 powerset$Sub_metering_2 <- as.numeric(as.character(powerset$Sub_metering_2)) 
 powerset$Sub_metering_3 <- as.numeric(as.character(powerset$Sub_metering_3)) 
 return powerset
 }
 
 #Creates plot 1
if (!exists("powerset"){ powerset <- getandsubset }
	png(filename = "Plot1.png", width = 480, height = 480, units = "px")
	with(powerset, hist(Global_active_power,  xlab = "Global Active Power (Killowatts)", col = "red", main = "Global Active Power"))
 
	dev.off()
 
 #Creats plot 2
if (!exists("powerset"){ powerset <- getandsubset }
	png(filename = "Plot2.png", width = 480, height = 480, units = "px")
	with(powerset, plot(DTG, Global_active_power, type = "l", ylab = "Global Active Power (killowatts)", xlab = ""))
	
	dev.off()
 
 #Creates plot 3
 if (!exists("powerset"){ powerset <- getandsubset }
	png(filename = "Plot3.png", width = 480, height = 480, units = "px")
    plot(powerset$DTG, powerset$Sub_metering_1, type = "l", ylab = "Energy Sub Metering", xlab = "")
		points(powerset$DTG, powerset$Sub_metering_2, type = "l", col = "red")
		points(powerset$DTG, powerset$Sub_metering_3, type = "l", col = "blue")
	
	dev.off()
 
 # Create plot 4
 if (!exists("powerset"){ powerset <- getandsubset }
	png(filename = "Plot4.png", width = 480, height = 480, units = "px")
	par(mfrow = c(2,2))
 
 #Global Active
	plot(powerset$DTG, powerset$Global_active_power, type = "l", ylab = "Global Active Power (killowatts)", xlab = "")
 
 # Voltage
	
	plot(powerset$DTG, powerset$Voltage, type = "l", ylab = "Voltage", xlab = "")
 
 # Sub metering
	
	plot(powerset$DTG, powerset$Sub_metering_1, type = "l", ylab = "Energy Sub Metering", xlab = "")
		points(powerset$DTG, powerset$Sub_metering_2, type = "l", col = "red")
		points(powerset$DTG, powerset$Sub_metering_3, type = "l", col = "blue")

 # Global Reactive
	plot(powerset$DTG, powerset$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
 
	dev.off()