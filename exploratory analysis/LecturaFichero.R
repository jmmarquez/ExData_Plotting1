# Abrir la conexion con el fichero .zip
nombrezip = "exdata-data-household_power_consumption.zip"
nombrefichero = "household_power_consumption.txt"
# conzip = unz("nombre zip",filename="nombre fichero")

# Alternativamente abrir conexion con fichero de texto en modo lectura binaria
conn = file(nombrefichero,"rb")

# Leer cabecera con los nombres de las variables
nomvar = readLines(conn,1)
nombres = strsplit(nomvar,";")[[1]]
consumo = data.frame(character(),character(),numeric(),numeric(),numeric(),
                     numeric(),numeric(),numeric(),numeric(),stringsAsFactors=FALSE)
names(consumo) = nombres

# Leer datos secuencialmente que cumplan la condición
#  fecha entre 2007-02-01 y 2007-02-02
#  e incluirlos en el data frame
fechaMenor = as.Date("2007-02-01")
fechaMayor = as.Date("2007-02-02")
linea = readLines(conn,1)
n=1
limite = 80000
while (length(linea)>0){
  lineaOK = strsplit(linea,";")[[1]]
  fecha = as.Date(lineaOK[1],"%d/%m/%Y")
  if ((fecha >= fechaMenor) & (fecha <= fechaMayor)) {
    #incluirlo en el data frame
    consumo[n,] = lineaOK
    n=n+1
  }
  linea = readLines(conn,1)
  limite = limite-1
  if (limite <0) break()
}
close(conn)

#convertir en numerico todos los valores numericos
consumo[,3]=as.numeric(consumo[,3])
consumo[,4]=as.numeric(consumo[,4])
consumo[,5]=as.numeric(consumo[,5])
consumo[,6]=as.numeric(consumo[,6])
consumo[,7]=as.numeric(consumo[,7])
consumo[,8]=as.numeric(consumo[,8])
consumo[,9]=as.numeric(consumo[,9])

#convertir consumo$Date y consumo$Time en clase POSIXt
consumo$datetime <- strptime(paste(consumo$Date,consumo$Time),"%d/%m/%Y %H:%M:%S")

#Dibuja Plot1
png("plot1.png",width=480,height=480)
hist(consumo$Global_active_power,xlab="Global Active Power (kilowats)", 
     main="Global Active Power",col="red")
dev.off()

#Dibuja Plot2
png("plot2.png",width=480,height=480)
with(consumo, plot(DateTime,Global_active_power,type="l",
                   ylab="Global Active Power (kilowats)", xlab=""))
dev.off()

#Dibuja Plot3
png("plot3.png",width=480,height=480)
with(consumo, plot(DateTime,Sub_metering_1,type="l",
                   ylab="Energy sub metering", cex=0.75, xlab="",col="black"))
with(consumo, lines(DateTime,Sub_metering_2,type="l",col="red"))
with(consumo, lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1)
dev.off()

#Dibujar Plot4
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(consumo, plot(DateTime,Global_active_power,type="l",
                   ylab="Global Active Power", xlab=""))
with(consumo, plot(DateTime,Voltage,type="l", 
                   ylab="Global Active Power", xlab="datatime"))
with(consumo, plot(DateTime,Sub_metering_1,type="l",
                   ylab="Energy sub metering", xlab="",col="black"))
with(consumo, lines(DateTime,Sub_metering_2,type="l",col="red"))
with(consumo, lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),lty=1,bty="n")
with(consumo, plot(DateTime,Global_reactive_power,type="l", xlab="datatime"))
dev.off()
