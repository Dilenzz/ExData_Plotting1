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

#plot 2
par(mfrow=c(1,1))
GAP<- (cons_set$Global_active_power)
set_length <- length(cons_set$Date)
plot2 <- plot(GAP, type = "l", xaxt="n", xlab="", 
              ylab = "Global Active Power (kilowatts)")
axis(side=1, at=c(0,set_length/2,set_length), labels=c("Th","Fr","Sat"))
dev.copy(png, file = "plot2.png")
dev.off()
