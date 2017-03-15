# Read in data if not already read in
dataDirectory <- "./data/"
if (!exists('hhpower')) {
    hhpower <- read.delim(
        file = paste0(dataDirectory,"household_power_consumption.txt")
        , sep = ";"
        , na.strings='?'
        , colClasses = c("character", "character", "numeric"
                         , "numeric", "numeric", "numeric"
                         , "numeric", "numeric", "numeric"
        )
    )
    
    # Clean up imported columns
    hhpower$Time <- strptime(
        paste(hhpower$Date, hhpower$Time)
        , format="%d/%m/%Y %H:%M:%S"
    )
    hhpower$Date <- as.Date(hhpower$Date, format="%d/%m/%Y")
    
    # Subset data to desired date range
    hhpower <- hhpower[hhpower$Date >= as.Date("2007-02-01") & hhpower$Date <= as.Date("2007-02-02"),]
}

# Create Plot to PNG Device
png(file="plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

# Add first plot
plot( hhpower$Time
      , hhpower$Global_active_power
      , type="n"
      , xlab=""
      , ylab="Global Active Power"
)
lines(hhpower$Time, hhpower$Global_active_power)

# Add second plot
plot( hhpower$Time
      , hhpower$Voltage
      , type="n"
      , xlab="datetime"
      , ylab="Voltage"
)
lines(hhpower$Time, hhpower$Voltage)

# Add 3rd plot
plot( hhpower$Time
      , hhpower$Sub_metering_1
      , type="n"
      , xlab=""
      , ylab="Energy sub metering"
)
# Add Lines
lines(hhpower$Time, hhpower$Sub_metering_1, col="black")
lines(hhpower$Time, hhpower$Sub_metering_2, col="red")
lines(hhpower$Time, hhpower$Sub_metering_3, col="blue")

# Add Legend
legend("topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , lty=1
       , col=c("black","red","blue")
       , bty = "n"
)

# Add foruth plot
plot( hhpower$Time
      , hhpower$Global_reactive_power
      , type="n"
      , xlab="datetime"
      , ylab="Global_reactive_power"
)
lines(hhpower$Time, hhpower$Global_reactive_power)


dev.off()

