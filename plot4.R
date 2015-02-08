## plot4.R: drawing plot1.png

## Assume the data file has been downloaded and unzipped in the current 
## working directory. If not, download the file and unzip it.
## This is done so that other plots (plot1.R, plot2.R and plot3.R)
## can directly subset data from the unziped file.

zip_file = "exdata-data-household_power_consumption.zip"
dat_file = "household_power_consumption.txt"

if(!file.exists(dat_file)) 
{
  if(!file.exists(zip_file))
  {
    ## Note, this works for Windows without 'method = "curl"', for Mac, this
    ## might need to be added.
    retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                           destfile = zip_file)
    
    ## Unzip the downloaded file for future use.
    unzip(zip_file)
    ## Check if the zip file contains the household_power_consumption.txt file
    ## If not, through an error message and return.
    if (!file.exists(dat_file))
    {
      message("The downloaded zip file does not include ", dat_file)
      return
    }
  }
}

## Reading the data from the contents of the zipped file
dat_all <- read.csv(dat_file, header=T, sep=";", stringsAsFactors=F, na.strings="?",
                    colClasses=c("character", "character", "numeric",
                                 "numeric", "numeric", "numeric",
                                 "numeric", "numeric", "numeric"))

## Subseting the date of interest
dat_plot <- dat_all[dat_all$Date == "1/2/2007" | dat_all$Date == "2/2/2007",]

## Combining Date and Time into one variable
dat_plot$datetime = strptime(paste(dat_plot$Date, dat_plot$Time), format="%d/%m/%Y %H:%M:%S")

## Plotting
png(filename="plot4.png", width=480, height=480)

# Setting the canvas for 2x2 plots
par(mfcol=c(2,2))

# First plot
plot(dat_plot$datetime, dat_plot$Global_active_power, type="l", xlab="",
     ylab="Global Active Power")

# Second plot
plot(dat_plot$datetime, dat_plot$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(dat_plot$datetime, dat_plot$Sub_metering_2, col="red")
lines(dat_plot$datetime, dat_plot$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lwd=par("lwd"), bty="n")

# Third Plot
plot(dat_plot$datetime, dat_plot$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# Fourth plot
plot(dat_plot$datetime, dat_plot$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()