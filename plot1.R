## Question 1 -> Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## get data

file = "summarySCC_PM25.rds"

NEI <- readRDS(file)

plotdata <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)


## create plot

png('plot1.png', width=480, height=480)

## plot data

plot(plotdata$year, plotdata$Emissions, type = "l", 
     main = "Total PM2.5 Emission in the US 1999-2008",
     xlab = "Year", ylab = "Emissions")

## close device

dev.off()
