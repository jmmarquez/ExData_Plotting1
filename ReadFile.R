# Create directory "./data" if it doesn't exist and download fileURL in consumo.zip if it doesn,t exist
downloadFile <- function () {
    if (!file.exists("./data")) { dir.create("data")}
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    if (!file.exists("./data/consumo.zip")) {download.file(fileUrl,"./data/consumo.zip",method="curl")}
}

# Extract file from consumo.zip (if it's not extracted) and build a dataframe with data
# between minDate and maxDate
readFile <- function (minDate="2007-02-01",maxDate="2007-02-02") {
    ficherozip="./data/consumo.zip"
    fechaMenor = as.Date(minDate)
    fechaMayor = as.Date(maxDate)
    
    # If it doesn't exist, unzip consumo.zip
    fileName = paste0("./data/",unzip(ficherozip,list=TRUE)[[1]])
    if (!file.exists(fileName)) {unzip(ficherozip,exdir="./data")}

    # read fileName and select records between fechaMenor and fechaMayor
    consumo = read.table(fileName,header=TRUE,stringsAsFactors=FALSE,sep=";",na.string="?")
    consumo$Fecha = as.Date(consumo$Date,"%d/%m/%Y")
    subset(consumo,(consumo$Fecha>=fechaMenor)&(consumo$Fecha<=fechaMayor))
}
