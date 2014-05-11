# Plot 4
# Load functions "downloadFile()" and "readFile(minDate,maxDate)" from ReadFile.R
# Draw Plot4 in file "Plot4.png"

source("ReadFile.R")
# Download the file from fix place if it is not downloaded
message(paste(Sys.time(),"... downloading File"),appendLF=TRUE)
downloadFile()
# unpack the file (if it isn't) and extract data of default dates
message(paste(Sys.time(),"... reading data from file"),appendLF=TRUE)
datos = readFile()

#Draw Plot4
#convertir datos$Date y datos$Time en clase POSIXt
datos$datetime <- strptime(paste(datos$Date,datos$Time),"%d/%m/%Y %H:%M:%S")

filePlot = "plot4.png"
message(paste(Sys.time(),"... ploting histogram in ",filePlot),appendLF=TRUE)
png(filePlot,width=480,height=480)
par(mfrow=c(2,2))
with(datos, plot(datetime,Global_active_power,type="l",
                   ylab="Global Active Power", xlab=""))
with(datos, plot(datetime,Voltage,type="l", 
                   ylab="Global Active Power", xlab="datatime"))
with(datos, plot(datetime,Sub_metering_1,type="l",
                   ylab="Energy sub metering", xlab="",col="black"))
with(datos, lines(datetime,Sub_metering_2,type="l",col="red"))
with(datos, lines(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1,bty="n")
with(datos, plot(datetime,Global_reactive_power,type="l", xlab="datatime"))
dev.off()
