## plot1.R: drawing plot1.png

## Assume the data file has been downloaded and unzipped in the current 
## working directory. If not, download the file and unzip it.
## This is done so that other plots (plot2.R, plot3.R and plot4.R)
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

# Adding one new column which combines Date and Time.
dat_all$Date <- as.Date(dat_all$Date, format = "%d/%m/%Y")

## Loading the dplyr package for subsetting data to be plotted.
library(dplyr)

dat_plot <- filter(dat_all, Date >= as.Date("2007-02-01"), 
                            Date <= as.Date("2007-02-02"))

## Plotting
png(filename="plot1.png", width=480, height=480)
hist(dat_plot$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off()
