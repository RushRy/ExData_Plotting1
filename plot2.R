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
png(file="plot2.png", width = 480, height = 480, units = "px")
plot( hhpower$Time
    , hhpower$Global_active_power
    , type="n"
    , xlab=""
    , ylab="Global Active Power (killowatts)"
    )
lines(hhpower$Time, hhpower$Global_active_power)
dev.off()

