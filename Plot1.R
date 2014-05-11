# Plot 1
# Load functions "downloadFile()" and "readFile(minDate,maxDate)" from ReadFile.R
# Draw Plot1 in file "Plot1.png"

source("ReadFile.R")
# Download the file from fix place if it is not downloaded
message(paste(Sys.time(),"... downloading File"),appendLF=TRUE)
downloadFile()
# unpack the file (if it isn't) and extract data of default dates
message(paste(Sys.time(),"... reading data from file"),appendLF=TRUE)
datos = readFile()

#Draw Plot1
filePlot = "plot1.png"
message(paste(Sys.time(),"... ploting histogram in ",filePlot),appendLF=TRUE)
png(filePlot,width=480,height=480)
hist(datos$Global_active_power,xlab="Global Active Power (kilowats)", 
     main="Global Active Power",col="red")
dev.off()
