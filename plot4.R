getwd()
setwd("C:/Users/Sergey/Documents/R/coursera/Exploratory DA")

# download and read the source file. Can be skipped if once done
url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile="source.zip")
source_file <- unzip("source.zip", files ="household_power_consumption.txt")
electro_cons<-read.table(source_file, sep=";",colClasses=c(rep("character",9)),
                         header=T)

electro_cons$Date <- as.Date(electro_cons$Date,format="%d/%m/%Y")
cons_set<-subset(electro_cons, Date >= "2007-02-01" & Date <= "2007-02-02")
#cons_set$Time <- strftime(strtime(cons_set$Time,format="%H:%M:%S"), format="%H:%M:%S")
cons_set[,c(3:9)] <- (sapply(cons_set[,c(3:9)], as.numeric))
set_length <- length(cons_set$Date)
GAP<- (cons_set$Global_active_power)


#multiplot 4
win.graph(5,5)
par(mfcol=c(2,2),mar=c(5,4,4,2), mai=c(0.7,0.7,0.2,0.2))
# add plot 1
plot(GAP, type = "l", xaxt="n", xlab="", 
     ylab = "Global Active Power (kilowatts)")
axis(side=1, at=c(0,set_length/2,set_length), labels=c("Th","Fr","Sat"))
#add plot 2
with(cons_set, {
    plot(cons_set$Sub_metering_1,type="n", xaxt="n", xlab="",ylab="Energy sub metering")
    lines(cons_set$Sub_metering_1, type ="l")
    lines(Sub_metering_2, type ="l", col="red")
    lines(Sub_metering_3, type ="l", col="blue")
    axis(side=1, at=c(0,set_length/2,set_length), labels=c("Th","Fr","Sat"))
    legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           lwd="1", col=c("black","blue","red"),cex=0.75,  bty="n")    
})
#add plot 3
plot(cons_set$Voltage, type = "l", xaxt="n", xlab="datetime", 
     ylab = "Voltage")
axis(side=1, at=c(0,set_length/2,set_length), labels=c("Th","Fr","Sat"))
#add plot 4
plot(cons_set$Global_reactive_power, type ="l", xaxt="n", xlab="datetime",
     ylab="Global_reactive_power")
axis(side=1, at=c(0,set_length/2,set_length), labels=c("Th","Fr","Sat"))

#save
dev.copy(png, file = "plot4.png")
dev.off()



