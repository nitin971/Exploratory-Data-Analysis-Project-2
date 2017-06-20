## Question 2 -> Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## get data

file = "summarySCC_PM25.rds"

NEI <- readRDS(file)

## plotdata: aggregate total PM25 emission from Baltimore per year


baltimore <- subset(NEI, fips == "24510")

plotdata <- aggregate(baltimore[c("Emissions")], list(year = baltimore$year), sum)

## create plot

## create file

png('plot2.png', width=480, height=480)

## plot data

plot(plotdata$year, plotdata$Emissions, type = "l", 
     main = "Total PM2.5 Emission in Baltimore 1999-2008",
     xlab = "Year", ylab = "Emissions")

## close device

dev.off()
