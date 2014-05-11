# Plot 3
# Load functions "downloadFile()" and "readFile(minDate,maxDate)" from ReadFile.R
# Draw Plot3 in file "Plot3.png"

source("ReadFile.R")
# Download the file from fix place if it is not downloaded
message(paste(Sys.time(),"... downloading File"),appendLF=TRUE)
downloadFile()
# unpack the file (if it isn't) and extract data of default dates
message(paste(Sys.time(),"... reading data from file"),appendLF=TRUE)
datos = readFile()

#Draw Plot3
#convertir datos$Date y datos$Time en clase POSIXt
datos$datetime <- strptime(paste(datos$Date,datos$Time),"%d/%m/%Y %H:%M:%S")

filePlot = "plot3.png"
message(paste(Sys.time(),"... ploting histogram in ",filePlot),appendLF=TRUE)
png(filePlot,width=480,height=480)
with(datos, plot(datetime,Sub_metering_1,type="l",
                 ylab="Energy sub metering", cex=0.75, xlab="",col="black"))
with(datos, lines(datetime,Sub_metering_2,type="l",col="red"))
with(datos, lines(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1)
dev.off()

