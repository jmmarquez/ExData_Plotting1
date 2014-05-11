# Plot 2
# Load functions "downloadFile()" and "readFile(minDate,maxDate)" from ReadFile.R
# Draw Plot2 in file "Plot2.png"

source("ReadFile.R")
# Download the file from fix place if it is not downloaded
message(paste(Sys.time(),"... downloading File"),appendLF=TRUE)
downloadFile()
# unpack the file (if it isn't) and extract data of default dates
message(paste(Sys.time(),"... reading data from file"),appendLF=TRUE)
datos = readFile()

#Draw Plot2
#convertir datos$Date y datos$Time en clase POSIXt
datos$datetime <- strptime(paste(datos$Date,datos$Time),"%d/%m/%Y %H:%M:%S")

filePlot = "plot2.png"
message(paste(Sys.time(),"... ploting histogram in ",filePlot),appendLF=TRUE)
png(filePlot,width=480,height=480)
with(datos, plot(datetime,Global_active_power,type="l",
                 ylab="Global Active Power (kilowats)", xlab=""))
dev.off()
